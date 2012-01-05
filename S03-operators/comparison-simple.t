use v6;
use Test;

plan 25;

# N.B.:  relational ops are in relational.t

#L<S03/Comparison semantics>

# spaceship comparisons (Num)
is(1 <=> 1, 0,      '1 <=> 1 is same');
is(1 <=> 2, -1,     '1 <=> 2 is increase');
is(2 <=> 1, 1,      '2 <=> 1 is decrease');
#?niecza skip 'System.FormatException: Unknown char: a'
is('a' <=> '1', -1, '<=> is in numeric context');

is 0 <=> -1, 1,  '0 <=> -1 is increase';
is -1 <=> 0, -1, '-1 <=> 0 is decrease';
is 0 <=> -1/2, 1, '0 <=> -1/2 is increase';
is 0 <=> 1/2, -1, '0 <=> 1/2 is increase';
is -1/2 <=> 0, -1,   '-1/2 <=> 0 is decrease';
is 1/2 <=> 0, 1,     '1/2 <=> 0 is decrease';
is 1/2 <=> 1/2, 0,   '1/2 <=> 1/2 is same';
is -1/2 <=> -1/2, 0, '-1/2 <=> -1/2 is same';
is 1/2 <=> -1/2, 1,  '1/2 <=> -1/2 is decrease';
is -1/2 <=> 1/2, -1, '-1/2 <=> 1/2 is increase';

# leg comparison (Str)
is('a' leg 'a', 0,  'a leg a is same');
is('a' leg 'b', -1, 'a leg b is increase');
is('b' leg 'a', 1,  'b leg a is decrease');
is('a' leg 1, 1,    'leg is in string context');

# cmp comparison
is('a' cmp 'a', 0,  'a cmp a is same');
is('a' cmp 'b', -1, 'a cmp b is increase');
is('b' cmp 'a', 1,  'b cmp a is decrease');
is(1 cmp 1, 0,      '1 cmp 1 is same');
is(1 cmp 2, -1,     '1 cmp 2 is increase');
is(2 cmp 1, 1,      '2 cmp 1 is decrease');
is('a' cmp 1, 1,    '"a" cmp 1 is decrease'); # unspecced but P5 behavior

done;

# vim: ft=perl6
