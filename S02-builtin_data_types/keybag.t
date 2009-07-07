use v6;
use Test;
plan 19;

# L<S02/Mutable types/"KeyBag of UInt">

# A KeyBag is a KeyHash of UInt, i.e. the values are positive Int

{
    my %h is KeyBag;

    %h = (a => 1, b => 0, c => 2);
    ok ! %h.exists( 'b' ), '"b", initialized to zero, does not exist';
    is %h.elems, 2, 'Inititalization worked';

    lives_ok { %h<c> = 0 }, 'can set an item to 0';
    ok ! %h.exists( 'c' ), '"c", set to zero, does not exist';
    is %h.elems, 1, 'one item left';
    is %h.keys, ('a'), '... and the right one is gone';

    lives_ok { %h<c>++ }, 'can add (++) an item that was removed';
    is %h.keys.sort, <a c>, '++ on an item reinstates it';

    lives_ok { %h<c>++ }, 'can "add" (++) an existing item';
    is %h<c>, 2, '++ on an existing item increments the counter';
    is %h.keys.sort, <a c>, '++ on an existing item does not add a key';

    lives_ok { %h<a>-- }, 'can remove an item with decrement (--)';
    is %h.keys, ('c'), 'decrement (--) removes items';
    ok ! %h.exists( 'a' ), 'item is gone according to .exists too';
    is %h<a>, 0, 'removed item is zero';

    lives_ok { %h<a>-- }, 'remove a missing item lives';
    is %h.keys, ('c'), 'removing missing item does not change contents';
    is %h<a>, 0, 'item removed again is still zero';

    is %h<z>, 0, 'item that was never present is zero';
}

# vim: ft=perl6
