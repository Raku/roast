use v6;
use Test;

# L<S03/List infix precedence/"the series operator">

plan *;

# single-term series

is ~( 1  ...  1 ), '1', '1 ... 1';
is ~( 'a'  ...  'a' ), 'a', "'a' ... 'a'";

# finite series that exactly hit their limit

is (1 ... 5).join(', '), '1, 2, 3, 4, 5', 'simple series with one item on the LHS';
is (1 ... -3).join(', '), '1, 0, -1, -2, -3', 'simple decreasing series with one item on the LHS';
is (1, 3 ... 9).join(', '), '1, 3, 5, 7, 9', 'simple additive series with two items on the LHS';
is (1, 0 ... -3).join(', '), '1, 0, -1, -2, -3', 'simple decreasing additive series with two items on the LHS';
is (1, 3, 5 ... 9).join(', '), '1, 3, 5, 7, 9', 'simple additive series with three items on the LHS';
is (1, 3, 9 ... 81).join(', '), '1, 3, 9, 27, 81', 'simple multiplicative series with three items on the LHS';
is (81, 27, 9 ... 1).join(', '), '81, 27, 9, 3, 1', 'decreasing multiplicative series with three items on the LHS';
is (1, { $_ + 2 } ... 9).join(', '), '1, 3, 5, 7, 9', 'simple series with one item and block closure on the LHS';
is (1, *+2 ... 9).join(', '), '1, 3, 5, 7, 9', 'simple series with one item and * closure on the LHS';
is (1, { $_ - 2 } ... -7).join(', '), '1, -1, -3, -5, -7', 'simple series with one item and closure on the LHS';
is (1, 3, 5, { $_ + 2 } ... 13).join(', '), '1, 3, 5, 7, 9, 11, 13', 'simple series with three items and block closure on the LHS';

is (1, { 1 / ((1 / $_) + 1) } ... 1/5).map({.perl}).join(', '), '1, 1/2, 1/3, 1/4, 1/5', 'tricky series with one item and closure on the LHS';
is (1, { -$_ } ... 1).join(', '), '1', 'simple alternating series with one item and closure on the LHS';
is (1, { -$_ } ... 3).[^5].join(', '), '1, -1, 1, -1, 1', 'simple alternating series with one item and closure on the LHS';

is (1 ... 5, 6, 7).join(', '), '1, 2, 3, 4, 5, 6, 7', 'simple series with two further terms on the RHS';
is (1 ... 5, 4, 3).join(', '), '1, 2, 3, 4, 5, 4, 3', 'simple series with two extra terms on the RHS';
is (1 ... 5, 'xyzzy', 'plugh').join(', '), '1, 2, 3, 4, 5, xyzzy, plugh', 'simple series with two weird items on the RHS';

# finite series that go past their limit

is (1 ... 5.5).join(', '), '1, 2, 3, 4, 5', 'simple series with one item on the LHS';
is (1 ... -3.5).join(', '), '1, 0, -1, -2, -3', 'simple decreasing series with one item on the LHS';
is (1, 3 ... 10).join(', '), '1, 3, 5, 7, 9', 'simple additive series with two items on the LHS';
is (1, 0 ... -3.5).join(', '), '1, 0, -1, -2, -3', 'simple decreasing additive series with two items on the LHS';
is (1, 3, 5 ... 10).join(', '), '1, 3, 5, 7, 9', 'simple additive series with three items on the LHS';
is (1, 3, 9 ... 100).join(', '), '1, 3, 9, 27, 81', 'simple multiplicative series with three items on the LHS';
is (81, 27, 9 ... 8/9).join(', '), '81, 27, 9, 3, 1', 'decreasing multiplicative series with three items on the LHS';
is (1, { $_ + 2 } ... 10).join(', '), '1, 3, 5, 7, 9', 'simple series with one item and block closure on the LHS';
is (1, *+2 ... 10).join(', '), '1, 3, 5, 7, 9', 'simple series with one item and * closure on the LHS';
is (1, { $_ - 2 } ... -8).join(', '), '1, -1, -3, -5, -7', 'simple series with one item and closure on the LHS';
is (1, 3, 5, { $_ + 2 } ... 14).join(', '), '1, 3, 5, 7, 9, 11, 13', 'simple series with three items and block closure on the LHS';

is (1, { 1 / ((1 / $_) + 1) } ... 11/60).map({.perl}).join(', '), '1, 1/2, 1/3, 1/4, 1/5', 'tricky series with one item and closure on the LHS';
is (1, { -$_ } ... 0).join(', '), '1', 'simple alternating series with one item and closure on the LHS';

is (1 ... 5.5, 6, 7).join(', '), '1, 2, 3, 4, 5, 6, 7', 'simple series with two further terms on the RHS';
is (1 ... 5.5, 4, 3).join(', '), '1, 2, 3, 4, 5, 4, 3', 'simple series with two extra terms on the RHS';
is (1 ... 5.5, 'xyzzy', 'plugh').join(', '), '1, 2, 3, 4, 5, xyzzy, plugh', 'simple series with two weird items on the RHS';

# infinite series without limits

is (1 ... *).[^5].join(', '), '1, 2, 3, 4, 5', 'simple series with one item on the LHS';
is (1, 3 ... *).[^5].join(', '), '1, 3, 5, 7, 9', 'simple additive series with two items on the LHS';
is (1, 0 ... *).[^5].join(', '), '1, 0, -1, -2, -3', 'simple decreasing additive series with two items on the LHS';
is (1, 3, 5 ... *).[^5].join(', '), '1, 3, 5, 7, 9', 'simple additive series with three items on the LHS';
is (8, 7, 6 ... *).[^5].join(', '), '8, 7, 6, 5, 4', 'simple decreasing additive series with three items on the LHS';
is (1, 3, 9 ... *).[^5].join(', '), '1, 3, 9, 27, 81', 'simple multiplicative series with three items on the LHS';
is (81, 27, 9 ... *).[^5].join(', '), '81, 27, 9, 3, 1', 'decreasing multiplicative series with three items on the LHS';
is (1, { $_ + 2 } ... *).[^5].join(', '), '1, 3, 5, 7, 9', 'simple series with one item and block closure on the LHS';
is (1, *+2 ... *).[^5].join(', '), '1, 3, 5, 7, 9', 'simple series with one item and * closure on the LHS';
is (1, { $_ - 2 } ... *).[^5].join(', '), '1, -1, -3, -5, -7', 'simple series with one item and closure on the LHS';
is (1, 3, 5, { $_ + 2 } ... *).[^7].join(', '), '1, 3, 5, 7, 9, 11, 13', 'simple series with three items and block closure on the LHS';

is (1, { 1 / ((1 / $_) + 1) } ... *).[^5].map({.perl}).join(', '), '1, 1/2, 1/3, 1/4, 1/5', 'tricky series with one item and closure on the LHS';
is (1, { -$_ } ... *).[^5].join(', '), '1, -1, 1, -1, 1', 'simple alternating series with one item and closure on the LHS';

is (1 ... *, 6, 7).[^7].join(', '), '1, 2, 3, 4, 5, 6, 7', 'simple series with two further terms on the RHS';
is (1 ... *, 4, 3).[^7].join(', '), '1, 2, 3, 4, 5, 6, 7', 'simple series with two extra terms on the RHS';
is (1 ... *, 'xyzzy', 'plugh').[^7].join(', '), '1, 2, 3, 4, 5, 6, 7', 'simple series with two weird items on the RHS';

# constant series

is ('c', { $_ } ... *).[^10].join(', '), 'c, c, c, c, c, c, c, c, c, c', 'constant series started with letter and identity closure';
is ('c', 'c' ... *).[^10].join(', '), 'c, c, c, c, c, c, c, c, c, c', 'constant series started with two letters';
is ('c', 'c', 'c' ... *).[^10].join(', '), 'c, c, c, c, c, c, c, c, c, c', 'constant series started with three letters';
is (1, 1 ... *).[^10].join(', '), '1, 1, 1, 1, 1, 1, 1, 1, 1, 1', 'constant series started with two numbers';
is (1, 1, 1 ... *).[^10].join(', '), '1, 1, 1, 1, 1, 1, 1, 1, 1, 1', 'constant series started with three numbers';

# misleading starts

is (1, 1, 1, 2, 3 ... 10).[^10].join(', '), '1, 1, 1, 2, 3, 4, 5, 6, 7, 8', 'series started with three identical numbers, but then goes arithmetic';
is (1, 1, 1, 2, 4 ... 16).join(', '), '1, 1, 1, 2, 4, 8, 16', 'series started with three identical numbers, but then goes geometric';
is (4, 2, 1, 2, 4 ... 16).join(', '), '4, 2, 1, 2, 4, 8, 16', 'geometric series started in one direction and continues in the other';

# some tests taken from Spec

#?rakudo 2 skip '&prefix:<!> does not work with series yet'
is (False, &prefix:<!> ... *).[^10].join(', '), "0, 1, 0, 1, 0, 1, 0, 1, 0, 1", "alternating False and True";
is (False, &prefix:<!> ... *).[^10].grep(Bool).elems, 10, "alternating False and True is always Bool";
is (False, { !$_ } ... *).[^10].join(', '), "0, 1, 0, 1, 0, 1, 0, 1, 0, 1", "alternating False and True";
is (False, { !$_ } ... *).[^10].grep(Bool).elems, 10, "alternating False and True is always Bool";

# L<S03/List infix precedence/'"asymptotically approaching" is not the same as "equals"'>
# infinite series with limits

is ~(1, 1/2, 1/4 ... 0).[^5].map({.perl}), '1 1/2 1/4 1/8 1/16', 'geometric series that never reaches its limit';
is ~(1, -1/2, 1/4 ... 0).[^5].map({.perl}), '1 -1/2 1/4 -1/8 1/16', 'alternating geometric series that never reaches its limit';
is (1, { 1 / ((1 / $_) + 1) } ... 0).[^5].map({.perl}).join(', '), '1, 1/2, 1/3, 1/4, 1/5', '"harmonic" series that never reaches its limit';

# empty series

# L<S03/List infix precedence/'limit value is on the "wrong"'>
#?rakudo 5 skip "RT #75832, series does not stop at end point"
is (1, 2 ... 0), Nil, 'empty increasing arithmetic series';
is (1, 0 ... 2), Nil, 'empty decreasing arithmetic series';
is (1, 2, 4 ... -5), Nil, 'empty increasing geometric series';
is (64, 32, 16 ... 70), Nil, 'empty decreasing geometric series';
is (1, 2 ... 0, 'xyzzy', 'plugh').join(' '), 'xyzzy plugh', 'series empty but for extra items';

# L<S03/List infix precedence/For a geometric series with sign changes>
#?rakudo 4 skip "or the 1, -2, 4 ... 1/2 case"
is (1, -2, 4 ... 1/2), Nil, 'empty alternating increasing-in-magnitude geometric series';
is (-64, 32, -16 ... 70), Nil, 'empty alternating decreasing-in-magnitude geometric series';
is (1, -1, 1 ... 2), Nil, 'empty alternating series (1)';
is (1, -1, 1 ... -2), Nil, 'empty alternating series (2)';

# L<S03/List infix precedence/excludes the limit if it happens to match exactly>
# excluded limits via "...^"
#?rakudo skip '...^ NYI'
{
    is (1 ...^ 5).join(', '), '1, 2, 3, 4', 'exclusive series';
    is (1 ...^ -3).join(', '), '1, 0, -1, -2', 'exclusive decreasing series';
    is (1 ...^ 5.5).join(', '), '1, 2, 3, 4, 5', "exclusive series that couldn't hit its limit anyway";
    is (1, 3, 9 ...^ 81).join(', '), '1, 3, 9, 27', 'exclusive geometric series';
    is (81, 27, 9 ...^ 2).join(', '), '81, 27, 9, 3', "exclusive decreasing geometric series that couldn't hit its limit anyway";
    is (2, -4, 8 ...^ 32).join(', '), '2, -4, 8, -16', 'exclusive alternating geometric series';
    is (2, -4, 8 ...^ -32).join(', '), '2, -4, 8, -16, 32', 'exclusive alternating geometric series (not an exact match)';
    is (1, { $_ + 2 } ...^ 9).join(', '), '1, 3, 5, 7', 'exclusive series with closure';
    is (1 ...^ 1), Nil, 'empty exclusive series';
    is (1, 1 ...^ 1), Nil, 'empty exclusive constant series';
    is (1, 2 ...^ 0), Nil, 'empty exclusive arithmetic series';
    is (1, 2 ...^ 0, 'xyzzy', 'plugh').join(' '), 'xyzzy plugh', 'exclusive series empty but for extra items';
    is ~(1 ...^ 0), '1', 'singleton exclusive series';
}


# RT #75698
ok ?(one((-5 ... ^5).flat) == 0), '-5 ... ^5 produces just one zero';

# RT #75316
isa_ok (1...()), Failure,
    'empty list on right side of series operator does not cause infinite loop';

done_testing;

# vim: ft=perl6
