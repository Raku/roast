use v6;
use Test;
use lib $?FILE.IO.parent(2).add: 'packages/Test-Helpers';
use Test::Util;

plan 333;

# L<S02/Mutable types/QuantHash of UInt>

# A BagHash is a QuantHash of UInt, i.e. the values are positive Int

sub showkv($x) {
    $x.keys.sort.map({"$_:{$x{$_}}"}).join(' ')
}

# L<S02/Immutable types/'the bag listop'>

{
    say "We do get here, right?";
    my $b = BagHash.new("a", "foo", "a", "a", "a", "a", "b", "foo");
    isa-ok $b, BagHash, 'we got a BagHash';
    is showkv($b), 'a:5 b:1 foo:2', '...with the right elements';

    is $b.default, 0, "Defaults to 0";
    is $b<a>, 5, 'Single-key subscript (existing element)';
    isa-ok $b<a>, Int, 'Single-key subscript yields an Int';
    is $b<santa>, 0, 'Single-key subscript (nonexistent element)';
    isa-ok $b<santa>, Int, 'Single-key subscript yields an Int (nonexistent element)';
    ok $b<a>:exists, 'exists with existing element';
    nok $b<santa>:exists, 'exists with nonexistent element';

    is $b.values.elems, 3, "Values returns the correct number of values";
    is ([+] $b.values), 8, "Values returns the correct sum";
    ok ?$b, "Bool returns True if there is something in the BagHash";
    nok ?BagHash.new(), "Bool returns False if there is nothing in the BagHash";

    my $hash;
    lives-ok { $hash = $b.hash }, ".hash doesn't die";
    isa-ok $hash, Hash, "...and it returned a Hash";
    is showkv($hash), 'a:5 b:1 foo:2', '...with the right elements';

    throws-like { $b.keys = <c d> },
      X::Assignment::RO,
      "Can't assign to .keys";
    throws-like { $b.values = 3, 4 },
      X::Assignment::RO,
      "Can't assign to .values";

    is ~$b<a b>, "5 1", 'Multiple-element access';
    is ~$b<a santa b easterbunny>, "5 0 1 0", 'Multiple-element access (with nonexistent elements)';

    is $b.total, 8, '.total gives sum of values';
    is $b.elems, 3, '.elems gives number of elements';
    is +$b, 8, '+$bag gives sum of values';

    lives-ok { $b<a> = 42 }, "Can assign to an existing element";
    is $b<a>, 42, "... and assignment takes effect";
    lives-ok { $b<brady> = 12 }, "Can assign to a new element";
    is $b<brady>, 12, "... and assignment takes effect";
    lives-ok { $b<spiderman> = 0 }, "Can assign zero to a nonexistent element";
    nok $b<spiderman>:exists, "... and that didn't create the element";
    lives-ok { $b<brady> = 0 }, "Can assign zero to a existing element";
    nok $b<brady>:exists, "... and it goes away";

    lives-ok { $b<a>++ }, "Can ++ an existing element";
    is $b<a>, 43, "... and the increment happens";
    lives-ok { $b<carter>++ }, "Can ++ a new element";
    is $b<carter>, 1, "... and the element is created";
    lives-ok { $b<a>-- }, "Can -- an existing element";
    is $b<a>, 42, "... and the decrement happens";
    lives-ok { $b<carter>-- }, "Can -- an element with value 1";
    nok $b<carter>:exists, "... and it goes away";
    is $b<farve>--, 0, "Can -- an element that doesn't exist";
    nok $b<farve>:exists, "... but it doesn't create it";
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
    isa-ok "a".BagHash, BagHash, "Str.BagHash makes a BagHash";
    is showkv("a".BagHash), 'a:1', "'a'.BagHash is bag a";

    isa-ok (a => 100000).BagHash, BagHash, "Pair.BagHash makes a BagHash";
    is showkv((a => 100000).BagHash), 'a:100000', "(a => 100000).BagHash is bag a:100000";
    is showkv((a => 0).BagHash), '', "(a => 0).BagHash is the empty bag";

    isa-ok <a b c>.BagHash, BagHash, "<a b c>.BagHash makes a BagHash";
    is showkv(<a b c a>.BagHash), 'a:2 b:1 c:1', "<a b c a>.BagHash makes the bag a:2 b:1 c:1";
    is showkv(["a", "b", "c", "a"].BagHash), 'a:2 b:1 c:1', "[a b c a].BagHash makes the bag a:2 b:1 c:1";
    is showkv([a => 3, b => 0, 'c', 'a'].BagHash), 'a:4 c:1', "[a => 3, b => 0, 'c', 'a'].BagHash makes the bag a:4 c:1";

    isa-ok {a => 2, b => 4, c => 0}.BagHash, BagHash, "{a => 2, b => 4, c => 0}.BagHash makes a BagHash";
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
    is @ks.grep({ .WHAT === Int })[0], 2, 'Int keys are left as Ints';
    is @ks.grep(* eqv False).elems, 1, 'Bool keys are left as Bools';
    is @ks.grep(Str)[0], 'a', 'And Str keys are permitted in the same set';
    is $b{2, 'a', False}.join(' '), '1 2 3', 'All keys have the right values';
}

{
    my $a = (1,2,3,2,2,2,2).BagHash;
    is $a.kv.sort, (1,1,1,2,3,5), "BagHash.kv returns list of keys and values";
}

{
    my $b = BagHash.new(<a b o p a p o o>);
    isa-ok $b, BagHash, '&BagHash.new given an array of strings produces a BagHash';
    is showkv($b), 'a:2 b:1 o:3 p:2', '...with the right elements';
}

{
    my $b = BagHash.new(1, [ foo => 10, bar => 17, baz => 42, santa => 0 ]);
    isa-ok $b, BagHash, '&BagHash.new given something and an array of pairs produces a BagHash';
    is +$b, 2, "... with two elements";
}

{
    my $b = BagHash.new({ foo => 10, bar => 17, baz => 42, santa => 0 }.hash);
    isa-ok $b, BagHash, '&BagHash.new given a Hash produces a BagHash';
    is +$b, 4, "... with four elements";
    is +$b.grep(Pair), 4, "... which are all Pairs";
}

{
    my $b = BagHash.new(1, { foo => 10, bar => 17, baz => 42, santa => 0 });
    isa-ok $b, BagHash, '&BagHash.new given a Hash and something produces a BagHash';
    is +$b, 2, "... with one element";
}

{
    my $b = BagHash.new(set <foo bar foo bar baz foo>);
    isa-ok $b, BagHash, '&BagHash.new given a Set produces a BagHash';
    is +$b, 1, "... with one element";
}

{
    my $b = BagHash.new(SetHash.new(<foo bar foo bar baz foo>));
    isa-ok $b, BagHash, '&BagHash.new given a SetHash produces a BagHash';
    is +$b, 1, "... with one element";
}

{
    my $b = BagHash.new(bag <foo bar foo bar baz foo>);
    isa-ok $b, BagHash, '&BagHash.new given a Bag produces a BagHash';
    is +$b, 1, "... with one element";
}

# Not sure how one should do this with the new BagHash constructor
# {
#     my $b = BagHash.new(set <foo bar foo bar baz foo>);
#     $b<bar> += 2;
#     my $c = BagHash.new($b);
#     isa-ok $c, BagHash, '&BagHash.new given a BagHash produces a BagHash';
#     is showkv($c), 'bar:3 baz:1 foo:1', '... with the right elements';
#     $c<manning> = 10;
#     is showkv($c), 'bar:3 baz:1 foo:1 manning:10', 'Creating a new element works';
#     is showkv($b), 'bar:3 baz:1 foo:1', '... and does not affect the original BagHash';
# }

{
    my $b = { foo => 10, bar => 1, baz => 2}.BagHash;

    # .list is just the keys, as per TimToady:
    # http://irclog.perlgeek.de/perl6/2012-02-07#i_5112706
    isa-ok $b.list.elems, 3, ".list returns 3 things";
    is $b.list.grep(Pair).elems, 3, "... all of which are Pairs";

    isa-ok $b.pairs.elems, 3, ".pairs returns 3 things";
    is $b.pairs.grep(Pair).elems, 3, "... all of which are Pairs";
    is $b.pairs.grep({ .key ~~ Str }).elems, 3, "... the keys of which are Strs";
    is $b.pairs.grep({ .value ~~ Int }).elems, 3, "... and the values of which are Ints";
}

{
    my $b = { foo => 10000000000, bar => 17, baz => 42 }.BagHash;
    my $s;
    my $c;
    lives-ok { $s = $b.raku }, ".raku lives";
    isa-ok $s, Str, "... and produces a string";
    ok $s.chars < 1000, "... of reasonable length";
    lives-ok { $c = EVAL $s }, ".raku.EVAL lives";
    isa-ok $c, BagHash, "... and produces a BagHash";
    is showkv($c), showkv($b), "... and it has the correct values";
}

{
    my $b = { foo => 2, bar => 3, baz => 1 }.BagHash;
    my $s;
    lives-ok { $s = $b.Str }, ".Str lives";
    isa-ok $s, Str, "... and produces a string";
    is $s.split(" ").sort.join(" "), "bar(3) baz foo(2)", "... which only contains bar baz and foo with the proper counts and separated by spaces";
}

{
    my $b = { foo => 10000000000, bar => 17, baz => 42 }.BagHash;
    my $s;
    lives-ok { $s = $b.gist }, ".gist lives"; isa-ok $s, Str, "... and produces a string";
    ok $s.chars < 1000, "... of reasonable length";
    ok $s ~~ /foo/, "... which mentions foo";
    ok $s ~~ /bar/, "... which mentions bar";
    ok $s ~~ /baz/, "... which mentions baz";
}

# L<S02/Names and Variables/'C<%x> may be bound to'>

{
    my %b := BagHash.new("a", "b", "c", "b");
    isa-ok %b, BagHash, 'A BagHash bound to a %var is a BagHash';
    is showkv(%b), 'a:1 b:2 c:1', '...with the right elements';

    is %b<b>, 2, 'Single-key subscript (existing element)';
    is %b<santa>, 0, 'Single-key subscript (nonexistent element)';

    lives-ok { %b<a> = 4 }, "Assign to an element";
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
    is $b.total, 3, '.pick should not change BagHash';
    is $b.elems, 2, '.pick should not change BagHash';

    my $c = * / 2;
    my $count = $c($b.total).Int;
    @a = $b.pick: $c;
    is +@a, $count, '.pick(Callable) returns the right number of items';
    is $b.total, 3, '.pick should not change BagHash';
    is $b.elems, 2, '.pick should not change BagHash';

    @a = $b.pick(-2.5);
    is +@a, 0, '.pick(<negative number>) does not return any items';

    # https://github.com/Raku/old-issue-tracker/issues/6228
    is +$b.pick(2.5), 2, ".pick int-ifies arg";
}

{
    my $b = {"a" => 100000000000, "b" => 1}.BagHash;

    my $a = $b.pick;
    ok $a eq "a" || $a eq "b", "We got one of the two choices (and this was pretty quick, we hope!)";

    my @a = $b.pick: 100;
    is +@a, 100, '.pick(100) returns 100 items';
    ok @a.grep(* eq 'a') > 98, '.pick(100) (1)';
    ok @a.grep(* eq 'b') < 2, '.pick(100) (2)';
    is $b.total, 100000000001, '.pick should not change BagHash';
    is $b.elems, 2, '.pick should not change BagHash';
}

# L<S32::Containers/BagHash/pickpairs>

{
    my $b = BagHash.new("a", "b", "b");

    my $a = $b.pickpairs;
    say :$a.raku;
    isa-ok $a, Pair, 'Did we get a Pair';
    ok ($a eq "a\t1" or $a eq "b\t2"), "We got one of the two choices";

    my @a = $b.pickpairs(2);
    is +@a, 2, '.pickpairs(2) returns the right number of items';
    is @a.grep(* eq "a\t1").elems, 1, '.pickpairs(2) returned one "a"';
    is @a.grep(* eq "b\t2").elems, 1, '.pickpairs(2) returned one "b"';

    @a = $b.pickpairs: *;
    is +@a, 2, '.pickpairs(*) returns the right number of items';
    is @a.grep(* eq "a\t1").elems, 1, '.pickpairs(*) (1)';
    is @a.grep(* eq "b\t2").elems, 1, '.pickpairs(*) (2)';
    is $b.total, 3, '.pickpairs should not change Bag';

    @a = $b.pickpairs(-2.5);
    is +@a, 0, '.pickpairs(<negative number>) does not return any items';
}

{
    my $b = BagHash.new(<a a b b c c d d e e f f g g h h>);
    my $c = * / 2;
    my $elems = $b.elems;
    my $total = $b.total;
    my $count = $c($b.elems).Int;
    my @a = $b.pickpairs: $c;
    is +@a, $count, '.pickpairs(Callable) returns the right number of items';
    is @a.grep( {.isa(Pair)} ).Num, $count, 'are they all Pairs';
    is @a.grep( {.value == 2} ).Num, $count, 'and they all have an expected value';
    is $b.total, $total, '.pickpairs should not change BagHash';
    is $b.elems, $elems, '.pickpairs should not change BagHash';
}

# L<S32::Containers/BagHash/grab>

{
    my $b = BagHash.new("a", "b", "b");

    my $a = $b.grab;
    ok $a eq "a" || $a eq "b", "We got one of the two choices";

    my @a = $b.grab(2);
    is +@a, 2, '.grab(2) returns the right number of items';
    ok @a.grep(* eq 'a').elems <= 1, '.grab(2) returned at most one "a"';
    is @a.grep(* eq 'b').elems, 2 - @a.grep(* eq 'a').elems, '.grab(2) and the rest are "b"';
    is $b.total, 0, '.grab *should* change BagHash';
    is $b.elems, 0, '.grab *should* change BagHash';
}

{
    my $b = BagHash.new("a", "b", "b");
    my @a = $b.grab: *;
    is +@a, 3, '.grab(*) returns the right number of items';
    is @a.grep(* eq 'a').elems, 1, '.grab(*) (1)';
    is @a.grep(* eq 'b').elems, 2, '.grab(*) (2)';
    is $b.total, 0, '.grab *should* change BagHash';
    is $b.elems, 0, '.grab *should* change BagHash';
}

{
    my $b = BagHash.new("a", "a", "b", "b", "b");
    my $c = * / 2;
    my $total = $b.total;
    my $count = $c($b.total).Int;
    my @a = $b.grab: $c;
    is +@a, $count, '.grab(Callable) returns the right number of items';
    is $b.total, $total - $count, '.grab *should* change BagHash';
}

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

{
    my $b = BagHash.new("a", "b", "b");

    my $a = $b.grabpairs[0];
    isa-ok $a, Pair, 'did we get a Pair';
    ok $a.key eq "a" || $a.key eq "b", "We got one of the two choices";

    my @a = $b.grabpairs(2);
    is +@a, 1, '.grabpairs(2) returns the right number of items';
    is @a.grep( {.isa(Pair)} ).Num, 1, 'are they all Pairs';
    ok @a[0].key eq "a" || @a[0].key eq "b", "We got one of the two choices";
    is $b.total, 0, '.grabpairs *should* change BagHash';
    is $b.elems, 0, '.grabpairs *should* change BagHash';
}

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

{
    my $b = BagHash.new(<a a b b c c d d e e f f g g h h>);
    my $c = * / 2;
    my $elems = $b.elems;
    my $count = $c($b.elems).Int;
    my @a = $b.grabpairs: $c;
    is +@a, $count, '.grabpairs(Callable) returns the right number of items';
    is @a.grep( {.isa(Pair)} ).Num, $count, 'are they all Pairs';
    is @a.grep( {.value == 2} ).Num, $count, 'and they all have an expected value';
    is $b.total, $($elems - $count) * 2, '.grabpairs *should* change BagHash';
    is $b.elems, $elems - $count, '.grabpairs *should* change BagHash';
}

{
    my $b = BagHash[Str].new( <a b c> );
    is-deeply $b.keys.sort.List, <a b c>, 'can we parameterize for strings?';
    ok BagHash[Str].keyof =:= Str, 'does .keyof return the correct type';
    throws-like { $b{42} = 1 }, X::TypeCheck::Binding,
      'does attempt to add item of wrong type croak';
    throws-like { BagHash[Int].new( <a b c> ) }, X::TypeCheck::Binding,
      'do wrong values make initialization croak';
}

# https://github.com/Raku/old-issue-tracker/issues/3836
{
    my %h is BagHash = a => 1, b => 0, c => 2;
    nok %h<b>:exists, '"b", initialized to zero, does not exist';
    is +%h.keys, 2, 'Inititalization worked';
    is %h.elems, 2, '.elems works';
    isa-ok %h<nonexisting>, Int, '%h<nonexisting> is an Int';
    is %h<nonexisting>, 0, '%h<nonexisting> is 0';
}

# https://github.com/Raku/old-issue-tracker/issues/3836
{
    my %h is BagHash = a => 1, b => 0, c => 2;

    lives-ok { %h<c> = 0 }, 'can set an item to 0';
    nok %h<c>:exists, '"c", set to zero, does not exist';
    is %h.elems, 1, 'one item left';
    is %h.keys, ('a'), '... and the right one is gone';

    lives-ok { %h<c>++ }, 'can add (++) an item that was removed';
    is %h.keys.sort, <a c>, '++ on an item reinstates it';
}

# https://github.com/Raku/old-issue-tracker/issues/3836
{
    my %h is BagHash = a => 1, c => 1;

    lives-ok { %h<c>++ }, 'can "add" (++) an existing item';
    is %h<c>, 2, '++ on an existing item increments the counter';
    is %h.keys.sort, <a c>, '++ on an existing item does not add a key';

    lives-ok { %h<a>-- }, 'can remove an item with decrement (--)';
    is %h.keys, ('c'), 'decrement (--) removes items';
    nok %h<a>:exists, 'item is gone according to exists too';
    is %h<a>, 0, 'removed item is zero';

    lives-ok { %h<a>-- }, 'remove a missing item lives';
    is %h.keys, ('c'), 'removing missing item does not change contents';
    is %h<a>, 0, 'item removed again is still zero';
}

{
    my %h of BagHash;
    ok %h.of.raku eq 'BagHash', 'is the hash really a BagHash';
    #?rakudo 2 todo 'in flux'
    lives-ok { %h = bag <a b c d c b> }, 'Assigning a Bag to a BagHash';
    is %h.keys.sort.map({ $^k ~ ':' ~ %h{$k} }).join(' '),
        'a:1 b:2 c:2 d:1', '... works as expected';
}

{
    isa-ok 42.BagHash, BagHash, "Method .BagHash works on Int-1";
    is showkv(42.BagHash), "42:1", "Method .BagHash works on Int-2";
    isa-ok "blue".BagHash, BagHash, "Method .BagHash works on Str-1";
    is showkv("blue".BagHash), "blue:1", "Method .BagHash works on Str-2";
    my @a = <Now the cross-handed set was the Paradise way>;
    isa-ok @a.BagHash, BagHash, "Method .BagHash works on Array-1";
    is showkv(@a.BagHash), "Now:1 Paradise:1 cross-handed:1 set:1 the:2 was:1 way:1", "Method .BagHash works on Array-2";
    my %x = "a" => 1, "b" => 2;
    isa-ok %x.BagHash, BagHash, "Method .BagHash works on Hash-1";
    is showkv(%x.BagHash), "a:1 b:2", "Method .BagHash works on Hash-2";
    isa-ok (@a, %x).BagHash, BagHash, "Method .BagHash works on List-1";
    is showkv((@a, %x).BagHash), "Now:1 Paradise:1 a:1 b:2 cross-handed:1 set:1 the:2 was:1 way:1",
       "Method .BagHash works on List-2";
}

{
    my $b1 = <a b b c c c d d d d>.BagHash;
    is $b1.total, 10, '.total gives sum of values (non-empty) 10';
    is +$b1, 10, '+$bag gives sum of values (non-empty) 10';
    is $b1.minpairs, [a=>1], '.minpairs works (non-empty) 10';
    is $b1.maxpairs, [d=>4], '.maxpairs works (non-empty) 10';
    is $b1.fmt('foo %s').split("\n").sort, ('foo a', 'foo b', 'foo c', 'foo d'),
      '.fmt(%s) works (non-empty 10)';
    is $b1.fmt('%s',',').split(',').sort, <a b c d>,
      '.fmt(%s,sep) works (non-empty 10)';
    is $b1.fmt('%s foo %s').split("\n").sort, ('a foo 1', 'b foo 2', 'c foo 3', 'd foo 4'),
      '.fmt(%s%s) works (non-empty 10)';
    is $b1.fmt('%s,%s',':').split(':').sort, <a,1 b,2 c,3 d,4>,
      '.fmt(%s%s,sep) works (non-empty 10)';

    my $b2 = <a b c c c d d d>.BagHash;
    is $b2.total, 8, '.total gives sum of values (non-empty) 8';
    is +$b2, 8, '+$bag gives sum of values (non-empty) 8';
    is $b2.minpairs.sort, [a=>1,b=>1], '.minpairs works (non-empty) 8';
    is $b2.maxpairs.sort, [c=>3,d=>3], '.maxpairs works (non-empty) 8';

    my $b3 = <a b c d>.BagHash;
    is $b3.total, 4, '.total gives sum of values (non-empty) 4';
    is +$b3, 4, '+$bag gives sum of values (non-empty) 4';
    is $b3.minpairs.sort,[a=>1,b=>1,c=>1,d=>1], '.minpairs works (non-empty) 4';
    is $b3.maxpairs.sort,[a=>1,b=>1,c=>1,d=>1], '.maxpairs works (non-empty) 4';

    my $e = ().BagHash;
    is $e.total, 0, '.total gives sum of values (empty)';
    is +$e, 0, '+$bag gives sum of values (empty)';
    is $e.minpairs, (), '.minpairs works (empty)';
    is $e.maxpairs, (), '.maxpairs works (empty)';
    is $e.fmt('foo %s'), "", '.fmt(%s) works (empty)';
    is $e.fmt('%s',','), "", '.fmt(%s,sep) works (empty)';
    is $e.fmt('%s foo %s'), "", '.fmt(%s%s) works (empty)';
    is $e.fmt('%s,%s',':'), "", '.fmt(%s%s,sep) works (empty)';
}

# https://github.com/Raku/old-issue-tracker/issues/3115
{
    my $b1 = BagHash.new( (a=>"b") );
    ok $b1.keys[0] ~~ ("a" => "b"), 'first key of BagHash is a Pair ("a" => "b")';
    my $b2 = BagHash.new( "a"=>"b" );
    ok $b2.keys[0] ~~ ("a" => "b"), 'again first key of BagHash is a Pair ("a" => "b")';
    my $b3 = BagHash.new( a=>"b" );
    ok $b3.elems == 0,
        'named argument is happily eaten by .new method';
}

{
    my $b = <a>.BagHash;
    $b<a> = 42;
    is $b<a>, 42, 'did we set an Int value';
    throws-like { $b<a> = "foo" },
      X::Str::Numeric,
      'Make sure we cannot assign Str on a key';

    $_ = 666 for $b.values;
    is $b<a>, 666, 'did we set an Int value from a .values alias';
    throws-like { $_ = "foo" for $b.values },
      X::Str::Numeric,
      'Make sure we cannot assign Str on a .values alias';

    .value = 999 for $b.pairs;
    is $b<a>, 999, 'did we set an Int value from a .pairs alias';
    throws-like { .value = "foo" for $b.pairs },
      X::Str::Numeric,
      'Make sure we cannot assign Str on a .pairs alias';

    for $b.kv -> \k, \v { v = 22 };
    is $b<a>, 22, 'did we set an Int value from a .kv alias';
    throws-like { for $b.kv -> \k, \v { v = "foo" } },
      X::Str::Numeric,
      'Make sure we cannot assign Str on a .kv alias';
}

{
    my $b = <a b b c c c d d d d>.BagHash;
    my @a1;
    for $b.values -> \v { @a1.push(v) }
    is @a1.sort, (1,2,3,4), 'did we see all values';
    my @a2;
    for $b.keys -> \v { @a2.push(v) }
    is @a2.sort, <a b c d>, 'did we see all keys';
    my %h1;
    for $b.pairs -> \p { %h1{p.key} = p.value }
    is %h1.sort, (:1a, :2b, :3c, :4d), 'did we see all the pairs';
    my %h2;
    for $b.kv -> \k, \v { %h2{k} = v }
    is %h2.sort, (:1a, :2b, :3c, :4d), 'did we see all the kv';
    my %h3;
    for $b.antipairs -> \p { %h3{p.value} = p.key }
    is %h3.sort, (:1a, :2b, :3c, :4d), 'did we see all the antipairs';
    my %h4;
    for $b.kxxv -> \k { %h4{k}++ }
    is %h4.sort, (:1a, :2b, :3c, :4d), 'did we see all the kxxv';
}

# https://github.com/Raku/old-issue-tracker/issues/5513
subtest '.hash does not cause keys to be stringified' => {
    plan 2;
    is BagHash.new($(<a b>)).hash.keys[0][0], 'a', 'BagHash.new';
    is ($(<a b>),).BagHash.hash.keys[0][0],   'a', '.BagHash';
}

{ # coverage; 2016-09-23
    my $bh = BagHash.new: <a a b>;
    is-deeply $bh.BagHash, $bh, '.BagHash returns equivalent BagHash';
    isa-ok $bh.Mix, Mix, '.Mix returns a Mix';
    is-deeply $bh.Mix, Mix.new(<a a b>), '.Mix values are correct';
}

group-of 10 => 'BagHash autovivification of non-existent keys' => {
    my BagHash  $bh1;
    is-deeply   $bh1<poinc>++,  0, 'correct return of postfix ++';
    is-deeply   $bh1<poinc>,    1, 'correct result of postfix ++';

    my BagHash  $bh2;
    is-deeply   $bh2<podec>--,  0, 'correct return of postfix --';
    # Bags don't have negatives, so 0 is the expected result:
    is-deeply   $bh2<podec>,    0, 'correct result of postfix --';

    my BagHash  $bh3;
    is-deeply ++$bh3<princ>,    1, 'correct return of prefix ++';
    is-deeply   $bh3<princ>,    1, 'correct result of prefix ++';

    my BagHash  $bh4;
    # Bags don't have negatives, so 0 is the expected result:
    is-deeply --$bh4<prdec>,    0, 'correct return of prefix --';
    is-deeply   $bh4<prdec>,    0, 'correct result of prefix --';

    my BagHash  $bh5;
    is-deeply   ($bh5<as> = 2), 2, 'correct return of assignment';
    is-deeply   $bh5<as>,       2, 'correct result of assignment';
}

{
    my $bh = <a a a>.BagHash;
    for $bh.values { $_-- }
    is-deeply $bh, <a a>.BagHash,
      'Can use $_ from .values to remove occurrences from BagHash';
    for $bh.values { $_ = 42 }
    is-deeply $bh, ('a' xx 42).BagHash,
      'Can use $_ from .values to set number occurrences in BagHash';
    for $bh.values { $_ = 0 }
    is-deeply $bh, ().BagHash,
      'Can use $_ from .values to remove items from BagHash';
}

{
    my $bh = <a a a>.BagHash;
    for $bh.kv -> \k, \v { v-- }
    is-deeply $bh, <a a>.BagHash,
      'Can use value from .kv to remove occurrences from BagHash';
    for $bh.kv -> \k, \v { v = 42 }
    is $bh, "a(42)",
      'Can use value from .kv to set number occurrences in BagHash';
    for $bh.kv -> \k, \v { v = 0 }
    is $bh, "",
      'Can use $_ from .kv to remove items from BagHash';
}

{
    my $bh = <a a a>.BagHash;
    for $bh.pairs { .value-- }
    is-deeply $bh, <a a>.BagHash,
      'Can use value from .pairs to remove occurrences from BagHash';
    for $bh.pairs { .value = 42 }
    is-deeply $bh, ('a' xx 42).BagHash,
      'Can use value from .pairs to set number occurrences in BagHash';
    for $bh.pairs { .value = 0 }
    is-deeply $bh, ().BagHash,
      'Can use $_ from .pairs to remove items from BagHash';
}

{
    throws-like { ^Inf .BagHash }, X::Cannot::Lazy, :what<BagHash>;
    throws-like { BagHash.new-from-pairs(^Inf) }, X::Cannot::Lazy, :what<BagHash>;
    throws-like { BagHash.new(^Inf) }, X::Cannot::Lazy, :what<BagHash>;

    for a=>"a", a=>Inf, a=>-Inf, a=>NaN, a=>3i -> $pair {
      my \ex := $pair.value eq 'a'
          ?? X::Str::Numeric !! X::Numeric::CannotConvert;
      throws-like { $pair.BagHash }, ex,
        "($pair.raku()).BagHash throws";
      throws-like { BagHash.new-from-pairs($pair) }, ex,
        "BagHash.new-from-pairs( ($pair.raku()) ) throws";
    }
}

# https://github.com/Raku/old-issue-tracker/issues/5892
subtest 'elements with weight zero are removed' => {
    plan 3;
    my $b = <a b b c d e f>.BagHash; $_-- for $b.values;
    is-deeply $b, ("b"=>1).BagHash, 'weight decrement';
    $b = <a b b c d e f>.BagHash; .value-- for $b.pairs;
    is-deeply $b, ("b"=>1).BagHash, 'Pair value decrement';
    $b = <a b b c d e f>.BagHash; $_= 0 for $b.values;
    is-deeply $b, ().BagHash, 'weight set to zero';
}

# https://github.com/Raku/old-issue-tracker/issues/6215
subtest "elements with negative weights are removed" => {
    plan 2;
    my $b = <a b b c d e f>.BagHash; $_ = -1 for $b.values;
    is-deeply $b, ().BagHash, 'weight < 0 removes element';
    $b = <a b b c d e f>.BagHash; .value = -1 for $b.pairs;
    is-deeply $b, ().BagHash, 'Pair value < 0 removes element';
}

# https://github.com/Raku/old-issue-tracker/issues/6598
is-deeply ('foo' => 10000000000000000000).BagHash.grab(1), ('foo',),
    'can .grab() a BagHash key with weight larger than 64 bits';

# https://github.com/Raku/old-issue-tracker/issues/6632
# https://github.com/Raku/old-issue-tracker/issues/6633
{
    my %h is BagHash = <a b b c c c d d d d>;
    is %h.elems, 4, 'did we get right number of elements';
    is %h<a>, 1, 'do we get 1 for a';
    is %h<e>, 0, 'do we get 0 value for e';
    is %h.^name, 'BagHash', 'is the %h really a BagHash';
    %h = <e e e e e f g>;
    is %h.elems, 3, 'did we get right number of elements after re-init';
    is %h<e>:delete, 5, 'did we get 5 by removing e';
    is %h.elems, 2, 'did we get right number of elements after :delete';
    lives-ok { %h<f> = 0 }, 'can delete from BagHash by assignment';
    is %h.elems, 1, 'did we get right number of elements assignment';
}

# https://github.com/rakudo/rakudo/issues/1983
{
    my %h is BagHash;
    %h<foo> = 10000000000000000000;
    is %h<foo>, 10000000000000000000, 'can successfully set >64-bit value';
}

# https://github.com/rakudo/rakudo/issues/2289
is-deeply (1,2,3).BagHash.ACCEPTS(().BagHash), False, 'can we smartmatch empty';

{
    my $bag = <a b c>.BagHash;
    is-deeply $bag.Set,     <a b c>.Set,     'coerce BagHash -> Set';
    is-deeply $bag.SetHash, <a b c>.SetHash, 'coerce BagHash -> SetHash';
    is-deeply $bag.Bag,     <a b c>.Bag,     'coerce BagHash -> Bag';
    is-deeply $bag.Mix,     <a b c>.Mix,     'coerce BagHash -> Mix';
    is-deeply $bag.MixHash, <a b c>.MixHash, 'coerce BagHash -> MixHash';
}

# https://github.com/Raku/old-issue-tracker/issues/6689
{
    my %bh is BagHash[Int] = 1,2,3;
    is-deeply %bh.keys.sort, (1,2,3), 'parameterized BagHash';
    is-deeply %bh.keyof, Int, 'did it parameterize ok';

    dies-ok { %bh<foo> = 42 }, 'adding element of wrong type fails';
    dies-ok { my %bh is BagHash[Int] = <a b c> }, 'must have Ints on creation';
}

# https://github.com/rakudo/rakudo/issues/1862
is <a b c>.BagHash.item.VAR.^name, 'Scalar', 'does .item work on BagHashes';

# vim: expandtab shiftwidth=4
