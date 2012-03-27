use v6;
use Test;

plan 110;

# L<S02/Mutable types/"KeyHash of Bool">

# A KeySet is a KeyHash of Bool, i.e. the values are Bool

sub showset($s) { $s.keys.sort.join(' ') }

# L<S02/Immutable types/'the set listop'>

{
    my $s = KeySet.new(<a b foo>);
    isa_ok $s, KeySet, 'KeySet.new produces a KeySet';
    is showset($s), 'a b foo', '...with the right elements';

    is $s<a>, True, 'Single-key subscript (existing element)';
    isa_ok $s<a>, Bool, 'Single-key subscript has correct type (existing element)';
    is $s<santa>, False, 'Single-key subscript (nonexistent element)';
    isa_ok $s<santa>, Bool, 'Single-key subscript has correct type (nonexistent element)';
    is $s.exists('a'), True, '.exists with existing element';
    is $s.exists('santa'), False, '.exists with nonexistent element';

    ok ?$s, "Bool returns True if there is something in the KeySet";
    nok ?Set.new(), "Bool returns False if there is nothing in the KeySet";

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
    is showset($s), 'a b baz foo', '...and it adds it to the KeySet';
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

#?rakudo skip ':exists and :delete NYI'
{
    my $s = KeySet.new(<a b foo>);
    is $s<a>:exists, True, ':exists with existing element';
    is $s<santa>:exists, False, ':exists with nonexistent element';
    is $s<a>:delete, True, ':delete returns current value on set';
    is showset($s), 'b foo', '...and actually deletes';
}

{
    my %h := KeySet.new(<a c>);
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

    # lives_ok { %h = set <Q P R> }, 'Assigning a Set to a KeySet';
    # is %h.keys.sort.join, 'PQR', '... works as expected';
}

{
    my $s = KeySet.new(<foo bar foo bar baz foo>);
    is showset($s), 'bar baz foo', 'KeySet.new discards duplicates';
}

{
    my $b = KeySet.new([ foo => 10, bar => 17, baz => 42 ]);
    isa_ok $b, KeySet, 'KeySet.new given an array of pairs produces a KeySet';
    is showset($b), 'bar baz foo', '... with the right elements';
}

{
    my $b = KeySet.new({ foo => 10, bar => 17, baz => 42 }.hash);
    isa_ok $b, KeySet, 'KeySet.new given a Hash produces a KeySet';
    is showset($b), 'bar baz foo', '... with the right elements';
}

{
    my $b = KeySet.new({ foo => 10, bar => 17, baz => 42 });
    isa_ok $b, KeySet, 'KeySet.new given a Hash produces a KeySet';
    is showset($b), 'bar baz foo', '... with the right elements';
}

{
    my $b = KeySet.new(set <foo bar foo bar baz foo>);
    isa_ok $b, KeySet, 'KeySet.new given a Set produces a KeySet';
    is showset($b), 'bar baz foo', '... with the right elements';
}

{
    my $b = KeySet.new(KeySet.new(<foo bar foo bar baz foo>));
    isa_ok $b, KeySet, 'KeySet.new given a KeySet produces a KeySet';
    is showset($b), 'bar baz foo', '... with the right elements';
}

{
    my $b = KeySet.new(KeyBag.new(<foo bar foo bar baz foo>));
    isa_ok $b, KeySet, 'KeySet.new given a KeyBag produces a KeySet';
    is showset($b), 'bar baz foo', '... with the right elements';
}

{
    my $b = KeySet.new(bag <foo bar foo bar baz foo>);
    isa_ok $b, KeySet, 'KeySet given a Bag produces a KeySet';
    is showset($b), 'bar baz foo', '... with the right elements';
}

{
    my $s = KeySet.new(<foo bar baz>);
    isa_ok $s.list.elems, 3, ".list returns 3 things";
    is $s.list.grep(Str).elems, 3, "... all of which are Str";
    is $s.iterator.grep(Str).elems, 3, ".iterator yields three Strs";
}

{
    my $s = KeySet.new(<foo bar baz>);
    my $str;
    my $c;
    lives_ok { $str = $s.perl }, ".perl lives";
    isa_ok $str, Str, "... and produces a string";
    lives_ok { $c = eval $str }, ".perl.eval lives";
    isa_ok $c, KeySet, "... and produces a KeySet";
    is showset($c), showset($s), "... and it has the correct values";
}

{
    my $s = KeySet.new(<foo bar baz>);
    lives_ok { $s = $s.Str }, ".Str lives";
    isa_ok $s, Str, "... and produces a string";
    is $s.split(" ").sort.join(" "), "bar baz foo", "... which only contains bar baz and foo separated by spaces";
}

{
    my $s = KeySet.new(<foo bar baz>);
    lives_ok { $s = $s.gist }, ".gist lives";
    isa_ok $s, Str, "... and produces a string";
    ok $s ~~ /foo/, "... which mentions foo";
    ok $s ~~ /bar/, "... which mentions bar";
    ok $s ~~ /baz/, "... which mentions baz";
}

# L<S02/Names and Variables/'C<%x> may be bound to'>

{
    my %s := KeySet.new(<a b c b>);
    isa_ok %s, KeySet, 'A KeySet bound to a %var is a KeySet';
    is showset(%s), 'a b c', '...with the right elements';

    is %s<a>, True, 'Single-key subscript (existing element)';
    is %s<santa>, False, 'Single-key subscript (nonexistent element)';

    lives_ok { %s<a> = True }, "Can assign to an element (KeySets are immutable)";
}

# L<S32::Containers/KeySet/roll>

{
    my $s = KeySet.new(<a b c>);

    my $a = $s.roll;
    ok $a eq "a" || $a eq "b" || $a eq "c", "We got one of the three choices";

    my @a = $s.roll(2);
    is +@a, 2, '.roll(2) returns the right number of items';
    is @a.grep(* eq 'a' | 'b' | 'c').elems, 2, '.roll(2) returned "a"s, "b"s, and "c"s';

    @a = $s.roll: 100;
    is +@a, 100, '.roll(100) returns 100 items';
    is @a.grep(* eq 'a' | 'b' | 'c').elems, 100, '.roll(100) returned "a"s, "b"s, and "c"s';
}

# L<S32::Containers/KeySet/pick>

{
    my $s = KeySet.new(<a b c d e f g h>);
    my @a = $s.pick: *;
    is @a.sort.join, 'abcdefgh', 'KeySet.pick(*) gets all elements';
    isnt @a.join, 'abcdefgh', 'KeySet.pick(*) returns elements in a random order';
      # There's only a 1/40_320 chance of that test failing by chance alone.
}

{
    my $s = KeySet.new(<a b c>);

    my $a = $s.pick;
    ok $a eq "a" || $a eq "b" || $a eq "c", "We got one of the three choices";

    my @a = $s.pick(2);
    is +@a, 2, '.pick(2) returns the right number of items';
    is @a.grep(* eq 'a' | 'b' | 'c').elems, 2, '.pick(2) returned "a"s, "b"s, and "c"s';
    ok @a.grep(* eq 'a').elems <= 1, '.pick(2) returned at most one "a"';
    ok @a.grep(* eq 'b').elems <= 1, '.pick(2) returned at most one "b"';
    ok @a.grep(* eq 'c').elems <= 1, '.pick(2) returned at most one "c"';
}

#?niecza skip "is KeySet doesn't work yet"
{
    my %h is KeySet = a => True, b => False, c => True;
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
    lives_ok { %h = set <Q P R> }, 'Assigning a Set to a KeySet';
    #?rakudo todo 'todo'
    is %h.keys.sort.join, 'PQR', '... works as expected';
}

# vim: ft=perl6
