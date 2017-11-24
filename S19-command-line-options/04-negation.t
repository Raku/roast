use v6;

use lib $?FILE.IO.parent(2).add("packages");

use Test;

plan 3;

use Test::Util;

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
