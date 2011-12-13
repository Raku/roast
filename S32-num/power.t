use v6;

use Test;

plan 43;

# Real **
is(0 ** 0,    1, "0 ** 0 ==  1");
is(0 ** 1,    0, "0 ** 1 ==  0");
is(1 ** 2,    1, "1 **  2 ==  1");
is(4 ** 0,    1, "4 **  0 ==  1");
is(4 ** 1,    4, "4 **  1 ==  4");
is(4 ** 2,   16, "4 **  2 == 16");

is(4 ** 0.5,  2, "4 ** .5 ==  2");
is(4 ** (1/2), 2, "4 ** (1/2) == 2 ");
#?niecza skip 'Rat.Str'
is(4 ** (-1/2), 0.5, "4 ** (-1/2) == 1/2 ");
is((-2) ** 2, 4, "-2 ** 2 = 4");

#?niecza todo '#87'
is(1 ** Inf, 1, '1**Inf=1');
is(0 ** Inf, 0, '0**Inf=0');
is(Inf ** 2, Inf, 'Inf**2 = Inf');
is((-Inf) ** 3, -Inf, '(-Inf)**3 = -Inf');
is(Inf ** Inf, Inf, 'Inf**Inf = Inf');
is(NaN ** 2, NaN, "NaN propagates with integer powers");
is(NaN ** 3.14, NaN, "NaN propagates with numeric powers");
is(0 ** NaN, NaN, "0**NaN=NaN");

# Not at all sure the next three cases are correct!

#?niecza 2 skip 'complex NaN stringy'
#?rakudo skip 'NaN**1i should be NaN'
is(NaN ** 1i, NaN, "NaN**1i=NaN");
#?rakudo skip '1i**NaN should be NaN'
is(1i ** NaN, NaN, "1i**NaN=NaN");
#?rakudo skip 'NaN**0 should be NaN'
is(NaN ** 0, NaN, "NaN**0=NaN");

is(NaN ** NaN, NaN, "NaN**NaN=NaN");
is(Inf ** NaN, NaN, "Inf**NaN=NaN");
is(NaN ** Inf, NaN, "NaN**Inf=NaN");

#?niecza 2 skip 'exp'
is_approx(exp(1) ** 0.5,  exp(0.5), "e **  .5 ==   exp(.5)");
is_approx(exp(1) ** 2.5,  exp(2.5), "e ** 2.5 ==  exp(2.5)");

# Complex ** Real
# These work by accident even if you don't have Complex **
is_approx((4 + 0i) ** 2, 4 ** 2, "(4+0i) ** 2 == 16");
is_approx(1i ** 4, 1, "i ** 4 == 1");
is_approx((4 + 0i) ** .5, 2, "(4+0i) ** .5 == 2");

is_approx(1i ** 2, -1, "i ** 2 == -1");
is_approx(1i ** 3, -1i, "i ** 3 == -i");
is_approx(5i ** 3, -125i, "5i ** 3 = -125i");
is_approx(3i ** 3, -27i, "3i ** 3 = -27i");
is_approx((-3i) ** 3, 27i, "-3i ** 3 = 27i");

#?rakudo skip 'i'
is_approx (-1) ** -i, 23.1406926327793, "(-1) ** -i is approx 23.1406926327793";

#?DOES 4
#?niecza skip 'roots'
{
    for (8i).roots(4) -> $z {
        is_approx($z ** 4, 8i, "quartic root of 8i ** 4 = 8i");
    }
}
#?DOES 1

# Real ** Complex
#?niecza skip 'exp'
{
    is_approx(exp(1) ** (pi * 1i), -1, "e ** pi i = -1");
}

# Complex ** Complex
is_approx((4 + 0i) ** (2 + 0i), 4 ** 2, "(4+0i) ** (2+0i) == 16");

# Rat ** a large number
#?niecza 2 skip 'does not work'
ok(1.015 ** 200 !~~ NaN, "1.015 ** 200 is not NaN");
#?rakudo todo 'big numbers'
is_approx(1.015 ** 200, 19.6430286394751, "1.015 ** 200 == 19.6430286394751");

done;

# vim: ft=perl6
