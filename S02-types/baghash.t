use v6;
use Test;

plan 214;

# L<S02/Mutable types/QuantHash of UInt>

# A BagHash is a QuantHash of UInt, i.e. the values are positive Int

sub showkv($x) {
    $x.keys.sort.map({"$_:{$x{$_}}"}).join(' ')
}

# L<S02/Immutable types/'the bag listop'>

{
    say "We do get here, right?";
    my $b = BagHash.new("a", "foo", "a", "a", "a", "a", "b", "foo");
    isa_ok $b, BagHash, 'we got a BagHash';
    is showkv($b), 'a:5 b:1 foo:2', '...with the right elements';

    is $b.default, 0, "Defaults to 0";
    is $b<a>, 5, 'Single-key subscript (existing element)';
    isa_ok $b<a>, Int, 'Single-key subscript yields an Int';
    is $b<santa>, 0, 'Single-key subscript (nonexistent element)';
    isa_ok $b<santa>, Int, 'Single-key subscript yields an Int (nonexistent element)';
    ok $b<a>:exists, 'exists with existing element';
    nok $b<santa>:exists, 'exists with nonexistent element';

    is $b.values.elems, 3, "Values returns the correct number of values";
    is ([+] $b.values), 8, "Values returns the correct sum";
    ok ?$b, "Bool returns True if there is something in the BagHash";
    nok ?BagHash.new(), "Bool returns False if there is nothing in the BagHash";
    
    my $hash;
    lives_ok { $hash = $b.hash }, ".hash doesn't die";
    isa_ok $hash, Hash, "...and it returned a Hash";
    is showkv($hash), 'a:5 b:1 foo:2', '...with the right elements';

    dies_ok { $b.keys = <c d> }, "Can't assign to .keys";
    dies_ok { $b.values = 3, 4 }, "Can't assign to .values";

    is ~$b<a b>, "5 1", 'Multiple-element access';
    is ~$b<a santa b easterbunny>, "5 0 1 0", 'Multiple-element access (with nonexistent elements)';

    #?pugs   skip '.total NYI'
    #?niecza skip '.total NYI'
    is $b.total, 8, '.total gives sum of values';
    is $b.elems, 3, '.elems gives number of elements';
    is +$b, 8, '+$bag gives sum of values';

    lives_ok { $b<a> = 42 }, "Can assign to an existing element";
    is $b<a>, 42, "... and assignment takes effect";
    lives_ok { $b<brady> = 12 }, "Can assign to a new element";
    is $b<brady>, 12, "... and assignment takes effect";
    lives_ok { $b<spiderman> = 0 }, "Can assign zero to a nonexistent element";
    nok $b<spiderman>:exists, "... and that didn't create the element";
    lives_ok { $b<brady> = 0 }, "Can assign zero to a existing element";
    nok $b<brady>:exists, "... and it goes away";
    
    lives_ok { $b<a>++ }, "Can ++ an existing element";
    is $b<a>, 43, "... and the increment happens";
    lives_ok { $b<carter>++ }, "Can ++ a new element";
    is $b<carter>, 1, "... and the element is created";
    lives_ok { $b<a>-- }, "Can -- an existing element";
    is $b<a>, 42, "... and the decrement happens";
    lives_ok { $b<carter>-- }, "Can -- an element with value 1";
    nok $b<carter>:exists, "... and it goes away";
    #?niecza todo
    dies_ok { $b<farve>-- }, "Cannot -- an element that doesn't exist";
    nok $b<farve>:exists, "... and everything is still okay";
}

{
    ok (BagHash.new: <a b c>) ~~ (BagHash.new: <a b c>), "Identical bags smartmatch with each other";
    ok (BagHash.new: <a b c c>) ~~ (BagHash.new: <a b c c>), "Identical bags smartmatch with each other";
    nok (BagHash.new: <b c>) ~~ (BagHash.new: <a b c>), "Subset does not smartmatch";
    nok (BagHash.new: <a b c>) ~~ (BagHash.new: <a b c c>), "Subset (only quantity different) does not smartmatch";
    nok (BagHash.new: <a b c d>) ~~ (BagHash.new: <a b c>), "Superset does not smartmatch";
    nok (BagHash.new: <a b c c c>) ~~ (BagHash.new: <a b c c>), "Superset (only quantity different) does not smartmatch";
    nok "a" ~~ (BagHash.new: <a b c>), "Smartmatch is not element of";
    ok (BagHash.new: <a b c>) ~~ BagHash, "Type-checking smartmatch works";

    ok (set <a b c>) ~~ (BagHash.new: <a b c>), "Set smartmatches with equivalent BagHash.new:";
    nok (set <a a a b c>) ~~ (BagHash.new: <a a a b c>), "... but not if the Bag has greater quantities";
    nok (set <a b c>) ~~ BagHash, "Type-checking smartmatch works";
}

{
    isa_ok "a".BagHash, BagHash, "Str.BagHash makes a BagHash";
    is showkv("a".BagHash), 'a:1', "'a'.BagHash is bag a";

    isa_ok (a => 100000).BagHash, BagHash, "Pair.BagHash makes a BagHash";
    is showkv((a => 100000).BagHash), 'a:100000', "(a => 100000).BagHash is bag a:100000";
    is showkv((a => 0).BagHash), '', "(a => 0).BagHash is the empty bag";

    isa_ok <a b c>.BagHash, BagHash, "<a b c>.BagHash makes a BagHash";
    is showkv(<a b c a>.BagHash), 'a:2 b:1 c:1', "<a b c a>.BagHash makes the bag a:2 b:1 c:1";
    is showkv(["a", "b", "c", "a"].BagHash), 'a:2 b:1 c:1', "[a b c a].BagHash makes the bag a:2 b:1 c:1";
    is showkv([a => 3, b => 0, 'c', 'a'].BagHash), 'a:4 c:1', "[a => 3, b => 0, 'c', 'a'].BagHash makes the bag a:4 c:1";

    isa_ok {a => 2, b => 4, c => 0}.BagHash, BagHash, "{a => 2, b => 4, c => 0}.BagHash makes a BagHash";
    is showkv({a => 2, b => 4, c => 0}.BagHash), 'a:2 b:4', "{a => 2, b => 4, c => 0}.BagHash makes the bag a:2 b:4";
}

{
    my $b = BagHash.new(<a a b foo>);
    is $b<a>:exists, True, ':exists with existing element';
    is $b<santa>:exists, False, ':exists with nonexistent element';
    is $b<a>:delete, 2, ':delete works on BagHash';
    is showkv($b), 'b:1 foo:1', '...and actually deletes';
}

{
    my $b = BagHash.new('a', False, 2, 'a', False, False);
    my @ks = $b.keys;
    #?niecza 3 skip "Non-Str keys NYI"
    is @ks.grep(Int)[0], 2, 'Int keys are left as Ints';
    is @ks.grep(* eqv False).elems, 1, 'Bool keys are left as Bools';
    is @ks.grep(Str)[0], 'a', 'And Str keys are permitted in the same set';
    is $b{2, 'a', False}.join(' '), '1 2 3', 'All keys have the right values';
}

#?rakudo skip "Odd number of elements"
#?niecza skip "Unmatched key in Hash.LISTSTORE"
{
    my %h = bag <a b o p a p o o>;
    ok %h ~~ Hash, 'A hash to which a Bag has been assigned remains a hash';
    is showkv(%h), 'a:2 b:1 o:3 p:2', '...with the right elements';
}

{
    my $b = BagHash.new(<a b o p a p o o>);
    isa_ok $b, BagHash, '&BagHash.new given an array of strings produces a BagHash';
    is showkv($b), 'a:2 b:1 o:3 p:2', '...with the right elements';
}

{
    my $b = BagHash.new([ foo => 10, bar => 17, baz => 42, santa => 0 ]);
    isa_ok $b, BagHash, '&BagHash.new given an array of pairs produces a BagHash';
    is +$b, 1, "... with one element";
}

{
    my $b = BagHash.new({ foo => 10, bar => 17, baz => 42, santa => 0 }.hash);
    isa_ok $b, BagHash, '&BagHash.new given a Hash produces a BagHash';
    #?rakudo todo "Needs to catch up with spec"
    is +$b, 4, "... with four elements";
    #?niecza todo "Non-string bag elements NYI"
    #?rakudo todo "Needs to catch up with spec"
    is +$b.grep(Pair), 4, "... which are all Pairs";
}

{
    my $b = BagHash.new({ foo => 10, bar => 17, baz => 42, santa => 0 });
    isa_ok $b, BagHash, '&BagHash.new given a Hash produces a BagHash';
    is +$b, 1, "... with one element";
}

{
    my $b = BagHash.new(set <foo bar foo bar baz foo>);
    isa_ok $b, BagHash, '&BagHash.new given a Set produces a BagHash';
    is +$b, 1, "... with one element";
}

{
    my $b = BagHash.new(SetHash.new(<foo bar foo bar baz foo>));
    isa_ok $b, BagHash, '&BagHash.new given a SetHash produces a BagHash';
    is +$b, 1, "... with one element";
}

{
    my $b = BagHash.new(bag <foo bar foo bar baz foo>);
    isa_ok $b, BagHash, '&BagHash.new given a Bag produces a BagHash';
    is +$b, 1, "... with one element";
}

# Not sure how one should do this with the new BagHash constructor
# {
#     my $b = BagHash.new(set <foo bar foo bar baz foo>);
#     $b<bar> += 2;
#     my $c = BagHash.new($b);
#     isa_ok $c, BagHash, '&BagHash.new given a BagHash produces a BagHash';
#     is showkv($c), 'bar:3 baz:1 foo:1', '... with the right elements';
#     $c<manning> = 10;
#     is showkv($c), 'bar:3 baz:1 foo:1 manning:10', 'Creating a new element works';
#     is showkv($b), 'bar:3 baz:1 foo:1', '... and does not affect the original BagHash';
# }

{
    my $b = { foo => 10, bar => 1, baz => 2}.BagHash;

    # .list is just the keys, as per TimToady: 
    # http://irclog.perlgeek.de/perl6/2012-02-07#i_5112706
    isa_ok $b.list.elems, 3, ".list returns 3 things";
    is $b.list.grep(Str).elems, 3, "... all of which are Str";

    isa_ok $b.pairs.elems, 3, ".pairs returns 3 things";
    is $b.pairs.grep(Pair).elems, 3, "... all of which are Pairs";
    is $b.pairs.grep({ .key ~~ Str }).elems, 3, "... the keys of which are Strs";
    is $b.pairs.grep({ .value ~~ Int }).elems, 3, "... and the values of which are Ints";

    #?rakudo 3 skip 'No longer Iterable'
    is $b.iterator.grep(Pair).elems, 3, ".iterator yields three Pairs";
    is $b.iterator.grep({ .key ~~ Str }).elems, 3, "... the keys of which are Strs";
    is $b.iterator.grep({True}).elems, 3, "... and nothing else";
}

{
    my $b = { foo => 10000000000, bar => 17, baz => 42 }.BagHash;
    my $s;
    my $c;
    lives_ok { $s = $b.perl }, ".perl lives";
    isa_ok $s, Str, "... and produces a string";
    ok $s.chars < 1000, "... of reasonable length";
    lives_ok { $c = eval $s }, ".perl.eval lives";
    isa_ok $c, BagHash, "... and produces a BagHash";
    is showkv($c), showkv($b), "... and it has the correct values";
}

{
    my $b = { foo => 2, bar => 3, baz => 1 }.BagHash;
    my $s;
    lives_ok { $s = $b.Str }, ".Str lives";
    isa_ok $s, Str, "... and produces a string";
    is $s.split(" ").sort.join(" "), "bar(3) baz foo(2)", "... which only contains bar baz and foo with the proper counts and separated by spaces";
}

{
    my $b = { foo => 10000000000, bar => 17, baz => 42 }.BagHash;
    my $s;
    lives_ok { $s = $b.gist }, ".gist lives";
    isa_ok $s, Str, "... and produces a string";
    ok $s.chars < 1000, "... of reasonable length";
    ok $s ~~ /foo/, "... which mentions foo";
    ok $s ~~ /bar/, "... which mentions bar";
    ok $s ~~ /baz/, "... which mentions baz";
}

# L<S02/Names and Variables/'C<%x> may be bound to'>

{
    my %b := BagHash.new("a", "b", "c", "b");
    isa_ok %b, BagHash, 'A BagHash bound to a %var is a BagHash';
    is showkv(%b), 'a:1 b:2 c:1', '...with the right elements';

    is %b<b>, 2, 'Single-key subscript (existing element)';
    is %b<santa>, 0, 'Single-key subscript (nonexistent element)';

    lives_ok { %b<a> = 4 }, "Assign to an element";
    is %b<a>, 4, "... and gets the correct value";
}

# L<S32::Containers/BagHash/roll>

{
    my $b = BagHash.new("a", "b", "b");

    my $a = $b.roll;
    ok $a eq "a" || $a eq "b", "We got one of the two choices";

    my @a = $b.roll(2);
    is +@a, 2, '.roll(2) returns the right number of items';
    is @a.grep(* eq 'a').elems + @a.grep(* eq 'b').elems, 2, '.roll(2) returned "a"s and "b"s';

    @a = $b.roll: 100;
    is +@a, 100, '.roll(100) returns 100 items';
    ok 2 < @a.grep(* eq 'a') < 75, '.roll(100) (1)';
    ok @a.grep(* eq 'a') + 2 < @a.grep(* eq 'b'), '.roll(100) (2)';

    @a = $b.roll(*)[^100];
    ok 2 < @a.grep(* eq 'a') < 75, '.roll(100) (1)';
    ok @a.grep(* eq 'a') + 2 < @a.grep(* eq 'b'), '.roll(100) (2)';

    #?pugs   skip '.total NYI'
    #?niecza skip '.total NYI'
    is $b.total, 3, '.roll should not change BagHash';
    is $b.elems, 2, '.roll should not change BagHash';
}

{
    my $b = {"a" => 100000000000, "b" => 1}.BagHash;

    my $a = $b.roll;
    ok $a eq "a" || $a eq "b", "We got one of the two choices (and this was pretty quick, we hope!)";

    my @a = $b.roll: 100;
    is +@a, 100, '.roll(100) returns 100 items';
    ok @a.grep(* eq 'a') > 97, '.roll(100) (1)';
    ok @a.grep(* eq 'b') < 3, '.roll(100) (2)';
    #?pugs   skip '.total NYI'
    #?niecza skip '.total NYI'
    is $b.total, 100000000001, '.roll should not change BagHash';
    is $b.elems, 2, '.roll should not change BagHash';
}

# L<S32::Containers/BagHash/pick>

{
    my $b = BagHash.new("a", "b", "b");

    my $a = $b.pick;
    ok $a eq "a" || $a eq "b", "We got one of the two choices";

    my @a = $b.pick(2);
    is +@a, 2, '.pick(2) returns the right number of items';
    ok @a.grep(* eq 'a').elems <= 1, '.pick(2) returned at most one "a"';
    is @a.grep(* eq 'b').elems, 2 - @a.grep(* eq 'a').elems, '.pick(2) and the rest are "b"';

    @a = $b.pick: *;
    is +@a, 3, '.pick(*) returns the right number of items';
    is @a.grep(* eq 'a').elems, 1, '.pick(*) (1)';
    is @a.grep(* eq 'b').elems, 2, '.pick(*) (2)';
    #?pugs   skip '.total NYI'
    #?niecza skip '.total NYI'
    is $b.total, 3, '.pick should not change BagHash';
    is $b.elems, 2, '.pick should not change BagHash';
}

{
    my $b = {"a" => 100000000000, "b" => 1}.BagHash;

    my $a = $b.pick;
    ok $a eq "a" || $a eq "b", "We got one of the two choices (and this was pretty quick, we hope!)";

    my @a = $b.pick: 100;
    is +@a, 100, '.pick(100) returns 100 items';
    ok @a.grep(* eq 'a') > 98, '.pick(100) (1)';
    ok @a.grep(* eq 'b') < 2, '.pick(100) (2)';
    #?pugs   skip '.total NYI'
    #?niecza skip '.total NYI'
    is $b.total, 100000000001, '.pick should not change BagHash';
    is $b.elems, 2, '.pick should not change BagHash';
}

# L<S32::Containers/BagHash/grab>

#?pugs   skip '.grab NYI'
#?niecza skip '.grab NYI'
{
    my $b = BagHash.new("a", "b", "b");

    my $a = $b.grab;
    ok $a eq "a" || $a eq "b", "We got one of the two choices";

    my @a = $b.grab(2);
    is +@a, 2, '.grab(2) returns the right number of items';
    ok @a.grep(* eq 'a').elems <= 1, '.grab(2) returned at most one "a"';
    is @a.grep(* eq 'b').elems, 2 - @a.grep(* eq 'a').elems, '.grab(2) and the rest are "b"';
    is $b.total, 0, '.grab *should* change BagHash';
    #?rakudo.jvm todo "RT #120407"
    is $b.elems, 0, '.grab *should* change BagHash';
}

#?pugs   skip '.grab NYI'
#?niecza skip '.grab NYI'
{
    my $b = BagHash.new("a", "b", "b");
    my @a = $b.grab: *;
    is +@a, 3, '.grab(*) returns the right number of items';
    is @a.grep(* eq 'a').elems, 1, '.grab(*) (1)';
    is @a.grep(* eq 'b').elems, 2, '.grab(*) (2)';
    is $b.total, 0, '.grab *should* change BagHash';
    #?rakudo.jvm todo "RT #120407"
    is $b.elems, 0, '.grab *should* change BagHash';
}

#?pugs   skip '.grab NYI'
#?niecza skip '.grab NYI'
{
    my $b = {"a" => 100000000000, "b" => 1}.BagHash;

    my $a = $b.grab;
    ok $a eq "a" || $a eq "b", "We got one of the two choices (and this was pretty quick, we hope!)";

    my @a = $b.grab: 100;
    is +@a, 100, '.grab(100) returns 100 items';
    ok @a.grep(* eq 'a') > 98, '.grab(100) (1)';
    ok @a.grep(* eq 'b') < 2, '.grab(100) (2)';
    is $b.total, 99999999900, '.grab *should* change BagHash';
    ok 0 <= $b.elems <= 2, '.grab *should* change BagHash';
}

# L<S32::Containers/BagHash/grabpairs>

#?pugs   skip '.grabpairs NYI'
#?niecza skip '.grabpairs NYI'
{
    my $b = BagHash.new("a", "b", "b");

    my $a = $b.grabpairs[0];
    isa_ok $a, Pair, 'did we get a Pair';
    ok $a.key eq "a" || $a.key eq "b", "We got one of the two choices";

    my @a = $b.grabpairs(2);
    is +@a, 1, '.grabpairs(2) returns the right number of items';
    is @a.grep( {.isa(Pair)} ).Num, 1, 'are they all Pairs';
    ok @a[0].key eq "a" || @a[0].key eq "b", "We got one of the two choices";
    is $b.total, 0, '.grabpairs *should* change BagHash';
    is $b.elems, 0, '.grabpairs *should* change BagHash';
}

#?pugs   skip '.grabpairs NYI'
#?niecza skip '.grabpairs NYI'
{
    my $b = BagHash.new(<a a b b c c d d e e f f g g h h>);
    my @a = $b.grabpairs: *;
    is +@a, 8, '.grabpairs(*) returns the right number of items';
    is @a.grep( {.isa(Pair)} ).Num, 8, 'are they all Pairs';
    is @a.grep( {.value == 2} ).Num, 8, 'and they all have an expected value';
    is @a.sort.map({.key}).join, "abcdefgh", 'SetHash.grabpairs(*) gets all elements';
    isnt @a.map({.key}).join, "abcdefgh", 'SetHash.grabpairs(*) returns elements in a random order';
    is $b.total, 0, '.grabpairs *should* change BagHash';
    is $b.elems, 0, '.grabpairs *should* change BagHash';
}

#?rakudo skip "'is ObjectType' NYI"
#?niecza skip "Trait name not available on variables"
{
    my %h is BagHash = a => 1, b => 0, c => 2;
    #?rakudo todo 'todo'
    nok %h<b>:exists, '"b", initialized to zero, does not exist';
    #?rakudo todo 'todo'
    is +%h.keys, 2, 'Inititalization worked';
    is %h.elems, 3, '.elems works';
    #?rakudo todo 'todo'
    isa_ok %h<nonexisting>, Int, '%h<nonexisting> is an Int';
    #?rakudo todo 'todo'
    is %h<nonexisting>, 0, '%h<nonexisting> is 0';
}

#?rakudo skip "'is ObjectType' NYI"
#?niecza skip "Trait name not available on variables"
{
    my %h is BagHash = a => 1, b => 0, c => 2;

    lives_ok { %h<c> = 0 }, 'can set an item to 0';
    #?rakudo todo 'todo'
    nok %h<c>:exists, '"c", set to zero, does not exist';
    #?rakudo todo 'todo'
    is %h.elems, 1, 'one item left';
    #?rakudo todo 'todo'
    is %h.keys, ('a'), '... and the right one is gone';

    lives_ok { %h<c>++ }, 'can add (++) an item that was removed';
    #?rakudo todo 'todo'
    is %h.keys.sort, <a c>, '++ on an item reinstates it';
}

#?rakudo skip "'is ObjectType' NYI"
#?niecza skip "Trait name not available on variables"
{
    my %h is BagHash = a => 1, c => 1;

    lives_ok { %h<c>++ }, 'can "add" (++) an existing item';
    is %h<c>, 2, '++ on an existing item increments the counter';
    is %h.keys.sort, <a c>, '++ on an existing item does not add a key';

    lives_ok { %h<a>-- }, 'can remove an item with decrement (--)';
    #?rakudo todo 'todo'
    is %h.keys, ('c'), 'decrement (--) removes items';
    #?rakudo todo 'todo'
    nok %h<a>:exists, 'item is gone according to exists too';
    is %h<a>, 0, 'removed item is zero';

    lives_ok { %h<a>-- }, 'remove a missing item lives';
    #?rakudo todo 'todo'
    is %h.keys, ('c'), 'removing missing item does not change contents';
    #?rakudo todo 'todo'
    is %h<a>, 0, 'item removed again is still zero';
}

#?niecza skip "Trait name not available on variables"
{
    my %h of BagHash;
    ok %h.of.perl eq 'BagHash', 'is the hash really a BagHash';
    #?rakudo 2 todo 'in flux'
    lives_ok { %h = bag <a b c d c b> }, 'Assigning a Bag to a BagHash';
    is %h.keys.sort.map({ $^k ~ ':' ~ %h{$k} }).join(' '),
        'a:1 b:2 c:2 d:1', '... works as expected';
}

{
    isa_ok 42.BagHash, BagHash, "Method .BagHash works on Int-1";
    is showkv(42.BagHash), "42:1", "Method .BagHash works on Int-2";
    isa_ok "blue".BagHash, BagHash, "Method .BagHash works on Str-1";
    is showkv("blue".BagHash), "blue:1", "Method .BagHash works on Str-2";
    my @a = <Now the cross-handed set was the Paradise way>;
    isa_ok @a.BagHash, BagHash, "Method .BagHash works on Array-1";
    is showkv(@a.BagHash), "Now:1 Paradise:1 cross-handed:1 set:1 the:2 was:1 way:1", "Method .BagHash works on Array-2";
    my %x = "a" => 1, "b" => 2;
    isa_ok %x.BagHash, BagHash, "Method .BagHash works on Hash-1";
    is showkv(%x.BagHash), "a:1 b:2", "Method .BagHash works on Hash-2";
    isa_ok (@a, %x).BagHash, BagHash, "Method .BagHash works on Parcel-1";
    is showkv((@a, %x).BagHash), "Now:1 Paradise:1 a:1 b:2 cross-handed:1 set:1 the:2 was:1 way:1",
       "Method .BagHash works on Parcel-2";
}

# vim: ft=perl6
