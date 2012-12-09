use v6;
use Test;

plan 93;

sub showset($s) { $s.keys.sort.join(' ') }

# L<S02/Immutable types/'the set listop'>

{
    my $s = set <a b foo>;
    isa_ok $s, Set, '&set produces a Set';
    is showset($s), 'a b foo', '...with the right elements';

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

    is ($s<a b>).grep(?*).elems, 2, 'Multiple-element access';
    is ($s<a santa b easterbunny>).grep(?*).elems, 2, 'Multiple-element access (with nonexistent elements)';

    is $s.elems, 3, '.elems gives number of keys';
    is +$s, 3, '+$set gives number of keys';
}

{
    my $s = set <a b foo>;
    is $s.exists(<a>), True, ':exists with existing element';
    is $s.exists(<santa>), False, ':exists with nonexistent element';
    dies_ok { $s.delete(<a>) }, ':delete does not work on set';
}

{
    my $s = set 2, 'a', False;
    my @ks = $s.keys;
    #?niecza 3 todo
    #?rakudo 3 todo ''
    is @ks.grep(Int)[0], 2, 'Int keys are left as Ints';
    is @ks.grep(* eqv False).elems, 1, 'Bool keys are left as Bools';
    is @ks.grep(Str)[0], 'a', 'And Str keys are permitted in the same set';
    is +$s, 3, 'Keys are counted correctly even when a key is False';
}

# RT #77760
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
    is showset($b), 'bar baz foo', '... with the right elements';
}

{
    my $b = set { foo => 10, bar => 17, baz => 42 }.hash;
    isa_ok $b, Set, '&Set.new given a Hash produces a Set';
    is showset($b), 'bar baz foo', '... with the right elements';
}

{
    my $b = set { foo => 10, bar => 17, baz => 42 };
    isa_ok $b, Set, '&Set.new given a Hash produces a Set';
    is showset($b), 'bar baz foo', '... with the right elements';
}

{
    my $b = set set <foo bar foo bar baz foo>;
    isa_ok $b, Set, '&Set.new given a Set produces a Set';
    is showset($b), 'bar baz foo', '... with the right elements';
}

{
    my $b = set KeySet.new(set <foo bar foo bar baz foo>);
    isa_ok $b, Set, '&Set.new given a KeySet produces a Set';
    is showset($b), 'bar baz foo', '... with the right elements';
}

{
    my $b = set KeyBag.new(set <foo bar foo bar baz foo>);
    isa_ok $b, Set, '&Set.new given a KeySet produces a Set';
    is showset($b), 'bar baz foo', '... with the right elements';
}

{
    my $b = set bag <foo bar foo bar baz foo>;
    isa_ok $b, Set, '&set given a Bag produces a Set';
    is showset($b), 'bar baz foo', '... with the right elements';
}

{
    my $s = set <foo bar baz>;
    isa_ok $s.list.elems, 3, ".list returns 3 things";
    is $s.list.grep(Str).elems, 3, "... all of which are Str";
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
    is_deeply [ ( set ( set <a b c> ), <c> ).list.sort ], [ 'a', 'b', 'c' ],
        'set inside set does not duplicate elements';
    
    my $s = set <a b c>;
    is_deeply [ ( set $s, <c> ).list.sort ], [ 'a', 'b', 'c' ],
        'variable of Set type inside set does not duplicate elements';
}

# vim: ft=perl6
