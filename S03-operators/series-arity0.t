use v6;
use Test;

# L<S03/List infix precedence/"can be 0-ary as well">

plan *;

# Test with Whatever limit
{
    my @rolls = ({ (1..6).pick } ... *).[^20];
    is +@rolls, 20, 'Got the number of rolls we asked for';
    is @rolls.grep(Int).elems, 20, 'all the rolls are Ints';
    is @rolls.grep(1..6).elems, 20, 'all the rolls are in the Range 1..6';
}

# Test with exact limit
{
    my @rolls = ({ (1..2).pick } ... 2).munch(100);
    ok +@rolls > 0, 'the series had at least one element...';
    ok +@rolls < 100, '... and the series terminated';
    is @rolls.grep(Int).elems, +@rolls, 'all the rolls are Ints';
    is @rolls.grep(2).elems, 1, 'There was exactly one 2 rolled...';
    is @rolls[@rolls.elems - 1], 2, '...and it was the last roll';
}

# Test with limit between possible values
{
    my @rolls = ({ (1..2).pick } ... 1.5).munch(100);
    ok +@rolls > 0, 'the series had at least one element...';
    ok +@rolls < 100, '... and the series terminated';
    is @rolls.grep(Int).elems, +@rolls, 'all the rolls are Ints';
    is @rolls.grep(@rolls[0]).elems, +@rolls, 'All the rolls are the same';
}

# Test with limit that cannot be hit
{
    my @rolls = ({ (1..6).pick } ... 7).munch(40);
    is +@rolls, 40, 'Got the number of rolls we asked for';
    is @rolls.grep(Int).elems, 40, 'all the rolls are Ints';
    is @rolls.grep(1..6).elems, 40, 'all the rolls are in the Range 1..6';
}


done_testing;
