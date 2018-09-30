use v6;
use lib $?FILE.IO.parent(2).add: 'packages';
use Test;
use Test::Util;

plan 9;

is-deeply 10 / 0,   <1/0>, "10 / 0 is a zero-denominator Rat.";
is-deeply 10 / 0.0, <1/0>, "10 / 0.0 is a zero-denominator Rat";
fails-like ｢10 div 0｣,    X::Numeric::DivideByZero, "10 div 0 softfails";
fails-like ｢10 / 0e0｣,    X::Numeric::DivideByZero, "10 / 0e0 softfails";
fails-like ｢(1/1) / 0e0｣, X::Numeric::DivideByZero, "(1/1) / 0e0 softfails";
fails-like ｢1e0 / (0/1)｣, X::Numeric::DivideByZero, "1e0 / (0/1) softfails";

# RT #112678
{
    is-deeply -8 div 3, -3, '$x div $y should give same result as floor($x/$y)';
    my int $rt112678 = -8;
    is-deeply $rt112678 div 3, -3, 'div works with negative native';
}

if $?BITS >= 64 { # RT #130686
    is-deeply (my int $ = 10000000000000000) div 4, 2500000000000000,
        'large `int` values do not overflow prematurely';
}
else {
    skip "this test doesn't make sense 32bit platforms";
}
