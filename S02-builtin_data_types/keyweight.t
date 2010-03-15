use v6;
use Test;
plan 4;

# L<S02/Mutable types>

{
    my %h is KeyWeight;

    %h = (a => FatRat.new(1,2), b => FatRat.new(3,4));
    is +%h.elems, 2, 'Inititalization worked';
    %h<a> = 0;
    is %h.elems, 1, '... and an item is gone';
    is %h.keys.join, 'a', '... and the right one is gone';
}

# L<S32::Containers/KeyWeight>
{
    my %h is KeyWeight;

    %h = (a => FatRat.new(1,2), b => FatRat.new(3,4));
    %h<a> = FatRat(-1,1); # negative key
    is +%h.elems, 2, 'No deletion of negative keys'; # may warn
}


# vim: ft=perl6
