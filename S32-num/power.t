use v6;
use lib 't/spec/packages';
use Test;
use Test::Util;

plan 78;

# Real **
is(0 ** 0,    1, "0 ** 0 ==  1");
is(0 ** 1,    0, "0 ** 1 ==  0");
is(1 ** 2,    1, "1 **  2 ==  1");
is(4 ** 0,    1, "4 **  0 ==  1");
is(4 ** 1,    4, "4 **  1 ==  4");
is(4 ** 2,   16, "4 **  2 == 16");

my $big-e = 4553535345364535345634543534;
my $big-o = 4553535345364535345634543533;
my $xno = X::Numeric::Overflow;

is 0 ** $big-e,     0, "0 ** $big-e == 0";
is 1 ** $big-e,     1, "1 ** $big-e == 1";
is 1e0 ** $big-e,   1, "1e0 ** $big-e == 1";
isa-ok 1e0 ** $big-e, Num, "1e0 ** $big-e is a Num";
is (-1) ** $big-e,  1, "-1 ** $big-e == 1";
is (-1) ** $big-o, -1, "-1 ** $big-o == -1";
#?niecza skip "Slow and wrong"
throws-like { EVAL qq[  2 ** $big-e]  }, $xno, " 2 ** $big-e";
#?niecza 2 skip "Slow and wrong"
throws-like { EVAL qq[(-2) ** $big-e] }, $xno, "-2 ** $big-e";
throws-like { EVAL qq[(-2) ** $big-o] }, $xno, "-2 ** $big-o";

is(4 ** 0.5,  2, "4 ** .5 ==  2");
is(4 ** (1/2), 2, "4 ** (1/2) == 2 ");
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

# Not at all sure the next two cases are correct!

#?niecza 2 todo 'complex NaN stringy'
#?rakudo 2 todo 'wrong results for "NaN" used with "**" RT #124800'
is(NaN ** 1i, NaN, "NaN**1i=NaN");
is(1i ** NaN, NaN, "1i**NaN=NaN");
# RT #124450
is(NaN ** 0, 1, "NaN**0=1");

is(NaN ** NaN, NaN, "NaN**NaN=NaN");
is(Inf ** NaN, NaN, "Inf**NaN=NaN");
is(NaN ** Inf, NaN, "NaN**Inf=NaN");

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

#?rakudo todo 'i RT #124810'
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

is(0⁰,    1, "0⁰ ==  1");
is(0¹,    0, "0¹ ==  0");
is(1²,    1, "1² ==  1");
is(4⁰,    1, "4⁰ ==  1");
is(4¹,    4, "4¹ ==  4");
is(4²,   16, "4² == 16");
is(2³²,  2 ** 32, "2³² == 2 ** 32");
is(2⁶⁴,  2 ** 64, "2⁶⁴ == 2 ** 64");
is(10¹⁰⁰,  10 ** 100, "10¹⁰⁰ == 10 ** 100");

is 0⁴⁵⁵³⁵³⁵³⁴⁵³⁶⁴⁵³⁵³⁴⁵, 0, "0⁴⁵⁵³⁵³⁵³⁴⁵³⁶⁴⁵³⁵³⁴⁵ == 0";
is 1⁴⁵⁵³⁵³⁵³⁴⁵³⁶⁴⁵³⁵³⁴⁵, 1, "1⁴⁵⁵³⁵³⁵³⁴⁵³⁶⁴⁵³⁵³⁴⁵ == 1";
is 1e0⁴⁵⁵³⁵³⁵³⁴⁵³⁶⁴⁵³⁵³⁴⁵, 1, "1e0⁴⁵⁵³⁵³⁵³⁴⁵³⁶⁴⁵³⁵³⁴⁵ == 1";
isa-ok 1e0⁴⁵⁵³⁵³⁵³⁴⁵³⁶⁴⁵³⁵³⁴⁵, Num, "1e0⁴⁵⁵³⁵³⁵³⁴⁵³⁶⁴⁵³⁵³⁴⁵ is a Num";
is (-1)⁴⁵⁵³⁵³⁵³⁴⁵³⁶⁴⁵³⁵³⁵⁴, 1, "(-1)⁴⁵⁵³⁵³⁵³⁴⁵³⁶⁴⁵³⁵³⁵⁴ == 1";
is (-1)⁴⁵⁵³⁵³⁵³⁴⁵³⁶⁴⁵³⁵³⁴⁵, -1, "(-1)⁴⁵⁵³⁵³⁵³⁴⁵³⁶⁴⁵³⁵³⁴⁵ == -1";
#?niecza skip "Slow and wrong"
throws-like { EVAL qq[2⁴⁵⁵³⁵³⁵³⁴⁵³⁶⁴⁵³⁵³⁴⁵] }, $xno, "2⁴⁵⁵³⁵³⁵³⁴⁵³⁶⁴⁵³⁵³⁴⁵ throws";
#?niecza 2 skip "Slow and wrong"
throws-like { EVAL qq[(-2)⁴⁵⁵³⁵³⁵³⁴⁵³⁶⁴⁵³⁵³⁵⁴] }, $xno, "(-2)⁴⁵⁵³⁵³⁵³⁴⁵³⁶⁴⁵³⁵³⁵⁴ throws";
throws-like { EVAL qq[(-2)⁴⁵⁵³⁵³⁵³⁴⁵³⁶⁴⁵³⁵³⁴⁵] }, $xno, "(-2)⁴⁵⁵³⁵³⁵³⁴⁵³⁶⁴⁵³⁵³⁴⁵ throws";

#?rakudo.jvm 6 skip 'parsing issue on JVM: Missing required term after infix'
is(4 ** ½,  2, "4 ** ½ ==  2");
is(4 ** -½, ½, "4 ** -½ == ½");
is-approx(27 ** ⅓, 3, "27 ** ⅓ ==  3");
is-approx(27 ** ⅔, 9, "27 ** ⅔ ==  9");
is-approx(27 ** -⅓, ⅓, "27 ** -⅓ == ⅓");
is-approx(27 ** -⅔, ⅑, "27 ** -⅔ == ⅑");

# RT #112788
# if no throwage happens, as is wanted, the program will take forever to run
# so we wait for 2 seconds, then print success message and exit; if the throw
# occurs, the Promise won't have a chance to print the success message.
is_run ｢start { sleep 2; say ‘pass’; exit }; EVAL ‘say 1.0000001 ** (10 ** 8)’｣,
    {:out("pass\n"), :err(''), :0status },
'raising a Rat to largish power does not throw';
throws-like { EVAL qq[say 1.0000001 ** (10 ** 90000)] }, 
    $xno, "raising a Rat to a very large number throws";

# vim: ft=perl6
