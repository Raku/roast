use v6;
use Test;
plan 3;

# L<S02/Mutable types>

{
    my %h is KeyWeight;

    %h = (a => FatRat.new(1,2), b => FatRat.new(3,4));
    is +%h.elems, 2, 'Inititalization worked';
    %h<a> = 0;
    is %h.elems, 1, '... and an item is gone';
    is %h.keys.join, 'a', '... and the right one is gone';
}

# vim: ft=perl6
