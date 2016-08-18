use v6;
use lib <t/spec/packages>;

use Test;
use Test::Util;

plan 10;

# Sanity check that the repl is working at all.
my $cmd = $*DISTRO.is-win
    ?? "echo exit(42)   | $*EXECUTABLE 1>&2"
    !! "echo 'exit(42)' | $*EXECUTABLE >/dev/null 2>&1";
is shell($cmd).exitcode, 42, 'exit(42) in executed REPL got run';

# RT #119339
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

    is_run_repl $code-to-run,
        out => /'Cannot resolve caller grep' .* 'We are still alive'/,
        err => '',
        'exceptions from lazy-evaluated things do not crash REPL';
}

# RT #127933
{
    my $code = [~]  'my ( int8 $a,  int16 $b,  int32 $c,  int64 $d,',
                        'uint8 $e, uint16 $f, uint32 $g, uint64 $h,',
                                              'num32 $i,  num64 $j,',
                    ') = 1, 2, 3, 4, 5, 6, 7, 8, 9e0, 10e0;';

    #?rakudo todo 'RT#127933'
    is_run_repl "$code\nsay 'test is good';\n",
        :err(''),
        :out(/'(1 2 3 4 5 6 7 8 9 10)' .* 'test is good'/),
    'Using native numeric types does not break REPL';
}

# RT #128595
{
    # REPL must not start, but if it does start and wait for input, it'll
    # "hang", from our point of view, which the test function will detect
    doesn't-hang \(:w, $*EXECUTABLE, '-M', "NonExistentModuleRT128595"),
        :out(/^$/),
        :err(/'Could not find NonExistentModuleRT128595'/),
    'REPL with -M with non-existent module does not start';
}

# RT #128973
{
    is_run_repl "my \$x = 42;\nsay qq/The value is \$x/;\n",
        :err(''),
        :out(/'The value is 42'/),
    'variables persist across multiple lines of input';
}

{
    # If the REPL evaluates all of the previously-entered code on each
    # entered line of code, then we'll have more than just two 'say' print
    # outs. So we check the output just for those two, and use look arounds
    # to ensure we don't have those printed elsewhere in the output
    my $code = join "\n", map { "say 'testing-repl-$_';"}, <one two>;
    is_run_repl "$code\n",
        :err(''),
        :out({
                $^o.comb('testing-repl-one') == 1
            and $^o.comb('testing-repl-two') == 1
        }),
    'previously-entered code must not be re-run on every line of input';
}
