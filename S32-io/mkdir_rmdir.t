use v6;
use Test;

plan 7;

# Tests for IO::Path.mkdir and IO::Path.rmdir
#
# See also S16-filehandles/mkdir_rmdir.t
# L<S32::IO/IO::Path>

#?niecza skip "mkdir rmdir NYI"
#?rakudo skip "mkdir rmdir NYI"
{
    my $d = testdir();
    $d.mkdir;
    ok $d.e, "$d exists";
    ok $d.d, "$d is a directory";

    $d.rmdir;
    ok !$d.e, "$d was removed";
}

# rmdir soft-fails when dir doesn't exist.
#?niecza skip "rmdir NYI"
#?rakudo skip "rmdir NYI"
#?DOES 1
{
    my $err = testdir().path.rmdir;
    isa_fatal_ok $err, X::IO::Rmdir;
}

# rmdir soft-fail when dir contains files.
#?niecza skip "mkdir rmdir NYI"
#?rakudo skip "mkdir rmdir NYI"
{
    my $dir = testdir();
    $dir.mkdir;
    spurt "$dir/file", "hello world";
    my $err = $dir.rmdir;
    isa_fatal_ok $err, X::IO::Rmdir;

    unlink "$dir/file";
    $dir.rmdir;
}

# mkdir in a dir that doesn't exist
#?niecza skip "mkdir NYI"
#?rakudo skip "mkdir NYI"
{
    my $dir = testdir().child(testdir());
    my $err = $dir.mkdir;
    isa_fatal_ok $err, X::IO::Mkdir;
}

# mkdir a dir that already exists
#?niecza skip "mkdir NYI"
#?rakudo skip "mkdir NYI"
{
    my $dir = testdir();
    $dir.mkdir;
    my $err = $dir.mkdir;
    isa_fatal_ok $err, X::IO::Mkdir;
}

sub testdir {
    my $testdir = "testdir-" ~ 1000000.rand.floor;
    die if $testdir.path.e;
    END try { $testdir.path.rmdir; 1; }
    $testdir.path;
}

sub isa_fatal_ok($e, $wanted) {
    $e ~~ "blow up";
    CATCH { 
        when $wanted {
            ok True, "Got expected " ~ $wanted.perl;
            return;
        }
        default { 
            ok False, "Got wrong error";
            return;
        }
    };
    ok False, "No exception, expected " ~ $wanted.perl;
}

