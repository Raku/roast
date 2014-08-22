use v6;
use Test;

plan 178;

sub showkv($x) {
    $x.keys.sort.map({ $^k ~ ':' ~ $x{$k} }).join(' ')
}

# L<S02/Immutable types/'the mix listop'>

{
    my $m = mix <a foo a a a a b foo>;
    isa_ok $m, Mix, '&mix produces a Mix';
    is showkv($m), 'a:5 b:1 foo:2', '...with the right elements';

    is $m.default, 0, "Defaults to 0";
    is $m<a>, 5, 'Single-key subscript (existing element)';
    isa_ok $m<a>, Int, 'Single-key subscript yields an Int';
    is $m<santa>, 0, 'Single-key subscript (nonexistent element)';
    isa_ok $m<santa>, Int, 'Single-key subscript yields an Int (nonexistent element)';
    ok $m<a>:exists, 'exists with existing element';
    nok $m<santa>:exists, 'exists with nonexistent element';

    is $m.values.elems, 3, "Values returns the correct number of values";
    is ([+] $m.values), 8, "Values returns the correct sum";
    ok ?$m, "Bool returns True if there is something in the Mix";
    nok ?Mix.new(), "Bool returns False if there is nothing in the Mix";

    my $hash;
    lives_ok { $hash = $m.hash }, ".hash doesn't die";
    isa_ok $hash, Hash, "...and it returned a Hash";
    is showkv($hash), 'a:5 b:1 foo:2', '...with the right elements';

    #?rakudo.parrot todo "?"
    #?rakudo.jvm    todo "?"
    throws_like { $m<a> = 5 },
      X::Assignment::RO,
      "Can't assign to an element (Mixs are immutable)";
    throws_like { $m<a>++ },
      X::AdHoc,
      "Can't increment an element (Mixs are immutable)";
    throws_like { $m.keys = <c d> },
      X::Assignment::RO,
      "Can't assign to .keys";
    throws_like { $m.values = 3, 4 },
      X::Assignment::RO,
      "Can't assign to .values";
    throws_like { $m<a>:delete },
      X::Immutable,
      "Can't :delete from Mix";
    throws_like { $m.delete_key("a") },
      X::Immutable,
      "Can't .delete_key from Mix";

    is ~$m<a b>, "5 1", 'Multiple-element access';
    is ~$m<a santa b easterbunny>, "5 0 1 0", 'Multiple-element access (with nonexistent elements)';

    #?niecza skip '.total NYI'
    is $m.total, 8, '.total gives sum of values';
    is +$m, 8, '+$mix gives sum of values';
}

{
    ok (mix <a b c>) ~~ (mix <a b c>), "Identical mixs smartmatch with each other";
    ok (mix <a b c c>) ~~ (mix <a b c c>), "Identical mixs smartmatch with each other";
    nok (mix <b c>) ~~ (mix <a b c>), "Subset does not smartmatch";
    nok (mix <a b c>) ~~ (mix <a b c c>), "Subset (only quantity different) does not smartmatch";
    nok (mix <a b c d>) ~~ (mix <a b c>), "Superset does not smartmatch";
    nok (mix <a b c c c>) ~~ (mix <a b c c>), "Superset (only quantity different) does not smartmatch";
    nok "a" ~~ (mix <a b c>), "Smartmatch is not element of";
    ok (mix <a b c>) ~~ Mix, "Type-checking smartmatch works";

    ok (set <a b c>) ~~ (mix <a b c>), "Set smartmatches with equivalent mix";
    nok (set <a b c>) ~~ (mix <a a a b b c>), "... but not if the Mix has greater quantities";
    nok (set <a b c>) ~~ Mix, "Type-checking smartmatch works";
}

{
    isa_ok "a".Mix, Mix, "Str.Mix makes a Mix";
    is showkv("a".Mix), 'a:1', "'a'.Mix is mix a";

    isa_ok (a => 100000).Mix, Mix, "Pair.Mix makes a Mix";
    is showkv((a => 100000).Mix), 'a:100000', "(a => 100000).Mix is mix a:100000";
    is showkv((a => 0).Mix), '', "(a => 0).Mix is the empty mix";

    isa_ok <a b c>.Mix, Mix, "<a b c>.Mix makes a Mix";
    is showkv(<a b c a>.Mix), 'a:2 b:1 c:1', "<a b c a>.Mix makes the mix a:2 b:1 c:1";
    is showkv(["a", "b", "c", "a"].Mix), 'a:2 b:1 c:1', "[a b c a].Mix makes the mix a:2 b:1 c:1";
    is showkv([a => 3, b => 0, 'c', 'a'].Mix), 'a:4 c:1', "[a => 3, b => 0, 'c', 'a'].Mix makes the mix a:4 c:1";

    isa_ok {a => 2, b => 4, c => 0}.Mix, Mix, "{a => 2, b => 4, c => 0}.Mix makes a Mix";
    is showkv({a => 2, b => 4, c => 0}.Mix), 'a:2 b:4', "{a => 2, b => 4, c => 0}.Mix makes the mix a:2 b:4";
}

{
    my $m = mix <a a b foo>;
    is $m<a>:exists, True, ':exists with existing element';
    is $m<santa>:exists, False, ':exists with nonexistent element';
    throws_like { $m<a>:delete },
      X::Immutable,
      ':delete does not work on mix';
    throws_like { $m.delete_key("a") },
      X::Immutable,
      '.delete_key does not work on mix';
}

{
    my $m = mix 'a', False, 2, 'a', False, False;
    my @ks = $m.keys;
    #?niecza 3 skip "Non-Str keys NYI"
    is @ks.grep(Int)[0], 2, 'Int keys are left as Ints';
    is @ks.grep(* eqv False).elems, 1, 'Bool keys are left as Bools';
    is @ks.grep(Str)[0], 'a', 'And Str keys are permitted in the same set';
    is $m{2, 'a', False}.join(' '), '1 2 3', 'All keys have the right values';
}

#?niecza skip "Unmatched key in Hash.LISTSTORE"
{
    throws_like 'my %h = mix <a b o p a p o o>', X::Hash::Store::OddNumber;
}
{
    my %h := mix <a b o p a p o o>;
    ok %h ~~ Mix, 'A hash to which a Mix has been bound becomes a Mix';
    is showkv(%h), 'a:2 b:1 o:3 p:2', '...with the right elements';
}

{
    my $m = mix <a b o p a p o o>;
    isa_ok $m, Mix, '&Mix.new given an array of strings produces a Mix';
    is showkv($m), 'a:2 b:1 o:3 p:2', '...with the right elements';
}

{
    my $m = mix [ foo => 10, bar => 17, baz => 42, santa => 0 ];
    isa_ok $m, Mix, '&Mix.new given an array of pairs produces a Mix';
    is +$m, 1, "... with one element";
}

{
    # {}.hash interpolates in list context
    my $m = mix { foo => 10, bar => 17, baz => 42, santa => 0 }.hash;
    isa_ok $m, Mix, '&Mix.new given a Hash produces a Mix';
    is +$m, 4, "... with four elements";
    #?niecza todo "Non-string mix elements NYI"
    #?rakudo todo "Not properly interpolating"
    is +$m.grep(Enum), 4, "... which are all Enums";
}

{
    # plain {} does not interpolate in list context
    my $m = mix { foo => 10, bar => 17, baz => 42, santa => 0 };
    isa_ok $m, Mix, '&Mix.new given a Hash produces a Mix';
    is +$m, 1, "... with one element";
}

{
    my $m = mix set <foo bar foo bar baz foo>;
    isa_ok $m, Mix, '&Mix.new given a Set produces a Mix';
    is +$m, 1, "... with one element";
}

{
    my $m = mix SetHash.new(<foo bar foo bar baz foo>);
    isa_ok $m, Mix, '&Mix.new given a SetHash produces a Mix';
    is +$m, 1, "... with one element";
}

{
    my $m = mix MixHash.new(<foo bar foo bar baz foo>);
    isa_ok $m, Mix, '&Mix.new given a MixHash produces a Mix';
    is +$m, 1, "... with one element";
}

{
    my $m = mix set <foo bar foo bar baz foo>;
    isa_ok $m, Mix, '&mix given a Set produces a Mix';
    is +$m, 1, "... with one element";
}

# L<S02/Names and Variables/'C<%x> may be bound to'>

{
    my %m := mix <a b c b>;
    isa_ok %m, Mix, 'A Mix bound to a %var is a Mix';
    is showkv(%m), 'a:1 b:2 c:1', '...with the right elements';

    is %m<b>, 2, 'Single-key subscript (existing element)';
    is %m<santa>, 0, 'Single-key subscript (nonexistent element)';

    #?rakudo.parrot todo "?"
    #?rakudo.jvm    todo "?"
    throws_like { %m<a> = 1 },
      X::Assignment::RO,
      "Can't assign to an element (Mixs are immutable)";
    #?rakudo.parrot todo "?"
    #?rakudo.jvm    todo "?"
    throws_like { %m = mix <a b> },
      X::Assignment::RO,
      "Can't assign to a %var implemented by Mix";
    throws_like { %m<a>:delete },
      X::Immutable,
      "Can't :delete from a Mix";
    throws_like { %m.delete_key("a") },
      X::Immutable,
      "Can't .delete_key from a Mix";
}

{
    my $m = { foo => 10.1, bar => 1.2, baz => 2.3}.Mix;
    is $m.total, 13.6, 'is the total calculated correctly';

    # .list is just the keys, as per TimToady: 
    # http://irclog.perlgeek.de/perl6/2012-02-07#i_5112706
    isa_ok $m.list.elems, 3, ".list returns 3 things";
    is $m.list.grep(Str).elems, 3, "... all of which are Str";

    isa_ok $m.pairs.elems, 3, ".pairs returns 3 things";
    is $m.pairs.grep(Enum).elems, 3, "... all of which are Enums";
    is $m.pairs.grep({ .key ~~ Str }).elems, 3, "... the keys of which are Strs";
    is $m.pairs.grep({ .value ~~ Real }).elems, 3, "... and the values of which are Reals";

    #?rakudo 3 skip 'No longer Iterable'
    is $m.iterator.grep(Enum).elems, 3, ".iterator yields three Enums";
    is $m.iterator.grep({ .key ~~ Str }).elems, 3, "... the keys of which are Strs";
    is $m.iterator.grep({True}).elems, 3, "... and nothing else";
}

{
    my $m = { foo => 10000000000.1, bar => 17.2, baz => 42.3 }.Mix;
    is $m.total, 10000000059.6, 'is the total calculated correctly';
    my $s;
    my $c;
    lives_ok { $s = $m.perl }, ".perl lives";
    isa_ok $s, Str, "... and produces a string";
    ok $s.chars < 1000, "... of reasonable length";
    lives_ok { $c = EVAL $s }, ".perl.EVAL lives";
    isa_ok $c, Mix, "... and produces a Mix";
    is showkv($c), showkv($m), "... and it has the correct values";
}

{
    my $m = { foo => 3.1, bar => -2.2, baz => 1 }.Mix;
    is $m.total, 1.9, 'is the total calculated correctly';
    my $s;
    lives_ok { $s = $m.Str }, ".Str lives";
    isa_ok $s, Str, "... and produces a string";
    is $s.split(" ").sort.join(" "), "bar(-2.2) baz foo(3.1)", "... which only contains bar baz and foo with the proper counts and separated by spaces";
}

{
    my $m = { foo => 10000000000, bar => 17, baz => 42 }.Mix;
    my $s;
    lives_ok { $s = $m.gist }, ".gist lives";
    isa_ok $s, Str, "... and produces a string";
    ok $s.chars < 1000, "... of reasonable length";
    ok $s ~~ /foo/, "... which mentions foo";
    ok $s ~~ /bar/, "... which mentions bar";
    ok $s ~~ /baz/, "... which mentions baz";
}

# L<S02/Names and Variables/'C<%x> may be bound to'>

{
    my %b := mix "a", "b", "c", "b";
    isa_ok %b, Mix, 'A Mix bound to a %var is a Mix';
    is showkv(%b), 'a:1 b:2 c:1', '...with the right elements';

    is %b<b>, 2, 'Single-key subscript (existing element)';
    is %b<santa>, 0, 'Single-key subscript (nonexistent element)';
}

# L<S32::Containers/Mix/roll>

{
    my $m = Mix.new("a", "b", "b");

    my $a = $m.roll;
    ok $a eq "a" || $a eq "b", "We got one of the two choices";

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

    #?niecza skip '.total NYI'
    is $m.total, 3, '.roll should not change Mix';
}

{
    my $m = {b => 1, a => 100000000000, c => -100000000000}.Mix;

    my $a = $m.roll;
    ok $a eq "a" || $a eq "b", "We got one of the two choices (and this was pretty quick, we hope!)";

    my @a = $m.roll: 100;
    is +@a, 100, '.roll(100) returns 100 items';
    diag "Found {+@a.grep(* eq 'a')} a's"
      if !ok @a.grep(* eq 'a') > 97, '.roll(100) (1)';
    diag "Found {+@a.grep(* eq 'b')} b's"
      if !ok @a.grep(* eq 'b') < 3, '.roll(100) (2)';
    #?niecza skip '.total NYI'
    is $m.total, 1, '.roll should not change Mix';
}

# L<S32::Containers/Mix/pick>

{
    my $m = Mix.new("a", "b", "b");
    throws_like { $m.pick },
      X::AdHoc,
      '.pick does not work on Mix';
}

# L<S32::Containers/Mix/grab>

#?niecza skip '.grab NYI'
{
    my $m = mix <a b b c c c>;
    throws_like { $m.grab },
      X::Immutable,
      'cannot call .grab on a Mix';
}

# L<S32::Containers/Mix/grabpairs>

#?niecza skip '.grabpairs NYI'
{
    my $m = mix <a b b c c c>;
    throws_like { $m.grabpairs },
      X::Immutable,
      'cannot call .grabpairs on a Mix';
}

{
    my $m1 = mix ( mix <a b c> ), <c c c d d d d>;
    is +$m1, 8, "Three elements";
    is $m1<c>, 3, "One of them is 'c'";
    is $m1<d>, 4, "One of them is 'd'";
    my $inner-mix = $m1.list.first(Mix);
    #?niecza 2 todo 'Mix in Mix does not work correctly yet'
    isa_ok $inner-mix, Mix, "One of the mix's elements is indeed a mix!";
    is showkv($inner-mix), "a:1 b:1 c:1", "With the proper elements";

    my $m = mix <a b c>;
    $m1 = mix $m, <c d>;
    is +$m1, 3, "Three elements";
    is $m1<c>, 1, "One of them is 'c'";
    is $m1<d>, 1, "One of them is 'd'";
    $inner-mix = $m1.list.first(Mix);
    #?niecza 2 todo 'Mix in Mix does not work correctly yet'
    isa_ok $inner-mix, Mix, "One of the mix's elements is indeed a mix!";
    is showkv($inner-mix), "a:1 b:1 c:1", "With the proper elements";
}

{
    isa_ok 42.Mix, Mix, "Method .Mix works on Int-1";
    is showkv(42.Mix), "42:1", "Method .Mix works on Int-2";
    isa_ok "blue".Mix, Mix, "Method .Mix works on Str-1";
    is showkv("blue".Mix), "blue:1", "Method .Mix works on Str-2";
    my @a = <Now the cross-handed set was the Paradise way>;
    isa_ok @a.Mix, Mix, "Method .Mix works on Array-1";
    is showkv(@a.Mix), "Now:1 Paradise:1 cross-handed:1 set:1 the:2 was:1 way:1", "Method .Mix works on Array-2";
    my %x = "a" => 1, "b" => 2;
    isa_ok %x.Mix, Mix, "Method .Mix works on Hash-1";
    is showkv(%x.Mix), "a:1 b:2", "Method .Mix works on Hash-2";
    isa_ok (@a, %x).Mix, Mix, "Method .Mix works on Parcel-1";
    is showkv((@a, %x).Mix), "Now:1 Paradise:1 a:1 b:2 cross-handed:1 set:1 the:2 was:1 way:1",
       "Method .Mix works on Parcel-2";
}

#?niecza skip '.total/.minpairs/.maxpairs/.fmt NYI'
{
    my $m1 = (a => 1.1, b => 2.2, c => 3.3, d => 4.4).Mix;
    is $m1.total, 11, '.total gives sum of values (non-empty) 11';
    is +$m1, 11, '+$set gives sum of values (non-empty) 11';
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

    my $m2 = (a => 1.1, b => 1.1, c => 3.3, d => 3.3).Mix;
    is $m2.total, 8.8, '.total gives sum of values (non-empty) 8.8';
    is +$m2, 8.8, '+$set gives sum of values (non-empty) 8.8';
    is $m2.minpairs.sort, [a=>1.1,b=>1.1], '.minpairs works (non-empty) 8.8';
    is $m2.maxpairs.sort, [c=>3.3,d=>3.3], '.maxpairs works (non-empty) 8.8';

    my $m3 = (a => 1.1, b => 1.1, c => 1.1, d => 1.1).Mix;
    is $m3.total, 4.4, '.total gives sum of values (non-empty) 4.4';
    is +$m3, 4.4, '+$set gives sum of values (non-empty) 4.4';
    is $m3.minpairs.sort,[a=>1.1,b=>1.1,c=>1.1,d=>1.1], '.minpairs works (non-empty) 4.4';
    is $m3.maxpairs.sort,[a=>1.1,b=>1.1,c=>1.1,d=>1.1], '.maxpairs works (non-empty) 4.4';

    my $e = ().Mix;
    is $e.total, 0, '.total gives sum of values (empty)';
    is +$e, 0, '+$mix gives sum of values (empty)';
    is $e.minpairs, (), '.minpairs works (empty)';
    is $e.maxpairs, (), '.maxpairs works (empty)';
    is $e.fmt('foo %s'), "", '.fmt(%s) works (empty)';
    is $e.fmt('%s',','), "", '.fmt(%s,sep) works (empty)';
    is $e.fmt('%s foo %s'), "", '.fmt(%s%s) works (empty)';
    is $e.fmt('%s,%s',':'), "", '.fmt(%s%s,sep) works (empty)';
}

{
    my $m = <a b c>.Mix;
    #?rakudo.parrot todo "?"
    #?rakudo.jvm    todo "?"
    throws_like { $m.pairs[0].key++ },
      X::Assignment::RO,
      'Cannot change key of Mix.pairs';
    throws_like { $m.pairs[0].value++ },
      X::AdHoc,
      'Cannot change value of Mix.pairs';
}

# vim: ft=perl6
