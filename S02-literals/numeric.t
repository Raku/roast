use v6;
use Test;

plan *;

isa_ok 1, Int, '1 produces a Int';
ok 1 ~~ Numeric, '1 is Numeric';
ok 1 ~~ Real, '1 is Real';

isa_ok 1.Num, Num, '1.Num produces a Int';
ok 1.Num ~~ Numeric, '1.Num is Numeric';
ok 1.Num ~~ Real, '1.Num is Real';

# L<S02/Literals/Rational literals are indicated>

is_approx 1/2, 0.5, '1/2 Rat literal';
isa_ok 1/2, Rat, '1/2 produces a Rat';
ok 1/2 ~~ Numeric, '1/2 is Numeric';
ok 1/2 ~~ Real, '1/2 is Real';
isa_ok 0x01/0x02, Rat, 'same with hexadecimal numbers';

ok 0x01/0x02 / (0x01/0x02) == 1, 'same with hexadecimal numbers';

# L<S02/Literals/Complex literals are similarly indicated>

isa_ok 1+1i, Complex, '1+1i is a Complex literal';
ok 1+1i ~~ Numeric, '1+1i is Numeric';
nok 1+1i ~~ Real, '1+1i is not Real';

done_testing;

# vim: ft=perl6 sw=4 ts=4 expandtab
