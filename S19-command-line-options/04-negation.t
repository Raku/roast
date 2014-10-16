use v6;

use Test;

plan 3;

use lib 't/spec/packages';
use Test::Util;

my Str $x;

#L<S19/Options and Values/Options may be negated with>

#?rakudo skip negation NYI
{
    is_run $x, :args['--/stagestats', '-e', 'say "hi"'],
        {
            out     => "hi",
            err     => "",
            status  => 0,
        },
        "negating stagestats doesn't print them";

    is_run $x, :args['-/hv'],
        {
            out     => '',
            err     => { m/"SORRY" .+ "cannot be negated"/ }
        },
        "negation of multiple short options fails";

    is_run $x, :args['--/target', 'foo'],
        {
            out     => '',
            err     => { m/"SORRY" .+ "cannot be negated"/ }
        },
        "negation of multiple short options fails";
}
