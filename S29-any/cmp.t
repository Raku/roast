use v6;
use Test;

plan 6;

# L<S32::Basics/Any/"=item cmp">

is('a' cmp 'a', 0,  'a is equal to a');
is('a' cmp 'b', -1, 'a is less than b');
is('b' cmp 'a', 1,  'b is greater than a');

is(3   cmp   3,  0,  '3 cmp 3 is 0');
is(2   cmp   3, -1,  '2 cmp 3 is -1');
is(3   cmp   4, -1,  '3 cmp 4 is -1');

# vim: ft=perl6
