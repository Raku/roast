# http://perl6advent.wordpress.com/2009/12/19/day-19-whatever/

use Test;

plan 6;

my @x = <a b c d e>;
is @x[*-2], 'd', 'Whatever indexing';
is @x.pick(*).elems, @x.elems, 'pick(*)';

{
    is (@x.map: * ~ 'A'), ("aA", "bA", "cA", "dA", "eA"), "* ~ 'A' with map";

    my $x = * * 2;
    is $x(4), 8, '* * 2 generates a code block';

    is (@x.map: *.succ), ["b", "c", "d", "e", "f"], '*.succ with map';

    my @list = 1, 5, 'a', 10, 6;
    is (@list.sort: ~*), [1, 10, 5, 6, "a"], '~* used to sort as list of strings';
}

# vim: expandtab shiftwidth=4
