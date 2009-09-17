use v6;
use Test;

plan *;

# L<S02/Literals/Rational literals are indicated>

is_approx 1/2, 0.5, '1/2 Rat literal';
isa_ok 1/2, Rat, '1/2 produces a Rat';
isa_ok 0x01/0x02, Rat, 'same with hexadecimal numbers';

ok 1/2 / 1/2 == 1, '1/2 / 1/2 parses as division of two Rat terms';
ok 0x01/0x02 / 0x01/0x02 == 1, 'same with hexadecimal numbers';
is 1/2 ** 3, 1/8,
   '1/2 is a term, and has tighter precedence than infix<**>';

# L<S02/Literals/Complex literals are similarly indicated>

isa_ok 1+1i, Complex, '1+1i is a Complex literal';
is_approx 1+1i * 2, 2+2i,
        '1+1i is a term, with tighter precedence than infix:<+>';
is_approx 5.2+1e42i / 2, 2.7+0.5e42i, 'works with scientific notation too';

done_testing;

# vim: ft=perl6 sw=4 ts=4 expandtab
