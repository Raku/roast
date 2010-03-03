use v6;
use Test;

# L<S03/List infix precedence/"the series operator">

plan *;

# some tests without regard to ending 

is (1 ... *).batch(5).join(', '), '1, 2, 3, 4, 5', 'simple series with one item on the LHS';
is (1, 3 ... *).batch(5).join(', '), '1, 3, 5, 7, 9', 'simple additive series with two items on the LHS';
is (1, 3, 5 ... *).batch(5).join(', '), '1, 3, 5, 7, 9', 'simple additive series with three items on the LHS';
is (1, 3, 9 ... *).batch(5).join(', '), '1, 3, 9, 27, 81', 'simple multiplicative series with three items on the LHS';
is (81, 27, 9 ... *).batch(5).join(', '), '81, 27, 9, 3, 1', 'decreasing multiplicative series with three items on the LHS';
is (1, { $_ + 2 } ... *).batch(5).join(', '), '1, 3, 5, 7, 9', 'simple series with one item and closure on the LHS';

is (1, { 1 / ((1 / $_) + 1) } ... *).batch(5).map({.perl}).join(', '), '1, 1/2, 1/3, 1/4, 1/5', 'tricky series with one item and closure on the LHS';

# some tests which exactly hit a limit

is (1 ... 5).batch(10).join(', '), '1, 2, 3, 4, 5', 'simple series with one item on the LHS';
is (1, 3 ... 9).batch(10).join(', '), '1, 3, 5, 7, 9', 'simple additive series with two items on the LHS';
is (1, 3, 5 ... 9).batch(10).join(', '), '1, 3, 5, 7, 9', 'simple additive series with three items on the LHS';
is (1, 3, 9 ... 81).batch(10).join(', '), '1, 3, 9, 27, 81', 'simple multiplicative series with three items on the LHS';
is (81, 27, 9 ... 1).batch(10).join(', '), '81, 27, 9, 3, 1', 'decreasing multiplicative series with three items on the LHS';
is (1, { $_ + 2 } ... 9).batch(10).join(', '), '1, 3, 5, 7, 9', 'simple series with one item and closure on the LHS';

is (1, { 1 / ((1 / $_) + 1) } ... 1/5).batch(10).map({.perl}).join(', '), '1, 1/2, 1/3, 1/4, 1/5', 'tricky series with one item and closure on the LHS';


done_testing;