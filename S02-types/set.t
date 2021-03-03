use v6;
use Test;
use lib $?FILE.IO.parent(2).add: 'packages/Test-Helpers';
use Test::Util;

plan 242;

sub showset($s) { $s.keys.sort.join(' ') }

# L<S02/Immutable types/'the set listop'>

{
    my $s = set <a b foo>;
    isa-ok $s, Set, '&set produces a Set';
    is showset($s), 'a b foo', '...with the right elements';

    is $s.default, False, "Default value is false";
    is $s<a>, True, 'Single-key subscript (existing element)';
    isa-ok $s<a>, Bool, 'Single-key subscript has correct type (existing element)';
    is $s<santa>, False, 'Single-key subscript (nonexistent element)';
    isa-ok $s<santa>, Bool, 'Single-key subscript has correct type (nonexistent element)';
    is $s<a>:exists, True, 'exists with existing element';
    is $s<santa>:exists, False, 'exists with nonexistent element';

    ok ?$s, "Bool returns True if there is something in the Set";
    nok ?Set.new(), "Bool returns False if there is nothing in the Set";

    my $hash;
    lives-ok { $hash = $s.hash }, ".hash doesn't die";
    isa-ok $hash, Hash, "...and it returned a Hash";
    is showset($hash), 'a b foo', '...with the right elements';
    is $hash.values.grep({ ($_ ~~ Bool) && $_ }).elems, 3, "...and values";

    dies-ok { $s<a> = True }, "Can't assign to an element (Sets are immutable)";
    dies-ok { $s.keys = <c d> }, "Can't assign to .keys";
    dies-ok { $s.values = <True False> }, "Can't assign to .values";
    dies-ok { $s<a>:delete }, "Can't :delete from Set";

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
    isa-ok "a".Set, Set, "Str.Set makes a Set";
    is showset("a".Set), 'a', "'a'.Set is set a";

    isa-ok (a => 1).Set, Set, "Pair.Set makes a Set";
    is showset((a => 1).Set), 'a', "(a => 1).Set is set a";
    is showset((a => 0).Set), '', "(a => 0).Set is the empty set";

    isa-ok <a b c>.Set, Set, "<a b c>.Set makes a Set";
    is showset(<a b c a>.Set), 'a b c', "<a b c a>.Set makes the set a b c";
    is showset(["a", "b", "c", "a"].Set), 'a b c', "[a b c a].Set makes the set a b c";
    is showset([a => 3, b => 0, 'c', 'a'].Set), 'a c', "[a => 3, b => 0, 'c', 'a'].Set makes the set a c";

    isa-ok {a => 2, b => 4, c => 0}.Set, Set, '{a => 2, b => 4, c => 0}.Set makes a Set';
    is showset({a => 2, b => 4, c => 0}.Set), 'a b', '{a => 2, b => 4, c => 0}.Set makes the set a b';

    # https://github.com/Raku/old-issue-tracker/issues/6147
    is-deeply (:a, :!b, :3c, :0d, :e<meow>, :f(''), 'g').Set,
        set('a', 'c', 'e', 'g'),
    '.Set on List of Pairs treats Pair.value as weight';

    # https://github.com/Raku/old-issue-tracker/issues/6147
    is-deeply {:a, :!b, :3c, :0d, :e<meow>, :f('')}.Set,
        set('a', 'c', 'e'),
    '.Set on Hash of Pairs treats Pair.value as weight';
}

{
    my $s = set <a b foo>;
    is $s<a>:exists, True, ':exists with existing element';
    is $s<santa>:exists, False, ':exists with nonexistent element';
    dies-ok { $s<a>:delete }, ':delete does not work on set';
}

{
    my $s = set 2, 'a', False;
    my @ks = $s.keys;
    is @ks.grep({ .WHAT === Int })[0], 2, 'Int keys are left as Ints';
    is @ks.grep(* eqv False).elems, 1, 'Bool keys are left as Bools';
    is @ks.grep(Str)[0], 'a', 'And Str keys are permitted in the same set';
    is +$s, 3, 'Keys are counted correctly even when a key is False';
}

{
    my %h := set <a b o p a p o o>;
    ok %h ~~ Set, 'A hash to which a Set has been bound becomes a set';
    is %h.keys.sort.join, 'abop', '...with the right keys';
    is %h.values, (True xx 4), '...and values all True';
}

{
    my $s = set <foo bar foo bar baz foo>;
    is showset($s), 'bar baz foo', '&set discards duplicates';
}

{
    my $b = set [ foo => 10, bar => 17, baz => 42 ];
    isa-ok $b, Set, '&Set.new given an array of pairs produces a Set';
    is +$b, 3, "... with three elements under the single arg rule";
}
{
    my $b = set $[ foo => 10, bar => 17, baz => 42 ];
    isa-ok $b, Set, '&Set.new given an itemized array of pairs produces a Set';
    is +$b, 1, "... with one element";
}

{
    # {}.hash interpolates in list context
    my $b = set { foo => 10, bar => 17, baz => 42 }.hash;
    isa-ok $b, Set, '&Set.new given a Hash produces a Set';
    is +$b, 3, "... with three elements";
    is +$b.grep(Pair), 3, "... all of which are Pairs";
}

{
    my $b = set { foo => 10, bar => 17, baz => 42 };
    isa-ok $b, Set, '&Set.new given a Hash produces a Set';
    is +$b, 3, "... with three elements under the single arg rule";
}
{
    my $b = set ${ foo => 10, bar => 17, baz => 42 };
    isa-ok $b, Set, '&Set.new given an itemized Hash produces a Set';
    is +$b, 1, "... with one element";
}

{
    my $b = set set <foo bar foo bar baz foo>;
    isa-ok $b, Set, '&Set.new given a Set produces a Set';
    is +$b, 1, "... with one element";
}

{
    my $b = set SetHash.new(<foo bar foo bar baz foo>);
    isa-ok $b, Set, '&Set.new given a SetHash produces a Set';
    is +$b, 1, "... with one element";
}

{
    my $b = set BagHash.new(<foo bar foo bar baz foo>);
    isa-ok $b, Set, '&Set.new given a SetHash produces a Set';
    is +$b, 1, "... with one element";
}

{
    my $b = set bag <foo bar foo bar baz foo>;
    isa-ok $b, Set, '&set given a Bag produces a Set';
    is +$b, 1, "... with one element";
}

{
    my $s = set <foo bar baz>;
    is $s.list.elems, 3, ".list returns 3 things";
    is $s.list.grep(Pair).elems, 3, "... all of which are Pairs";
    isa-ok $s.pairs.elems, 3, ".pairs returns 3 things";
    is $s.pairs.grep(Pair).elems, 3, "... all of which are Pairs";
    is $s.pairs.grep({ .key ~~ Str }).elems, 3, "... the keys of which are Strs";
    is $s.pairs.grep({ .value ~~ Bool }).elems, 3, "... and the values of which are Bool";
}

{
    my $s = set <foo bar baz>;
    my $str;
    my $c;
    lives-ok { $str = $s.raku }, ".raku lives";
    isa-ok $str, Str, "... and produces a string";
    lives-ok { $c = EVAL $str }, ".raku.EVAL lives";
    isa-ok $c, Set, "... and produces a Set";
    is showset($c), showset($s), "... and it has the correct values";
}

{
    my $s = set <foo bar baz>;
    lives-ok { $s = $s.Str }, ".Str lives";
    isa-ok $s, Str, "... and produces a string";
    is $s.split(" ").sort.join(" "), "bar baz foo", "... which only contains bar baz and foo separated by spaces";
}

{
    my $s = set <foo bar baz>;
    lives-ok { $s = $s.gist }, ".gist lives";
    isa-ok $s, Str, "... and produces a string";
    ok $s ~~ /foo/, "... which mentions foo";
    ok $s ~~ /bar/, "... which mentions bar";
    ok $s ~~ /baz/, "... which mentions baz";
}

# L<S02/Names and Variables/'C<%x> may be bound to'>

{
    my %s := set <a b c b>;
    isa-ok %s, Set, 'A Set bound to a %var is a Set';
    is showset(%s), 'a b c', '...with the right elements';

    is %s<a>, True, 'Single-key subscript (existing element)';
    is %s<santa>, False, 'Single-key subscript (nonexistent element)';

    dies-ok { %s<a> = True }, "Can't assign to an element (Sets are immutable)";
    dies-ok { %s = a => True, b => True }, "Can't assign to a %var implemented by Set";
    dies-ok { %s<a>:delete }, "Can't :delete a key from a Set";
}

# L<S03/Hyper operators/'unordered type'>
#?rakudo skip "Hypers not yet Set compatible"
{
    is showset(set(1, 2, 3) »+» 6), '7 8 9', 'Set »+» Int';
    is showset("a" «~« set(<pple bbot rmadillo>)), 'abbot apple armadillo', 'Str «~« Set';
    is showset(-« set(3, 9, -4)), '-9 -3 4', '-« Set';
    is showset(set(<b e g k z>)».pred), 'a d f j y', 'Set».pred';

    throws-like { set(1, 2) »+« set(3, 4) }, Exception,'Set »+« Set is illegal';
    throws-like { set(1, 2) »+« [3, 4] }, Exception, 'Set »+« Array is illegal';
    throws-like { set(1, 2) «+» [3, 4] }, Exception, 'Set «+» Array is illegal';
    throws-like { [1, 2] »+« set(3, 4) }, Exception, 'Set »+« Array is illegal';
    throws-like { [1, 2] «+» set(3, 4) }, Exception, 'Set «+» Array is illegal';
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
    is $s.total, 3, '.roll should not change Set';
}

# empty set handling of .roll
{
    is-deeply set().roll, Nil,         'empty set.roll -> Nil';
    for
      1,    '1',
      *-1,  '*-1',
      *,    '*',
      Inf,  'Inf',
      -1,   '-1',
      -Inf, '-Inf'
    -> $p, $t {
        is-eqv set().roll($p), ().Seq, "empty set.roll($t) -> ().Seq"
    }
    dies-ok { set().roll(NaN) }, 'empty set.roll(NaN) should die';
}

# L<S32::Containers/Set/pick>

{
    my $s = set <a b c d e f g h>;
    my @a = $s.pick: *;
    is @a.sort.join, 'abcdefgh', 'Set.pick(*) gets all elements';
    isnt @a.join, 'abcdefgh', 'Set.pick(*) returns elements in a random order';
      # There's only a 1/40_320 chance of that test failing by chance alone.
    is $s.total, 8, '.pick should not change Set';
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
    is $s.total, 3, '.pick should not change Set';
}

# empty set handling of .pick
{
    is-deeply set().pick, Nil,         'empty set.pick -> Nil';
    for
      1,    '1',
      *-1,  '*-1',
      *,    '*',
      Inf,  'Inf',
      -1,   '-1',
      -Inf, '-Inf'
    -> $p, $t {
        is-eqv set().pick($p), ().Seq, "empty set.pick($t) -> ().Seq"
    }
    dies-ok { set().pick(NaN) }, 'empty set.pick(NaN) should die';
}

# L<S32::Containers/Set/grab>

{
    my $s = set <a b c>;
    dies-ok { $s.grab }, 'cannot call .grab on a Set';

    for
      1,    '1',
      *-1,  '*-1',
      *,    '*',
      Inf,  'Inf',
      -1,   '-1',
      -Inf, '-Inf',
      NaN,  'NaN'
    -> $p, $t {
        dies-ok { $s.grab($p) }, "cannot call .grab($t) on a Set"
    }
}

# L<S32::Containers/Set/grabpairs>

{
    my $s = set <a b c>;
    dies-ok { $s.grabpairs }, 'cannot call .grabpairs on a Set';
}

# https://github.com/Raku/old-issue-tracker/issues/2585
{
    my $s1 = Set.new(( set <a b c> ), <c d>);
    is +$s1, 2, "Two elements";
    my $inner-set = $s1.keys.first(Set);
    isa-ok $inner-set, Set, "One of the set's elements is indeed a Set!";
    is showset($inner-set), "a b c", "With the proper elements";
    my $inner-list = $s1.keys.first(List);
    isa-ok $inner-list, List, "One of the set's elements is indeed a List!";
    is $inner-list, <c d>, "With the proper elements";

    my $s = set <a b c>;
    $s1 = Set.new($s, <c d>);
    is +$s1, 2, "Two elements";
    $inner-set = $s1.keys.first(Set);
    isa-ok $inner-set, Set, "One of the set's elements is indeed a set!";
    is showset($inner-set), "a b c", "With the proper elements";
    $inner-list = $s1.keys.first(List);
    isa-ok $inner-list, List, "One of the set's elements is indeed a List!";
    is $inner-list, <c d>, "With the proper elements";
}

{
    isa-ok 42.Set, Set, "Method .Set works on Int-1";
    is showset(42.Set), "42", "Method .Set works on Int-2";
    isa-ok "blue".Set, Set, "Method .Set works on Str-1";
    is showset("blue".Set), "blue", "Method .Set works on Str-2";
    my @a = <Now the cross-handed set was the Paradise way>;
    isa-ok @a.Set, Set, "Method .Set works on Array-1";
    is showset(@a.Set), "Now Paradise cross-handed set the was way", "Method .Set works on Array-2";
    my %x = "a" => 1, "b" => 2;
    isa-ok %x.Set, Set, "Method .Set works on Hash-1";
    is showset(%x.Set), "a b", "Method .Set works on Hash-2";
    isa-ok (@a, %x).Set, Set, "Method .Set works on List-1";
    is showset((@a, %x).Set), "Now Paradise a b cross-handed set the was way", "Method .Set works on List-2";
}

{
    my $s = <a b b c c c d d d d>.Set;
    is $s.total, 4, '.total gives sum of values (non-empty)';
    is +$s, 4, '+$set gives sum of values (non-empty)';
    is $s.minpairs.sort,[a=>True,b=>True,c=>True,d=>True], '.minpairs works (non-empty)';
    is $s.maxpairs.sort,[a=>True,b=>True,c=>True,d=>True], '.maxpairs works (non-empty)';
    is $s.fmt('foo %s').split("\n").sort, ('foo a', 'foo b', 'foo c', 'foo d'),
      '.fmt(%s) works (non-empty)';
    is $s.fmt('%s',',').split(',').sort, <a b c d>,
      '.fmt(%s,sep) works (non-empty)';
    is $s.fmt('%s foo %s').split("\n").sort, ('a foo True', 'b foo True', 'c foo True', 'd foo True'),
      '.fmt(%s%s) works (non-empty)';
    is $s.fmt('%s,%s',':').split(':').sort, <a,True b,True c,True d,True>,
      '.fmt(%s%s,sep) works (non-empty)';

    my $e = ().Set;
    is $e.total, 0, '.total gives sum of values (empty)';
    is +$e, 0, '+$set gives sum of values (empty)';
    is $e.minpairs, (), '.minpairs works (empty)';
    is $e.maxpairs, (), '.maxpairs works (empty)';
    is $e.fmt('foo %s'), "", '.fmt(%s) works (empty)';
    is $e.fmt('%s',','), "", '.fmt(%s,sep) works (empty)';
    is $e.fmt('%s foo %s'), "", '.fmt(%s%s) works (empty)';
    is $e.fmt('%s,%s',':'), "", '.fmt(%s%s,sep) works (empty)';
}

{
    my $s = <a b c>.Set;
    dies-ok { $s.pairs[0].key++ },     'Cannot change key of Set.pairs';
    dies-ok { $s.pairs[0].value = 0 }, 'Cannot change value of Set.pairs';
}

# https://github.com/Raku/old-issue-tracker/issues/3071
{
    my $s = set();
    $s (|)= 5;
    is $s, set(5), 'can metaop set assign like: (|)=';
}

# https://github.com/Raku/old-issue-tracker/issues/3835
{
    isnt 'a Str|b Str|c'.Set.WHICH, <a b c>.Set.WHICH,
      'Faulty .WHICH creation';
}

# https://github.com/Raku/old-issue-tracker/issues/2997
{
    my $s = Set.new([1,2],[3,4]);
    is $s.elems, 2, 'arrays not flattened out by Set.new (1)';
    is $s.keys.sort[0], [1,2], 'arrays not flattened out by Set.new (2)';
    is $s.keys.sort[1], [3,4], 'arrays not flattened out by Set.new (3)';
}

# https://github.com/Raku/old-issue-tracker/issues/4399
{
    class MySet is Set { };
    my $s = MySet.new([1, 2], 3);
    is $s.elems, 2, 'Can subclass Set';

    class RT125611 is Set {
        method foo( $foo ) {
            self{$foo} = True; self
        }
    }
    throws-like 'my $rt125611 = RT125611.new.foo: "a"', X::Assignment::RO,
        'trying to assign throws X::Assignment::RO';
}

{
    my $a = (1,2,3,2,2,2,2).Set;
    is $a.kv[0,2,4].sort, (1,2,3), "Set.kv returns list of keys and values (1)";
    is $a.kv[1,3,5], (True, True, True), "Set.kv returns list of keys and values (2)";
}

# https://github.com/Raku/old-issue-tracker/issues/4975
{
    ok <one two three>.map({$_}) ~~ set(<two three one>), 'smartmatch a Seq';
}

{
    isa-ok set(42).Hash.keys[0], Int, "make sure set.Hash returns objects";
}

# https://github.com/Raku/old-issue-tracker/issues/5095
subtest '.hash does not cause keys to be stringified' => {
    plan 3;
    is Set.new($(<a b>)).hash.keys[0][0], 'a', 'Set.new';
    is ($(<a b>),).Set.hash.keys[0][0],   'a', '.Set';
    is set($(<a b>),).hash.keys[0][0],    'a', 'set()';
}

{
    throws-like { my Set $s; $s<as> = 2 }, Exception,
        'autovivification of of Set:U complains about immutability';
}

{
    is-deeply set(42).Mix, Mix.new(42), '.Mix on set gives correct Mix';
    is-deeply set(42).MixHash, MixHash.new(42),
        '.MixHash on set gives correct MixHash';
}

{
    ok ().Set  =:= set(), '().Set returns the empty set';
}

{
    is-deeply { a => 42, b => 666 }.Set, <a b>.Set,
      'coercion of Map to Set 1';
    is-deeply { a => 42, b => 0   }.Set, <a>.Set,
      'coercion of Map to Set 2';
    is-deeply :{ 42 => "a", 666 => "b" }.Set, (42,666).Set,
      'coercion of object Hash to Set 1';
    is-deeply :{ 42 => "a", 666 => "" }.Set,   42.Set,
      'coercion of object Hash to Set 2';
}

{
    is-deeply Set[Str].new( <a b c> ).keys.sort.List, <a b c>,
      'can we parameterize for strings?';
    ok Set[Str].keyof =:= Str, 'does .keyof return the correct type';
    throws-like { Set[Int].new( <a b c> ) }, X::TypeCheck::Binding,
      'do wrong values make initialization croak';
}

{
    throws-like { ^Inf .Set }, X::Cannot::Lazy, :what<Set>;
    throws-like { Set.new-from-pairs(^Inf) }, X::Cannot::Lazy, :what<Set>;
    throws-like { Set.new(^Inf) }, X::Cannot::Lazy, :what<Set>;
}

# https://github.com/Raku/old-issue-tracker/issues/3135
{
    throws-like 'set;', Exception, message => /set/,
        'set listop called without arguments and parentheses dies (1)';
    throws-like 'set<a b c>;', X::Syntax::Confused, message => /subscript/,
        'set listop called without arguments dies (2)';
}

# https://github.com/Raku/old-issue-tracker/issues/6240
subtest 'set ops do not hang with Setty/Baggy/Mixy type objects' => {
    my @ops =
      &infix:<<∈>>,      '∈',
      &infix:<<(elem)>>, '(elem)',
      &infix:<<∉>>,      '∉',
      &infix:<<∋>>,      '∋',
      &infix:<<(cont)>>, '(cont)',
      &infix:<<∌>>,      '∌',
      &infix:<<⊆>>,      '⊆',
      &infix:<<(<=)>>,   '(<=)',
      &infix:<<⊈>>,      '⊈',
      &infix:<<⊂>>,      '⊂',
      &infix:<<(<)>>,    '(<)',
      &infix:<<⊄>>,      '⊄',
      &infix:<<⊇>>,      '⊇',
      &infix:<<(>=)>>,   '(>=)',
      &infix:<<⊉>>,      '⊉',
      &infix:<<⊃>>,      '⊃',
      &infix:<<(>)>>,    '(>)',
      &infix:<<⊅>>,      '⊅',
      &infix:<<∪>>,      '∪',
      &infix:<<(|)>>,    '(|)',
      &infix:<<∩>>,      '∩',
      &infix:<<(&)>>,    '(&)',
      &infix:<<∖>>,      '∖ ',
      &infix:<<(-)>>,    '(-)',
      &infix:<<⊖>>,      '⊖',
      &infix:<<(^)>>,    '(^)',
      &infix:<<⊍>>,      '⊍',
      &infix:<<(.)>>,    '(.)',
      &infix:<<⊎>>,      '⊎',
      &infix:<<(+)>>,    '(+)',
    ;

    my @types := Set, SetHash, Bag, BagHash, Mix, MixHash;
    plan @ops ÷ 2 × @types;

    for @types -> $type {
        for @ops -> &op, $name {
            lives-ok { op($ = 1, $type) }, "$type.raku() $name";
        }
    }
}

# https://github.com/Raku/old-issue-tracker/issues/6632
# https://github.com/Raku/old-issue-tracker/issues/6633
{
    my %h is Set = <a b c d>;
    is %h.elems, 4, 'did we get right number of elements';
    ok %h<a>, 'do we get a truthy value for a';
    nok %h<e>, 'do we get a falsy value for e';
    is %h.^name, 'Set', 'is the %h really a Set';
    dies-ok { %h = <e f g> }, 'cannot re-initialize Set';
    dies-ok { %h<a>:delete }, 'cannot :delete from Set';
    dies-ok { %h<a> = False }, 'cannot delete from Set by assignment';
}

is +set(.3e0, .1e0+.2e0, 1e0, 1e0+4e-15), 4,
    'Nums that are close to each other remain distinct when put in sets';

# GH#2068
{
    dies-ok { my Int %h := :42foo.Set.Hash },
      'have typechecking on a Hashifeid Set iterator';
}

# R#2289
is-deeply (1,2,3).Set.ACCEPTS(().Set), False, 'can we smartmatch empty';

{
    my $set = <a b c>.Set;
    is-deeply $set.SetHash, <a b c>.SetHash, 'coerce Set -> SetHash';
    is-deeply $set.Bag,     <a b c>.Bag,     'coerce Set -> Bag';
    is-deeply $set.BagHash, <a b c>.BagHash, 'coerce Set -> BagHash';
    is-deeply $set.Mix,     <a b c>.Mix,     'coerce Set -> Mix';
    is-deeply $set.MixHash, <a b c>.MixHash, 'coerce Set -> MixHash';
}

# https://github.com/Raku/old-issue-tracker/issues/6689
{
    my %s is Set[Int] = 1,2,3;
    is-deeply %s.keys.sort, (1,2,3), 'parameterized Set';
    is-deeply %s.keyof, Int, 'did it parameterize ok';

    dies-ok { my %s is Set[Int] = <a b c> }, 'must have Ints';
}

is-deeply Set.Setty, Set, 'multi method Setty(Set:U:) returns a Set type object';

my @a = ["a", "b", "c"];
my @b = [1, 2, 4]; 
is-deeply BagHash.new.STORE(@a, @b), BagHash.new.STORE(@a Z=> @b), 'the two Set:D.STORE candidates create equivalent objects';

# https://github.com/rakudo/rakudo/issues/1862
is <a b c>.Set.item.VAR.^name, 'Scalar', 'does .item work on Sets';

{
    is-deeply Set.of, Bool, 'does Set type object return proper type';
    is-deeply Set.new.of, Bool, 'does Set object return proper type';
}

# vim: expandtab shiftwidth=4
