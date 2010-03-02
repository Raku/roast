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


done_testing;