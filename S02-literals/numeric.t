use v6;
use Test;

plan *;

# L<S02/Literals/Rational literals are indicated>

is_approx 1/2, 0.5, '1/2 Rat literal';
isa_ok 1/2, Rat, '1/2 produces a Rat';
isa_ok 0x01/0x02, Rat, 'same with hexadecimal numbers';

ok 0x01/0x02 / (0x01/0x02) == 1, 'same with hexadecimal numbers';

# L<S02/Literals/Complex literals are similarly indicated>

isa_ok 1+1i, Complex, '1+1i is a Complex literal';

done_testing;

# vim: ft=perl6 sw=4 ts=4 expandtab
