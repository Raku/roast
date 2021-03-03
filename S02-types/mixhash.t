use v6;
use Test;
use lib $?FILE.IO.parent(2).add("packages/Test-Helpers");
use Test::Util;

plan 286;

# L<S02/Mutable types/QuantHash of UInt>

# A MixHash is a QuantHash of UInt, i.e. the values are positive Int

sub showkv($x) {
    $x.keys.sort.map({"$_:{$x{$_}}"}).join(' ')
}

# L<S02/Immutable types/'the mix listop'>

{
    say "We do get here, right?";
    my $m = MixHash.new("a", "foo", "a", "a", "a", "a", "b", "foo");
    isa-ok $m, MixHash, 'we got a MixHash';
    is showkv($m), 'a:5 b:1 foo:2', '...with the right elements';

    is $m.default, 0, "Defaults to 0";
    is $m<a>, 5, 'Single-key subscript (existing element)';
    isa-ok $m<a>, Int, 'Single-key subscript yields an Int';
    is $m<santa>, 0, 'Single-key subscript (nonexistent element)';
    isa-ok $m<santa>, Int, 'Single-key subscript yields an Int (nonexistent element)';
    ok $m<a>:exists, 'exists with existing element';
    nok $m<santa>:exists, 'exists with nonexistent element';

    is $m.values.elems, 3, "Values returns the correct number of values";
    is ([+] $m.values), 8, "Values returns the correct sum";
    ok ?$m, "Bool returns True if there is something in the MixHash";
    nok ?MixHash.new(), "Bool returns False if there is nothing in the MixHash";

    my $hash;
    lives-ok { $hash = $m.hash }, ".hash doesn't die";
    isa-ok $hash, Hash, "...and it returned a Hash";
    is showkv($hash), 'a:5 b:1 foo:2', '...with the right elements';

    throws-like { $m.keys = <c d> },
      X::Assignment::RO,
      "Can't assign to .keys";
    throws-like { $m.values = 3, 4 },
      X::Assignment::RO,
      "Can't assign to .values";

    is ~$m<a b>, "5 1", 'Multiple-element access';
    is ~$m<a santa b easterbunny>, "5 0 1 0", 'Multiple-element access (with nonexistent elements)';

    is $m.total, 8, '.total gives sum of values';
    is $m.elems, 3, '.total gives sum of values';
    is +$m, 8, '+$mix gives sum of values';

    lives-ok { $m<a> = 42 }, "Can assign to an existing element";
    is $m<a>, 42, "... and assignment takes effect";
    lives-ok { $m<brady> = 12 }, "Can assign to a new element";
    is $m<brady>, 12, "... and assignment takes effect";
    lives-ok { $m<spiderman> = 0 }, "Can assign zero to a nonexistent element";
    nok $m<spiderman>:exists, "... and that didn't create the element";
    lives-ok { $m<brady> = 0 }, "Can assign zero to a existing element";
    nok $m<brady>:exists, "... and it goes away";

    lives-ok { $m<a>++ }, "Can ++ an existing element";
    is $m<a>, 43, "... and the increment happens";
    lives-ok { $m<carter>++ }, "Can ++ a new element";
    is $m<carter>, 1, "... and the element is created";
    lives-ok { $m<a>-- }, "Can -- an existing element";
    is $m<a>, 42, "... and the decrement happens";
    lives-ok { $m<carter>-- }, "Can -- an element with value 1";
    nok $m<carter>:exists, "... and it goes away";
    lives-ok { $m<farve>-- }, "Can -- an element that doesn't exist";
    ok $m<farve>:exists, "... and everything is still okay";
}

{
    ok (MixHash.new: <a b c>) ~~ (MixHash.new: <a b c>), "Identical mixs smartmatch with each other";
    ok (MixHash.new: <a b c c>) ~~ (MixHash.new: <a b c c>), "Identical mixs smartmatch with each other";
    nok (MixHash.new: <b c>) ~~ (MixHash.new: <a b c>), "Subset does not smartmatch";
    nok (MixHash.new: <a b c>) ~~ (MixHash.new: <a b c c>), "Subset (only quantity different) does not smartmatch";
    nok (MixHash.new: <a b c d>) ~~ (MixHash.new: <a b c>), "Superset does not smartmatch";
    nok (MixHash.new: <a b c c c>) ~~ (MixHash.new: <a b c c>), "Superset (only quantity different) does not smartmatch";
    nok "a" ~~ (MixHash.new: <a b c>), "Smartmatch is not element of";
    ok (MixHash.new: <a b c>) ~~ MixHash, "Type-checking smartmatch works";

    ok (set <a b c>) ~~ (MixHash.new: <a b c>), "Set smartmatches with equivalent MixHash.new:";
    nok (set <a a a b c>) ~~ (MixHash.new: <a a a b c>), "... but not if the Mix has greater quantities";
    nok (set <a b c>) ~~ MixHash, "Type-checking smartmatch works";
}

{
    isa-ok "a".MixHash, MixHash, "Str.MixHash makes a MixHash";
    is showkv("a".MixHash), 'a:1', "'a'.MixHash is mix a";

    isa-ok (a => 100000).MixHash, MixHash, "Pair.MixHash makes a MixHash";
    is showkv((a => 100000).MixHash), 'a:100000', "(a => 100000).MixHash is mix a:100000";
    is showkv((a => 0).MixHash), '', "(a => 0).MixHash is the empty mix";

    isa-ok <a b c>.MixHash, MixHash, "<a b c>.MixHash makes a MixHash";
    is showkv(<a b c a>.MixHash), 'a:2 b:1 c:1', "<a b c a>.MixHash makes the mix a:2 b:1 c:1";
    is showkv(["a", "b", "c", "a"].MixHash), 'a:2 b:1 c:1', "[a b c a].MixHash makes the mix a:2 b:1 c:1";
    is showkv([a => 3, b => 0, 'c', 'a'].MixHash), 'a:4 c:1', "[a => 3, b => 0, 'c', 'a'].MixHash makes the mix a:4 c:1";

    isa-ok {a => 2, b => 4, c => 0}.MixHash, MixHash, "{a => 2, b => 4, c => 0}.MixHash makes a MixHash";
    is showkv({a => 2, b => 4, c => 0}.MixHash), 'a:2 b:4', "{a => 2, b => 4, c => 0}.MixHash makes the mix a:2 b:4";
}

{
    my $m = MixHash.new(<a a b foo>);
    is $m<a>:exists, True, ':exists with existing element';
    is $m<santa>:exists, False, ':exists with nonexistent element';
    is $m<a>:delete, 2, ':delete works on MixHash';
    is showkv($m), 'b:1 foo:1', '...and actually deletes';
}

{
    my $m = MixHash.new('a', False, 2, 'a', False, False);
    my @ks = $m.keys;
    is @ks.grep({ .WHAT === Int })[0], 2, 'Int keys are left as Ints';
    is @ks.grep(* eqv False).elems, 1, 'Bool keys are left as Bools';
    is @ks.grep(Str)[0], 'a', 'And Str keys are permitted in the same set';
    is $m{2, 'a', False}.join(' '), '1 2 3', 'All keys have the right values';
}

{
    my $a = (1,2,3,2,2,2,2).MixHash;
    is $a.kv.sort, (1,1,1,2,3,5), "MixHash.kv returns list of keys and values";
}

{
    my $m = MixHash.new(<a b o p a p o o>);
    isa-ok $m, MixHash, '&MixHash.new given an array of strings produces a MixHash';
    is showkv($m), 'a:2 b:1 o:3 p:2', '...with the right elements';
}

{
    my $m = MixHash.new([ foo => 10.1, bar => 17.2, baz => 42.3, santa => 0 ]);
    isa-ok $m, MixHash, '&MixHash.new given an array of pairs produces a MixHash';
    is $m.total, 4, 'make sure .total is ok';
    is $m.elems, 4, 'make sure .elems is ok';
}

{
    my $m = MixHash.new({ foo => 10, bar => 17, baz => 42, santa => 0 }.hash);
    isa-ok $m, MixHash, '&MixHash.new given a Hash produces a MixHash';
    is +$m, 4, "... with four elements";
    is +$m.grep(Pair), 4, "... which are all Pairs";
}

{
    my $m = MixHash.new({ foo => 10, bar => 17, baz => 42, santa => 0 });
    isa-ok $m, MixHash, '&MixHash.new given a Hash produces a MixHash';
    is +$m, 4, "... with four elements";
}

{
    my $m = MixHash.new(set <foo bar foo bar baz foo>);
    isa-ok $m, MixHash, '&MixHash.new given a Set produces a MixHash';
    is +$m, 1, "... with one element";
}

{
    my $m = MixHash.new(MixHash.new(<foo bar foo bar baz foo>));
    isa-ok $m, MixHash, '&MixHash.new given a MixHash produces a MixHash';
    is +$m, 1, "... with one element";
}

{
    my $m = MixHash.new(mix <foo bar foo bar baz foo>);
    isa-ok $m, MixHash, '&MixHash.new given a Mix produces a MixHash';
    is +$m, 1, "... with one element";
}

# Not sure how one should do this with the new MixHash constructor
# {
#     my $m = MixHash.new(set <foo bar foo bar baz foo>);
#     $m<bar> += 2;
#     my $c = MixHash.new($m);
#     isa-ok $c, MixHash, '&MixHash.new given a MixHash produces a MixHash';
#     is showkv($c), 'bar:3 baz:1 foo:1', '... with the right elements';
#     $c<manning> = 10;
#     is showkv($c), 'bar:3 baz:1 foo:1 manning:10', 'Creating a new element works';
#     is showkv($m), 'bar:3 baz:1 foo:1', '... and does not affect the original MixHash';
# }

{
    my $m = { foo => 10.1, bar => 1.2, baz => 2.3}.MixHash;
    is $m.total, 13.6, 'make sure .total is ok';
    is $m.elems, 3, 'make sure .elems is ok';

    # .list is just the keys, as per TimToady:
    # http://irclog.perlgeek.de/perl6/2012-02-07#i_5112706
    is $m.list.elems, 3, ".list returns 3 things";
    is $m.list.grep(Pair).elems, 3, "... all of which are Pairs";

    is $m.pairs.elems, 3, ".pairs returns 3 things";
    is $m.pairs.grep(Pair).elems, 3, "... all of which are Pairs";
    is $m.pairs.grep({ .key ~~ Str }).elems, 3, "... the keys of which are Strs";
    is $m.pairs.grep({ .value ~~ Real }).elems, 3, "... and the values of which are Ints";
}

{
    my $m = { foo => 10000000000, bar => 17, baz => 42 }.MixHash;
    my $s;
    my $c;
    lives-ok { $s = $m.raku }, ".raku lives";
    isa-ok $s, Str, "... and produces a string";
    ok $s.chars < 1000, "... of reasonable length";
    lives-ok { $c = EVAL $s }, ".raku.EVAL lives";
    isa-ok $c, MixHash, "... and produces a MixHash";
    is showkv($c), showkv($m), "... and it has the correct values";
}

{
    my $m = { foo => 2, bar => 3, baz => 1 }.MixHash;
    my $s;
    lives-ok { $s = $m.Str }, ".Str lives";
    isa-ok $s, Str, "... and produces a string";
    is $s.split(" ").sort.join(" "), "bar(3) baz foo(2)", "... which only contains bar baz and foo with the proper counts and separated by spaces";
}

{
    my $m = { foo => 10000000000, bar => 17, baz => 42 }.MixHash;
    my $s;
    lives-ok { $s = $m.gist }, ".gist lives";
    isa-ok $s, Str, "... and produces a string";
    ok $s.chars < 1000, "... of reasonable length";
    ok $s ~~ /foo/, "... which mentions foo";
    ok $s ~~ /bar/, "... which mentions bar";
    ok $s ~~ /baz/, "... which mentions baz";
}

# L<S02/Names and Variables/'C<%x> may be bound to'>

{
    my %b := MixHash.new("a", "b", "c", "b");
    isa-ok %b, MixHash, 'A MixHash bound to a %var is a MixHash';
    is showkv(%b), 'a:1 b:2 c:1', '...with the right elements';

    is %b<b>, 2, 'Single-key subscript (existing element)';
    is %b<santa>, 0, 'Single-key subscript (nonexistent element)';

    lives-ok { %b<a> = 4 }, "Assign to an element";
    is %b<a>, 4, "... and gets the correct value";
}

# L<S32::Containers/MixHash/roll>

{
    my $m = MixHash.new("a", "b", "b");

    my $a = $m.roll;
    ok $a eq "a" || $a eq "b", "We got one of the two choices";

    isa-ok $m.roll, Str, ".roll with no arguments returns a key of the MixHash";
    ok $m.roll(0) ~~ Iterable, ".roll(0) gives you an Iterable";
    ok $m.roll(1) ~~ Iterable, ".roll(1) gives you an Iterable";
    ok $m.roll(2) ~~ Iterable, ".roll(2) gives you an Iterable";
    is +$m.roll(0), 0, ".roll(0) returns 0 results";
    is +$m.roll(1), 1, ".roll(1) returns 1 result";

    my @a = $m.roll(2);
    is +@a, 2, '.roll(2) returns the right number of items';
    is @a.grep(* eq 'a').elems + @a.grep(* eq 'b').elems, 2, '.roll(2) returned "a"s and "b"s';

    @a = $m.roll: 100;
    is +@a, 100, '.roll(100) returns 100 items';
    ok 2 < @a.grep(* eq 'a') < 75, '.roll(100) (1)';
    ok @a.grep(* eq 'a') + 2 < @a.grep(* eq 'b'), '.roll(100) (2)';

    @a = $m.roll(*)[^100];
    ok 2 < @a.grep(* eq 'a') < 75, '.roll(*)[^100] (1)';
    ok @a.grep(* eq 'a') + 2 < @a.grep(* eq 'b'), '.roll(*)[^100] (2)';

    is $m.total, 3, '.roll should not change MixHash';
    is $m.elems, 2, '.roll should not change MixHash';
}

{
    my $m = {a => 100000000000, b => 1, c => -100000000000}.MixHash;
    is $m.total, 1, 'make sure total is ok';
    is $m.elems, 3, '.roll should not change MixHash';

    my $a = $m.roll;
    ok $a eq "a" || $a eq "b", "We got one of the two choices (and this was pretty quick, we hope!)";

    my @a = $m.roll: 100;
    is +@a, 100, '.roll(100) returns 100 items';
    ok @a.grep(* eq 'a') > 97, '.roll(100) (1)';
    ok @a.grep(* eq 'b') < 3, '.roll(100) (2)';
    is $m.total, 1, '.roll should not change MixHash';
    is $m.elems, 3, '.roll should not change MixHash';
}

# L<S32::Containers/MixHash/grabpairs>

{
    my $m = MixHash.new("a", "b", "b");

    my $a = $m.grabpairs[0];
    isa-ok $a, Pair, 'did we get a Pair';
    ok $a.key eq "a" || $a.key eq "b", "We got one of the two choices";

    my @a = $m.grabpairs(2);
    is +@a, 1, '.grabpairs(2) returns the right number of items';
    is @a.grep( {.isa(Pair)} ).Num, 1, 'are they all Pairs';
    ok @a[0].key eq "a" || @a[0].key eq "b", "We got one of the two choices";
    is $m.total, 0, '.grabpairs *should* change MixHash';
    is $m.elems, 0, '.grabpairs *should* change MixHash';
}

{
    my $m = (a=>1.1,b=>2.2,c=>3.3,d=>4.4,e=>5.5,f=>6.6,g=>7.7,h=>8.8).MixHash;
    my @a = $m.grabpairs: *;
    is +@a, 8, '.grabpairs(*) returns the right number of items';
    is @a.grep( {.isa(Pair)} ).Num, 8, 'are they all Pairs';
    is @a.grep( {1.1 <= .value <= 8.8} ).Num, 8, 'and they all have an expected value';
    is @a.sort.map({.key}).join, "abcdefgh", 'MixHash.grabpairs(*) gets all elements';
    isnt @a.map({.key}).join, "abcdefgh", 'MixHash.grabpairs(*) returns elements in a random order';
    is $m.total, 0, '.grabpairs *should* change MixHash';
    is $m.elems, 0, '.grabpairs *should* change MixHash';
}

# https://github.com/Raku/old-issue-tracker/issues/3836
{
    my %h is MixHash = a => 1, b => 0, c => 2;
    nok %h<b>:exists, '"b", initialized to zero, does not exist';
    is +%h.keys, 2, 'Inititalization worked';
    is %h.elems, 2, '.elems works';
    isa-ok %h<nonexisting>, Int, '%h<nonexisting> is an Int';
    is %h<nonexisting>, 0, '%h<nonexisting> is 0';
}

# https://github.com/Raku/old-issue-tracker/issues/3836
{
    my %h is MixHash = a => 1, b => 0, c => 2;

    lives-ok { %h<c> = 0 }, 'can set an item to 0';
    nok %h<c>:exists, '"c", set to zero, does not exist';
    is %h.elems, 1, 'one item left';
    is %h.keys, ('a'), '... and the right one is gone';

    lives-ok { %h<c>++ }, 'can add (++) an item that was removed';
    is %h.keys.sort, <a c>, '++ on an item reinstates it';
}

# https://github.com/Raku/old-issue-tracker/issues/3836
{
    my %h is MixHash = a => 1, c => 1;

    lives-ok { %h<c>++ }, 'can "add" (++) an existing item';
    is %h<c>, 2, '++ on an existing item increments the counter';
    is %h.keys.sort, <a c>, '++ on an existing item does not add a key';

    lives-ok { %h<a>-- }, 'can remove an item with decrement (--)';
    is %h.keys, ('c'), 'decrement (--) removes items';
    nok %h<a>:exists, 'item is gone according to exists too';
    is %h<a>, 0, 'removed item is zero';

    is %h<a>--, 0, 'going negative returns 0';
    ok %h<a>:exists, 'item exists too';
    is %h.keys.sort, <a c>, 'going negative adds the item';
    is %h<a>, -1, 'item now at -1';
}

{
    my %h of MixHash;
    ok %h.of.raku eq 'MixHash', 'is the hash really a MixHash';
    #?rakudo 2 todo 'in flux'
    lives-ok { %h = mix <a b c d c b> }, 'Assigning a Mix to a MixHash';
    is %h.keys.sort.map({ $^k ~ ':' ~ %h{$k} }).join(' '),
        'a:1 b:2 c:2 d:1', '... works as expected';
}

{
    isa-ok 42.MixHash, MixHash, "Method .MixHash works on Int-1";
    is showkv(42.MixHash), "42:1", "Method .MixHash works on Int-2";
    isa-ok "blue".MixHash, MixHash, "Method .MixHash works on Str-1";
    is showkv("blue".MixHash), "blue:1", "Method .MixHash works on Str-2";
    my @a = <Now the cross-handed set was the Paradise way>;
    isa-ok @a.MixHash, MixHash, "Method .MixHash works on Array-1";
    is showkv(@a.MixHash), "Now:1 Paradise:1 cross-handed:1 set:1 the:2 was:1 way:1", "Method .MixHash works on Array-2";
    my %x = "a" => 1, "b" => 2;
    isa-ok %x.MixHash, MixHash, "Method .MixHash works on Hash-1";
    is showkv(%x.MixHash), "a:1 b:2", "Method .MixHash works on Hash-2";
    isa-ok (@a, %x).MixHash, MixHash, "Method .MixHash works on List-1";
    is showkv((@a, %x).MixHash), "Now:1 Paradise:1 a:1 b:2 cross-handed:1 set:1 the:2 was:1 way:1",
       "Method .MixHash works on List-2";
}

{
    my $m1 = (a => 1.1, b => 2.2, c => 3.3, d => 4.4).MixHash;
    is $m1.total, 11, '.total gives sum of values (non-empty) 11';
    is +$m1, 11, '+$mix gives sum of values (non-empty) 11';
    is $m1.minpairs, [a=>1.1], '.minpairs works (non-empty) 11';
    is $m1.maxpairs, [d=>4.4], '.maxpairs works (non-empty) 11';
    is $m1.fmt('foo %s').split("\n").sort, ('foo a', 'foo b', 'foo c', 'foo d'),
      '.fmt(%s) works (non-empty 11)';
    is $m1.fmt('%s',',').split(',').sort, <a b c d>,
      '.fmt(%s,sep) works (non-empty 11)';
    is $m1.fmt('%s foo %s').split("\n").sort, ('a foo 1.1', 'b foo 2.2', 'c foo 3.3', 'd foo 4.4'),
      '.fmt(%s%s) works (non-empty 11)';
    is $m1.fmt('%s,%s',':').split(':').sort, <a,1.1 b,2.2 c,3.3 d,4.4>,
      '.fmt(%s%s,sep) works (non-empty 11)';

    my $m2 = (a => 1.1, b => 1.1, c => 3.3, d => 3.3).MixHash;
    is $m2.total, 8.8, '.total gives sum of values (non-empty) 8.8';
    is +$m2, 8.8, '+$mix gives sum of values (non-empty) 8.8';
    is $m2.minpairs.sort, [a=>1.1,b=>1.1], '.minpairs works (non-empty) 8.8';
    is $m2.maxpairs.sort, [c=>3.3,d=>3.3], '.maxpairs works (non-empty) 8.8';

    my $m3 = (a => 1.1, b => 1.1, c => 1.1, d => 1.1).MixHash;
    is $m3.total, 4.4, '.total gives sum of values (non-empty) 4.4';
    is +$m3, 4.4, '+$mix gives sum of values (non-empty) 4.4';
    is $m3.minpairs.sort,[a=>1.1,b=>1.1,c=>1.1,d=>1.1], '.minpairs works (non-empty) 4.4';
    is $m3.maxpairs.sort,[a=>1.1,b=>1.1,c=>1.1,d=>1.1], '.maxpairs works (non-empty) 4.4';

    my $e = ().MixHash;
    is $e.total, 0, '.total gives sum of values (empty)';
    is +$e, 0, '+$mix gives sum of values (empty)';
    is-deeply $e.minpairs, (), '.minpairs works (empty)';
    is-deeply $e.maxpairs, (), '.maxpairs works (empty)';
    is-deeply $e.fmt('foo %s'), "", '.fmt(%s) works (empty)';
    is-deeply $e.fmt('%s',','), "", '.fmt(%s,sep) works (empty)';
    is-deeply $e.fmt('%s foo %s'), "", '.fmt(%s%s) works (empty)';
    is-deeply $e.fmt('%s,%s',':'), "", '.fmt(%s%s,sep) works (empty)';
}

{
    my $m = <a>.MixHash;
    $m<a> = 42.1;
    is-deeply $m<a>, 42.1, 'did we set a Real value';
    throws-like { $m<a> = "foo" },
      X::Str::Numeric,
      'Make sure we cannot assign Str on a key';

    $_ = 666.1 for $m.values;
    is-deeply $m<a>, 666.1, 'did we set a Real value from a .values alias';
    throws-like { $_ = "foo" for $m.values },
      X::Str::Numeric,
      'Make sure we cannot assign Str on a .values alias';

    .value = 999.1 for $m.pairs;
    is-deeply $m<a>, 999.1, 'did we set a Real value from a .pairs alias';
    throws-like { .value = "foo" for $m.pairs },
      X::Str::Numeric,
      'Make sure we cannot assign Str on a .pairs alias';

    for $m.kv -> \k, \v { v = 22.1 };
    is-deeply $m<a>, 22.1, 'did we set a Real value from a .kv alias';
    throws-like { for $m.kv -> \k, \v { v = "foo" } },
      X::Str::Numeric,
      'Make sure we cannot assign Str on a .kv alias';
}

{
    my $m = (a=>1.1, b=>2.2, c=>3.3, d=> 4.4).MixHash;
    my @a1;
    for $m.values -> \v { @a1.push(v) }
    is @a1.sort, (1.1,2.2,3.3,4.4), 'did we see all values';
    my @a2;
    for $m.keys -> \v { @a2.push(v) }
    is @a2.sort, <a b c d>, 'did we see all keys';
    my %h1;
    for $m.pairs -> \p { %h1{p.key} = p.value }
    is %h1.sort, (a=>1.1, b=>2.2, c=>3.3, d=>4.4), 'did we see all the pairs';
    my %h2;
    for $m.kv -> \k, \v { %h2{k} = v }
    is %h2.sort, (a=>1.1, b=>2.2, c=>3.3, d=>4.4), 'did we see all the kv';
    my %h3;
    for $m.antipairs -> \p { %h3{p.value} = p.key }
    is %h3.sort, (a=>1.1, b=>2.2, c=>3.3, d=>4.4), 'did we see all the antipairs';
}

# https://github.com/Raku/old-issue-tracker/issues/5513
subtest '.hash does not cause keys to be stringified' => {
    plan 2;
    is MixHash.new($(<a b>)).hash.keys[0][0], 'a', 'MixHash.new';
    is ($(<a b>),).MixHash.hash.keys[0][0],   'a', '.MixHash';
}

{ # coverage; 2016-10-13
    my $mh = MixHash.new-from-pairs: 'sugar' => .2, 'flour' => 2.7,
        'sugar' => 1.1, 'cyanide' => 0;

    is-deeply $mh.Bag, Bag.new(<sugar flour flour>), '.Bag coercer';
    is-deeply $mh.BagHash, BagHash.new(<sugar flour flour>),
        '.BagHash coercer';

    my $code = ｢my $m = Mix.new-from-pairs('a' => -20, 'b' => 1.5);｣
        ~ ｢my $a = $m.Bag; my $b = $m.BagHash｣;
    is_run $code, { :err(''), :out(""), :0status },
        'negative MixHash weights removed from Bag coercion without warnings';
}

group-of 10 => 'MixHash autovivification of non-existent keys' => {
    my MixHash  $mh1;
    is-deeply   $mh1<poinc>++,  0, 'correct return of postfix ++';
    is-deeply   $mh1<poinc>,    1, 'correct result of postfix ++';

    my MixHash  $mh2;
    is-deeply   $mh2<podec>--,  0, 'correct return of postfix --';
    is-deeply   $mh2<podec>,   -1, 'correct result of postfix --';

    my MixHash  $mh3;
    is-deeply ++$mh3<princ>,    1, 'correct return of prefix ++';
    is-deeply   $mh3<princ>,    1, 'correct result of prefix ++';

    my MixHash  $mh4;
    is-deeply --$mh4<prdec>,   -1, 'correct return of prefix --';
    is-deeply   $mh4<prdec>,   -1, 'correct result of prefix --';

    my MixHash  $mh5;
    is-deeply   ($mh5<as> = 2), 2, 'correct return of assignment';
    is-deeply   $mh5<as>,       2, 'correct result of assignment';
}

{ # https://irclog.perlgeek.de/perl6-dev/2016-11-07#i_13528982
    my $a = (:a(-10), :b(-30)                 ).MixHash;
    my $b = (         :b(-20), :c(-10), :d(10)).MixHash;
    my $r = (:a(-10), :b(-20), :c(-10), :d(10)).MixHash;
    is-deeply $a  ∪  $b, $r, 'negative weights remain with  ∪  operator';
    is-deeply $a (|) $b, $r, 'negative weights remain with (|) operator';
}

{
    my $mh = <a a a>.MixHash;
    for $mh.values { $_-- }
    is-deeply $mh, <a a>.MixHash,
      'Can use $_ from .values to remove occurrences from MixHash';
    for $mh.values { $_ = 42 }
    is-deeply $mh, ('a' xx 42).MixHash,
      'Can use $_ from .values to set number occurrences in MixHash';
    for $mh.values { $_ = 0 }
    is-deeply $mh, ().MixHash,
      'Can use $_ from .values to remove items from MixHash';
}

{
    my $mh = <a a a>.MixHash;
    for $mh.kv -> \k, \v { v-- }
    is-deeply $mh, <a a>.MixHash,
      'Can use value from .kv to remove occurrences from MixHash';
    for $mh.kv -> \k, \v { v = 42 }
    is-deeply $mh, ('a' xx 42).MixHash,
      'Can use value from .kv to set number occurrences in MixHash';
    for $mh.kv -> \k, \v { v = 0 }
    is-deeply $mh, ().MixHash,
      'Can use $_ from .kv to remove items from MixHash';
}

{
    my $mh = <a a a>.MixHash;
    for $mh.pairs { .value-- }
    is-deeply $mh, <a a>.MixHash,
      'Can use value from .pairs to remove occurrences from MixHash';
    for $mh.pairs { .value = 42 }
    is-deeply $mh, ('a' xx 42).MixHash,
      'Can use value from .pairs to set number occurrences in MixHash';
    for $mh.pairs { .value = 0 }
    is-deeply $mh, ().MixHash,
      'Can use $_ from .pairs to remove items from MixHash';
}

{
    throws-like { ^Inf .MixHash }, X::Cannot::Lazy, :what<MixHash>;
    throws-like { MixHash.new-from-pairs(^Inf) }, X::Cannot::Lazy, :what<MixHash>;
    throws-like { MixHash.new(^Inf) }, X::Cannot::Lazy, :what<MixHash>;

    for a=>"a", a=>Inf, a=>-Inf, a=>NaN, a=>3i -> $pair {
      my \ex := $pair.value ~~ Complex
          ?? X::Numeric::Real !! $pair.value eq 'a'
          ?? X::Str::Numeric  !! X::OutOfRange;
      throws-like { $pair.MixHash }, ex,
        "($pair.raku()).MixHash throws";
      throws-like { MixHash.new-from-pairs($pair) }, ex,
        "MixHash.new-from-pairs( ($pair.raku()) ) throws";
    }
}

{
    my $m = MixHash[Str].new( <a b c> );
    is-deeply $m.keys.sort.List, <a b c>, 'can we parameterize for strings?';
    ok MixHash[Str].keyof =:= Str, 'does .keyof return the correct type';
    throws-like { $m{42} = 1 }, X::TypeCheck::Binding,
      'does attempt to add item of wrong type croak';
    throws-like { MixHash[Int].new( <a b c> ) }, X::TypeCheck::Binding,
      'do wrong values make initialization croak';
}

# https://github.com/Raku/old-issue-tracker/issues/6343
{
    is-deeply (a => -1, a => 1).MixHash,      MixHash.new,
      'final value 0 disappears in MixHash (1)';
    is-deeply (a => -1, a => 1, "b").MixHash, MixHash.new("b"),
      'final value 0 disappears in MixHash (2)';
}

# https://github.com/Raku/old-issue-tracker/issues/5892
subtest 'elements with weight zero are removed' => {
    plan 3;
    my $b = <a b b c d e f>.MixHash; $_-- for $b.values;
    is-deeply $b, ("b"=>1).MixHash, 'weight decrement';
    $b = <a b b c d e f>.MixHash; .value-- for $b.pairs;
    is-deeply $b, ("b"=>1).MixHash, 'Pair value decrement';
    $b = <a b b c d e f>.MixHash; $_= 0 for $b.values;
    is-deeply $b, ().MixHash, 'weight set to zero';
}

# https://github.com/Raku/old-issue-tracker/issues/6215
# https://github.com/Raku/old-issue-tracker/issues/5892
subtest "elements with negative weights are allowed in MixHashes" => {
    plan 2;
    my $b = <a b b c>.MixHash; $_ = -1 for $b.values;
    is-deeply $b, ("b"=>-1,"a"=>-1,"c"=>-1).MixHash, 'negative weights are ok';
    $b = <a b b c>.MixHash; .value = -1.5 for $b.pairs;
    is-deeply $b, ("b"=>-1.5,"a"=>-1.5,"c"=>-1.5).MixHash, 'negative Pair values are ok';
}

# https://github.com/Raku/old-issue-tracker/issues/6632
# https://github.com/Raku/old-issue-tracker/issues/6633
{
    my %h is MixHash = <a b b c c c d d d d>;
    is %h.elems, 4, 'did we get right number of elements';
    is %h<a>, 1, 'do we get 1 for a';
    is %h<e>, 0, 'do we get 0 value for e';
    is %h.^name, 'MixHash', 'is the %h really a BagHash';
    %h = <e e e e e f g>;
    is %h.elems, 3, 'did we get right number of elements after re-init';
    is %h<e>:delete, 5, 'did we get 5 by removing e';
    is %h.elems, 2, 'did we get right number of elements after :delete';
    lives-ok { %h<f> = 0 }, 'can delete from MixHash by assignment';
    is %h.elems, 1, 'did we get right number of elements assignment';
}

# R#2289
is-deeply (1,2,3).MixHash.ACCEPTS(().MixHash), False, 'can we smartmatch empty';

{
    my $mix = <a b c>.MixHash;
    is-deeply $mix.Set,     <a b c>.Set,     'coerce MixHash -> Set';
    is-deeply $mix.SetHash, <a b c>.SetHash, 'coerce MixHash -> SetHash';
    is-deeply $mix.Bag,     <a b c>.Bag,     'coerce MixHash -> Bag';
    is-deeply $mix.BagHash, <a b c>.BagHash, 'coerce MixHash -> BagHash';
    is-deeply $mix.Mix,     <a b c>.Mix,     'coerce MixHash -> Mix';
}

# https://github.com/Raku/old-issue-tracker/issues/6689
{
    my %mh is MixHash[Int] = 1,2,3;
    is-deeply %mh.keys.sort, (1,2,3), 'parameterized MixHash';
    is-deeply %mh.keyof, Int, 'did it parameterize ok';

    dies-ok { %mh<foo> = 42e0 }, 'adding element of wrong type fails';
    dies-ok { my %mh is MixHash[Int] = <a b c> }, 'must have Ints on creation';
}

# https://github.com/rakudo/rakudo/issues/1862
is <a b c>.MixHash.item.VAR.^name, 'Scalar', 'does .item work on MixHashes';

{
    is-deeply MixHash.of, Real, 'does MixHash type object return proper type';
    is-deeply MixHash.new.of, Real, 'does MixHash object return proper type';
}

# vim: expandtab shiftwidth=4
