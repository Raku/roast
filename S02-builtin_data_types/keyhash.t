use v6;
use Test;
plan 18;

# L<S02/Mutable types/"A KeyHash differs from a normal Hash">

# untyped KeyHash
{
    my %h is KeyHash;

    %h = (a => 1, b => 3, c => -1, d => 7);
    is +%h.elems, 4, 'Inititalization worked';
    lives_ok { %h<d> = 0 }, 'can set an item to 0';
    is %h.elems, 3, '... and an item is gone';
    is %h.keys.sort.join(''), 'abc', '... and the right one is gone';
    %h<c>++;
    is %h.keys.sort.join(''), 'ab', '++ on an item with -1 deletes it';
    %h<a>--;
    is ~%h.keys, 'b', '-- also removes items when they go to zero';
    %h<b>--;
    is ~%h.keys, 'b', '... but only if they go to zero';
    %h<c> = 'abc';
    is ~%h<b c>, '2 abc', 'can store a string as well';
    %h<c> = '';
    is +%h, 1, 'setting a value to the null string also removes it';
    %h<b> = undef;
    is %h, 0, 'setting a value to undef also removes it';
    ok !%h, '... and the empty hash is false in boolean context';
}

# typed KeyHash
{
    my Int %h is KeyHash;

    %h = (a => 1, b => 3, c => -1, d => 7);
    is +%h.elems, 4, 'Inititalization worked';
    lives_ok { %h<d> = 0 }, 'can set an item to 0';
    is %h.elems, 3, '... and an item is gone';
    is %h.keys.sort.join(''), 'abc', '... and the right one is gone';
    %h<c>++;
    is %h.keys.sort.join(''), 'ab', '++ on an item with -1 deletes it';
    %h<a>--;
    is ~%h.keys, 'b', '-- also removes items when they go to zero';
    %h<b>--;
    is ~%h.keys, 'b', '... but only if they go to zero';
}


# vim: ft=perl6
