use v6;
use Test;

plan 23;

# L<S02/Mutable types/KeyHash of UInt>

# A KeyBag is a KeyHash of UInt, i.e. the values are positive Int

{
    my %h is KeyBag = a => 1, b => 0, c => 2;
    nok %h.exists( 'b' ), '"b", initialized to zero, does not exist';
    is +%h.keys, 2, 'Inititalization worked';
    is %h.elems, 3, '.elems works';
    isa_ok %h<nonexisting>, Int, '%h<nonexisting> is an Int';
    is %h<nonexisting>, 0, '%h<nonexisting> is 0';
}

{
    my %h is KeyBag = a => 1, b => 0, c => 2;

    lives_ok { %h<c> = 0 }, 'can set an item to 0';
    nok %h.exists( 'c' ), '"c", set to zero, does not exist';
    is %h.elems, 1, 'one item left';
    is %h.keys, ('a'), '... and the right one is gone';

    lives_ok { %h<c>++ }, 'can add (++) an item that was removed';
    is %h.keys.sort, <a c>, '++ on an item reinstates it';
}

{
    my %h is KeyBag = a => 1, c => 1;

    lives_ok { %h<c>++ }, 'can "add" (++) an existing item';
    is %h<c>, 2, '++ on an existing item increments the counter';
    is %h.keys.sort, <a c>, '++ on an existing item does not add a key';

    lives_ok { %h<a>-- }, 'can remove an item with decrement (--)';
    is %h.keys, ('c'), 'decrement (--) removes items';
    nok %h.exists( 'a' ), 'item is gone according to .exists too';
    is %h<a>, 0, 'removed item is zero';

    lives_ok { %h<a>-- }, 'remove a missing item lives';
    is %h.keys, ('c'), 'removing missing item does not change contents';
    is %h<a>, 0, 'item removed again is still zero';
}

{
    my %h is KeyBag;
    lives_ok { %h = bag <a b c d c b> }, 'Assigning a Bag to a KeyBag';
    is %h.keys.sort.map({ $^k ~ ':' ~ %h{$^k} }).join(' '),
        'a:1 b:2 c:2 d:1', '... works as expected';
}

# vim: ft=perl6
