use v6;
use Test;

# L<S03/List infix precedence/"the series operator">

plan *;

# some tests without regard to ending 

is (1 ... *).[^5].join(', '), '1, 2, 3, 4, 5', 'simple series with one item on the LHS';
is (1, 3 ... *).[^5].join(', '), '1, 3, 5, 7, 9', 'simple additive series with two items on the LHS';
is (1, 0 ... *).[^5].join(', '), '1, 0, -1, -2, -3', 'simple decreasing additive series with two items on the LHS';
is (1, 3, 5 ... *).[^5].join(', '), '1, 3, 5, 7, 9', 'simple additive series with three items on the LHS';
is (1, 3, 9 ... *).[^5].join(', '), '1, 3, 9, 27, 81', 'simple multiplicative series with three items on the LHS';
is (81, 27, 9 ... *).[^5].join(', '), '81, 27, 9, 3, 1', 'decreasing multiplicative series with three items on the LHS';
is (1, { $_ + 2 } ... *).[^5].join(', '), '1, 3, 5, 7, 9', 'simple series with one item and closure on the LHS';
is (1, { $_ - 2 } ... *).[^5].join(', '), '1, -1, -3, -5, -7', 'simple series with one item and closure on the LHS';

is (1, { 1 / ((1 / $_) + 1) } ... *).[^5].map({.perl}).join(', '), '1, 1/2, 1/3, 1/4, 1/5', 'tricky series with one item and closure on the LHS';
is (1, { -$_ } ... *).[^5].join(', '), '1, -1, 1, -1, 1', 'simple repeating series with one item and closure on the LHS';

# some tests which exactly hit a limit

is (1 ... 5).[^10].join(', '), '1, 2, 3, 4, 5', 'simple series with one item on the LHS';
is (1, 3 ... 9).[^10].join(', '), '1, 3, 5, 7, 9', 'simple additive series with two items on the LHS';
is (1, 0 ... -3).[^10].join(', '), '1, 0, -1, -2, -3', 'simple decreasing additive series with two items on the LHS';
is (1, 3, 5 ... 9).[^10].join(', '), '1, 3, 5, 7, 9', 'simple additive series with three items on the LHS';
is (1, 3, 9 ... 81).[^10].join(', '), '1, 3, 9, 27, 81', 'simple multiplicative series with three items on the LHS';
is (81, 27, 9 ... 1).[^10].join(', '), '81, 27, 9, 3, 1', 'decreasing multiplicative series with three items on the LHS';
is (1, { $_ + 2 } ... 9).[^10].join(', '), '1, 3, 5, 7, 9', 'simple series with one item and closure on the LHS';
is (1, { $_ - 2 } ... -7).[^10].join(', '), '1, -1, -3, -5, -7', 'simple series with one item and closure on the LHS';

is (1, { 1 / ((1 / $_) + 1) } ... 1/5).[^10].map({.perl}).join(', '), '1, 1/2, 1/3, 1/4, 1/5', 'tricky series with one item and closure on the LHS';
is (1, { -$_ } ... 1).[^10].join(', '), '1', 'simple repeating series with one item and closure on the LHS';
is (1, { -$_ } ... 3).[^5].join(', '), '1, -1, 1, -1, 1', 'simple repeating series with one item and closure on the LHS';

# some tests which go past a limit

is (1 ... 5.5).[^10].join(', '), '1, 2, 3, 4, 5', 'simple series with one item on the LHS';
is (1, 3 ... 10).[^10].join(', '), '1, 3, 5, 7, 9', 'simple additive series with two items on the LHS';
is (1, 0 ... -3.5).[^10].join(', '), '1, 0, -1, -2, -3', 'simple decreasing additive series with two items on the LHS';
is (1, 3, 5 ... 10).[^10].join(', '), '1, 3, 5, 7, 9', 'simple additive series with three items on the LHS';
is (1, 3, 9 ... 100).[^10].join(', '), '1, 3, 9, 27, 81', 'simple multiplicative series with three items on the LHS';
is (81, 27, 9 ... 8/9).[^10].join(', '), '81, 27, 9, 3, 1', 'decreasing multiplicative series with three items on the LHS';
is (1, { $_ + 2 } ... 10).[^10].join(', '), '1, 3, 5, 7, 9', 'simple series with one item and closure on the LHS';
is (1, { $_ - 2 } ... -8).[^10].join(', '), '1, -1, -3, -5, -7', 'simple series with one item and closure on the LHS';

is (1, { 1 / ((1 / $_) + 1) } ... 11/60).[^10].map({.perl}).join(', '), '1, 1/2, 1/3, 1/4, 1/5', 'tricky series with one item and closure on the LHS';
is (1, { -$_ } ... 0).[^10].join(', '), '1', 'simple repeating series with one item and closure on the LHS';

# some tests taken from Spec
is (<a b c>, {.succ } ... *).[^10].join(', '), "a, b, c, d, e, f, g, h, i, j", "string-valued series staring from array and with explicit .succ";
is (0,2,4, { $_ + 2 } ... 42).join(', '), (0..42).grep({$_ !% 2}).join(', '), "evens starting with three values and closure";
#?rakudo 2 skip '&prefix:<!> does not work with series yet'
is (False, &prefix:<!> ... *).[^10].join(', '), "0, 1, 0, 1, 0, 1, 0, 1, 0, 1", "alternating False and True";
is (False, &prefix:<!> ... *).[^10].grep(Bool).elems, 10, "alternating False and True is always Bool";
is (False, { !$_ } ... *).[^10].join(', '), "0, 1, 0, 1, 0, 1, 0, 1, 0, 1", "alternating False and True";
is (False, { !$_ } ... *).[^10].grep(Bool).elems, 10, "alternating False and True is always Bool";

# tests for strange cases
is (1, 1, 1 ... 10).[^10].join(', '), '1, 1, 1, 1, 1, 1, 1, 1, 1, 1', 'series started with three identical numbers';
is (1, 1, 1, 2, 3 ... 10).[^10].join(', '), '1, 1, 1, 2, 3, 4, 5, 6, 7, 8', 'series started with three identical numbers, but then goes arithmetic';
is (1, 1, 1, 2, 4 ... 16).[^10].join(', '), '1, 1, 1, 2, 4, 8, 16', 'series started with three identical numbers, but then goes geometric';
is (4, 2, 1, 2, 4 ... 16).[^10].join(', '), '4, 2, 1, 2, 4, 8, 16', 'series started with three identical numbers, but then goes geometric';
is ('a', 'b' ... *).[^10].join(', '), 'a, b, c, d, e, f, g, h, i, j', 'series started with two different letters';
is (<a b c> ... *).[^10].join(', '), "a, b, c, d, e, f, g, h, i, j", "string-valued series staring from array";
is ('z' ... 'a').[^10].join(', '), 'z, y, x, w, v, u, t, s, r, q', 'descending series started with one letter';
is (<z y> ... 'a').[^10].join(', '), 'z, y, x, w, v, u, t, s, r, q', 'descending series started with two different letters';
is (<z y x> ... 'a').[^10].join(', '), 'z, y, x, w, v, u, t, s, r, q', 'descending series started with two different letters';

# tests for repetition 
is ('c', { $_ } ... *).[^10].join(', '), 'c, c, c, c, c, c, c, c, c, c', 'series started with letter and identify closure';
is ('c', 'c' ... *).[^10].join(', '), 'c, c, c, c, c, c, c, c, c, c', 'series started with two identical letters';
is ('c', 'c', 'c' ... *).[^10].join(', '), 'c, c, c, c, c, c, c, c, c, c', 'series started with three identical letters';

# tests for alphabetical series crossing 'z'
#?rakudo 1 todo "RT#74990: Series of letters doesn't stop at end point"
is ('x' ... 'z').join(', '), 'x, y, z', "series ending with 'z' don't cross to two-letter strings";

done_testing;
