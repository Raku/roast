use v6;
use Test;

plan 36;

## N.B.:  Tests for infix:«<=>» (spaceship) and infix:<cmp> belong
## in F<t/S03-operators/comparison.t>.

#L<S03/Chaining binary precedence>

# from t/operators/relational.t

## numeric relationals ( < , >, <=, >= )

ok(1 < 2, '1 is less than 2');
ok(!(2 < 1), '2 is ~not~ less than 1');

ok(2 > 1, '2 is greater than 1');
ok(!(1 > 2), '1 is ~not~ greater than 2');

ok(1 <= 2, '1 is less than or equal to 2');
ok(1 <= 1, '1 is less than or equal to 1');
ok(!(1 <= 0), '1 is ~not~ less than or equal to 0');

ok(2 >= 1, '2 is greater than or equal to 1');
ok(2 >= 2, '2 is greater than or equal to 2');
ok(!(2 >= 3), '2 is ~not~ greater than or equal to 3');

## XXX:  need tests for numeric coercion

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

## XXX: need tests for string coercion

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

