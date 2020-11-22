use v6;
unit module Test::Util;

use Test;
use MONKEY-GUTS;

sub group-of (
    Pair (
        Int:D :key($plan),
        Pair  :value((
            Str:D :key($desc),
                  :value(&tests))))
) is export is test-assertion {
    subtest $desc => {
        plan $plan;
        tests
    }
}

sub is-path(
  IO::Path:D $got, IO::Path:D $exp, Str:D $desc
) is export is test-assertion {
    cmp-ok $got.resolve, '~~', $exp.resolve, $desc;
}

sub is-deeply-junction (
    Junction $got, Junction $expected, Str:D $desc
) is export is test-assertion {
    sub junction-guts (Junction $j) {
        $j.gist ~~ /^ $<type>=(\w+)/;
        my $type := ~$<type>;
        my @guts;
        my $l = Lock.new;
        $j.THREAD: { $l.protect: {
              when Junction { @guts.push: junction-guts $_ }
              @guts.push: $_
          }
        }
        @guts .= sort;
        [$type, @guts]
    }

    is-deeply junction-guts($got), junction-guts($expected), $desc;
}

proto test-iter-opt(|) is export {*}
multi test-iter-opt(
  Iterator:D \iter, @data is raw, Str:D $desc
) is test-assertion  {
    TEST-ITER-OPT iter, @data, +@data, $desc;
}
multi test-iter-opt(
  Iterator:D \iter, UInt:D \items, Str:D $desc
) is test-assertion  {
    TEST-ITER-OPT iter, Nil, items, $desc;
}
sub TEST-ITER-OPT (\iter, \data, \n, $desc,) {
    subtest $desc => {
        plan 3 + 2*n + ($_ with data);
        sub count (\v, $desc) {
            iter.can('count-only')
              ?? is-deeply iter.count-only, v, "count  ($desc)"
              !! skip "iterator does not support .count-only ($desc)";
        }
        sub bool (\v, $desc) {
            iter.can('bool-only')
              ?? is-deeply iter.bool-only, v, "bool   ($desc)"
              !! skip "iterator does not support .bool-only ($desc)";
        }
        for ^n -> $i {
            count  n-$i,  "before pull $i";
            bool ?(n-$i), "before pull $i";
            data andthen is-deeply iter.pull-one, data[$i], "pulled (pull $i)"
                 orelse  iter.pull-one;
        }
        count  0, 'after last pull';
        bool  ?0, 'after last pull';
        ok iter.pull-one =:= IterationEnd, 'one more pull gives IterationEnd';
    }
}

proto sub is-eqv(|) is export {*}
multi sub is-eqv(Seq:D $got, Seq:D $expected, Str:D $desc) is test-assertion {
    $got.cache; $expected.cache;
    _is-eqv $got, $expected, $desc;
}
multi sub is-eqv(Seq:D $got, Mu $expected, Str:D $desc) is test-assertion {
    $got.cache;
    _is-eqv $got, $expected, $desc;
}
multi sub is-eqv(Mu $got, Seq:D $expected, Str:D $desc) is test-assertion {
    $expected.cache;
    _is-eqv $got, $expected, $desc;
}
multi sub is-eqv(Mu $got, Mu $expected, Str:D $desc) is test-assertion {
    _is-eqv $got, $expected, $desc;
}
sub _is-eqv (Mu $got, Mu $expected, Str:D $desc) {
    # test inside a sub so we handle Failures
    sub test-eqv (Mu $got, Mu $expected) { $got eqv $expected }

    my $test = test-eqv $got, $expected;
    my $ok = ok ?$test, $desc;
    if !$test {
        my $got_raku      = try { $got.raku };
        my $expected_raku = try { $expected.raku };
        if $got_raku.defined && $expected_raku.defined {
            diag "expected: $expected_raku\n"
                ~ "     got: $got_raku";
        }
    }
    $ok
}

proto sub is_run(|) is export {*}

# No input, no test name
multi sub is_run( Str $code, %expected, *%o ) is test-assertion {
    return is_run( $code, '', %expected, '', |%o );
}

# Has input, but not a test name
multi sub is_run( Str $code, Str $input, %expected, *%o ) is test-assertion {
    return is_run( $code, $input, %expected, '', |%o );
}

# No input, named
multi sub is_run( Str $code, %expected, Str $name, *%o ) is test-assertion {
    return is_run( $code, '', %expected, $name, |%o );
}

multi sub is_run(
  Str $code, Str $input, %expected, Str $name, *%o
) is test-assertion {
    my %got = get_out( $code, $input, |%o );

    # The test may have executed, but if so, the results couldn't be collected.
    if %got<test_died> {
        return skip 'test died: ' ~ %got<test_died>, 1;
    }

    my $ok = ?1;
    my $tests_aggregated = 0;
    my @diag_q;
    %expected<status> = 0 if
        not %expected<status>:exists
        and (not %expected<err>:exists or %expected<err> ~~ Str and %expected<err> eq '');

    # We check each of the attributes and pass the test only if all are good.
    for <status out err> -> $attr {
        # Attributes not specified are not tested.
        next if !(%expected{$attr}:exists);

        my $attr_good = %got{$attr} ~~ %expected{$attr};

        # The check for this attribute failed.
        # Note why for a diag() after the test failure is reported.
        if !$attr_good {
            @diag_q.push(     "     got $attr: {%got{$attr}.raku}"      );
            if %expected{$attr} ~~ Str|Num {
                @diag_q.push( "expected $attr: {%expected{$attr}.raku}" );
            }
        }

        $ok = $ok && $attr_good;
        $tests_aggregated++;
    }

    if $tests_aggregated == 0 {
        return skip 'nothing tested', 1;
    }

    ok ?$ok, $name;
    diag $_ for @diag_q;

    return;
}

our sub run( Str $code, Str $input = '', *%o) {
    my %got = get_out( $code, $input, |%o );
    if %got<err>:exists && %got<err>.chars {
        diag 'error: ' ~ %got<err>;
    }
    if %got<test_died>:exists && %got<err>.chars {
        diag 'test died: ' ~ %got<test_died>;
    }
    return %got<out>;
}

sub get_out( Str $code, Str $input?, :@args, :@compiler-args) is export {
    if $*DISTRO.name eq 'browser' {
        return CORE::<&run>(:fake-run, $code, $input, :@args, :@compiler-args);
    }

    my $fnbase = $*TMPDIR.add('getout').absolute;
    $fnbase ~= '-' ~ $*PID if defined $*PID;
    $fnbase ~= '-' ~ 1_000_000.rand.Int;

    my $clobber = sub ($a, $b) {
        my $fh = open $a, :w
            or die "Can't create '$a': $!";
        $fh.print( $b );
        $fh.close or die "close failed: $!";
    };

    my @actual_args;
    my $sep = $*DISTRO.is-win ?? q["] !! q['];
    for @args {
        if /<['"]>/ {
            die "Command line arguments may not contain single or double quotes";
        }

        @actual_args.push: $_.match(/\s | \v/)
            ?? $sep ~ $_ ~ $sep
            !! $_;
    }

    my %out;

    try {
        $clobber( "$fnbase.in", $input );
        $clobber( "$fnbase.code", $code ) if defined $code;

        my $cmd = $*EXECUTABLE.absolute ~ ' ';
        $cmd ~= @compiler-args.join(' ') ~ ' ' if @compiler-args;
        $cmd ~= $fnbase ~ '.code'  if $code.defined;
        $cmd ~= " @actual_args.join(' ') < $fnbase.in > $fnbase.out 2> $fnbase.err";
        # diag("Command line: $cmd");
        %out<status> = +shell( $cmd );
        %out<out> = slurp "$fnbase.out";
        %out<err> = slurp "$fnbase.err";

        CATCH { %out<test_died> = ~$! }
    }

    # Try to delete all the temp files written.  If any survive, die.
    my @files = map { "$fnbase.$_".IO }, <code in out err>;
    for @files -> $f {
        unlink $f;
        if $f.e {
            sleep 3;
            $f.unlink or die "Can't unlink '$f': $!";
        }
    }

    return %out;
}

proto doesn't-hang(|) is export {*}
multi doesn't-hang(
  Str $args, $desc, :$in, :$wait = 15, :$out, :$err
) is test-assertion  {
    if $*DISTRO.name eq 'browser' {
        is_run($args, { :$out, :$err }, $desc);
    } else {
        doesn't-hang \($*EXECUTABLE.absolute, '-e', $args), $desc,
            :$in, :$wait, :$out, :$err;
    }
}

# TODO XXX: for some reason shoving this variable inside the routine and
# using `state` instead of `my` results in it having value 0
my $VM-time-scale-multiplier = $*VM.name eq 'jvm' ?? 20/3 !! 1;
multi doesn't-hang (
    Capture $args, $desc = 'code does not hang',
    :$in, :$wait = 15, :$out, :$err,
) is test-assertion  {
    my $prog = Proc::Async.new: |$args;
    my ($stdout, $stderr) = '', '';
    $prog.stdout.tap: { $stdout ~= $^a };
    $prog.stderr.tap: { $stderr ~= $^a };

    # We start two Promises: the program to run and a Promise that waits for
    # $wait seconds. We await any of them, so if the $wait seconds pass,
    # await returns and we follow the path that assumes the code we ran hung.
    my $promise = $prog.start;
    await $prog.write: $in.encode if $in.defined;

    # waiting for the program to hang is broken on the js backend
    if $*VM.name eq 'js' {
        await $promise;
        subtest $desc, {
            plan(+ ($out, $err).grep(*.defined));
            cmp-ok $stdout, '~~', $out, 'STDOUT' if $out.defined;
            cmp-ok $stderr, '~~', $err, 'STDERR' if $err.defined;
        };
        return;
    }

    await Promise.anyof: Promise.in(
        $wait * $VM-time-scale-multiplier * (%*ENV<ROAST_TIMING_SCALE>//1)
    ), $promise;

    my $did-not-hang = False;
    given $promise.status {
        when Kept { $did-not-hang = True };
        $prog.kill;
    }

    subtest $desc, {
        plan 1 + ( $did-not-hang ?? ($out, $err).grep(*.defined) !! 0 );
        ok $did-not-hang, 'program did not hang'
          or diag "\nHang in doesn't-hang() test detected by heuristic.\n"
            ~ "You can set \%*ENV<ROAST_TIMING_SCALE> to a value higher than 1\n"
            ~ "to make it wait longer.\n";
        if $did-not-hang {
            cmp-ok $stdout, '~~', $out, 'STDOUT' if $out.defined;
            cmp-ok $stderr, '~~', $err, 'STDERR' if $err.defined;
        }
    };
}

proto warns-like(|) is export {*}
multi warns-like(Str $code, |c) is test-assertion { warns-like {$code.EVAL}, |c }
multi warns-like(&code, $test, Str $desc) is test-assertion {
    my ($did-warn, $message) = False;
    &code();
    CONTROL { when CX::Warn { $did-warn = True; $message = .message; .resume } }

    subtest $desc => {
        plan 2;
        ok $did-warn, 'code threw a warning';
        cmp-ok $message, '~~', $test, 'warning message passes test';
    }
}

proto doesn't-warn(|) is export {*}
multi doesn't-warn(Str $code, |c) is test-assertion {
    doesn't-warn {$code.EVAL}, |c
}
multi doesn't-warn(&code, Str $desc) is test-assertion {
    my ($did-warn, $message) = False;
    &code();
    CONTROL { when CX::Warn { $did-warn = True; $message = .message; .resume } }

    diag "code must not warn but it produced a warning: $message" if $did-warn;
    nok $did-warn, $desc;
}

sub make-rand-path (--> IO::Path:D) {
    my $p = $*TMPDIR;
    $p.resolve.child: (
        'perl6_roast_',
        $*PROGRAM.basename, '_line',
        ((try callframe(3).code.line)||''), '_',
        rand,
        time,
    ).join.subst: :g, /\W/, '_';
}
my @FILES-FOR-make-temp-file;
my @DIRS-FOR-make-temp-dir;
END {
    unlink @FILES-FOR-make-temp-file;
    rmdir  @DIRS-FOR-make-temp-dir;
}
sub make-temp-path(|c) is export { make-temp-file |c }
sub make-temp-file
    (:$content where Any:U|Blob|Cool, Int :$chmod --> IO::Path:D) is export
{
    @FILES-FOR-make-temp-file.push: my \p = make-rand-path;
    with   $chmod   { p.spurt: $content // ''; p.chmod: $_ }
    orwith $content { p.spurt: $_ }
    p
}
sub make-temp-dir (Int $chmod? --> IO::Path:D) is export {
    @DIRS-FOR-make-temp-dir.push: my \p = make-rand-path;
    p.mkdir;
    p.chmod: $_ with $chmod;
    p
}

proto no-fatal-throws-like(|) is export {*}
multi no-fatal-throws-like(Str:D $test, |c) is test-assertion {
    my $*THROWS-LIKE-CONTEXT = CALLER::;
    throws-like "no fatal; my \$ = do \{ $test }; Nil", |c;
}
multi no-fatal-throws-like(&test, |c) is test-assertion {
    my $*THROWS-LIKE-CONTEXT = CALLER::;
    throws-like { no fatal; my $ = do { test }; Nil }, |c;
}

sub run-with-tty(
    $code, $desc, :$in = '', :$status = 0, :$out = '', :$err = ''
) is export is test-assertion {
    if $*DISTRO.name eq 'ubuntu' and $*KERNEL.release ~~ /:i Microsoft/ {
        skip 'WSL as of Mar 2018 did not support `script` command for test: roast issue #395';
        return;
    }
    state $path = make-temp-file.absolute;
    # on MacOS, `script` doesn't take the command via `c` arg
    state $script = shell(:!out, :!err, 'script -t/dev/null -qc "" /dev/null')
        ?? “script -t/dev/null -qc '"$*EXECUTABLE.absolute()" "$path"' /dev/null”
        !! shell(:!out, :!err, “script -q /dev/null "$*EXECUTABLE.absolute()" -e ""”)
            ?? “script -q /dev/null "$*EXECUTABLE.absolute()" "$path"”
            !! do { skip "need `script` command to run test: $desc"; return }

    subtest $desc => {
        $path.IO.spurt: $code;
        given shell :in, :out, :err, $script {
            plan 3;
            # on MacOS, `script` really wants the ending newline...
            .in.spurt: "$in\n", :close;
            cmp-ok .out.slurp(:close), '~~', $out,    'STDOUT';
            cmp-ok .err.slurp(:close), '~~', $err,    'STDERR';
            cmp-ok .exitcode,  '~~', $status, 'exit code';
        }
    }
}

sub throws-like-any(
  $code, @ex_type, $reason?, *%matcher
) is export is test-assertion {
    subtest {
        plan 2 + %matcher.keys.elems;
        my $msg;
        if $code ~~ Callable {
            $msg = 'code dies';
            $code()
        } else {
            $msg = "'$code' died";
            EVAL $code, context => CALLER::CALLER::CALLER::CALLER::;
        }
        flunk $msg;
        skip 'Code did not die, can not check exception', 1 + %matcher.elems;
        CATCH {
            default {
                pass $msg;
                my $type_ok = $_ ~~ @ex_type.any;
                ok $type_ok , "right exception type (@ex_type.map(*.^name))";
                if $type_ok {
                    for %matcher.kv -> $k, $v {
                        my $got is default(Nil) = $_."$k"();
                        my $ok = $got ~~ $v,;
                        ok $ok, ".$k matches $v.gist()";
                        unless $ok {
                            diag "Expected: " ~ ($v ~~ Str ?? $v !! $v.raku)
                              ~ "\nGot:      $got";
                        }
                    }
                } else {
                    diag "Expected: @ex_type.map(*.^name)\n"
                        ~ "Got:      $_.^name()\n"
                        ~ "Exception message: $_.message()";
                    skip 'wrong exception type', %matcher.elems;
                }
            }
        }
    }, $reason // "did we throws-like @ex_type.map(*.^name)?";
}

sub make-test-dist(%meta6 --> Distribution) is export {
    my $dist-dir = make-temp-dir;
    $dist-dir.IO.child('META6.json').spurt(%meta6.to-json);

    for %meta6<provides>.grep(*.defined) {
        my $to = $dist-dir.IO.child(.value) andthen {.parent.mkdir unless .parent.e}
        $to.spurt: (qq|unit module {.key}; | ~ q|our sub source-file is export { $?FILE }; our sub resources is export { %?RESOURCES };|);
    }

    for %meta6<resources>.grep(*.defined) -> $path {
        my $resources-dir = $dist-dir.child('resources');
        my $to = $path ~~ m/^libraries\/(.*)/
            ?? $resources-dir.add('libraries').add( $*VM.platform-library-name($0.Str.IO) )
            !! $resources-dir.add($path);
        $to.parent.mkdir unless $to.parent.e;
        $to.spurt: (qq|resource|);
    }

    my $dist = Distribution::Path.new($dist-dir);

    return $dist;
}

=begin pod

=head1 NAME

Test::Util - Extra utility code for testing

=head1 SYNOPSIS

  use Test;
  use Test::Util;

  is_run( 'say $*IN.lines',                            # code to run
          'GIGO',                                      # input for code
          { out => "GIGO\n", err => '', status => 0 }, # results expected
          'input comes back out' );                    # test name

=head1 DESCRIPTION

This module is for test code that would be useful
across Raku implementations.

=head1 FUNCTIONS

=head2 group-of
group-of (Pair (Int:D :key($plan), Pair :value((Str:D :key($desc), :value(&tests)))))

A more concise way to write subtests. Code:

    group-of 42 => 'some feature' => {
        ok 1;
        ok 2;
        ...
        ok 42;
    }

Is equivalent to:

    subtest 'some feature' => {
        plan 42;
        ok 1;
        ok 2;
        ...
        ok 42;
    }

=head2 is-path (IO::Path:D $got, IO::Path:D $exp, Str:D $desc)

Tests whether two C<IO::Path> objects reference the same resource.

=head2 is-eqv (Mu $got, Mu $expected, Str:D $description)

Compare two items using `eqv` semantics. Basically this is the same
as L<is-deeply|https://docs.raku.org/language/testing#index-entry-is-deeply-is-deeply%28%24value%2C_%24expected%2C_%24description%3F%29>
except without the C<Seq>-converted-to-C<List> issue, so you can
compare C<Seq> with a C<List> and the test will fail (while
C<is-deeply> would succeed if the elements are the same).

Can test only C<Any> arguments,
with C<Mu>s only accepted to handle C<Junctions>.


=head2 is_run( Str $code, Str $input?, %wanted, Str $name?, :@args, :@compiler-args )

It runs the code given, feeding it the input given, and collects results
in the form of its stdout, stderr, and exit status.  The %wanted hash
specifies which of these to check and what to check them against.
Every item in the hash must "match" for the is_run() test to pass.
For example:

   {
       out    => "Hello world!\n",   # outputs Hello world!
       err    => '',                 # no error output
       status => 0,                  # standard successful exit
   },

Any of those items not present in the %wanted hash will not be tested
(that is, the test passes regardless of the results of those items).
For example, if 'status' is not specified, the test passes regardless
of what the code's exit status was.

Each item can be a string, a Regexp, or a Callable.  Strings must match
exactly.

A Callable is passed the result, and the test passes
if the Callable returns a true value.
For example:

  is_run( 'rand.say', { out => sub { $^a > 0 && $^a < 1 }, err => '' },
          'output of rand is between zero and one' );

You can use named arguments to pass arguments to the Raku executable
(C<:compiler-args>) or to the program being run (C<:args>):

    is_run 'use Foo; sub MAIN (:$test) {...}',
        :args['--test'], :compiler-args['-I', 'lib'];

=head3 Errors

If the underlying code could not be executed properly (e.g., because
temp files could not be accessed), is_run() will skip().

If the %wanted hash passed in does not contain any of the items it checks,
is_run() will skip() (but it will still execute the code not being tested).

is_run() depends on get_out(), which might die.  In that case, it dies
also (this error is not trapped).

=head2 doesn't-hang ( ... )

    doesn't-hang 'say "some code"' :out(/'some code'/),
        'some code does not hang';

    doesn't-hang \(:w, $*EXECUTABLE, '-M', "SomeNonExistentMod"),
        :in("say 'output works'\nexit\n"),
        :out(/'output works'/),
    'REPL with -M with non-existent module';

Uses C<Proc::Async> to execute a potentially-hanging program and kills it after
a specified timeout, if it doesn't surrender peacefully. Collects STDERR
and STDOUT, optional taking regex matchers for additional testing. Takes
the following arguments:

=head3 First positional argument

    'say "some code"'

    \(:w, $*EXECUTABLE, '-M', "SomeNonExistentMod")

B<Mandatory.> Can be a C<Capture> or a C<Str>. A C<Capture> represents
arguments to pass to C<Proc::Async.new()>. If C<Str> is passed, it is treated
as if a capture with C<\($*EXECUTABLE, '-e', $code-to-run)> passed, where
C<$code-to-run> is the code contained in the passed C<Str>.

=head3 Second positional argument

B<Optional.> Takes a C<Str> for test description. B<Defaults to:>
C<'code does not hang'>

=head3 C<:wait>

B<Optional.> Specifies the amount of time in seconds to wait for the
executed program to finish. B<Defaults to:> C<5>; on JVM backend, an
additional multipler of C<20/3> is used as currently that backend takes
longer to start procs.

=head3 C<:in>

B<Optional>. Takes a C<Str> that will be sent to executed program's STDIN.
B<By default> not specified.

=head3 C<:out>

B<Optional>. Takes a C<.defined> object that will be smartmatched against
C<Str> containing program's STDOUT. If the program doesn't finish before
C<:wait> seconds, no attempt to check STDOUT will be made. B<By default>
not specified.

=head3 C<:err>

B<Optional>. Takes a C<.defined> object that will be smartmatched against
C<Str> containing program's STDERR. If the program doesn't finish before
C<:wait> seconds, no attempt to check STDERR will be made. B<By default>
not specified.

=head2 get_out( Str $code, Str $input?, :@args )

This is what is_run() uses to do its work.  It returns a hash with the
'status', 'err', and 'out' of the code run.  In addition, if the hash
it returns has an element named 'test_died', that means it failed to
either run the code or collect the results.  Any other elements of the
hash should be disregarded.

C<:@args> can contain command line arguments passed to the program.
They may not contain quote characters, or get_out will complain loudly.

=head3 Errors

This will die if it can't clean up the temp files it uses to do its work.
All other errors should be trapped and reported via the 'test_died' item.

=head2 is-deeply-junction( Junction $got, Junction $expected, Str:D $desc)

Guts two junctions and uses C<is-deeply> test on those guts. Use to
compare two Junctions for equivalence. The test relies on given Junction to
be gistable, and their guts to be sortable and usable in C<is-deeply>, thus,
for example, Junctions containing lazy lists cannot be used with this
routine.

=head2 warns-like($code-or-str-to-eval, $expected, $desc)

    multi warns-like (Str $code, |c)  { warns-like {$code.EVAL}, |c }
    multi warns-like (&code, $test, Str $desc) {

Catches warnings emited by the provided code (or, if Str is provided,
the EVAL of that Str) and smartmatches them against `$test`, using `cmp-ok`
to do the test..

=head2 doesn't-warn($code-or-str-to-eval, $desc)

    multi doesn't-warn (Str $code, |c)  { warns-like {$code.EVAL}, |c }
    multi doesn't-warn (&code, Str $desc) {

B<NOTE: currently this sub won't catch COMPILE TIME warnings!>

Tests whether the code warns, passing the test if it doesn't.

=head2  make-temp-file(:$content, :$chmod)

    sub make-temp-file(:$content where Blob|Cool, Int :$chmod --> IO::Path:D)

Creates a semi-random path in C<$*TMPDIR>, optionally setting C<$chmod> and
spurting C<$content> into it. If C<$chmod> is set, but C<$content> isn't,
spurts an empty string. Automatically deletes the file with C<END> phaser.

=head2  make-temp-path(:$content, :$chmod)

Alias for C<make-temp-file>

=head2 make-temp-dir($chmod?)

    sub make-temp-dir (Int $chmod? --> IO::Path:D)

Creates a semi-randomly named directory in C<$*TMPDIR>, optionally setting
C<$chmod>, and returns an C<IO::Path> pointing to it. Automatically
C<rmdir>s it with C<END> phaser. It's your responsibility to ensure the
directory is empty at that time.

=head2 run-with-tty

    sub run-with-tty (
        $code, $desc, :$in = '', :$status = 0, :$out = '', :$err = ''
    )

Puts C<$code> into a file, and runs it with C<$*EXECUTABLE> using C<`script`>
command line utility, if available, or skips the tests if not. Appends C<\n> to
C<$in> (MacOS's C<`script`> seems to require it), and sends it to the program.
Then performs three smartmatch tests against C<$status> (exitcode), C<$out>
(slurped STDOUT content) and C<$err> (slurped STDERR content).

At the time of this writing, on MacOS's STDOUT seems to be prefixed with
STDIN and C<^D\b\b> chars after it when running Rakudo compiler.

Note that some variations of C<script> command might be passing C/dev/null>
as first argument to your code. This is due to current implementation of
this test routine trying to ignore the generation of timing file.

=head2 no-fatal-throws-like

Same as Test.pm6's C<throws-like>, except wraps the given code into
C<no fatal; my $ = do { … }; Nil>. The point of that is if the code merely
does C<fail()> instead of C<throw()>, then the test will detect that and fail.

=head2 C<test-iter-opt>

    multi test-iter-opt (Iterator:D \iter, @data is raw,  Str:D $desc)
    multi test-iter-opt (Iterator:D \iter, UInt:D \items, Str:D $desc)

Tests the data pulled from C<iter> matches corresponding values in C<@data>,
if provided, and, if they're implemented, tests the values of C<.count-only> and
C<.bool-only> methods before iterating the L<Iterator>, after each pull,
after last pull, and after C<IterationEnd> has been received.

Instead of providing C<@data>, you can simply provide the number of values
you're expecting. This lets you test iterators for which you cannot predict
the order/content of pulled values.

=head2 C<throws-like-any>

    sub throws-like-any($code, @ex_type, $reason?, *%matcher);

Same C<throws-like> except takes a C<Positional> for exception types and
the test passes if any of those exceptions are thrown.

=head2 make-test-dist(%meta6)

    sub make-test-dist (%meta6 --> Distribution)

Creates a C<CompUnit::Repository::FileSystem> compatible C<Distribution::Path>
and an on-disk representation. It uses the module names, module paths, and resources as
declared in C<%meta6>. Each generated module will export a subroutine C<source-file> which
will return its C<$?FILE>, and a subroutine C<resources> which will return its C<%?RESOURCES>.

=end pod

# vim: expandtab shiftwidth=4
