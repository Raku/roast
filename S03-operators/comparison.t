use v6;
use Test;

plan 41;

# N.B.:  relational ops are in relational.t

# L<S03/Nonchaining binary precedence/Order::Less, Order::Same, or Order::More>
is(+Order::Less, -1, 'Order::Less numifies to -1');
is(+Order::Same,  0, 'Order::Same numifies to 0');
is(+Order::More,  1, 'Order::More numifies to 1');

#L<S03/Comparison semantics>

# spaceship comparisons (Num)
is(1 <=> 1, Order::Same, '1 <=> 1 is same');
is(1 <=> 2, Order::Less, '1 <=> 2 is less');
is(2 <=> 1, Order::More, '2 <=> 1 is more');

is 0 <=> -1,      Order::More, '0 <=> -1 is less';
is -1 <=> 0,      Order::Less, '-1 <=> 0 is more';
is 0 <=> -1/2,    Order::More, '0 <=> -1/2 is more';
is 0 <=> 1/2,     Order::Less, '0 <=> 1/2 is less';
is -1/2 <=> 0,    Order::Less, '-1/2 <=> 0 is more';
is 1/2 <=> 0,     Order::More, '1/2 <=> 0 is more';
is 1/2 <=> 1/2,   Order::Same, '1/2 <=> 1/2 is same';
is -1/2 <=> -1/2, Order::Same, '-1/2 <=> -1/2 is same';
is 1/2 <=> -1/2,  Order::More, '1/2 <=> -1/2 is more';
is -1/2 <=> 1/2,  Order::Less, '-1/2 <=> 1/2 is less';

# leg comparison (Str)
is('a' leg 'a',     Order::Same, 'a leg a is same');
is('a' leg 'b',     Order::Less, 'a leg b is less');
is('b' leg 'a',     Order::More, 'b leg a is more');
is('a' leg 1,       Order::More, 'leg is in string context');
is("a" leg "a\0",   Order::Less, 'a leg a\0 is less');
is("a\0" leg "a\0", Order::Same, 'a\0 leg a\0 is same');
is("a\0" leg "a",   Order::More, 'a\0 leg a is more');

# cmp comparison
is('a' cmp 'a',     Order::Same, 'a cmp a is same');
is('a' cmp 'b',     Order::Less, 'a cmp b is less');
is('b' cmp 'a',     Order::More, 'b cmp a is more');
is(1 cmp 1,         Order::Same, '1 cmp 1 is same');
is(1 cmp 2,         Order::Less, '1 cmp 2 is less');
is(2 cmp 1,         Order::More, '2 cmp 1 is more');
is('a' cmp 1,       Order::More, '"a" cmp 1 is more'); # unspecced P5 behavior
is("a" cmp "a\0",   Order::Less, 'a cmp a\0 is less');
is("a\0" cmp "a\0", Order::Same, 'a\0 cmp a\0 is same');
is("a\0" cmp "a",   Order::More, 'a\0 cmp a is more');

# compare numerically with non-numeric
{
    class Blue { 
        method Numeric() { 3; }
    } 
    my $a = Blue.new;

    ok +$a == 3, '+$a == 3 (just checking)';
    ok $a == 3, '$a == 3';
    ok $a != 4, '$a != 4';
    nok $a != 3, 'not true that $a != 3';
    
    #?rakudo 4 todo 'nom regression'
    lives_ok { $a < 5 }, '$a < 5 lives okay';
    lives_ok { $a <= 5 }, '$a <= 5 lives okay';
    lives_ok { $a > 5 }, '$a > 5 lives okay';
    lives_ok { $a >= 5 }, '$a => 5 lives okay';
}

# vim: ft=perl6
