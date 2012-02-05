use v6;
use Test;

plan 69;

# L<S02/Mutable types/KeyHash of UInt>

# A KeyBag is a KeyHash of UInt, i.e. the values are positive Int

sub showkv($x) {
    $x.keys.sort.map({ $^k ~ ':' ~ $x{$^k} }).join(' ')
}

# L<S02/Immutable types/'the bag listop'>

{
    my $b = KeyBag.new("a", "foo", "a", "a", "a", "a", "b", "foo");
    isa_ok $b, KeyBag, 'we got a KeyBag';
    is showkv($b), 'a:5 b:1 foo:2', '...with the right elements';

    is $b<a>, 5, 'Single-key subscript (existing element)';
    is $b<santa>, 0, 'Single-key subscript (nonexistent element)';
    ok $b.exists('a'), '.exists with existing element';
    nok $b.exists('santa'), '.exists with nonexistent element';

    dies_ok { $b.keys = <c d> }, "Can't assign to .keys";
    dies_ok { $b.values = 3, 4 }, "Can't assign to .values";

    #?niecza 2 todo
    is ([+] $b<a b>), 6, 'Multiple-element access';
    is ([+] $b<a santa b easterbunny>), 6, 'Multiple-element access (with nonexistent elements)';

    is $b.elems, 8, '.elems gives sum of values';
    is +$b, 8, '+$bag gives sum of values';

    lives_ok { $b<a> = 42 }, "Can assign to an existing element";
    is $b<a>, 42, "... and assignment takes effect";
    lives_ok { $b<brady> = 12 }, "Can assign to a new element";
    is $b<brady>, 12, "... and assignment takes effect";
    
    lives_ok { $b<a>++ }, "Can ++ an existing element";
    is $b<a>, 43, "... and the increment happens";
    lives_ok { $b<carter>++ }, "Can ++ a new element";
    is $b<carter>, 1, "... and the element is created";
    lives_ok { $b<a>-- }, "Can -- an existing element";
    is $b<a>, 42, "... and the decrement happens";
    lives_ok { $b<carter>-- }, "Can -- an element with value 1";
    nok $b.exists("carter"), "... and it goes away";
    lives_ok { $b<farve>-- }, "Can -- an element that doesn't exist";
    nok $b.exists("farve"), "... and everything is still okay";
}

{
    my $b = KeyBag.new('a', False, 2, 'a', False, False);
    my @ks = $b.keys;
    #?niecza 2 todo
    is @ks.grep(Int)[0], 2, 'Int keys are left as Ints';
    is @ks.grep(* eqv False).elems, 1, 'Bool keys are left as Bools';
    is @ks.grep(Str)[0], 'a', 'And Str keys are permitted in the same set';
    #?niecza todo
    is $b{2, 'a', False}.sort.join(' '), '1 2 3', 'All keys have the right values';
}

#?niecza skip "Unmatched key in Hash.LISTSTORE"
{
    my %h = bag <a b o p a p o o>;
    ok %h ~~ Hash, 'A hash to which a Bag has been assigned remains a hash';
    is showkv(%h), 'a:2 b:1 o:3 p:2', '...with the right elements';
}

{
    my $b = bag set <foo bar foo bar baz foo>;
    isa_ok $b, Bag, '&bag given a Set produces a Bag';
    is showkv($b), 'bar:1 baz:1 foo:1', '... with the right elements';
}

# L<S02/Names and Variables/'C<%x> may be bound to'>

{
    my %b := bag <a b c b>;
    isa_ok %b, Bag, 'A Bag bound to a %var is a Bag';
    is showkv(%b), 'a:1 b:2 c:1', '...with the right elements';

    is %b<b>, 2, 'Single-key subscript (existing element)';
    is %b<santa>, 0, 'Single-key subscript (nonexistent element)';

    dies_ok { %b<a> = 1 }, "Can't assign to an element (Bags are immutable)";
    dies_ok { %b = bag <a b> }, "Can't assign to a %var implemented by Bag";
}

# L<S32::Containers/Bag/pick>

{
    my $b = bag <a b b>;

    my @a = $b.pick: *;
    is +@a, 3, '.pick(*) returns the right number of items';
    is @a.grep(* eq 'a').elems, 1, '.pick(*) (1)';
    is @a.grep(* eq 'b').elems, 2, '.pick(*) (2)';
}

# L<S32::Containers/Bag/roll>

{
    my $b = bag <a b b>;

    my @a = $b.roll: 100;
    is +@a, 100, '.roll(100) returns 100 items';
    ok 2 < @a.grep(* eq 'a') < 75, '.roll(100) (1)';
    ok @a.grep(* eq 'a') + 2 < @a.grep(* eq 'b'), '.roll(100) (2)';
}

#?niecza skip "Trait name not available on variables"
{
    my %h is KeyBag = a => 1, b => 0, c => 2;
    nok %h.exists( 'b' ), '"b", initialized to zero, does not exist';
    is +%h.keys, 2, 'Inititalization worked';
    is %h.elems, 3, '.elems works';
    isa_ok %h<nonexisting>, Int, '%h<nonexisting> is an Int';
    is %h<nonexisting>, 0, '%h<nonexisting> is 0';
}

#?niecza skip "Trait name not available on variables"
{
    my %h is KeyBag = a => 1, b => 0, c => 2;

    lives_ok { %h<c> = 0 }, 'can set an item to 0';
    nok %h.exists( 'c' ), '"c", set to zero, does not exist';
    is %h.elems, 1, 'one item left';
    is %h.keys, ('a'), '... and the right one is gone';

    lives_ok { %h<c>++ }, 'can add (++) an item that was removed';
    is %h.keys.sort, <a c>, '++ on an item reinstates it';
}

#?niecza skip "Trait name not available on variables"
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

#?niecza skip "Trait name not available on variables"
{
    my %h is KeyBag;
    lives_ok { %h = bag <a b c d c b> }, 'Assigning a Bag to a KeyBag';
    is %h.keys.sort.map({ $^k ~ ':' ~ %h{$^k} }).join(' '),
        'a:1 b:2 c:2 d:1', '... works as expected';
}

# vim: ft=perl6
