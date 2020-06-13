use v6;
use Test;
plan 7;

#L<S03/"Smart matching"/Any Callable:($) item sub truth>
{
    sub is_even($x) { $x % 2 == 0 }
    sub is_odd ($x) { $x % 2 == 1 }
    ok 4 ~~ &is_even,    'scalar sub truth (unary)';
    ok 4 !~~ &is_odd,    'scalar sub truth (unary, negated smart-match)';
    ok !(3 ~~ &is_even), 'scalar sub truth (unary)';
    ok !(3 !~~ &is_odd), 'scalar sub truth (unary, negated smart-match)';
}

#L<S03/"Smart matching"/Any Callable:() simple closure truth>
{
    sub uhuh { 1 }
    sub nuhuh { Mu }

    ok((Mu ~~ &uhuh), "scalar sub truth");
    ok(!(Mu ~~ &nuhuh), "negated scalar sub false");
}

# https://github.com/rakudo/rakudo/issues/1566
subtest 'no glitches with Routines not doing Callable role' => {
    plan +my @routines := &min, &max, &minmax;
    does-ok $_, Callable, .name for @routines;
}

# vim: expandtab shiftwidth=4
