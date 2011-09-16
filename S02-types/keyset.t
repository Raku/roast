use v6;
use Test;

plan 10;

# L<S02/Mutable types/"KeyHash of Bool">

# A KeySet is a KeyHash of Bool, i.e. the values are Bool

{
    my %h is KeySet = a => True, b => False, c => True;
    is +%h.elems, 2, 'Inititalization worked';

    lives_ok { %h<c> = False }, 'can set an item to False';
    is %h.elems, 1, '... and an item is gone';
    is ~%h.keys, 'a', '... and the right one is gone';

    %h<c>++;
    is %h.keys.sort.join, 'ac', '++ on an item reinstates it';
    %h<c>++;
    is %h.keys.sort.join, 'ac', '++ on an existing item does nothing';

    %h<a>--;
    is ~%h.keys, 'c', '-- removes items';
    %h<b>--;
    is ~%h.keys, 'c', '... but only if they were there from the beginning';

    lives_ok { %h = set <Q P R> }, 'Assigning a Set to a KeySet';
    is %h.keys.sort.join, 'PQR', '... works as expected';
}

# vim: ft=perl6
