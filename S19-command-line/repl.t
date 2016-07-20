use v6;
use lib <t/spec/packages>;

use Test;
use Test::Util;

plan 9;

# Sanity check that the repl is working at all.
my $cmd = $*DISTRO.is-win
    ?? "echo exit(42)   | $*EXECUTABLE 1>&2"
    !! "echo 'exit(42)' | $*EXECUTABLE >/dev/null 2>&1";
is shell($cmd).exitcode, 42, 'exit(42) in executed REPL got run';

# RT #119339
#?rakudo.jvm skip 'is_run_repl hangs on JVM'
{
    is_run_repl "say 069\n",
        out => /'69'/,
        err => /'Potential difficulties:'
            .* "Leading 0 is not allowed. For octals, use '0o' prefix,"
            .* 'but note that 69 is not a valid octal number'/,
        'prefix 0 on invalid octal warns in REPL';

    is_run_repl "say 067\n",
        out => /'67'/,
        err => /'Potential difficulties:'
            .* 'Leading 0 does not indicate octal in Perl 6.'
            .* 'Please use 0o67 if you mean that.'/,
        'prefix 0 on valid octal warns in REPL';

    is_run_repl "say 0o67\n", out => /'55'/, err => '',
        'prefix 0o on valid octal works fine in REPL';
}

# RT #70297
{
    my $proc = &CORE::run( $*EXECUTABLE, :in, :out, :err);
    $proc.in.close;

    #?rakudo 2 skip 'Result differs on OSX'
    subtest {
        plan 2;
        is   $proc.err.slurp-rest, '', 'stderr is correct';
        like $proc.out.slurp-rest, /"To exit type 'exit' or '^D'\n> "/,
            'stdout is correct';
    }, 'Pressing CTRL+D in REPL produces correct output on exit';
}

# RT #128470
{
    my $code-to-run = q/[1..99].map:{[$_%%5&&'fizz', $_%%3&&'buzz'].grep:Str}/
        ~ "\nsay 'We are still alive';\n";

    #?rakudo.jvm skip 'is_run_repl hangs on JVM'
    is_run_repl $code-to-run,
        out => /'Cannot resolve caller grep' .* 'We are still alive'/,
        err => '',
        'exceptions from lazy-evaluated things do not crash REPL';
}

# RT #127695
{
    my $temp-dir = $*TMPDIR.child('rakudo-roast-RT127695-test' ~ rand);
    LEAVE {
        try $temp-dir.child('.precomp').rmdir;
        try $temp-dir.rmdir;
    }

    is $temp-dir.mkdir, True,
        'successfully created temp directory to use for -I in test';

    my $proc = &CORE::run(
        $*EXECUTABLE, '-I', $temp-dir.Str, '-MNon::Existent::Module::Blah',
        :in, :out, :err
    );
    $proc.in.write: "say 'hello'\n".encode;
    $proc.in.close;
    like $proc.out.slurp-rest, /'rakudo-roast-RT127695-test'/,
        '-I in REPL works';
}

# RT #128595
{
    #?rakudo.moar todo 'RT 128595'
    #?rakudo.jvm skip 'Proc::Async NYI'
    doesn't-hang \(:w, $*EXECUTABLE, '-M', "SomeNonExistentMod"),
        :in("say 'output works'\n"),
        :out(/'output works'/),
    'REPL with -M with non-existent module';
}
