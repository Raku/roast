use v6;
use Test;
use lib $?FILE.IO.parent(2).add("packages/Test-Helpers");
use Test::Util;

plan 236;

sub showkv($x) {
    $x.keys.sort.map({ $^k ~ ':' ~ $x{$k} }).join(' ')
}

# L<S02/Immutable types/'the mix listop'>

{
    my $m = mix <a foo a a a a b foo>;
    isa-ok $m, Mix, '&mix produces a Mix';
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
    ok ?$m, "Bool returns True if there is something in the Mix";
    nok ?Mix.new(), "Bool returns False if there is nothing in the Mix";

    my $hash;
    lives-ok { $hash = $m.hash }, ".hash doesn't die";
    isa-ok $hash, Hash, "...and it returned a Hash";
    is showkv($hash), 'a:5 b:1 foo:2', '...with the right elements';

    throws-like { $m<a> = 5 },
      X::Assignment::RO,
      "Can't assign to an element (Mixs are immutable)";
    throws-like { $m<a>++ },
      Exception,
      "Can't increment an element (Mixs are immutable)";
    throws-like { $m.keys = <c d> },
      X::Assignment::RO,
      "Can't assign to .keys";
    throws-like { $m.values = 3, 4 },
      X::Assignment::RO,
      "Can't assign to .values";
    throws-like { $m<a>:delete },
      X::Immutable,
      "Can't :delete from Mix";

    is ~$m<a b>, "5 1", 'Multiple-element access';
    is ~$m<a santa b easterbunny>, "5 0 1 0", 'Multiple-element access (with nonexistent elements)';

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
    isa-ok "a".Mix, Mix, "Str.Mix makes a Mix";
    is showkv("a".Mix), 'a:1', "'a'.Mix is mix a";

    isa-ok (a => 100000).Mix, Mix, "Pair.Mix makes a Mix";
    is showkv((a => 100000).Mix), 'a:100000', "(a => 100000).Mix is mix a:100000";
    is showkv((a => 0).Mix), '', "(a => 0).Mix is the empty mix";

    isa-ok <a b c>.Mix, Mix, "<a b c>.Mix makes a Mix";
    is showkv(<a b c a>.Mix), 'a:2 b:1 c:1', "<a b c a>.Mix makes the mix a:2 b:1 c:1";
    is showkv(["a", "b", "c", "a"].Mix), 'a:2 b:1 c:1', "[a b c a].Mix makes the mix a:2 b:1 c:1";
    is showkv([a => 3, b => 0, 'c', 'a'].Mix), 'a:4 c:1', "[a => 3, b => 0, 'c', 'a'].Mix makes the mix a:4 c:1";

    isa-ok {a => 2, b => 4, c => 0}.Mix, Mix, "{a => 2, b => 4, c => 0}.Mix makes a Mix";
    is showkv({a => 2, b => 4, c => 0}.Mix), 'a:2 b:4', "{a => 2, b => 4, c => 0}.Mix makes the mix a:2 b:4";
}

{
    my $m = mix <a a b foo>;
    is $m<a>:exists, True, ':exists with existing element';
    is $m<santa>:exists, False, ':exists with nonexistent element';
    throws-like { $m<a>:delete },
      X::Immutable,
      ':delete does not work on mix';
}

{
    my $m = mix 'a', False, 2, 'a', False, False;
    my @ks = $m.keys;
    is @ks.grep({ .WHAT === Int })[0], 2, 'Int keys are left as Ints';
    is @ks.grep(* eqv False).elems, 1, 'Bool keys are left as Bools';
    is @ks.grep(Str)[0], 'a', 'And Str keys are permitted in the same set';
    is $m{2, 'a', False}.join(' '), '1 2 3', 'All keys have the right values';
}

{
    my %s = mix <a b o p a p o o>;
    is-deeply %s, { :2a, :1b, :2p, :3o }, 'flattens under single arg rule';
    my %m = mix <a b o p>,< a p o o>;
    is-deeply %m, { :2a, :1b, :2p, :3o }, 'also flattens';
}
{
    my %h := mix <a b o p a p o o>;
    ok %h ~~ Mix, 'A hash to which a Mix has been bound becomes a Mix';
    is showkv(%h), 'a:2 b:1 o:3 p:2', '...with the right elements';
}

{
    my $m = mix <a b o p a p o o>;
    isa-ok $m, Mix, '&Mix.new given an array of strings produces a Mix';
    is showkv($m), 'a:2 b:1 o:3 p:2', '...with the right elements';
}

{
    my $m = mix [ foo => 10, bar => 17, baz => 42, santa => 0 ];
    isa-ok $m, Mix, '&Mix.new given an array of pairs produces a Mix';
    is +$m, 4, "... with four elements under the single arg rule";
}
{
    my $m = mix $[ foo => 10, bar => 17, baz => 42, santa => 0 ];
    isa-ok $m, Mix, '&Mix.new given an itemized array of pairs produces a Mix';
    is +$m, 1, "... with one element";
}

{
    # {}.hash interpolates in list context
    my $m = mix { foo => 10, bar => 17, baz => 42, santa => 0 }.hash;
    isa-ok $m, Mix, '&Mix.new given a Hash produces a Mix';
    is +$m, 4, "... with four elements";
    is +$m.grep(Pair), 4, "... which are all Pairs";
}

{
    my $m = mix { foo => 10, bar => 17, baz => 42, santa => 0 };
    isa-ok $m, Mix, '&Mix.new given a Hash produces a Mix';
    is +$m, 4, "... with four elements under the single arg rule";
}
{
    my $m = mix ${ foo => 10, bar => 17, baz => 42, santa => 0 };
    isa-ok $m, Mix, '&Mix.new given an itemized Hash produces a Mix';
    is +$m, 1, "... with one element";
}

{
    my $m = mix set <foo bar foo bar baz foo>;
    isa-ok $m, Mix, '&Mix.new given a Set produces a Mix';
    is +$m, 1, "... with one element";
}

{
    my $m = mix SetHash.new(<foo bar foo bar baz foo>);
    isa-ok $m, Mix, '&Mix.new given a SetHash produces a Mix';
    is +$m, 1, "... with one element";
}

{
    my $m = mix MixHash.new(<foo bar foo bar baz foo>);
    isa-ok $m, Mix, '&Mix.new given a MixHash produces a Mix';
    is +$m, 1, "... with one element";
}

{
    my $m = mix set <foo bar foo bar baz foo>;
    isa-ok $m, Mix, '&mix given a Set produces a Mix';
    is +$m, 1, "... with one element";
}

# L<S02/Names and Variables/'C<%x> may be bound to'>

{
    my %m := mix <a b c b>;
    isa-ok %m, Mix, 'A Mix bound to a %var is a Mix';
    is showkv(%m), 'a:1 b:2 c:1', '...with the right elements';

    is %m<b>, 2, 'Single-key subscript (existing element)';
    is %m<santa>, 0, 'Single-key subscript (nonexistent element)';

    throws-like { %m<a> = 1 },
      X::Assignment::RO,
      "Can't assign to an element (Mixs are immutable)";
    throws-like { %m = mix <a b> },
      X::Assignment::RO,
      "Can't assign to a %var implemented by Mix";
    throws-like { %m<a>:delete },
      X::Immutable,
      "Can't :delete from a Mix";
}

{
    my $m = { foo => 10.1, bar => 1.2, baz => 2.3}.Mix;
    is $m.total, 13.6, 'is the total calculated correctly';

    # .list is just the keys, as per TimToady:
    # http://irclog.perlgeek.de/perl6/2012-02-07#i_5112706
    isa-ok $m.list.elems, 3, ".list returns 3 things";
    is $m.list.grep(Pair).elems, 3, "... all of which are Pairs";

    isa-ok $m.pairs.elems, 3, ".pairs returns 3 things";
    is $m.pairs.grep(Pair).elems, 3, "... all of which are Pairs";
    is $m.pairs.grep({ .key ~~ Str }).elems, 3, "... the keys of which are Strs";
    is $m.pairs.grep({ .value ~~ Real }).elems, 3, "... and the values of which are Reals";
}

{
    my $m = { foo => 10000000000.1, bar => 17.2, baz => 42.3 }.Mix;
    is $m.total, 10000000059.6, 'is the total calculated correctly';
    my $s;
    my $c;
    lives-ok { $s = $m.raku }, ".raku lives";
    isa-ok $s, Str, "... and produces a string";
    ok $s.chars < 1000, "... of reasonable length";
    lives-ok { $c = EVAL $s }, ".raku.EVAL lives";
    isa-ok $c, Mix, "... and produces a Mix";
    is showkv($c), showkv($m), "... and it has the correct values";
}

{
    my $m = { foo => 3.1, bar => -2.2, baz => 1 }.Mix;
    is $m.total, 1.9, 'is the total calculated correctly';
    my $s;
    lives-ok { $s = $m.Str }, ".Str lives";
    isa-ok $s, Str, "... and produces a string";
    is $s.split(" ").sort.join(" "), "bar(-2.2) baz foo(3.1)", "... which only contains bar baz and foo with the proper counts and separated by spaces";
}

{
    my $m = { foo => 10000000000, bar => 17, baz => 42 }.Mix;
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
    my %b := mix "a", "b", "c", "b";
    isa-ok %b, Mix, 'A Mix bound to a %var is a Mix';
    is showkv(%b), 'a:1 b:2 c:1', '...with the right elements';

    is %b<b>, 2, 'Single-key subscript (existing element)';
    is %b<santa>, 0, 'Single-key subscript (nonexistent element)';
}

# L<S32::Containers/Mix/roll>

{
    my $m = Mix.new("a", "b", "b");

    my $a = $m.roll;
    ok $a eq "a" || $a eq "b", "We got one of the two choices";

    isa-ok $m.roll, Str, ".roll with no arguments returns a key of the Mix";
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
    is $m.total, 1, '.roll should not change Mix';
}

# L<S32::Containers/Mix/pick>

{
    my $m = Mix.new("a", "b", "b");
    throws-like { $m.pick },
      Exception,
      '.pick does not work on Mix';
}

# L<S32::Containers/Mix/grab>

{
    my $m = mix <a b b c c c>;
    throws-like { $m.grab },
      X::Immutable,
      'cannot call .grab on a Mix';
}

# L<S32::Containers/Mix/grabpairs>

{
    my $m = mix <a b b c c c>;
    throws-like { $m.grabpairs },
      X::Immutable,
      'cannot call .grabpairs on a Mix';
}

{
    my $m1 = Mix.new(( mix <a b c> ), <c c c d d d d>);
    is +$m1, 2, "Two elements";
    my $inner-mix = $m1.keys.first(Mix);
    isa-ok $inner-mix, Mix, "One of the mix's elements is indeed a Mix!";
    is showkv($inner-mix), "a:1 b:1 c:1", "With the proper elements";
    my $inner-list = $m1.keys.first(List);
    isa-ok $inner-list, List, "One of the mix's elements is indeed a List!";
    is $inner-list, <c c c d d d d>, "With the proper elements";

    my $m = mix <a b c>;
    $m1 = Mix.new($m, <c d>);
    is +$m1, 2, "Two elements";
    $inner-mix = $m1.keys.first(Mix);
    isa-ok $inner-mix, Mix, "One of the mix's elements is indeed a mix!";
    is showkv($inner-mix), "a:1 b:1 c:1", "With the proper elements";
    $inner-list = $m1.keys.first(List);
    isa-ok $inner-list, List, "One of the mix's elements is indeed a List!";
    is $inner-list, <c d>, "With the proper elements";
}

{
    isa-ok 42.Mix, Mix, "Method .Mix works on Int-1";
    is showkv(42.Mix), "42:1", "Method .Mix works on Int-2";
    isa-ok "blue".Mix, Mix, "Method .Mix works on Str-1";
    is showkv("blue".Mix), "blue:1", "Method .Mix works on Str-2";
    my @a = <Now the cross-handed set was the Paradise way>;
    isa-ok @a.Mix, Mix, "Method .Mix works on Array-1";
    is showkv(@a.Mix), "Now:1 Paradise:1 cross-handed:1 set:1 the:2 was:1 way:1", "Method .Mix works on Array-2";
    my %x = "a" => 1, "b" => 2;
    isa-ok %x.Mix, Mix, "Method .Mix works on Hash-1";
    is showkv(%x.Mix), "a:1 b:2", "Method .Mix works on Hash-2";
    isa-ok (@a, %x).Mix, Mix, "Method .Mix works on List-1";
    is showkv((@a, %x).Mix), "Now:1 Paradise:1 a:1 b:2 cross-handed:1 set:1 the:2 was:1 way:1",
       "Method .Mix works on List-2";
}

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
    is-deeply Mix[Str].new( <a b c> ).keys.sort.List, <a b c>,
      'can we parameterize for strings?';
    ok Mix[Str].keyof =:= Str, 'does .keyof return the correct type';
    throws-like { Mix[Int].new( <a b c> ) }, X::TypeCheck::Binding,
      'do wrong values make initialization croak';
}

# https://github.com/Raku/old-issue-tracker/issues/3805
isnt
  '91D95D6EDD0F0C61D02A2989781C5AEB10832C94'.Mix.WHICH,
  <a b c>.Mix.WHICH,
  'Faulty .WHICH creation';

{
    my $m = <a>.Mix;
    throws-like { $m<a> = 42.1 },
      X::Assignment::RO,
      'Make sure we cannot assign on a key';

    throws-like { $_ = 666.1 for $m.values },
      Exception,  # X::Assignment::RO  ???
      'Make sure we cannot assign on a .values alias';

    throws-like { .value = 999.1 for $m.pairs },
      X::Assignment::RO,
      'Make sure we cannot assign on a .pairs alias';

    throws-like { for $m.kv -> \k, \v { v = 22.1 } },
      X::Assignment::RO,
      'Make sure we cannot assign on a .kv alias';
}

{
    my $m = (a=>1.1, b=>2.2, c=>3.3, d=> 4.4).Mix;
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
    plan 3;
    is Mix.new($(<a b>)).hash.keys[0][0], 'a', 'Mix.new';
    is ($(<a b>),).Mix.hash.keys[0][0],   'a', '.Mix';
    is mix($(<a b>)).hash.keys[0][0],     'a', 'mix()';
}

{ # coverage; 2016-10-13
    my $m = Mix.new-from-pairs: 'sugar' => .2, 'flour' => 2.7,
        'sugar' => 1.1, 'cyanide' => 0;

    is-deeply $m.Bag, Bag.new(<sugar flour flour>), '.Bag coercer';
    is-deeply $m.BagHash, BagHash.new(<sugar flour flour>),
        '.BagHash coercer';

    my $code = ｢my $m = Mix.new-from-pairs('a' => -20, 'b' => 1.5);｣
        ~ ｢my $a = $m.Bag; my $b = $m.BagHash｣;
    is_run $code, { :err(''), :out(""), :0status },
        'negative Mix weights removed from Bag coercion without warnings';
}

{
    throws-like { my Mix $m; $m<as> = 2 }, Exception,
        'autovivification of of Mix:U complains about immutability';
}

{ # https://irclog.perlgeek.de/perl6-dev/2016-11-07#i_13528982
    my $a = (:a(-10), :b(-30)                 ).Mix;
    my $b = (         :b(-20), :c(-10), :d(10)).Mix;
    my $r = (:a(-10), :b(-20), :c(-10), :d(10)).Mix;
    is-deeply $a  ∪  $b, $r, 'negative weights remain with  ∪  operator';
    is-deeply $a (|) $b, $r, 'negative weights remain with (|) operator';
}

{
    ok ().Mix  =:= mix(), '().Mix returns the empty mix';
}

{
    throws-like { ^Inf .Mix }, X::Cannot::Lazy, :what<Mix>;
    throws-like { Mix.new-from-pairs(^Inf) }, X::Cannot::Lazy, :what<Mix>;
    throws-like { Mix.new(^Inf) }, X::Cannot::Lazy, :what<Mix>;

    for a=>"a", a=>Inf, a=>-Inf, a=>NaN, a=>3i -> $pair {
      my \ex := $pair.value ~~ Complex
          ?? X::Numeric::Real !! $pair.value eq 'a'
          ?? X::Str::Numeric  !! X::OutOfRange;
      throws-like { $pair.Mix }, ex,
        "($pair.raku()).Mix throws";
      throws-like { Mix.new-from-pairs($pair) }, ex,
        "Mix.new-from-pairs( ($pair.raku()) ) throws";
    }
}

# https://github.com/Raku/old-issue-tracker/issues/6343
{
    is-deeply (a => -1, a => 1).Mix,      mix(),
      'final value 0 disappears in Mix for empty mix';
    is-deeply (a => -1, a => 1, "b").Mix, Mix.new("b"),
      'final value 0 disappears in Mix';
}

# https://github.com/Raku/old-issue-tracker/issues/6430
#?rakudo.jvm todo 'got: Nil'
{
    is-deeply (a => ½).Mix    .roll, 'a', 'Mix.roll with fractional weights';
    is-deeply (a => ½).MixHash.roll, 'a', 'MixHash.roll with fractional weights';
}

# https://github.com/Raku/old-issue-tracker/issues/6632
# https://github.com/Raku/old-issue-tracker/issues/6633
{
    my %h is Mix = <a b b c c c d d d d>;
    is %h.elems, 4, 'did we get right number of elements';
    is %h<a>, 1, 'do we get 1 for a';
    is %h<e>, 0, 'do we get 0 for e';
    is %h.^name, 'Mix', 'is the %h really a Mix';
    dies-ok { %h = <e f g> }, 'cannot re-initialize Mix';
    dies-ok { %h<a>:delete }, 'cannot :delete from Mix';
    dies-ok { %h<a> = False }, 'cannot delete from Mix by assignment';
}

# https://github.com/rakudo/rakudo/issues/2289
is-deeply (1,2,3).Mix.ACCEPTS(().Mix), False, 'can we smartmatch empty';

{
    my $mix = <a b c>.Mix;
    is-deeply $mix.Set,     <a b c>.Set,     'coerce Mix -> Set';
    is-deeply $mix.SetHash, <a b c>.SetHash, 'coerce Mix -> SetHash';
    is-deeply $mix.Bag,     <a b c>.Bag,     'coerce Mix -> Bag';
    is-deeply $mix.BagHash, <a b c>.BagHash, 'coerce Mix -> BagHash';
    is-deeply $mix.MixHash, <a b c>.MixHash, 'coerce Mix -> MixHash';
}

# https://github.com/Raku/old-issue-tracker/issues/6689
{
    my %m is Mix[Int] = 1,2,3;
    is-deeply %m.keys.sort, (1,2,3), 'parameterized Mix';
    is-deeply %m.keyof, Int, 'did it parameterize ok';

    dies-ok { my %m is Mix[Int] = <a b c> }, 'must have Ints on creation';
}

# https://github.com/rakudo/rakudo/issues/1862
lives-ok { <a b c>.Mix.item = 42 }, 'does .item work on Mixes';

# vim: expandtab shiftwidth=4
