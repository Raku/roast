use v6;
unit module Test::Util;

use Test;
use MONKEY-GUTS;

sub is-deeply-junction (
    Junction $got, Junction $expected, Str:D $desc
) is export {
    sub junction-guts (Junction $j) {
        my $st = nqp::getattr(nqp::decont($j), Junction, '$!storage');
        do for ^nqp::elems(nqp::decont($st)) {
            given nqp::atpos(nqp::decont($st), $_) {
                when Junction { junction-guts($_).Slip }
                $_
            }
        }
    }

    is-deeply junction-guts($got), junction-guts($expected), $desc;
}

multi sub is-eqv(Seq:D $got, Seq:D $expected, Str:D $desc) is export {
    $got.cache; $expected.cache;
    _is-eqv $got, $expected, $desc;
}
multi sub is-eqv(Seq:D $got, Mu $expected, Str:D $desc) is export {
    $got.cache;
    _is-eqv $got, $expected, $desc;
}
multi sub is-eqv(Mu $got, Seq:D $expected, Str:D $desc) is export {
    $expected.cache;
    _is-eqv $got, $expected, $desc;
}
multi sub is-eqv(Mu $got, Mu $expected, Str:D $desc) is export {
    _is-eqv $got, $expected, $desc;
}
sub _is-eqv (Mu $got, Mu $expected, Str:D $desc) {
    # test inside a sub so we handle Failures
    sub test-eqv (Mu $got, Mu $expected) { $got eqv $expected }

    my $test = test-eqv $got, $expected;
    my $ok = ok ?$test, $desc;
    if !$test {
        my $got_perl      = try { $got.perl };
        my $expected_perl = try { $expected.perl };
        if $got_perl.defined && $expected_perl.defined {
            diag "expected: $expected_perl\n"
                ~ "     got: $got_perl";
        }
    }
    $ok
}

proto sub is_run(|) is export { * }

# No input, no test name
multi sub is_run( Str $code, %expected, *%o ) {
    return is_run( $code, '', %expected, '', |%o );
}

# Has input, but not a test name
multi sub is_run( Str $code, Str $input, %expected, *%o ) {
    return is_run( $code, $input, %expected, '', |%o );
}

# No input, named
multi sub is_run( Str $code, %expected, Str $name, *%o ) {
    return is_run( $code, '', %expected, $name, |%o );
}

multi sub is_run( Str $code, Str $input, %expected, Str $name, *%o ) {
    my %got = get_out( $code, $input, |%o );

    # The test may have executed, but if so, the results couldn't be collected.
    if %got<test_died> {
        return skip 'test died: ' ~ %got<test_died>, 1;
    }

    my $ok = ?1;
    my $tests_aggregated = 0;
    my @diag_q;

    # We check each of the attributes and pass the test only if all are good.
    for <status out err> -> $attr {
        # Attributes not specified are not tested.
        next if !(%expected{$attr}:exists);

        my $attr_good = %got{$attr} ~~ %expected{$attr};

        # The check for this attribute failed.
        # Note why for a diag() after the test failure is reported.
        if !$attr_good {
            @diag_q.push(     "     got $attr: {%got{$attr}.perl}"      );
            if %expected{$attr} ~~ Str|Num {
                @diag_q.push( "expected $attr: {%expected{$attr}.perl}" );
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
    my $fnbase = 'getout';
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
        @actual_args.push: $sep ~ $_ ~ $sep;
    }

    my %out;

    try {
        $clobber( "$fnbase.in", $input );
        $clobber( "$fnbase.code", $code ) if defined $code;

        my $perl6 = ~$*EXECUTABLE;
        my $cmd = $perl6 ~~ m:i/niecza/ ?? "mono $perl6 " !! "$perl6 ";
        $perl6 ~~ s{^perl6} = './perl6';
        $cmd = $perl6 ~ ' ';
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
    my @files = map { "$fnbase.$_" }, <code in out err>;
    for @files -> $f {
        try unlink $f;
        if $f.IO ~~ :e {
            die "Can't unlink '$f'";
        }
    }

    return %out;
}

sub is_run_repl ($code, $desc, :$out, :$err) is export {
    my $proc = &CORE::run( $*EXECUTABLE, :in, :out, :err );
    $proc.in.print: $code;
    $proc.in.close;
    subtest {
        plan +($out, $err).grep: *.defined;
        with $out {
            my $output    = $proc.out.slurp;
            my $test-name = 'stdout is correct';
            when Str      { is      $output, $_, $test-name; }
            when Regex    { like    $output, $_, $test-name; }
            when Callable { ok   $_($output),    $test-name; }

            die "Don't know how to handle :out of type $_.^name()";
        }

        with $err {
            my $output    = $proc.err.slurp;
            my $test-name = 'stderr is correct';
            when Str      { is      $output, $_, $test-name; }
            when Regex    { like    $output, $_, $test-name; }
            when Callable { ok   $_($output),    $test-name; }

            die "Don't know how to handle :err of type $_.^name()";
        }
    }, $desc;
}

multi doesn't-hang (Str $args, $desc, :$in, :$wait = 1.5, :$out, :$err)
is export {
    doesn't-hang \($*EXECUTABLE, '-e', $args), $desc,
        :$in, :$wait, :$out, :$err;
}

multi doesn't-hang (
    Capture $args, $desc = 'code does not hang',
    :$in, :$wait = 1.5, :$out, :$err,
) is export {
    my $prog = Proc::Async.new: |$args;
    my ($stdout, $stderr) = '', '';
    $prog.stdout.tap: { $stdout ~= $^a };
    $prog.stderr.tap: { $stderr ~= $^a };

    # We start two Promises: the program to run and a Promise that waits for
    # $wait seconds. We await any of them, so if the $wait seconds pass,
    # await returns and we follow the path that assumes the code we ran hung.
    my $promise = $prog.start;
    await $prog.write: $in.encode if $in.defined;
    await Promise.anyof: Promise.in($wait * (%*ENV<ROAST_TIMING_SCALE>//1)),
                         $promise;

    my $did-not-hang = False;
    given $promise.status {
        when Kept { $did-not-hang = True };
        $prog.kill;
    }

    subtest $desc, {
        plan 1 + ( $did-not-hang ?? ($out, $err).grep(*.defined) !! 0 );
        ok $did-not-hang, 'program did not hang';
        if $did-not-hang {
            like $stdout, $out, 'STDOUT matches' if $out.defined;
            like $stderr, $err, 'STDERR matches' if $err.defined;
        }
    };
}

multi warns-like (Str $code, |c) is export { warns-like {$code.EVAL}, |c }
multi warns-like (&code, $test, Str $desc) is export {
    my ($did-warn, $message) = False;
    &code();
    CONTROL { when CX::Warn { $did-warn = True; $message = .message; .resume } }

    subtest $desc => {
        plan 2;
        ok $did-warn, 'code threw a warning';
        cmp-ok $message, '~~', $test, 'warning message passes test';
    }
}

multi doesn't-warn (Str $code, |c) is export { doesn't-warn {$code.EVAL}, |c }
multi doesn't-warn (&code, Str $desc) is export {
    my ($did-warn, $message) = False;
    &code();
    CONTROL { when CX::Warn { $did-warn = True; $message = .message; .resume } }

    diag "code must not warn but it produced a warning: $message" if $did-warn;
    nok $did-warn, $desc;
}

sub make-rand-path (--> IO::Path:D) {
    $*TMPDIR.resolve.child: (
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

sub fails-like (&test, $ex-type, $reason?, *%matcher) is export {
    subtest $reason => sub {
        plan 2;
        CATCH { default {
            with "expected code to fail but it threw {.^name} instead" {
                .&flunk;
                .&skip;
                return False;
            }
        }}
        my $res = test;
        isa-ok $res, Failure, 'code returned a Failure';
        throws-like { $res.sink }, $ex-type,
            'Failure threw when sunk', |%matcher,
    }
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
across Perl 6 implementations.

=head1 FUNCTIONS

=head2 is-eqv (Mu $got, Mu $expected, Str:D $description)

Compare two items using `eqv` semantics. Basically this is the same
as L<is-deeply|https://docs.perl6.org/language/testing#index-entry-is-deeply-is-deeply%28%24value%2C_%24expected%2C_%24description%3F%29>
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

You can use named arguments to pass arguments to the perl6 executable
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

=head2 is_run_repl ($code, $desc, :$out, :$err)

    is_run_repl "say 42\nexit\n", :err(''), :out(/"42\n"/),
        'say 42 works fine';

Fires up the REPL and enters the given C<$code>. Be sure to send correct
newlines, as you would press ENTER key when using the REPL manually.

The C<:$out> and C<:$err> named arguments are optional and corresponding
tests are only run when the arguments are specified. They test REPL's STDOUT
and STDERR respectively. Can take Str, Regex, or Callable, which respectively
causes the test to use C<is>, C<like>, or execute the Callable with the output
as the given argument and use C<ok> on its output.

Will close STDIN (equivalent to sending CTRL+D in REPL) after sending the
input, so you do not have to send explicit C<exit\n>

B<NOTE:>
STDOUT will generally contain all the messages displayed by the REPL at the
start.

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
executed program to finish. B<Defaults to:> C<1.5>

=head3 C<:in>

B<Optional>. Takes a C<Str> that will be sent to executed program's STDIN.
B<By default> not specified.

=head3 C<:out>

B<Optional>. Takes a C<Regex> that will be used to match against program's
STDOUT. If the program doesn't finish before C<:wait> seconds, no attempt
to check STDOUT will be made. B<By default> not specified.

=head3 C<:err>

B<Optional>. Takes a C<Regex> that will be used to match against program's
STDERR. If the program doesn't finish before C<:wait> seconds, no attempt
to check STDERR will be made. B<By default> not specified.

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
compare two Junctions for equivalence. I<Note:> this test is rather strict
and will fail even if the two Junctions are functionally equivalent, for
example 1|2 and 2|1 are considered to be different Junctions.

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

=head2 make-temp-dir($chmod?)

    sub make-temp-dir (Int $chmod? --> IO::Path:D)

Creates a semi-randomly named directory in C<$*TMPDIR>, optionally setting
C<$chmod>, and returns an C<IO::Path> pointing to it. Automatically
C<rmdir>s it with C<END> phaser. It's your responsibility to ensure the
directory is empty at that time.

=head2 fails-like(&test, $ex-type, $reason?, *%matcher)

    fails-like(&test, $ex-type, $reason?, *%matcher)

Like C<throws-like> but checks the code C<fail>s (as opposed to C<throw>ing).

Executes C<&test> and uses C<Test.pm>'s C<isa-ok> to check the return value is a
C<Failure>, then uses C<Test.pm>'s <throws-like> to check that C<Failure>
throws the correct exception when sunk.

=end pod

# vim: ft=perl6
