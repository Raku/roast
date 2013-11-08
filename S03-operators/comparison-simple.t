use v6;
use Test;

plan 24;

# N.B.:  relational ops are in relational.t

#L<S03/Comparison semantics>

# spaceship comparisons (Num)
is(1 <=> 1, Order::Same, '1 <=> 1 is same');
is(1 <=> 2, Order::Less, '1 <=> 2 is increase');
is(2 <=> 1, Order::More, '2 <=> 1 is decrease');

is 0 <=> -1,      Order::More, '0 <=> -1 is increase';
is -1 <=> 0,      Order::Less, '-1 <=> 0 is decrease';
is 0 <=> -1/2,    Order::More, '0 <=> -1/2 is increase';
is 0 <=> 1/2,     Order::Less, '0 <=> 1/2 is increase';
is -1/2 <=> 0,    Order::Less, '-1/2 <=> 0 is decrease';
is 1/2 <=> 0,     Order::More, '1/2 <=> 0 is decrease';
is 1/2 <=> 1/2,   Order::Same, '1/2 <=> 1/2 is same';
is -1/2 <=> -1/2, Order::Same, '-1/2 <=> -1/2 is same';
is 1/2 <=> -1/2,  Order::More,  '1/2 <=> -1/2 is decrease';
is -1/2 <=> 1/2,  Order::Less, '-1/2 <=> 1/2 is increase';

# leg comparison (Str)
is('a' leg 'a', Order::Same, 'a leg a is same');
is('a' leg 'b', Order::Less, 'a leg b is increase');
is('b' leg 'a', Order::More, 'b leg a is decrease');
is('a' leg 1,   Order::More, 'leg is in string context');

# cmp comparison
is('a' cmp 'a', Order::Same, 'a cmp a is same');
is('a' cmp 'b', Order::Less, 'a cmp b is increase');
is('b' cmp 'a', Order::More, 'b cmp a is decrease');
is(1 cmp 1,     Order::Same, '1 cmp 1 is same');
is(1 cmp 2,     Order::Less, '1 cmp 2 is increase');
is(2 cmp 1,     Order::More, '2 cmp 1 is decrease');
is('a' cmp 1,   Order::More, '"a" cmp 1 is decrease'); # unspecced but P5 behavior

# vim: ft=perl6
