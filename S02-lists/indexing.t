
use v6;
use Test;
plan 2;

# RT #122423
is (42)[*/2], 42, 'Indexing half way into one element list';

# http://irclog.perlgeek.de/perl6/2015-01-23#i_9994456
{
    isa_ok (my @)[*-1], Failure, 'Out of range index returns a Failure object';
}
