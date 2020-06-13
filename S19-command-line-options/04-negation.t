use v6;
use Test;
use lib $?FILE.IO.parent(2).add("packages/Test-Helpers");
use Test::Util;

plan 3;

my Str $x;

#L<S19/Options and Values/Options may be negated with>

#?rakudo todo ''
{
    is_run $x, :args['-/h', '-e', 'say q[hi]'],
        {
            out     => "hi\n",
            err     => "",
            status  => 0,
        },
        "negating stagestats doesn't print them";

    is_run $x, :args['-/hv'],
        {
            out     => rx/"SORRY" .+ "cannot be negated"/,
            err     => '',
        },
        "negation of multiple short options fails";

    is_run $x, :args['--/target', 'foo'],
        {
            out     => rx/"SORRY" .+ "cannot be negated"/,
            err     => '',
        },
        "negation of short option that needs a value fails";
}

# vim: expandtab shiftwidth=4
