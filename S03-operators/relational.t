use v6;
use Test;

plan 118;

## N.B.:  Tests for infix:«<=>» (spaceship) and infix:<cmp> belong
## in F<t/S03-operators/comparison.t>.

#L<S03/Chaining binary precedence>

# from t/operators/relational.t

## numeric relationals ( < , >, <=, >= )

ok(1 < 2, '1 is less than 2');
ok(!(2 < 1), '2 is ~not~ less than 1');

ok 1/4 < 3/4, '1/4 is less than 3/4';
ok !(3/4 < 1/4), '3/4 is not less than 1/4';
ok 1/2 < 1, '1/2 is less than 1';
ok !(1 < 1/2), '1 is not less than 1/2';

ok(2 > 1, '2 is greater than 1');
ok(!(1 > 2), '1 is ~not~ greater than 2');

ok 3/4 > 1/4, '3/4 is greater than 1/4';
ok !(1/4 > 3/4), '1/2 is not greater than 3/4';
ok 1 > 1/2, '1 is greater than 1/2';
ok !(1/2 > 1), '1/2 is not greater than 1';

ok(1 <= 2, '1 is less than or equal to 2');
ok(1 <= 1, '1 is less than or equal to 1');
ok(!(1 <= 0), '1 is ~not~ less than or equal to 0');

ok 1/4 <= 3/4, '1/4 is less than or equal to 3/4';
ok !(3/4 <= 1/4), '3/4 is not less than or equal to 1/4';
ok 1/2 <= 1, '1/2 is less than or equal to 1';
ok !(1 <= 1/2), '1 is not less than or equal to 1/2';
ok 1/2 <= 1/2, '1/2 is less than or equal to 1/2';

ok(2 >= 1, '2 is greater than or equal to 1');
ok(2 >= 2, '2 is greater than or equal to 2');
ok(!(2 >= 3), '2 is ~not~ greater than or equal to 3');

ok !(1/4 >= 3/4), '1/4 is greater than or equal to 3/4';
ok 3/4 >= 1/4, '3/4 is not greater than or equal to 1/4';
ok !(1/2 >= 1), '1/2 is greater than or equal to 1';
ok 1 >= 1/2, '1 is not greater than or equal to 1/2';
ok 1/2 >= 1/2, '1/2 is greater than or equal to 1/2';

# Ensure that these operators actually return Bool::True or Bool::False
is(1 < 2,  Bool::True,  '< true');
is(1 > 0,  Bool::True,  '> true');
is(1 <= 2, Bool::True,  '<= true');
is(1 >= 0, Bool::True,  '>= true');
is(1 < 0,  Bool::False, '< false');
is(1 > 2,  Bool::False, '> false');
is(1 <= 0, Bool::False, '<= false');
is(1 >= 2, Bool::False, '>= false');

## string relationals ( lt, gt, le, ge )

ok('a' lt 'b', 'a is less than b');
ok(!('b' lt 'a'), 'b is ~not~ less than a');

ok('b' gt 'a', 'b is greater than a');
ok(!('a' gt 'b'), 'a is ~not~ greater than b');

ok('a' le 'b', 'a is less than or equal to b');
ok('a' le 'a', 'a is less than or equal to a');
ok(!('b' le 'a'), 'b is ~not~ less than or equal to a');

ok('b' ge 'a', 'b is greater than or equal to a');
ok('b' ge 'b', 'b is greater than or equal to b');
ok(!('b' ge 'c'), 'b is ~not~ greater than or equal to c');

# +'a' is 0. This means 1 is less than 'a' in numeric context but not string
ok(!('a' lt '1'), 'lt uses string context');
ok(!('a' le '1'), 'le uses string context (1)');
ok(!('a' le '0'), 'le uses string context (2)');
ok('a' gt '1',    'gt uses string context');
ok('a' ge '1',    'ge uses string context (1)');
ok('a' ge '0',    'ge uses string context (2)');

# Ensure that these operators actually return Bool::True or Bool::False
is('b' lt 'c', Bool::True,  'lt true');
is('b' gt 'a', Bool::True,  'gt true');
is('b' le 'c', Bool::True,  'le true');
is('b' ge 'a', Bool::True,  'ge true');
is('b' lt 'a', Bool::False, 'lt false');
is('b' gt 'c', Bool::False, 'gt false');
is('b' le 'a', Bool::False, 'le false');
is('b' ge 'c', Bool::False, 'ge false');

## Multiway comparisons (RFC 025)
# L<S03/"Chained comparisons">

ok(5 > 4 > 3, "chained >");
ok(3 < 4 < 5, "chained <");
ok(5 == 5 > -5, "chained mixed = and > ");
ok(!(3 > 4 < 5), "chained > and <");
ok(5 <= 5 > -5, "chained <= and >");
ok(-5 < 5 >= 5, "chained < and >=");

is(5 > 1 < 10, 5 > 1 && 1 < 10, 'chained 5 > 1 < 10');
is(5 < 1 < 10, 5 < 1 && 1 < 10, 'chained 5 < 1 < 10');

ok('e' gt 'd' gt 'c', "chained gt");
ok('c' lt 'd' lt 'e', "chained lt");
ok('e' eq 'e' gt 'a', "chained mixed = and gt ");
ok(!('c' gt 'd' lt 'e'), "chained gt and lt");
ok('e' le 'e' gt 'a', "chained le and gt");
ok('a' lt 'e' ge 'e', "chained lt and ge");

is('e' gt 'a' lt 'j', 'e' gt 'a' && 'a' lt 'j', 'e gt a lt j');
is('e' lt 'a' lt 'j', 'e' lt 'a' && 'a' lt 'j', 'e lt a lt j');

ok("5" gt "4" gt "3", "5 gt 4 gt 3 chained str comparison");
ok("3" lt "4" lt "5", "3 lt 4 gt 5 chained str comparison");
ok(!("3" gt "4" lt "5"), "!(3 gt 4 lt 5) chained str comparison");
ok("5" eq "5" gt "0", '"5" eq "5" gt "0" chained str comparison with equality');
ok("5" le "5" gt "0", "5 le 5 gt 0 chained str comparison with le");
ok("0" lt "5" ge "5", "0 lt 5 ge 5 chained comparison with ge");

# make sure we don't have "padding" or "trimming" semantics
ok("a" lt "a\0", 'a lt a\0');
ok("a" lt "a ", 'a lt a\x20');
ok("a\0" gt "a", 'a\0 gt a');
ok("a " gt "a", 'a\x20 gt a');

# test NaN relational ops
is(NaN == 1, Bool::False, 'NaN == 1');
is(NaN <  1, Bool::False, 'NaN <  1');
is(NaN <= 1, Bool::False, 'NaN <= 1');
is(NaN >  1, Bool::False, 'NaN >  1');
is(NaN >= 1, Bool::False, 'NaN >= 1');
is(NaN != 1, Bool::True,  'NaN != 1');

is(1 == NaN, Bool::False, '1 == NaN');
is(1 <  NaN, Bool::False, '1 <  NaN');
is(1 <= NaN, Bool::False, '1 <= NaN');
is(1 >  NaN, Bool::False, '1 >  NaN');
is(1 >= NaN, Bool::False, '1 >= NaN');
is(1 != NaN, Bool::True,  '1 != NaN');

is(NaN == NaN, Bool::False, 'NaN == NaN');
is(NaN <  NaN, Bool::False, 'NaN <  NaN');
is(NaN <= NaN, Bool::False, 'NaN <= NaN');
is(NaN >  NaN, Bool::False, 'NaN >  NaN');
is(NaN >= NaN, Bool::False, 'NaN >= NaN');
is(NaN != NaN, Bool::True,  'NaN != NaN');

# regression test for rakudo failure 2012-07-08 (pmichaud)
# Int,Rat comparisons
is(7 == 2.4, False, 'Int == Rat');
is(7 != 2.4, True , 'Int != Rat');
is(7 <  2.4, False, 'Int <  Rat');
is(7 <= 2.4, False, 'Int <= Rat');
is(7 >  2.4, True , 'Int >  Rat');
is(7 >= 2.4, True , 'Int >= Rat');
#?pugs skip 'Order enum'
is(7 <=> 2.4, Order::Decrease, 'Int <=> Rat');

# Rat,Int comparisons
is(2.4 == 7, False, 'Rat == Int');
is(2.4 != 7, True , 'Rat != Int');
is(2.4 <  7, True , 'Rat <  Int');
is(2.4 <= 7, True , 'Rat <= Int');
is(2.4 >  7, False, 'Rat >  Int');
is(2.4 >= 7, False, 'Rat >= Int');
#?pugs skip 'Order enum'
is(2.4 <=> 7, Order::Increase, 'Rat <=> Int');

done;

# vim: ft=perl6
