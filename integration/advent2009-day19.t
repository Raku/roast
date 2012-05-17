# http://perl6advent.wordpress.com/2009/12/19/day-19-whatever/

use v6;
use Test;

plan 6;

my @x = <a b c d e>;
#?pugs todo
is @x[*-2], 'd', 'Whatever indexing';
is @x.pick(*).elems, @x.elems, 'pick(*)';

{
    #?pugs skip 'Casting errors'
    is (@x.map: * ~ 'A'), ("aA", "bA", "cA", "dA", "eA"), "* ~ 'A' with map";

    my $x = * * 2;
    #?pugs skip 'Casting errors'
    is $x(4), 8, '* * 2 generates a code block';

    #?pugs skip '.succ'
    is (@x.map: *.succ), ["b", "c", "d", "e", "f"], '*.succ with map';

    my @list = 1, 5, 'a', 10, 6;
    #?pugs 2 todo
    is (@list.sort: ~*), [1, 10, 5, 6, "a"], '~* used to sort as list of strings';
}
