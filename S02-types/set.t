use v6;
use Test;

plan 139;

sub showset($s) { $s.keys.sort.join(' ') }

# L<S02/Immutable types/'the set listop'>

{
    my $s = set <a b foo>;
    isa_ok $s, Set, '&set produces a Set';
    is showset($s), 'a b foo', '...with the right elements';

    is $s.default, False, "Default value is false";
    is $s<a>, True, 'Single-key subscript (existing element)';
    isa_ok $s<a>, Bool, 'Single-key subscript has correct type (existing element)';
    is $s<santa>, False, 'Single-key subscript (nonexistent element)';
    isa_ok $s<santa>, Bool, 'Single-key subscript has correct type (nonexistent element)';
    is $s.exists('a'), True, '.exists with existing element';
    is $s.exists('santa'), False, '.exists with nonexistent element';

    ok ?$s, "Bool returns True if there is something in the Set";
    nok ?Set.new(), "Bool returns False if there is nothing in the Set";

    my $hash;
    lives_ok { $hash = $s.hash }, ".hash doesn't die";
    isa_ok $hash, Hash, "...and it returned a Hash";
    is showset($hash), 'a b foo', '...with the right elements';
    is $hash.values.grep({ ($_ ~~ Bool) && $_ }).elems, 3, "...and values";

    dies_ok { $s<a> = True }, "Can't assign to an element (Sets are immutable)";
    dies_ok { $s.keys = <c d> }, "Can't assign to .keys";
    dies_ok { $s.values = <True False> }, "Can't assign to .values";
    dies_ok { $s<a>:delete }, "Can't :delete from Set";
    dies_ok { $s.delete("a") }, "Can't .delete from Set";

    is ($s<a b>).grep(?*).elems, 2, 'Multiple-element access';
    is ($s<a santa b easterbunny>).grep(?*).elems, 2, 'Multiple-element access (with nonexistent elements)';

    is $s.elems, 3, '.elems gives number of keys';
    is +$s, 3, '+$set gives number of keys';
}

{
    ok (set <a b c>) ~~ (set <a b c>), "Identical sets smartmatch with each other";
    nok (set <b c>) ~~ (set <a b c>), "Subset does not smartmatch";
    nok (set <a b c d>) ~~ (set <a b c>), "Superset does not smartmatch";
    nok "a" ~~ (set <a b c>), "Smartmatch is not element of";
    ok (set <a b c>) ~~ Set, "Type-checking smartmatch works";

    ok (bag <a b c>) ~~ (set <a b c>), "Bag smartmatches with equivalent set";
    ok (bag <a a a b c>) ~~ (set <a b c>), "... even if the Bag has greater quantities";
    nok (bag <b c>) ~~ (set <a b c>), "Subset does not smartmatch";
    nok (bag <a b c d>) ~~ (set <a b c>), "Superset does not smartmatch";
    nok (bag <a b c>) ~~ Set, "Type-checking smartmatch works";
}

{
    isa_ok "a".Set, Set, "Str.Set makes a Set";
    is showset("a".Set), 'a', "'a'.Set is set a";

    isa_ok (a => 1).Set, Set, "Pair.Set makes a Set";
    is showset((a => 1).Set), 'a', "(a => 1).Set is set a";
    is showset((a => 0).Set), '', "(a => 0).Set is the empty set";

    isa_ok <a b c>.Set, Set, "<a b c>.Set makes a Set";
    is showset(<a b c a>.Set), 'a b c', "<a b c a>.Set makes the set a b c";
    is showset(["a", "b", "c", "a"].Set), 'a b c', "[a b c a].Set makes the set a b c";
    is showset([a => 3, b => 0, 'c', 'a'].Set), 'a c', "[a => 3, b => 0, 'c', 'a'].Set makes the set a c";

    isa_ok {a => 2, b => 4, c => 0}.Set, Set, "{a => 2, b => 4, c => 0}.Set makes a Set";
    is showset({a => 2, b => 4, c => 0}.Set), 'a b', "{a => 2, b => 4, c => 0}.Set makes the set a b";
}

{
    my $s = set <a b foo>;
    is $s.exists(<a>), True, ':exists with existing element';
    is $s.exists(<santa>), False, ':exists with nonexistent element';
    dies_ok { $s<a>:delete }, ':delete does not work on set';
    dies_ok { $s.delete(<a>) }, '.delete does not work on set';
}

{
    my $s = set 2, 'a', False;
    my @ks = $s.keys;
    #?niecza 3 todo
    is @ks.grep(Int)[0], 2, 'Int keys are left as Ints';
    is @ks.grep(* eqv False).elems, 1, 'Bool keys are left as Bools';
    is @ks.grep(Str)[0], 'a', 'And Str keys are permitted in the same set';
    is +$s, 3, 'Keys are counted correctly even when a key is False';
}

# RT #77760
#?rakudo skip "Odd number of elements"
#?niecza skip "Unmatched key in Hash.LISTSTORE"
{
    my %h = set <a b o p a p o o>;
    ok %h ~~ Hash, 'A hash to which a Set has been assigned remains a hash';
    #?rakudo todo "got ao"
    is %h.keys.sort.join, 'abop', '...with the right keys';
    #?rakudo todo "got bp"
    is %h.values, (True, True, True, True), '...and values all True';
}

{
    my $s = set <foo bar foo bar baz foo>;
    is showset($s), 'bar baz foo', '&set discards duplicates';
}

{
    my $b = set [ foo => 10, bar => 17, baz => 42 ];
    isa_ok $b, Set, '&Set.new given an array of pairs produces a Set';
    is +$b, 1, "... with one element";
}

{
    # {}.hash interpolates in list context
    my $b = set { foo => 10, bar => 17, baz => 42 }.hash;
    isa_ok $b, Set, '&Set.new given a Hash produces a Set';
    #?rakudo todo "Not properly interpolating"
    is +$b, 3, "... with three elements";
    #?rakudo todo "Not properly interpolating"
    #?niecza todo "Losing type in Set"
    is +$b.grep(Pair), 3, "... all of which are Pairs";
}

{
    # plain {} does not interpolate in list context
    my $b = set { foo => 10, bar => 17, baz => 42 };
    isa_ok $b, Set, '&Set.new given a Hash produces a Set';
    is +$b, 1, "... with one element";
}

{
    my $b = set set <foo bar foo bar baz foo>;
    isa_ok $b, Set, '&Set.new given a Set produces a Set';
    is +$b, 1, "... with one element";
}

{
    my $b = set KeySet.new(<foo bar foo bar baz foo>);
    isa_ok $b, Set, '&Set.new given a KeySet produces a Set';
    is +$b, 1, "... with one element";
}

{
    my $b = set KeyBag.new(<foo bar foo bar baz foo>);
    isa_ok $b, Set, '&Set.new given a KeySet produces a Set';
    is +$b, 1, "... with one element";
}

{
    my $b = set bag <foo bar foo bar baz foo>;
    isa_ok $b, Set, '&set given a Bag produces a Set';
    is +$b, 1, "... with one element";
}

{
    my $s = set <foo bar baz>;
    isa_ok $s.list.elems, 3, ".list returns 3 things";
    is $s.list.grep(Str).elems, 3, "... all of which are Str";
    #?rakudo skip "Set is no longer Iterable"
    is $s.iterator.grep(Str).elems, 3, ".iterator yields three Strs";
}

{
    my $s = set <foo bar baz>;
    my $str;
    my $c;
    lives_ok { $str = $s.perl }, ".perl lives";
    isa_ok $str, Str, "... and produces a string";
    lives_ok { $c = eval $str }, ".perl.eval lives";
    isa_ok $c, Set, "... and produces a Set";
    is showset($c), showset($s), "... and it has the correct values";
}

{
    my $s = set <foo bar baz>;
    lives_ok { $s = $s.Str }, ".Str lives";
    isa_ok $s, Str, "... and produces a string";
    is $s.split(" ").sort.join(" "), "bar baz foo", "... which only contains bar baz and foo separated by spaces";
}

{
    my $s = set <foo bar baz>;
    lives_ok { $s = $s.gist }, ".gist lives";
    isa_ok $s, Str, "... and produces a string";
    ok $s ~~ /foo/, "... which mentions foo";
    ok $s ~~ /bar/, "... which mentions bar";
    ok $s ~~ /baz/, "... which mentions baz";
}

# L<S02/Names and Variables/'C<%x> may be bound to'>

{
    my %s := set <a b c b>;
    isa_ok %s, Set, 'A Set bound to a %var is a Set';
    is showset(%s), 'a b c', '...with the right elements';

    is %s<a>, True, 'Single-key subscript (existing element)';
    is %s<santa>, False, 'Single-key subscript (nonexistent element)';

    dies_ok { %s<a> = True }, "Can't assign to an element (Sets are immutable)";
    dies_ok { %s = a => True, b => True }, "Can't assign to a %var implemented by Set";
    dies_ok { %s<a>:delete }, "Can't :delete a key from a Set";
    dies_ok { %s.delete("a") }, "Can't .delete a key from a Set";
}

# L<S03/Hyper operators/'unordered type'>
#?niecza skip "Hypers not yet Set compatible"
#?rakudo todo "Hypers not yet Set compatible"
{
    is showset(set(1, 2, 3) »+» 6), '7 8 9', 'Set »+» Int';
    is showset("a" «~« set(<pple bbot rmadillo>)), 'abbot apple armadillo', 'Str «~« Set';
    is showset(-« set(3, 9, -4)), '-9 -3 4', '-« Set';
    is showset(set(<b e g k z>)».pred), 'a d f j y', 'Set».pred';

    dies_ok { set(1, 2) »+« set(3, 4) }, 'Set »+« Set is illegal';
    dies_ok { set(1, 2) «+» set(3, 4) }, 'Set «+» Set is illegal';
    dies_ok { set(1, 2) »+« [3, 4] }, 'Set »+« Array is illegal';
    dies_ok { set(1, 2) «+» [3, 4] }, 'Set «+» Array is illegal';
    dies_ok { [1, 2] »+« set(3, 4) }, 'Set »+« Array is illegal';
    dies_ok { [1, 2] «+» set(3, 4) }, 'Set «+» Array is illegal';
}

# L<S32::Containers/Set/roll>

{
    my $s = set <a b c>;

    my $a = $s.roll;
    ok $a eq "a" || $a eq "b" || $a eq "c", "We got one of the three choices";

    my @a = $s.roll(2);
    is +@a, 2, '.roll(2) returns the right number of items';
    is @a.grep(* eq 'a' | 'b' | 'c').elems, 2, '.roll(2) returned "a"s, "b"s, and "c"s';

    @a = $s.roll: 100;
    is +@a, 100, '.roll(100) returns 100 items';
    is @a.grep(* eq 'a' | 'b' | 'c').elems, 100, '.roll(100) returned "a"s, "b"s, and "c"s';
}

# L<S32::Containers/Set/pick>

{
    my $s = set <a b c d e f g h>;
    my @a = $s.pick: *;
    is @a.sort.join, 'abcdefgh', 'Set.pick(*) gets all elements';
    isnt @a.join, 'abcdefgh', 'Set.pick(*) returns elements in a random order';
      # There's only a 1/40_320 chance of that test failing by chance alone.
}

{
    my $s = set <a b c>;

    my $a = $s.pick;
    ok $a eq "a" || $a eq "b" || $a eq "c", "We got one of the three choices";

    my @a = $s.pick(2);
    is +@a, 2, '.pick(2) returns the right number of items';
    is @a.grep(* eq 'a' | 'b' | 'c').elems, 2, '.pick(2) returned "a"s, "b"s, and "c"s';
    ok @a.grep(* eq 'a').elems <= 1, '.pick(2) returned at most one "a"';
    ok @a.grep(* eq 'b').elems <= 1, '.pick(2) returned at most one "b"';
    ok @a.grep(* eq 'c').elems <= 1, '.pick(2) returned at most one "c"';
}

# RT 107022
{
    my $s1 = set ( set <a b c> ), <c d>;
    is +$s1, 3, "Three elements";
    ok $s1<c>, "One of them is 'c'";
    ok $s1<d>, "One of them is 'd'";
    my $inner-set = $s1.first(Set);
    #?niecza 2 todo 'Set in Set does not work correctly yet'
    isa_ok $inner-set, Set, "One of the set's elements is indeed a set!";
    #?rakudo todo "Set does not conform to new standard yet"
    is showset($inner-set), "a b c", "With the proper elements";

    my $s = set <a b c>;
    $s1 = set $s, <c d>;
    is +$s1, 3, "Three elements";
    ok $s1<c>, "One of them is 'c'";
    ok $s1<d>, "One of them is 'd'";
    $inner-set = $s1.first(Set);
    #?niecza 2 todo 'Set in Set does not work correctly yet'
    isa_ok $inner-set, Set, "One of the set's elements is indeed a set!";
    #?rakudo todo "Set does not conform to new standard yet"
    is showset($inner-set), "a b c", "With the proper elements";
}

{
    isa_ok 42.Set, Set, "Method .Set works on Int-1";
    is showset(42.Set), "42", "Method .Set works on Int-2";
    isa_ok "blue".Set, Set, "Method .Set works on Str-1";
    is showset("blue".Set), "blue", "Method .Set works on Str-2";
    my @a = <Now the cross-handed set was the Paradise way>;
    isa_ok @a.Set, Set, "Method .Set works on Array-1";
    is showset(@a.Set), "Now Paradise cross-handed set the was way", "Method .Set works on Array-2";
    my %x = "a" => 1, "b" => 2;
    isa_ok %x.Set, Set, "Method .Set works on Hash-1";
    is showset(%x.Set), "a b", "Method .Set works on Hash-2";
    isa_ok (@a, %x).Set, Set, "Method .Set works on Parcel-1";
    is showset((@a, %x).Set), "Now Paradise a b cross-handed set the was way", "Method .Set works on Parcel-2";
}

# vim: ft=perl6
