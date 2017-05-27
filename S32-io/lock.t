use v6;
use lib <lib t/spec/packages/>;
use Test;
use Test::Util;

# Tests for IO::Handle.lock/.unlock methods
my $SLEEP = 1 * (%*ENV<ROAST_TIMING_SCALE> || 1);
plan 28;

#?DOES 1
sub test-lock (
    Capture :$args1, Str :$args2 = '', :$fails-to-lock,
    :$open-for-write, :$blocks-write, :$fails-write,
    :$open-for-read,  :$blocks-read,  :$fails-read,
){
    my $file = make-temp-file :content<test>;
    my $fh;
    $fh = $file.IO.open(:r) if $open-for-read;
    $fh = $file.IO.open(:w) if $open-for-write;
    $fh.DEFINITE or die 'Provide :open-for-read or :open-for-write to test';
    LEAVE $fh.close;

    subtest "$args1.perl(), $args2.perl()" => sub {
        quietly plan $fails-to-lock
            ?? 1
            !! (!$blocks-read and !$fails-read) + $blocks-write + $fails-write
                + $blocks-read + $fails-read + 1;

        if $fails-to-lock {
            # XXX TODO: is it meant to be this way for Windows?
            $*DISTRO.is-win
                ?? skip
                    'locking filehandle in wrong mode does not throw on Windows'
                !! fails-like { $fh.lock: |$args1 }, X::IO::Lock,
                    'fails to lock';
            return;
        }

        $fh.lock: |$args1;

        if $blocks-write {
            is_run qq|
                start \{
                    my \$fh = '$file'.IO.open(:w);
                    say "LOCKING";
                    \$fh.lock($args2); say "FAILED";
                }
                sleep $SLEEP; say "DONE"
            |, {
                :err(''), :out{
                    not .contains: 'FAILED'
                    and .contains: 'LOCKING'
                    and .contains: 'DONE'
                }
            }, 'we got blocked for writing';
        }

        if $fails-write {
            is_run qq|
                my \$fh = '$file'.IO.open(:w);
                say "LOCKING";
                my \$res = \$fh.lock($args2);
                if \$res ~~ Failure and \$res.exception ~~ X::IO::Lock
                    \{ say "DONE"; exit }
                say "FAILED";
            |, {
                :err(''), :out{
                    not .contains: 'FAILED'
                    and .contains: 'LOCKING'
                    and .contains: 'DONE'
                }
            }, 'we received Failure when locking for writing';
        }

        unless $blocks-read or $fails-read {
            is_run qq|
                my \$fh = '$file'.IO.open(:r);
                say "LOCKING";
                \$fh.lock(:shared, :non-blocking);
                say "SUCCESS";
            |, {
                :err(''), :out{.contains: 'LOCKING' and .contains: 'SUCCESS' }
            }, 'we can still lock as shared';
        }

        if $blocks-read {
            is_run qq|
                start \{
                    my \$fh = '$file'.IO.open(:r);
                    say "LOCKING";
                    \$fh.lock($args2); say "FAILED";
                }
                sleep $SLEEP; say "DONE"
            |, {
                :err(''), :out{
                    not .contains: 'FAILED'
                    and .contains: 'LOCKING'
                    and .contains: 'DONE'
                }
            }, 'we got blocked for reading';
        }

        if $fails-read {
            is_run qq|
                my \$fh = '$file'.IO.open(:r);
                say "LOCKING";
                my \$res = \$fh.lock($args2);
                if \$res ~~ Failure and \$res.exception ~~ X::IO::Lock
                    \{ say "DONE"; exit }
                say "FAILED";
            |, {
                :err(''), :out{
                    not .contains: 'FAILED'
                    and .contains: 'LOCKING'
                    and .contains: 'DONE'
                }
            }, 'we received Failure when locking for reading';
        }

        $fh.unlock;
        with $file.open(:w) {
            ok .lock, '.unlock removes lock';
            .unlock;
        }
    }
}

test-lock :open-for-read,  :fails-to-lock, args1 => \();
test-lock :open-for-read,  :fails-to-lock, args1 => \(:non-blocking);
test-lock :open-for-read,  :fails-to-lock, args1 => \(:!non-blocking);
test-lock :open-for-read,  :fails-to-lock, args1 => \(:!shared);
test-lock :open-for-read,  :fails-to-lock, args1 => \(:!shared,  :non-blocking);
test-lock :open-for-read,  :fails-to-lock, args1 => \(:!shared, :!non-blocking);

#?rakudo.jvm 6 skip '[io grant] Could not obtain blocking, shared lock: NonWritableChannelException'
test-lock :open-for-read,  :blocks-write, args1 => \(:shared);
test-lock :open-for-read,  :blocks-write, args1 => \(:shared,  :non-blocking);
test-lock :open-for-read,  :blocks-write, args1 => \(:shared, :!non-blocking);

test-lock :open-for-read,  :fails-write, args2 => ':non-blocking',
    args1 => \(:shared);
test-lock :open-for-read,  :fails-write, args2 => ':non-blocking',
    args1 => \(:shared, :non-blocking);
test-lock :open-for-read,  :fails-write, args2 => ':non-blocking',
    args1 => \(:shared, :!non-blocking);

#?rakudo.jvm 3 todo '[io grant] expected Failure, bot Bool'
test-lock :open-for-write, :fails-to-lock, args1 => \(:shared);
test-lock :open-for-write, :fails-to-lock, args1 => \(:shared,  :non-blocking);
test-lock :open-for-write, :fails-to-lock, args1 => \(:shared, :!non-blocking);

test-lock :open-for-write, :blocks-write, :blocks-read,
    args1 => \();
test-lock :open-for-write, :blocks-write, :blocks-read,
    args1 => \(:non-blocking);
test-lock :open-for-write, :blocks-write, :blocks-read,
    args1 => \(:!non-blocking);
test-lock :open-for-write, :blocks-write, :blocks-read,
    args1 => \(:!shared);
test-lock :open-for-write, :blocks-write, :blocks-read,
    args1 => \(:!shared,  :non-blocking);
test-lock :open-for-write, :blocks-write, :blocks-read,
    args1 => \(:!shared, :!non-blocking);

#?rakudo.jvm 5 skip '[io grant] hangs'
test-lock :open-for-write, :fails-write, :fails-read,
    args2 => ':non-blocking', args1 => \();
test-lock :open-for-write, :fails-write, :fails-read,
    args2 => ':non-blocking', args1 => \(:non-blocking);
test-lock :open-for-write, :fails-write, :fails-read,
    args2 => ':non-blocking', args1 => \(:!non-blocking);
test-lock :open-for-write, :fails-write, :fails-read,
    args2 => ':non-blocking', args1 => \(:!shared, :non-blocking);
test-lock :open-for-write, :fails-write, :fails-read,
    args2 => ':non-blocking', args1 => \(:!shared, :!non-blocking);


#?rakudo.jvm skip '[io grant] Could not obtain blocking, shared lock: NonWritableChannelException'
{
    my $file = make-temp-file :content<test>;
    my $fh = $file.open: :r; LEAVE $fh.close;
    $fh.lock: :shared, :non-blocking;
    start { sleep $SLEEP; $fh.unlock }
    is_run qq|my \$fh = '$file'.IO.open: :w; \$fh.lock; print "DONE"|, {
        :err(''), :out<DONE>
    }, 'we get the write lock after shared lock is unlocked';
}

#?rakudo.jvm skip '[io grant] Could not obtain blocking, shared lock: NonWritableChannelException'
{
    my $file = make-temp-file :content<test>;
    my $fh = $file.open: :w; LEAVE $fh.close;
    $fh.lock: :non-blocking;
    start { sleep $SLEEP; $fh.unlock }
    is_run qq|my \$fh = '$file'.IO.open: :r; \$fh.lock: :shared; print "DONE"|, {
        :err(''), :out<DONE>
    }, 'we get the shared lock after exclusive lock is unlocked';
}



# vim: expandtab shiftwidth=4 ft=perl6
