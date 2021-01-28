use v6;
use Test;

plan 246;

sub showkv($x) {
    $x.keys.sort.map({ $^k ~ ':' ~ $x{$k} }).join(' ')
}

# L<S02/Immutable types/'the bag listop'>

{
    my $b = bag <a foo a a a a b foo>;
    isa-ok $b, Bag, '&bag produces a Bag';
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
    ok ?$b, "Bool returns True if there is something in the Bag";
    nok ?Bag.new(), "Bool returns False if there is nothing in the Bag";

    my $hash;
    lives-ok { $hash = $b.hash },
      ".hash doesn't die";
    isa-ok $hash, Hash, "...and it returned a Hash";
    is showkv($hash), 'a:5 b:1 foo:2', '...with the right elements';

    throws-like { $b<a> = 5 },
      X::Assignment::RO,
      "Can't assign to an element (Bags are immutable)";
    throws-like { $b<a>++ },
      Exception, # no exception type yet
      "Can't increment an element (Bags are immutable)";
    throws-like { $b.keys = <c d> },
      X::Assignment::RO,
      "Can't assign to .keys";
    throws-like { $b.values = 3, 4 },
      X::Assignment::RO,
      "Can't assign to .values";
    throws-like { $b<a>:delete },
      X::Immutable,
      "Can't :delete from Bag";

    is ~$b<a b>, "5 1", 'Multiple-element access';
    is ~$b<a santa b easterbunny>, "5 0 1 0", 'Multiple-element access (with nonexistent elements)';
}

{
    ok (bag <a b c>) ~~ (bag <a b c>), "Identical bags smartmatch with each other";
    ok (bag <a b c c>) ~~ (bag <a b c c>), "Identical bags smartmatch with each other";
    nok (bag <b c>) ~~ (bag <a b c>), "Subset does not smartmatch";
    nok (bag <a b c>) ~~ (bag <a b c c>), "Subset (only quantity different) does not smartmatch";
    nok (bag <a b c d>) ~~ (bag <a b c>), "Superset does not smartmatch";
    nok (bag <a b c c c>) ~~ (bag <a b c c>), "Superset (only quantity different) does not smartmatch";
    nok "a" ~~ (bag <a b c>), "Smartmatch is not element of";
    ok (bag <a b c>) ~~ Bag, "Type-checking smartmatch works";

    ok (set <a b c>) ~~ (bag <a b c>), "Set smartmatches with equivalent bag";
    nok (set <a b c>) ~~ (bag <a a a b c>), "... but not if the Bag has greater quantities";
    nok (set <a b c>) ~~ Bag, "Type-checking smartmatch works";
}

{
    isa-ok "a".Bag, Bag, "Str.Bag makes a Bag";
    is showkv("a".Bag), 'a:1', "'a'.Bag is bag a";

    isa-ok (a => 100000).Bag, Bag, "Pair.Bag makes a Bag";
    is showkv((a => 100000).Bag), 'a:100000', "(a => 100000).Bag is bag a:100000";
    is showkv((a => 0).Bag), '', "(a => 0).Bag is the empty bag";

    isa-ok <a b c>.Bag, Bag, "<a b c>.Bag makes a Bag";
    is showkv(<a b c a>.Bag), 'a:2 b:1 c:1', "<a b c a>.Bag makes the bag a:2 b:1 c:1";
    is showkv(["a", "b", "c", "a"].Bag), 'a:2 b:1 c:1', "[a b c a].Bag makes the bag a:2 b:1 c:1";
    is showkv([a => 3, b => 0, 'c', 'a'].Bag), 'a:4 c:1', "[a => 3, b => 0, 'c', 'a'].Bag makes the bag a:4 c:1";

    isa-ok {a => 2, b => 4, c => 0}.Bag, Bag, "{a => 2, b => 4, c => 0}.Bag makes a Bag";
    is showkv({a => 2, b => 4, c => 0}.Bag), 'a:2 b:4', "{a => 2, b => 4, c => 0}.Bag makes the bag a:2 b:4";
}

{
    my $b = bag <a a b foo>;
    is $b<a>:exists, True, ':exists with existing element';
    is $b<santa>:exists, False, ':exists with nonexistent element';
    throws-like { $b<a>:delete },
      X::Immutable,
      ':delete does not work on bag';
}

{
    my $b = bag 'a', False, 2, 'a', False, False;
    my @ks = $b.keys;
    is @ks.grep({ .WHAT === Int })[0], 2, 'Int keys are left as Ints';
    is @ks.grep(* eqv False).elems, 1, 'Bool keys are left as Bools';
    is @ks.grep(Str)[0], 'a', 'And Str keys are permitted in the same set';
    is $b{2, 'a', False}.join(' '), '1 2 3', 'All keys have the right values';
}

{
    my %s = bag <a b o p a p o o>;
    is-deeply %s, { :2a, :1b, :3o, :2p }, 'single arg rule rules';
    my %m = bag <a b o p>,< a p o o>;
    is-deeply %m, { :2a, :1b, :3o, :2p }, 'flattening rules';
}
{
    my %h := bag <a b o p a p o o>;
    ok %h ~~ Bag, 'A hash to which a Bag has been bound becomes a Bag';
    is showkv(%h), 'a:2 b:1 o:3 p:2', '...with the right elements';
}

{
    my $b = bag <a b o p a p o o>;
    isa-ok $b, Bag, '&Bag.new given an array of strings produces a Bag';
    is showkv($b), 'a:2 b:1 o:3 p:2', '...with the right elements';
}

{
    my $b = bag [ foo => 10, bar => 17, baz => 42, santa => 0 ];
    isa-ok $b, Bag, '&Bag.new given an array of pairs produces a Bag';
    is +$b, 4, "... with four elements under the single arg rule";
}

{
    my $b = bag $[ foo => 10, bar => 17, baz => 42, santa => 0 ];
    isa-ok $b, Bag, '&Bag.new given an itemized array of pairs produces a Bag';
    is +$b, 1, "... with one element";
}

{
    # {}.hash interpolates in list context
    my $b = bag { foo => 10, bar => 17, baz => 42, santa => 0 }.hash;
    isa-ok $b, Bag, '&Bag.new given a Hash produces a Bag';
    is +$b, 4, "... with four elements";
    is +$b.grep(Pair), 4, "... which are all Pairs";
}

{
    my $b = bag { foo => 10, bar => 17, baz => 42, santa => 0 };
    isa-ok $b, Bag, '&Bag.new given a Hash produces a Bag';
    is +$b, 4, "... with one element";
}
{
    my $b = bag ${ foo => 10, bar => 17, baz => 42, santa => 0 };
    isa-ok $b, Bag, '&Bag.new given an itemized Hash produces a Bag';
    is +$b, 1, "... with one element";
}

{
    my $b = bag set <foo bar foo bar baz foo>;
    isa-ok $b, Bag, '&Bag.new given a Set produces a Bag';
    is +$b, 1, "... with one element";
}

{
    my $b = bag SetHash.new(<foo bar foo bar baz foo>);
    isa-ok $b, Bag, '&Bag.new given a SetHash produces a Bag';
    is +$b, 1, "... with one element";
}

{
    my $b = bag BagHash.new(<foo bar foo bar baz foo>);
    isa-ok $b, Bag, '&Bag.new given a BagHash produces a Bag';
    is +$b, 1, "... with one element";
}

{
    my $b = bag set <foo bar foo bar baz foo>;
    isa-ok $b, Bag, '&bag given a Set produces a Bag';
    is +$b, 1, "... with one element";
}

# L<S02/Names and Variables/'C<%x> may be bound to'>

{
    my %b := bag <a b c b>;
    isa-ok %b, Bag, 'A Bag bound to a %var is a Bag';
    is showkv(%b), 'a:1 b:2 c:1', '...with the right elements';

    is %b<b>, 2, 'Single-key subscript (existing element)';
    is %b<santa>, 0, 'Single-key subscript (nonexistent element)';

    throws-like { %b<a> = 1 },
      X::Assignment::RO,
      "Can't assign to an element (Bags are immutable)";
    throws-like { %b = bag <a b> },
      X::Assignment::RO,
      "Can't assign to a %var implemented by Bag";
    throws-like { %b<a>:delete },
      X::Immutable,
      "Can't :delete from a Bag";
}

{
    my $b = { foo => 10, bar => 1, baz => 2}.Bag;

    # .list is just the keys, as per TimToady:
    # http://irclog.perlgeek.de/perl6/2012-02-07#i_5112706
    is $b.list.elems, 3, ".list returns 3 things";
    is $b.list.grep(Pair).elems, 3, "... all of which are Pairs";

    is $b.pairs.elems, 3, ".pairs returns 3 things";
    is $b.pairs.grep(Pair).elems, 3, "... all of which are Pairs";
    is $b.pairs.grep({ .key ~~ Str }).elems, 3, "... the keys of which are Strs";
    is $b.pairs.grep({ .value ~~ Int }).elems, 3, "... and the values of which are Ints";
}

{
    my $b = { foo => 10000000000, bar => 17, baz => 42 }.Bag;
    my $s;
    my $c;
    lives-ok { $s = $b.raku },
      ".raku lives";
    isa-ok $s, Str, "... and produces a string";
    ok $s.chars < 1000, "... of reasonable length";
    lives-ok { $c = EVAL $s },
      ".raku.EVAL lives";
    isa-ok $c, Bag, "... and produces a Bag";
    is showkv($c), showkv($b), "... and it has the correct values";
}

{
    my $b = { foo => 2, bar => 3, baz => 1 }.Bag;
    my $s;
    lives-ok { $s = $b.Str },
      ".Str lives";
    isa-ok $s, Str, "... and produces a string";
    is $s.split(" ").sort.join(" "), "bar(3) baz foo(2)", "... which only contains bar baz and foo with the proper counts and separated by spaces";
}

{
    my $b = { foo => 10000000000, bar => 17, baz => 42 }.Bag;
    my $s;
    lives-ok { $s = $b.gist },
      ".gist lives";
    isa-ok $s, Str, "... and produces a string";
    ok $s.chars < 1000, "... of reasonable length";
    ok $s ~~ /foo/, "... which mentions foo";
    ok $s ~~ /bar/, "... which mentions bar";
    ok $s ~~ /baz/, "... which mentions baz";
}

# L<S02/Names and Variables/'C<%x> may be bound to'>

{
    my %b := bag "a", "b", "c", "b";
    isa-ok %b, Bag, 'A Bag bound to a %var is a Bag';
    is showkv(%b), 'a:1 b:2 c:1', '...with the right elements';

    is %b<b>, 2, 'Single-key subscript (existing element)';
    is %b<santa>, 0, 'Single-key subscript (nonexistent element)';
}

# L<S32::Containers/Bag/roll>

{
    my $b = Bag.new("a", "b", "b");

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

    is $b.total, 3, '.roll should not change Bag';
}

{
    my $b = {"a" => 100000000000, "b" => 1}.Bag;

    my $a = $b.roll;
    ok $a eq "a" || $a eq "b", "We got one of the two choices (and this was pretty quick, we hope!)";

    my @a = $b.roll: 100;
    is +@a, 100, '.roll(100) returns 100 items';
    ok @a.grep(* eq 'a') > 97, '.roll(100) (1)';
    ok @a.grep(* eq 'b') < 3, '.roll(100) (2)';
    is $b.total, 100000000001, '.roll should not change Bag';
}

# L<S32::Containers/Bag/pick>

{
    my $b = Bag.new("a", "b", "b");

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
    is $b.total, 3, '.pick should not change Bag';

    @a = $b.pick(-2.5);
    is +@a, 0, '.pick(<negative number>) does not return any items';

    # https://github.com/rakudo/rakudo/issues/1438
	  lives-ok { $b.pick(1).gist }, ".pick() gives valid result with argument";
    # https://github.com/Raku/old-issue-tracker/issues/6228
    is +$b.pick(2.5), 2, ".pick int-ifies arg";
}

{
    my $b = {"a" => 100000000000, "b" => 1}.Bag;

    my $a = $b.pick;
    ok $a eq "a" || $a eq "b", "We got one of the two choices (and this was pretty quick, we hope!)";

    my @a = $b.pick: 100;
    is +@a, 100, '.pick(100) returns 100 items';
    ok @a.grep(* eq 'a') > 98, '.pick(100) (1)';
    ok @a.grep(* eq 'b') < 2, '.pick(100) (2)';
    is $b.total, 100000000001, '.pick should not change Bag';
}

# L<S32::Containers/Bag/pickpairs>

{
    my $b = Bag.new("a", "b", "b");

    my $a = $b.pickpairs;
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

# L<S32::Containers/Bag/grab>

{
    my $b = bag <a b b c c c>;
    throws-like { $b.grab },
      X::Immutable,
      'cannot call .grab on a Bag';
}

# L<S32::Containers/Bag/grabpairs>

{
    my $b = bag <a b b c c c>;
    throws-like { $b.grabpairs },
      X::Immutable,
      'cannot call .grabpairs on a Bag';
}

{
    my $b1 = Bag.new( (bag <a b c>) , <c c c d d d d>);
    is +$b1, 2, "Two elements";
    my $inner-bag = $b1.keys.first(Bag);
    isa-ok $inner-bag, Bag, "One of the bag's elements is indeed a Bag!";
    is showkv($inner-bag), "a:1 b:1 c:1", "With the proper elements";
    my $inner-list = $b1.keys.first(List);
    isa-ok $inner-list, List, "One of the bag's elements is indeed a List!";
    is $inner-list, <c c c d d d d>, 'with the proper elements';

    my $b = bag <a b c>;
    $b1 = Bag.new($b, <c d>);
    is +$b1, 2, "Two elements";
    $inner-bag = $b1.keys.first(Bag);
    isa-ok $inner-bag, Bag, "One of the bag's elements is indeed a bag!";
    is showkv($inner-bag), "a:1 b:1 c:1", "With the proper elements";
    $inner-list = $b1.keys.first(List);
    isa-ok $inner-list, List, "One of the bag's elements is indeed a List!";
    is $inner-list, <c d>, 'with the proper elements';
}

{
    isa-ok 42.Bag, Bag, "Method .Bag works on Int-1";
    is showkv(42.Bag), "42:1", "Method .Bag works on Int-2";
    isa-ok "blue".Bag, Bag, "Method .Bag works on Str-1";
    is showkv("blue".Bag), "blue:1", "Method .Bag works on Str-2";
    my @a = <now the cross-handed set was the paradise way>;
    isa-ok @a.Bag, Bag, "Method .Bag works on Array-1";
    is showkv(@a.Bag), "cross-handed:1 now:1 paradise:1 set:1 the:2 was:1 way:1", "Method .Bag works on Array-2";
    my %x = "a" => 1, "b" => 2;
    isa-ok %x.Bag, Bag, "Method .Bag works on Hash-1";
    is showkv(%x.Bag), "a:1 b:2", "Method .Bag works on Hash-2";
    isa-ok (@a, %x).Bag, Bag, "Method .Bag works on List-1";
    is showkv((@a, %x).Bag), "a:1 b:2 cross-handed:1 now:1 paradise:1 set:1 the:2 was:1 way:1",
       "Method .Bag works on List-2";
}

{
    my $b1 = <a b b c c c d d d d>.Bag;
    is $b1.total, 10, '.total gives sum of values (non-empty 10)';
    is +$b1, 10, '+$bag gives sum of values (non-empty 10)';
    is $b1.minpairs, [a=>1], '.minpairs works (non-empty 10)';
    is $b1.maxpairs, [d=>4], '.maxpairs works (non-empty 10)';
    # Bag is unordered according to S02:1476
    is $b1.fmt('foo %s').split("\n").sort, ('foo a', 'foo b', 'foo c', 'foo d'),
      '.fmt(%s) works (non-empty 10)';
    is $b1.fmt('%s',',').split(',').sort, <a b c d>,
      '.fmt(%s,sep) works (non-empty 10)';
    is $b1.fmt('%s foo %s').split("\n").sort, ('a foo 1', 'b foo 2', 'c foo 3', 'd foo 4'),
      '.fmt(%s%s) works (non-empty 10)';
    is $b1.fmt('%s,%s',':').split(':').sort, <a,1 b,2 c,3 d,4>,
      '.fmt(%s%s,sep) works (non-empty 10)';

    my $b2 = <a b c c c d d d>.Bag;
    is $b2.total, 8, '.total gives sum of values (non-empty 8)';
    is +$b2, 8, '+$bag gives sum of values (non-empty 8)';
    is $b2.minpairs.sort, [a=>1, b=>1], '.minpairs works (non-empty 8)';
    is $b2.maxpairs.sort, [c=>3, d=>3], '.maxpairs works (non-empty 8)';

    $b2 = <a b c d>.Bag;
    is $b2.total, 4, '.total gives sum of values (non-empty 4)';
    is +$b2, 4, '+$bag gives sum of values (non-empty 4)';
    is $b2.minpairs.sort,[a=>1,b=>1,c=>1,d=>1], '.minpairs works (non-empty 4)';
    is $b2.maxpairs.sort,[a=>1,b=>1,c=>1,d=>1], '.maxpairs works (non-empty 4)';

    my $e = ().Bag;
    is $e.total, 0, '.total gives sum of values (empty)';
    is +$e, 0, '+$bag gives sum of values (empty)';
    is $e.minpairs, (), '.minpairs works (empty)';
    is $e.maxpairs, (), '.maxpairs works (empty)';
    is $e.fmt('foo %s'), "", '.fmt(%s) works (empty)';
    is $e.fmt('%s',','), "", '.fmt(%s,sep) works (empty)';
    is $e.fmt('%s foo %s'), "", '.fmt(%s%s) works (empty)';
    is $e.fmt('%s,%s',':'), "", '.fmt(%s%s,sep) works (empty)';
}

{
    is-deeply Bag[Str].new( <a b c> ).keys.sort.List, <a b c>,
      'can we parameterize for strings?';
    ok Bag[Str].keyof =:= Str, 'does .keyof return the correct type';
    throws-like { Bag[Int].new( <a b c> ) }, X::TypeCheck::Binding,
      'do wrong values make initialization croak';
}

# https://github.com/Raku/old-issue-tracker/issues/3805
isnt
  '91D95D6EDD0F0C61D02A2989781C5AEB10832C94'.Bag.WHICH,
  <a b c>.Bag.WHICH,
  'Faulty .WHICH creation';

# https://github.com/Raku/old-issue-tracker/issues/3126
{
    my @pairings;
    my Bag $bag .= new: <foo foo bar>;
    for $bag.keys X $bag.keys -> ($a, $b) {
        @pairings.push: $a ~ $b;
    }
    @pairings .= sort;
    my $string = [~] @pairings;
    is $string, 'barbarbarfoofoobarfoofoo',
        'can use cross operator X with bag keys';
}

# https://github.com/Raku/old-issue-tracker/issues/4399
{
    my class MyBag is Bag { }
    my $b = MyBag.new(|<a foo a a a a b foo>);
    isa-ok $b, MyBag, 'MyBag.new produces a MyBag';
    is showkv($b), 'a:5 b:1 foo:2', '...with the right elements';
}

{
    my $b = <a>.Bag;
    throws-like { $b<a> = 42 },
      X::Assignment::RO,
      'Make sure we cannot assign on a key';

    throws-like { $_ = 666 for $b.values },
     Exception,   # X::Assignment::RO ???
      'Make sure we cannot assign on a .values alias';

    throws-like { .value = 999 for $b.pairs },
      X::Assignment::RO,
      'Make sure we cannot assign on a .pairs alias';

    throws-like { for $b.kv -> \k, \v { v = 22 } },
      X::Assignment::RO,
      'Make sure we cannot assign on a .kv alias';
}

{
    my $b = <a b b c c c d d d d>.Bag;
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
    plan 3;
    is Bag.new($(<a b>)).hash.keys[0][0], 'a', 'Bag.new';
    is ($(<a b>),).Bag.hash.keys[0][0],   'a', '.Bag';
    is bag($(<a b>)).hash.keys[0][0],     'a', 'bag()';
}

{
    throws-like { my Bag $b; $b<as> = 2 }, Exception,
        'autovivification of of Bag:U complains about immutability';
}

{
   is {'red' => 200000000000000000019}.Bag.<red>,
      200000000000000000019,
      'value can be larger than a native int';
}

{
    ok ().Bag  =:= bag(), '().Bag returns the empty bag';
}

{
    throws-like { ^Inf .Bag }, X::Cannot::Lazy, :what<Bag>;
    throws-like { Bag.new-from-pairs(^Inf) }, X::Cannot::Lazy, :what<Bag>;
    throws-like { Bag.new(^Inf) }, X::Cannot::Lazy, :what<Bag>;

    for a=>"a", a=>Inf, a=>-Inf, a=>NaN, a=>3i -> $pair {
      my \ex := $pair.value eq 'a'
          ?? X::Str::Numeric !! X::Numeric::CannotConvert;
      throws-like { $pair.Bag }, ex,
        "($pair.raku()).Bag throws";
      throws-like { Bag.new-from-pairs($pair) }, ex,
        "Bag.new-from-pairs( ($pair.raku()) ) throws";
    }
}

# https://github.com/Raku/old-issue-tracker/issues/6632
# https://github.com/Raku/old-issue-tracker/issues/6633
{
    my %h is Bag = <a b b c c c d d d d>;
    is %h.elems, 4, 'did we get right number of elements';
    is %h<a>, 1, 'do we get 1 for a';
    is %h<e>, 0, 'do we get 0 for e';
    is %h.^name, 'Bag', 'is the %h really a Bag';
    dies-ok { %h = <e f g> }, 'cannot re-initialize Bag';
    dies-ok { %h<a>:delete }, 'cannot :delete from Bag';
    dies-ok { %h<a> = False }, 'cannot delete from Bag by assignment';
}

# https://github.com/rakudo/rakudo/issues/2289
is-deeply (1,2,3).Bag.ACCEPTS( ().Bag ), False, 'can we smartmatch empty';

{
    my $bag = <a b c>.Bag;
    is-deeply $bag.Set,     <a b c>.Set,     'coerce Bag -> Set';
    is-deeply $bag.SetHash, <a b c>.SetHash, 'coerce Bag -> SetHash';
    is-deeply $bag.BagHash, <a b c>.BagHash, 'coerce Bag -> BagHash';
    is-deeply $bag.Mix,     <a b c>.Mix,     'coerce Bag -> Mix';
    is-deeply $bag.MixHash, <a b c>.MixHash, 'coerce Bag -> MixHash';
}

# https://github.com/Raku/old-issue-tracker/issues/6689
{
    my %b is Bag[Int] = 1,2,3;
    is-deeply %b.keys.sort, (1,2,3), 'parameterized Bag';
    is-deeply %b.keyof, Int, 'did it parameterize ok';

    dies-ok { my %b is Bag[Int] = <a b c> }, 'must have Ints on creation';
}

# https://github.com/rakudo/rakudo/issues/1862
is <a b c>.Set.item.VAR.^name, 'Scalar', 'does .item work on Sets';

# vim: expandtab shiftwidth=4
