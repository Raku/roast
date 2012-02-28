use v6;
use Test;
plan 6;

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
#?pugs skip 'Mu'
{
    sub uhuh { 1 }
    sub nuhuh { Mu }

    ok((Mu ~~ &uhuh), "scalar sub truth");
    ok(!(Mu ~~ &nuhuh), "negated scalar sub false");
}

done;

# vim: ft=perl6
