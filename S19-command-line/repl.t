use v6;
use Test;
plan 4;

# Sanity check that the repl is working at all.
my $cmd = $*DISTRO.is-win
    ?? "echo exit(42)   | $*EXECUTABLE 1>&2"
    !! "echo 'exit(42)' | $*EXECUTABLE >/dev/null 2>&1";
is shell($cmd).exitcode, 42, 'exit(42) in executed REPL got run';

{
    # RT #119339
    subtest { plan 2;
        my $proc = run $*EXECUTABLE, :in, :out, :err;
        $proc.in.print: "say 069\nexit\n";
        like $proc.out.slurp-rest, /'69'/, 'stdout contains the number';
        like $proc.err.slurp-rest, /'Potential difficulties:'
            .* "Leading 0 is not allowed. For octals, use '0o' prefix,"
            .* 'but note that 69 is not a valid octal number'
        /, 'stderr contains correct warning';
    }, 'prefix 0 on invalid octal warns in REPL';

    subtest { plan 2;
        my $proc = run $*EXECUTABLE, :in, :out, :err;
        $proc.in.print: "say 067\nexit\n";
        like $proc.out.slurp-rest, /'67'/, 'stdout contains the number';
        like $proc.err.slurp-rest, /'Potential difficulties:'
            .* 'Leading 0 does not indicate octal in Perl 6.'
            .* 'Please use 0o67 if you mean that.'
        /, 'stderr contains correct warning';
    }, 'prefix 0 on valid octal warns in REPL';

    subtest { plan 2;
        my $proc = run $*EXECUTABLE, :in, :out, :err;
        $proc.in.print: "say 0o67\nexit\n";
        like $proc.out.slurp-rest, /'55'/, 'stdout contains the number';
        is   $proc.err.slurp-rest,     '', 'stderr is empty';
    }, 'prefix 0o on valid octal works fine in REPL';
}
