use v6;
use Test;

plan 191;

# L<S02/Mutable types/"QuantHash of Bool">

# A SetHash is a QuantHash of Bool, i.e. the values are Bool

sub showset($s) { $s.keys.sort.join(' ') }

# L<S02/Immutable types/'the set listop'>

{
    my $s = SetHash.new(<a b foo>);
    isa_ok $s, SetHash, 'SetHash.new produces a SetHash';
    is showset($s), 'a b foo', '...with the right elements';

    is $s.default, False, "Default value is false";
    is $s<a>, True, 'Single-key subscript (existing element)';
    isa_ok $s<a>, Bool, 'Single-key subscript has correct type (existing element)';
    is $s<santa>, False, 'Single-key subscript (nonexistent element)';
    isa_ok $s<santa>, Bool, 'Single-key subscript has correct type (nonexistent element)';
    is $s<a>:exists, True, 'exists with existing element';
    is $s<santa>:exists, False, 'exists with nonexistent element';

    ok ?$s, "Bool returns True if there is something in the SetHash";
    nok ?Set.new(), "Bool returns False if there is nothing in the SetHash";

    my $hash;
    lives_ok { $hash = $s.hash }, ".hash doesn't die";
    isa_ok $hash, Hash, "...and it returned a Hash";
    is showset($hash), 'a b foo', '...with the right elements';
    is $hash.values.grep({ ($_ ~~ Bool) && $_ }).elems, 3, "...and values";

    dies_ok { $s.keys = <c d> }, "Can't assign to .keys";
    dies_ok { $s.values = <True False> }, "Can't assign to .values";

    is ($s<a b>).grep(?*).elems, 2, 'Multiple-element access';
    is ($s<a santa b easterbunny>).grep(?*).elems, 2, 'Multiple-element access (with nonexistent elements)';

    is $s.elems, 3, '.elems gives number of keys';
    is +$s, 3, '+$set gives number of keys';
    
    $s<baz> = True;
    lives_ok { $s<baz> = True }, 'can set an item to True';
    is showset($s), 'a b baz foo', '...and it adds it to the SetHash';
    lives_ok { $s<baz> = True }, 'can set the same item to True';
    is showset($s), 'a b baz foo', '...and it does nothing';

    lives_ok { $s<baz> = False }, 'can set an item to False';
    is showset($s), 'a b foo', 'and it removes it';
    lives_ok { $s<baz> = False }, 'can set an item which does not exist to False';
    is showset($s), 'a b foo', '... and it is not added to the set';
    
    lives_ok { $s<foo> = False }, 'can set an item to False';
    is $s.elems, 2, '... and an item is gone';
    is showset($s), 'a b', '... and the right one is gone';
    
    lives_ok { $s<foo>++ }, 'can ++ an item';
    is showset($s), 'a b foo', '++ on an item reinstates it';
    lives_ok { $s<foo>++ }, 'can ++ an item';
    is showset($s), 'a b foo', '++ on an existing item does nothing';

    lives_ok { $s<b>-- }, 'can -- an item';
    is showset($s), 'a foo', '-- on an item removes it';
    lives_ok { $s<bar>-- }, 'can -- an item';
    is showset($s), 'a foo', '... but only if they were there to start with';
}

{
    my $a = (1,2,3,2,2,2,2).SetHash;
    is $a.kv.sort, ((1, Bool::True), (2, Bool::True), (3, Bool::True)).list.sort, "SetHash.kv returns list of keys and values";
}


{
    ok (SetHash.new: <a b c>) ~~ (SetHash.new: <a b c>), "Identical sets smartmatch with each other";
    nok (SetHash.new: <b c>) ~~ (SetHash.new: <a b c>), "Subset does not smartmatch";
    nok (SetHash.new: <a b c d>) ~~ (SetHash.new: <a b c>), "Superset does not smartmatch";
    nok "a" ~~ (SetHash.new: <a b c>), "Smartmatch is not element of";
    ok (SetHash.new: <a b c>) ~~ SetHash, "Type-checking smartmatch works";
    ok (set <a b c>) ~~ (SetHash.new: <a b c>), "SetHash matches Set, too";

    ok (bag <a b c>) ~~ (SetHash.new: <a b c>), "Bag smartmatches with equivalent SetHash:";
    ok (bag <a a a b c>) ~~ (SetHash.new: <a b c>), "... even if the Bag has greater quantities";
    nok (bag <b c>) ~~ (SetHash.new: <a b c>), "Subset does not smartmatch";
    nok (bag <a b c d>) ~~ (SetHash.new: <a b c>), "Superset does not smartmatch";
    nok (bag <a b c>) ~~ SetHash, "Type-checking smartmatch works";
}

{
    isa_ok "a".SetHash, SetHash, "Str.SetHash makes a SetHash";
    is showset("a".SetHash), 'a', "'a'.SetHash is set a";

    isa_ok (a => 1).SetHash, SetHash, "Pair.SetHash makes a SetHash";
    is showset((a => 1).SetHash), 'a', "(a => 1).SetHash is set a";
    is showset((a => 0).SetHash), '', "(a => 0).SetHash is the empty set";

    isa_ok <a b c>.SetHash, SetHash, "<a b c>.SetHash makes a SetHash";
    is showset(<a b c a>.SetHash), 'a b c', "<a b c a>.SetHash makes the set a b c";
    is showset(["a", "b", "c", "a"].SetHash), 'a b c', "[a b c a].SetHash makes the set a b c";
    is showset([a => 3, b => 0, 'c', 'a'].SetHash), 'a c', "[a => 3, b => 0, 'c', 'a'].SetHash makes the set a c";

    isa_ok {a => 2, b => 4, c => 0}.SetHash, SetHash, "{a => 2, b => 4, c => 0}.SetHash makes a SetHash";
    is showset({a => 2, b => 4, c => 0}.SetHash), 'a b', "{a => 2, b => 4, c => 0}.SetHash makes the set a b";
}

{
    my $s = SetHash.new(<a b foo>);
    is $s<a>:exists, True, ':exists with existing element';
    is $s<santa>:exists, False, ':exists with nonexistent element';
    is $s<a>:delete, True, ':delete returns current value on set';
    is showset($s), 'b foo', '...and actually deletes';
}

{
    my %h := SetHash.new(<a c>);
    is +%h.elems, 2, 'Inititalization worked';

    lives_ok { %h<c> = False }, 'can set an item to False';
    is %h.elems, 1, '... and an item is gone';
    is ~%h.keys, 'a', '... and the right one is gone';

    %h<c>++;
    is %h.keys.sort.join, 'ac', '++ on an item reinstates it';
    %h<c>++;
    is %h.keys.sort.join, 'ac', '++ on an existing item does nothing';

    %h<a>--;
    is ~%h.keys, 'c', '-- removes items';
    %h<b>--;
    is ~%h.keys, 'c', '... but only if they were there from the beginning';

    # lives_ok { %h = set <Q P R> }, 'Assigning a Set to a SetHash';
    # is %h.keys.sort.join, 'PQR', '... works as expected';
}

{
    my $s = SetHash.new(<foo bar foo bar baz foo>);
    is showset($s), 'bar baz foo', 'SetHash.new discards duplicates';
}

{
    my $b = SetHash.new([ foo => 10, bar => 17, baz => 42 ]);
    isa_ok $b, SetHash, 'SetHash.new given an array of pairs produces a SetHash';
    is +$b, 1, '... with one element';
}

{
    my $b = SetHash.new({ foo => 10, bar => 17, baz => 42 }.hash);
    isa_ok $b, SetHash, 'SetHash.new given a Hash produces a SetHash';
    #?rakudo todo "Not up to current spec"
    is +$b, 3, '... with three elements';
    #?niecza todo "Non-string keys NYI"
    #?rakudo todo "Not up to current spec"
    is +$b.grep(Pair), 3, '... which are all Pairs';
}

{
    my $b = SetHash.new({ foo => 10, bar => 17, baz => 42 });
    isa_ok $b, SetHash, 'SetHash.new given a Hash produces a SetHash';
    is +$b, 1, '... with one element';
}

{
    my $b = SetHash.new(set <foo bar foo bar baz foo>);
    isa_ok $b, SetHash, 'SetHash.new given a Set produces a SetHash';
    is +$b, 1, '... with one element';
}

{
    my $b = SetHash.new(SetHash.new(<foo bar foo bar baz foo>));
    isa_ok $b, SetHash, 'SetHash.new given a SetHash produces a SetHash';
    is +$b, 1, '... with one element';
}

{
    my $b = SetHash.new(BagHash.new(<foo bar foo bar baz foo>));
    isa_ok $b, SetHash, 'SetHash.new given a BagHash produces a SetHash';
    is +$b, 1, '... with one element';
}

{
    my $b = SetHash.new(bag <foo bar foo bar baz foo>);
    isa_ok $b, SetHash, 'SetHash given a Bag produces a SetHash';
    is +$b, 1, '... with one element';
}

{
    my $s = SetHash.new(<foo bar baz>);
    isa_ok $s.list.elems, 3, ".list returns 3 things";
    is $s.list.grep(Str).elems, 3, "... all of which are Str";
    #?rakudo skip 'no longer Iterable'
    is $s.iterator.grep(Str).elems, 3, ".iterator yields three Strs";
}

{
    my $s = SetHash.new(<foo bar baz>);
    my $str;
    my $c;
    lives_ok { $str = $s.perl }, ".perl lives";
    isa_ok $str, Str, "... and produces a string";
    lives_ok { $c = EVAL $str }, ".perl.eval lives";
    isa_ok $c, SetHash, "... and produces a SetHash";
    is showset($c), showset($s), "... and it has the correct values";
}

{
    my $s = SetHash.new(<foo bar baz>);
    lives_ok { $s = $s.Str }, ".Str lives";
    isa_ok $s, Str, "... and produces a string";
    is $s.split(" ").sort.join(" "), "bar baz foo", "... which only contains bar baz and foo separated by spaces";
}

{
    my $s = SetHash.new(<foo bar baz>);
    lives_ok { $s = $s.gist }, ".gist lives";
    isa_ok $s, Str, "... and produces a string";
    ok $s ~~ /foo/, "... which mentions foo";
    ok $s ~~ /bar/, "... which mentions bar";
    ok $s ~~ /baz/, "... which mentions baz";
}

# L<S02/Names and Variables/'C<%x> may be bound to'>

{
    my %s := SetHash.new(<a b c b>);
    isa_ok %s, SetHash, 'A SetHash bound to a %var is a SetHash';
    is showset(%s), 'a b c', '...with the right elements';

    is %s<a>, True, 'Single-key subscript (existing element)';
    is %s<santa>, False, 'Single-key subscript (nonexistent element)';

    lives_ok { %s<a> = True }, "Can assign to an element (SetHash are immutable)";
}

# L<S32::Containers/SetHash/roll>

{
    my $s = SetHash.new(<a b c>);

    my $a = $s.roll;
    ok $a eq "a" || $a eq "b" || $a eq "c", "We got one of the three choices";

    my @a = $s.roll(2);
    is +@a, 2, '.roll(2) returns the right number of items';
    is @a.grep(* eq 'a' | 'b' | 'c').elems, 2, '.roll(2) returned "a"s, "b"s, and "c"s';

    @a = $s.roll: 100;
    is +@a, 100, '.roll(100) returns 100 items';
    is @a.grep(* eq 'a' | 'b' | 'c').elems, 100, '.roll(100) returned "a"s, "b"s, and "c"s';
    #?pugs   skip '.total NYI'
    #?niecza skip '.total NYI'
    is $s.total, 3, '.roll should not change the SetHash';
    is $s.elems, 3, '.roll should not change the SetHash';
}

# L<S32::Containers/SetHash/pick>

{
    my $s = SetHash.new(<a b c d e f g h>);
    my @a = $s.pick: *;
    is @a.sort.join, 'abcdefgh', 'SetHash.pick(*) gets all elements';
    isnt @a.join, 'abcdefgh', 'SetHash.pick(*) returns elements in a random order';
      # There's only a 1/40_320 chance of that test failing by chance alone.
    #?pugs   skip '.total NYI'
    #?niecza skip '.total NYI'
    is $s.total, 8, '.pick should not change the SetHash';
    is $s.elems, 8, '.pick should not change the SetHash';
}

{
    my $s = SetHash.new(<a b c>);

    my $a = $s.pick;
    ok $a eq "a" || $a eq "b" || $a eq "c", "We got one of the three choices";

    my @a = $s.pick(2);
    is +@a, 2, '.pick(2) returns the right number of items';
    is @a.grep(* eq 'a' | 'b' | 'c').elems, 2, '.pick(2) returned "a"s, "b"s, and "c"s';
    ok @a.grep(* eq 'a').elems <= 1, '.pick(2) returned at most one "a"';
    ok @a.grep(* eq 'b').elems <= 1, '.pick(2) returned at most one "b"';
    ok @a.grep(* eq 'c').elems <= 1, '.pick(2) returned at most one "c"';
    #?pugs   skip '.total NYI'
    #?niecza skip '.total NYI'
    is $s.total, 3, '.pick should not change the SetHash';
    is $s.elems, 3, '.pick should not change the SetHash';
}

# L<S32::Containers/SetHash/grab>

#?pugs   skip '.grab NYI'
#?niecza skip '.grab NYI'
{
    my $s = SetHash.new(<a b c d e f g h>);
    my @a = $s.grab: *;
    is @a.sort.join, 'abcdefgh', 'SetHash.grab(*) gets all elements';
    isnt @a.join, 'abcdefgh', 'SetHash.grab(*) returns elements in a random order';
      # There's only a 1/40_320 chance of that test failing by chance alone.
    is $s.total, 0, '.grab *should* change the SetHash';
    is $s.elems, 0, '.grab *should* change the SetHash';
}

#?pugs   skip '.grab NYI'
#?niecza skip '.grab NYI'
{
    my $s = SetHash.new(<a b c>);

    my $a = $s.grab;
    ok $a eq "a" || $a eq "b" || $a eq "c", "We got one of the three choices";
    is $s.total, 2, '.grab *should* change the SetHash';
    is $s.elems, 2, '.grab *should* change the SetHash';

    my @a = $s.grab(2);
    is +@a, 2, '.grab(2) returns the right number of items';
    is @a.grep(* eq 'a' | 'b' | 'c').elems, 2, '.grab(2) returned "a"s, "b"s, and "c"s';
    ok @a.grep(* eq 'a').elems <= 1, '.grab(2) returned at most one "a"';
    ok @a.grep(* eq 'b').elems <= 1, '.grab(2) returned at most one "b"';
    ok @a.grep(* eq 'c').elems <= 1, '.grab(2) returned at most one "c"';
    is $s.total, 0, '.grab *should* change the SetHash';
    is $s.elems, 0, '.grab *should* change the SetHash';
}

# L<S32::Containers/SetHash/grabpairs>

#?pugs   skip '.grabpairs NYI'
#?niecza skip '.grabpairs NYI'
{
    my $s = SetHash.new(<a b c d e f g h>);
    my @a = $s.grabpairs: *;
    is @a.grep( {.isa(Pair)} ).Num, 8, 'are they all Pairs';
    is @a.grep( {.value === True} ).Num, 8, 'and they all have a True value';
    is @a.sort.map({.key}).join, "abcdefgh", 'SetHash.grabpairs(*) gets all elements';
    isnt @a.map({.key}).join, "abcdefgh", 'SetHash.grabpairs(*) returns elements in a random order';
      # There's only a 1/40_320 chance of that test failing by chance alone.
    is $s.total, 0, '.grabpairs *should* change the SetHash';
    is $s.elems, 0, '.grabpairs *should* change the SetHash';
}

#?pugs   skip '.grabpairs NYI'
#?niecza skip '.grabpairs NYI'
{
    my $s = SetHash.new(<a b c>);

    my $a = $s.grabpairs[0];
    isa_ok $a, Pair, 'and is it a Pair';
    ok $a.key eq "a" || $a.key eq "b" || $a.key eq "c", "We got one of the three choices";
    is $s.total, 2, '.grabpairs *should* change the SetHash';
    is $s.elems, 2, '.grabpairs *should* change the SetHash';

    my @a = $s.grabpairs(2);
    is @a.grep( {.isa(Pair)} ).Num, 2, 'are they all Pairs';
    is +@a, 2, '.grabpairs(2) returns the right number of items';
    is @a.grep(*.key eq 'a' | 'b' | 'c').elems, 2, '.grabpairs(2) returned "a"s, "b"s, and "c"s';
    ok @a.grep(*.key eq 'a').elems <= 1, '.grabpairs(2) returned at most one "a"';
    ok @a.grep(*.key eq 'b').elems <= 1, '.grabpairs(2) returned at most one "b"';
    ok @a.grep(*.key eq 'c').elems <= 1, '.grabpairs(2) returned at most one "c"';
    is $s.total, 0, '.grabpairs *should* change the SetHash';
    is $s.elems, 0, '.grabpairs *should* change the SetHash';
}

#?rakudo skip "'is ObjectType' NYI"
#?niecza skip "is SetHash doesn't work yet"
{
    my %h is SetHash = a => True, b => False, c => True;
    #?rakudo todo 'todo'
    is +%h.elems, 2, 'Inititalization worked';

    lives_ok { %h<c> = False }, 'can set an item to False';
    #?rakudo todo 'todo'
    is %h.elems, 1, '... and an item is gone';
    #?rakudo todo 'todo'
    is ~%h.keys, 'a', '... and the right one is gone';

    %h<c>++;
    #?rakudo todo 'todo'
    is %h.keys.sort.join, 'ac', '++ on an item reinstates it';
    %h<c>++;
    #?rakudo todo 'todo'
    is %h.keys.sort.join, 'ac', '++ on an existing item does nothing';

    %h<a>--;
    #?rakudo todo 'todo'
    is ~%h.keys, 'c', '-- removes items';
    %h<b>--;
    #?rakudo todo 'todo'
    is ~%h.keys, 'c', '... but only if they were there from the beginning';

    #?rakudo todo 'todo'
    lives_ok { %h = set <Q P R> }, 'Assigning a Set to a SetHash';
    #?rakudo todo 'todo'
    is %h.keys.sort.join, 'PQR', '... works as expected';
}

{
    isa_ok 42.SetHash, SetHash, "Method .SetHash works on Int-1";
    is showset(42.SetHash), "42", "Method .SetHash works on Int-2";
    isa_ok "blue".SetHash, SetHash, "Method .SetHash works on Str-1";
    is showset("blue".SetHash), "blue", "Method .SetHash works on Str-2";
    my @a = <Now the cross-handed set was the Paradise way>;
    isa_ok @a.SetHash, SetHash, "Method .SetHash works on Array-1";
    is showset(@a.SetHash), "Now Paradise cross-handed set the was way", "Method .SetHash works on Array-2";
    my %x = "a" => 1, "b" => 2;
    isa_ok %x.SetHash, SetHash, "Method .SetHash works on Hash-1";
    is showset(%x.SetHash), "a b", "Method .SetHash works on Hash-2";
    isa_ok (@a, %x).SetHash, SetHash, "Method .SetHash works on Parcel-1";
    is showset((@a, %x).SetHash), "Now Paradise a b cross-handed set the was way", "Method .SetHash works on Parcel-2";
}

#?pugs   skip '.total/.min/.max NYI'
#?niecza skip '.total/.min/.max NYI'
{
    my $s = <a b b c c c d d d d>.SetHash;
    is $s.total, 4, '.total gives sum of values (non-empty)';
    is +$s, 4, '+$set gives sum of values (non-empty)';
    is $s.min, 1, '.min works (non-empty)';
    is $s.max, 1, '.max works (non-empty)';

    my $e = ().SetHash;
    is $e.total, 0, '.total gives sum of values (empty)';
    is +$e, 0, '+$set gives sum of values (empty)';
    is $e.min, Inf, '.min works (empty)';
    is $e.max, -Inf, '.max works (empty)';
}

# vim: ft=perl6
