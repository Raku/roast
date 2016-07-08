use v6;
use lib <t/spec/packages>;

use Test;
use Test::Util;

plan 5;

# Sanity check that the repl is working at all.
my $cmd = $*DISTRO.is-win
    ?? "echo exit(42)   | $*EXECUTABLE 1>&2"
    !! "echo 'exit(42)' | $*EXECUTABLE >/dev/null 2>&1";
is shell($cmd).exitcode, 42, 'exit(42) in executed REPL got run';

{
    # RT #119339
    is_run_repl "say 069\nexit\n", {
        out => /'69'/,
        err => /'Potential difficulties:'
            .* "Leading 0 is not allowed. For octals, use '0o' prefix,"
            .* 'but note that 69 is not a valid octal number'/
    }, 'prefix 0 on invalid octal warns in REPL';

    is_run_repl "say 067\nexit\n", {
        out => /'67'/,
        err => /'Potential difficulties:'
            .* 'Leading 0 does not indicate octal in Perl 6.'
            .* 'Please use 0o67 if you mean that.'/
    }, 'prefix 0 on valid octal warns in REPL';

    is_run_repl "say 0o67\nexit\n", { out => /'55'/, err => '' },
        'prefix 0o on valid octal works fine in REPL';
}

{
    # RT #70297
    my $proc = &CORE::run( $*EXECUTABLE, :in, :out, :err);
    $proc.in.close;
    subtest {
        plan 2;
        is   $proc.err.slurp-rest, '', 'stderr is correct';
        like $proc.out.slurp-rest, /"To exit type 'exit' or '^D'\n> "/,
            'stdout is correct';
    }, 'Pressing CTRL+D in REPL produces correct output on exit';
}
