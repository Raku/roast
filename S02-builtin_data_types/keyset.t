use v6;
use Test;
plan 8;

# L<S02/Mutable types/"KeySet KeyHash of Bool">

# A KeySet is a KeyHash of Bool, i.e. the values are Bool

{
    my %h is KeySet;

    %h = (a => True, b => False, c => True);
    is +%h.elems, 2, 'Inititalization worked';
    lives_ok { %h<c> = 0 }, 'can set an item to 0';
    is %h.elems, 1, '... and an item is gone';
    is %h.keys.join, 'a', '... and the right one is gone';
    %h<c>++;
    is %h.keys.sort.join, 'ac', '++ on an item reinstates it';
    %h<c>++;
    is %h.keys.sort.join, 'ac', '++ on an existing item does nothing';
    %h<a>--;
    is ~%h.keys, 'c', '-- removes items';
    %h<b>--;
    is ~%h.keys, 'c', '... but only if they were there from the beginning';
}

# vim: ft=perl6
