use v6;
use Test;

# L<S03/List infix precedence/"the series operator">

plan *;

# some tests without regard to ending 

{
    my @rolls = ({ (1..6).pick } ... *).batch(20);
    is +@rolls, 20, 'Got the number of rolls we asked for';
    is @rolls.grep(Int).elems, 20, 'all the rolls are Ints';
    is @rolls.grep(1..6).elems, 20, 'all the rolls are in the Range 1..6';
}

{
    my @rolls = ({ (1..2).pick } ... 2).batch(100);
    ok +@rolls < 100, 'the series terminated';
    is @rolls.grep(Int).elems, +@rolls, 'all the rolls are Ints';
    is @rolls.grep(2).elems, 1, 'There was exactly one 2 rolled...';
    is @rolls[@rolls.elems - 1], 2, '...and it was the last roll';
}

{
    my @rolls = ({ (1..2).pick } ... 1.5).batch(100);
    ok +@rolls < 100, 'the series terminated...';
    ok +@rolls > 1, '... and the series had more than one element';
    is @rolls.grep(Int).elems, +@rolls, 'all the rolls are Ints';
    is @rolls.grep(@rolls[@rolls.elems - 1]).elems, 1, 
       'The last roll was the only roll of its number';
}


done_testing;