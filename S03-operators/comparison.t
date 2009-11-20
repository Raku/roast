use v6;
use Test;

plan *;

# N.B.:  relational ops are in relational.t

# L<S03/Nonchaining binary precedence/Order::Increase, Order::Same, or Order::Decrease>
is(+Order::Increase, -1, 'Order::Increase numifies to -1');
is(+Order::Same,      0, 'Order::Same numifies to 0');
is(+Order::Decrease,  1, 'Order::Decrease numifies to 1');

#L<S03/Comparison semantics>

# spaceship comparisons (Num)
is(1 <=> 1, Order::Same,     '1 <=> 1 is same');
is(1 <=> 2, Order::Increase, '1 <=> 2 is increase');
is(2 <=> 1, Order::Decrease, '2 <=> 1 is decrease');
is('a' <=> '1', Order::Increase, '<=> is in numeric context');

is 0 <=> -1,   Order::Decrease, '0 <=> -1 is increase';
is -1 <=> 0,      Order::Increase, '-1 <=> 0 is decrease';
#?rakudo 2 todo 'RT 70664'
is 0 <=> -1/2,    Order::Decrease, '0 <=> -1/2 is increase';
is 0 <=> 1/2,     Order::Increase, '0 <=> 1/2 is increase';
#?rakudo 6 skip 'No suitable candidate found for cmp_num, with signature PP->I'
is -1/2 <=> 0,    Order::Increase, '-1/2 <=> 0 is decrease';
is 1/2 <=> 0,     Order::Decrease, '1/2 <=> 0 is decrease';
is 1/2 <=> 1/2,   Order::Same, '1/2 <=> 1/2 is same';
is -1/2 <=> -1/2, Order::Same, '-1/2 <=> -1/2 is same';
is 1/2 <=> -1/2,  Order::Decrease, '1/2 <=> -1/2 is decrease';
is -1/2 <=> 1/2,  Order::Increase, '-1/2 <=> 1/2 is increase';

# leg comparison (Str)
is('a' leg 'a', Order::Same,     'a leg a is same');
is('a' leg 'b', Order::Increase, 'a leg b is increase');
is('b' leg 'a', Order::Decrease, 'b leg a is decrease');
is('a' leg 1,   Order::Decrease, 'leg is in string context');

# cmp comparison
is('a' cmp 'a', Order::Same,     'a cmp a is same');
is('a' cmp 'b', Order::Increase, 'a cmp b is increase');
is('b' cmp 'a', Order::Decrease, 'b cmp a is decrease');
is(1 cmp 1,     Order::Same,     '1 cmp 1 is same');
is(1 cmp 2,     Order::Increase, '1 cmp 2 is increase');
is(2 cmp 1,     Order::Decrease, '2 cmp 1 is decrease');
is('a' cmp 1,   Order::Decrease, '"a" cmp 1 is decrease'); # unspecced but P5 behavior

done_testing;

# vim: ft=perl6
