use v6;
use Test;
use lib $?FILE.IO.parent(2).add("packages/Test-Helpers");
use Test::Util;

plan 89;

# Real **
is-deeply(0 ** 0,    1, "0 ** 0 ==  1");
is-deeply(0 ** 1,    0, "0 ** 1 ==  0");
is-deeply(1 ** 2,    1, "1 **  2 ==  1");
is-deeply(4 ** 0,    1, "4 **  0 ==  1");
is-deeply(4 ** 1,    4, "4 **  1 ==  4");
is-deeply(4 ** 2,   16, "4 **  2 == 16");

my $large-even = 4553535345364535345634543534;
my $large-odd  = 4553535345364535345634543533;
is-deeply      0  ** $large-even,   0, "  0 ** $large-even == 0";
is-deeply      1  ** $large-even,   1, "  1 ** $large-even == 1";
is-deeply    1e0  ** $large-even, 1e0, "1e0 ** $large-even == 1";
is-deeply    (-1) ** $large-even,   1, " -1 ** $large-even == 1";
is-deeply    (-1) ** $large-odd,   -1, " -1 ** $large-odd  == -1";

is-approx(4 ** 0.5,  2, "4 ** .5 ==  2");
is-approx(4 ** (1/2), 2, "4 ** (1/2) == 2 ");
is-approx(4 ** (-1/2), 0.5, "4 ** (-1/2) == 1/2 ");
is-deeply((-2) ** 2, 4, "-2 ** 2 = 4");

is-deeply(1 ** Inf, 1e0, '1**Inf=1');
is-deeply(0 ** Inf, 0e0, '0**Inf=0');
is-deeply(Inf ** 2, Inf, 'Inf**2 = Inf');
is-deeply((-Inf) ** 3, -Inf, '(-Inf)**3 = -Inf');
is-deeply(Inf ** Inf, Inf, 'Inf**Inf = Inf');
is-deeply(NaN ** 2, NaN, "NaN propagates with integer powers");
is-deeply(NaN ** 3.14, NaN, "NaN propagates with numeric powers");
is-deeply(0 ** NaN, NaN, "0**NaN=NaN");

# Not at all sure the next two cases are correct!

#?rakudo 2 todo 'wrong results for "NaN" used with "**"'
is-deeply(NaN ** 1i, NaN, "NaN**1i=NaN");
is-deeply(1i ** NaN, NaN, "1i**NaN=NaN");
# https://github.com/Raku/old-issue-tracker/issues/3804
is-deeply(NaN ** 0, 1e0, "NaN**0=1");
# https://github.com/Raku/old-issue-tracker/issues/5752
is-deeply(1 ** NaN, 1e0, '1**NaN=1');

is-deeply(NaN ** NaN, NaN, "NaN**NaN=NaN");
is-deeply(Inf ** NaN, NaN, "Inf**NaN=NaN");
is-deeply(NaN ** Inf, NaN, "NaN**Inf=NaN");

is-approx(exp(1) ** 0.5,  exp(0.5), "e **  .5 ==   exp(.5)");
is-approx(exp(1) ** 2.5,  exp(2.5), "e ** 2.5 ==  exp(2.5)");

# Complex ** Real
# These work by accident even if you don't have Complex **
is-approx((4 + 0i) ** 2, 4 ** 2, "(4+0i) ** 2 == 16");
is-approx(1i ** 4, 1, "i ** 4 == 1");
is-approx((4 + 0i) ** .5, 2, "(4+0i) ** .5 == 2");

is-approx(1i ** 2, -1, "i ** 2 == -1");
is-approx(1i ** 3, -1i, "i ** 3 == -i");
is-approx(5i ** 3, -125i, "5i ** 3 = -125i");
is-approx(3i ** 3, -27i, "3i ** 3 = -27i");
is-approx((-3i) ** 3, 27i, "-3i ** 3 = 27i");

#?rakudo todo 'i'
is-approx (-1) ** -i, 23.1406926327793, "(-1) ** -i is approx 23.1406926327793";

{
    for (8i).roots(4) -> $z {
        is-approx($z ** 4, 8i, "quartic root of 8i ** 4 = 8i");
    }
}

# Real ** Complex
{
    is-approx(exp(1) ** (pi * 1i), -1, "e ** pi i = -1");
}

# Complex ** Complex
is-approx((4 + 0i) ** (2 + 0i), 4 ** 2, "(4+0i) ** (2+0i) == 16");

# Rat ** a large number
ok(1.015 ** 200 !~~ NaN, "1.015 ** 200 is not NaN");
is-approx(1.015 ** 200, 19.6430286394751, "1.015 ** 200 == 19.6430286394751");

is-deeply(0⁰,    1, "0⁰ ==  1");
is-deeply(0¹,    0, "0¹ ==  0");
is-deeply(1²,    1, "1² ==  1");
is-deeply(4⁰,    1, "4⁰ ==  1");
is-deeply(4¹,    4, "4¹ ==  4");
is-deeply(4²,   16, "4² == 16");
is-deeply(2³²,  2 ** 32, "2³² == 2 ** 32");
is-deeply(2⁶⁴,  2 ** 64, "2⁶⁴ == 2 ** 64");
is-deeply(10¹⁰⁰,  10 ** 100, "10¹⁰⁰ == 10 ** 100");

# Test corresponding curried forms

is-deeply(*⁰(0),    1, "*⁰(0) ==  1");
is-deeply(*¹(0),    0, "*¹(0) ==  0");
is-deeply(*²(1),    1, "*²(1) ==  1");
is-deeply(*⁰(4),    1, "*⁰() ==  1");
is-deeply(*¹(4),    4, "*¹() ==  4");
is-deeply(*²(4),   16, "*²() == 16");
is-deeply(*³²(2),  2 ** 32, "*³²(2) == 2 ** 32");
is-deeply(*⁶⁴(2),  2 ** 64, "*⁶⁴(2) == 2 ** 64");
is-deeply(*¹⁰⁰(10),  10 ** 100, "*¹⁰⁰(10) == 10 ** 100");

# Test some odd numbers too.

is-deeply(3³,  *³(3), "3³");
is-deeply(3⁴,  *⁴(3), "3⁴");
is-deeply(3⁵,  *⁵(3), "3⁵");
is-deeply(3⁶,  *⁶(3), "3⁶");
is-deeply(3⁷,  *⁷(3), "3⁷");
is-deeply(3⁸,  *⁸(3), "3⁸");
is-deeply(3⁹,  *⁹(3), "3⁹");
is-deeply(3¹⁰, *¹⁰(3), "3¹⁰");
is-deeply(3¹³, *¹³(3), "3¹³");
is-deeply((-1)¹²³, *¹²³(-1), "(-1)¹²³");

is-deeply    0⁴⁵⁵³⁵³⁵³⁴⁵³⁶⁴⁵³⁵³⁴⁵,   0, "   0⁴⁵⁵³⁵³⁵³⁴⁵³⁶⁴⁵³⁵³⁴⁵ ==  0";
is-deeply    1⁴⁵⁵³⁵³⁵³⁴⁵³⁶⁴⁵³⁵³⁴⁵,   1, "   1⁴⁵⁵³⁵³⁵³⁴⁵³⁶⁴⁵³⁵³⁴⁵ ==  1";
is-deeply  1e0⁴⁵⁵³⁵³⁵³⁴⁵³⁶⁴⁵³⁵³⁴⁵, 1e0, " 1e0⁴⁵⁵³⁵³⁵³⁴⁵³⁶⁴⁵³⁵³⁴⁵ ==  1";
is-deeply (-1)⁴⁵⁵³⁵³⁵³⁴⁵³⁶⁴⁵³⁵³⁵⁴,   1, "(-1)⁴⁵⁵³⁵³⁵³⁴⁵³⁶⁴⁵³⁵³⁵⁴ ==  1";
is-deeply (-1)⁴⁵⁵³⁵³⁵³⁴⁵³⁶⁴⁵³⁵³⁴⁵,  -1, "(-1)⁴⁵⁵³⁵³⁵³⁴⁵³⁶⁴⁵³⁵³⁴⁵ == -1";

#?rakudo.jvm 6 todo 'got: 1'
is-approx(4 ** ½,  2, "4 ** ½ ==  2");
is-approx(4 ** -½, ½, "4 ** -½ == ½");
is-approx(27 ** ⅓, 3, "27 ** ⅓ ==  3");
is-approx(27 ** ⅔, 9, "27 ** ⅔ ==  9");
is-approx(27 ** -⅓, ⅓, "27 ** -⅓ == ⅓");
is-approx(27 ** -⅔, ⅑, "27 ** -⅔ == ⅑");

# https://github.com/Raku/old-issue-tracker/issues/4787

#?rakudo.jvm skip 'unival NYI'
#?DOES 1
{
  subtest 'power ops with uncommon No chars as terms work' => {
    my @nos = <⁰ ¹ ² ³ ⁴ ⁵ ⁶ ⁷ ⁸ ⁹ ⅟ 𑁓 ౸ ㆒ 𐌣 >;
    plan 5*@nos;
    for @nos -> $no {
        my $v = unival $no;
        is-deeply .EVAL, $v**12,  $_ with "$no¹²";
        is-deeply .EVAL, $v**12,  $_ with "$no⁺¹²";
        is-deeply .EVAL, $v**-12, $_ with "$no⁻¹²";
        is-deeply "$no¯¹²".EVAL, $v**-12, "$no¯¹² (macron)";

        is-deeply .EVAL, 2**$v**2, $_ with "2**$no²";
    }
  }
}

# vim: expandtab shiftwidth=4
