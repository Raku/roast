use v6;
use Test;

plan 9;

isa-ok 10 div 0   , Failure, "10 div 0 softfails";
isa-ok 10 / 0     , Rat, "10 / 0 is a Rat.";
isa-ok 10 / 0.0   , Rat, "10 / 0.0 is a Rat";
isa-ok 10 / 0e0   , Failure, "10 / 0e0 softfails";
isa-ok (1/1) / 0e0, Failure, "(1/1) / 0e0 softfails";
isa-ok 1e0 / (0/1), Failure, "1e0 / (0/1) softfails";

# RT #112678
{
    is -8 div 3, -3, '$x div $y should give same result as floor($x/$y)';
    my int $rt112678 = -8;
    is $rt112678 div 3, -3, 'div works with negative native';
}

if $?BITS >= 64 { # RT #130686
    is-deeply (my int $ = 10000000000000000) div 4, 2500000000000000,
        'large `int` values do not overflow prematurely';
}
else {
    skip "this test doesn't make sense 32bit platforms";
}
