use v6;
use Test;

plan 6;

# L<S32::Basics/Any/"=item cmp">

is('a' cmp 'a', Order::Same,      'a is equal to a');
is('a' cmp 'b', Order::Increase,  'a is less than b');
is('b' cmp 'a', Order::Decrease,  'b is greater than a');

is(3   cmp   3, Order::Same,      '3 cmp 3 is 0');
is(2   cmp   3, Order::Increase,  '2 cmp 3 is -1');
is(3   cmp   4, Order::Increase,  '3 cmp 4 is -1');

# vim: ft=perl6
