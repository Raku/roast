use v6;
use Test;

plan 3;

# L<S29/Any/"=item cmp">

is('a' cmp 'a', 0,  'a is equal to a');
is('a' cmp 'b', -1, 'a is less than b');
is('b' cmp 'a', 1,  'b is greater than a');

