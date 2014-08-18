# http://perl6advent.wordpress.com/2009/12/06/day-6-going-into-hyperspace/

use v6;
use Test;

plan 15;

my @a = 1, 2, 3, 4;
my @b = 3, 1;
my @c = 3, 1, 3, 1;

my @a-copy;
my @pi = 0, pi/4, pi/2, pi, 2*pi;
my @pi-sin = @pi>>.sin;

is (@a <<+>> @c), [4, 3, 6, 5], 'Dwimmy hyperoperator on arrays of the same length';
is (@a >>+<< @c), [4, 3, 6, 5], 'Non-dwimmy hyperoperator on arrays of the same length';
is (@a <<+>> @b), [4, 3, 6, 5], 'Dwimmy hyperoperator on arrays of different size';
throws_like {@a >>+<< @b}, X::HyperOp::NonDWIM,
  'Non-dwimmy hyperoperator on arrays of different size fails';
is (@a >>+>> 2), [3, 4, 5, 6], 'Single scalars extend to the right';
is (3 <<+<< @a), [4, 5, 6, 7], 'Single scalars extend to the left';
is (~<<@a), ["1", "2", "3", "4"], 'Hyperoperator with prefix operator';
is $(@a-copy = @a; @a-copy>>++; @a-copy), [2, 3, 4, 5], 'Hyperoperator with postfix operator';
for @pi Z @pi-sin -> $elem, $elem-sin {
    is_approx $elem.sin, $elem-sin, 'Hyperoperator used to call .sin on each list element';
}
is ((-1, 0, 3, 42)>>.Str), ["-1", "0", "3", "42"], 'Hyperoperator used to call .Str on each list element';

#?niecza todo
{
	is $(@a-copy = @a; @a-copy >>/=>> 4; @a-copy), [1/2, 2/2, 3/2, 4/2], 'In-place operators work';
}
