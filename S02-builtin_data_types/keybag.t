use v6;
use Test;
plan 12;

# L<S02/Mutable types/"KeyBag of UInt">

# A KeyBag is a KeyHash of UInt, i.e. the values are positive Int

# XXX A KeyHash of UInt wouldn't do what these tests look for.
# I'd think a bag's .elems would return the sum of .values
# I'd also think a bag's .keys would repeat an item that appears many times.

{
    my %h is KeyBag;

    %h = (a => 1, b => 0, c => 2);
    is %h.elems, 3, 'Inititalization worked';
    lives_ok { %h<c> = 0 }, 'can set an item to 0';
    is %h.elems, 1, '... and an item is gone';
    is ~%h.keys, 'a', '... and the right one is gone';

    %h<c>++;
    is ~%h.keys.sort, 'ac', '++ on an item reinstates it';
    %h<c>++;
    is ~%h.keys.sort, 'acc', '++ on an existing item adds another';
    %h<a>--;
    is ~%h.keys, 'cc', '-- removes items';
    %h<b>--;
    is ~%h.keys, 'cc', '... but only if they were there from the beginning';

    %h<b> = 1;
    is %h<b>, 1, 'item treated as a value is integer';
    %h<b>--;
    is %h<b>, 0, 'removed item is zero';
    %h<b>--;
    is %h<b>, 0, 'item removed again is still zero';
    is %h<z>, 0, 'item that was never present is zero';
}

# vim: ft=perl6
