use v6;

use Test;

plan 4 * 19 + 105;

# L<S02/Mutable types/A single key-to-value association>
# basic Pair

for
  foo => "bar",                     'fat-comma',
  Pair.new(:key<foo>, :value<bar>), 'Pair.new(:key,:value)',
  Pair.new("foo", "bar"),           'Pair.new(key,value)',
  pair("foo","bar"),                'pair()'
-> $pair, $type {
    diag "checking $type";
    isa-ok($pair, Pair);

# get key and value from the pair as many ways as possible

    is(key($pair:), 'foo', 'got the right key($pair:)');
    is(value($pair:), 'bar', 'got the right value($pair:)');

    is($pair.key(), 'foo', 'got the right $pair.key()');
    is($pair.value(), 'bar', 'got the right $pair.value()');

    is($pair.key, 'foo', 'got the right $pair.key');
    is($pair.value, 'bar', 'got the right $pair.value');

# get both (kv) as many ways as possible

    my @pair1a = kv($pair);
    is(+@pair1a, 2, 'got the right number of elements in the list');
    is(@pair1a[0], 'foo', 'got the right key');
    is(@pair1a[1], 'bar', 'got the right value');

    my @pair1b = kv $pair;
    is(+@pair1b, 2, 'got the right number of elements in the list');
    is(@pair1b[0], 'foo', 'got the right key');
    is(@pair1b[1], 'bar', 'got the right value');

    my @pair1c = $pair.kv;
    is(+@pair1c, 2, 'got the right number of elements in the list');
    is(@pair1c[0], 'foo', 'got the right key');
    is(@pair1c[1], 'bar', 'got the right value');

    my @pair1d = $pair.kv();
    is(+@pair1d, 2, 'got the right number of elements in the list');
    is(@pair1d[0], 'foo', 'got the right key');
    is(@pair1d[1], 'bar', 'got the right value');
} #19

# Pair with a numeric value

my $pair2 = 'foo' => 2;
isa-ok($pair2, Pair);

is($pair2.value, 2, 'got the right value');

# Pair with a Pair value

my $pair3 = "foo" => ("bar" => "baz");
isa-ok($pair3, Pair);

my $pair3a = $pair3.value;
isa-ok($pair3a, Pair);
is($pair3a.key, 'bar', 'got right nested pair key');
is($pair3a.value, 'baz', 'got right nested pair key');

is($pair3.value.key, 'bar', 'got right nested pair key (method chaining)');
is($pair3.value.value, 'baz', 'got right nested pair key (method chaining)');

# Pair with a Pair key

my $pair4 = ("foo" => "bar") => "baz";
isa-ok($pair4, Pair);

is($pair4.value, 'baz', 'got the right value');

isa-ok($pair4.key, Pair);
is($pair4.key.key, 'foo', 'got right nested key');
is($pair4.key.value, 'bar', 'got right nested value');

my $quux = (quux => "xyzzy");
is($quux.key, 'quux', "lhs quotes" );

{
    my $pair = :when<now>;
    #?rakudo todo 'should it really have \n on the end?'
    is ~(%($pair)), "when\tnow\n", 'hash stringification';
    # hold back this one according to audreyt
    #ok $pair.does(Hash), 'Pair does Hash';
    ok (%($pair) ~~ Hash), '%() makes creates a real Hash';
}

# colonpair syntax
{
    is(:foo.key, 'foo', 'got the right key :foo.key');
    isa-ok(:foo.value, Bool, ':foo.value isa Bool');
    ok( (:foo), ':foo is True');
    ok( :foo.value, ':foo.value is True');
    is(:!foo.key, 'foo', 'got the right key :!foo.key');
    isa-ok(:!foo.value, Bool, ':!foo.value isa Bool');
    nok( :!foo.value, ':!foo.value is False');
}

# illustrate a bug

{
    my $var   = 'foo' => 'bar';
    sub test1 (Pair $pair) {
        isa-ok($pair,Pair);
        my $testpair = $pair;
        isa-ok($testpair,Pair); # new lvalue variable is also a Pair
        my $boundpair := $pair;
        isa-ok($boundpair,Pair); # bound variable is also a Pair
        is($pair.key, 'foo', 'in sub test1 got the right $pair.key');
        is($pair.value, 'bar', 'in sub test1 got the right $pair.value');

    }
    test1 $var;
}

my %hash  = ('foo' => 'bar');

{
    for  %hash.pairs -> $pair {
        isa-ok($pair,Pair) ;
        my $testpair = $pair;
        isa-ok($testpair, Pair); # new lvalue variable is also a Pair
        my $boundpair := $pair;
        isa-ok($boundpair,Pair); # bound variable is also a Pair
        is($pair.key, 'foo', 'in for loop got the right $pair.key');
        is($pair.value, 'bar', 'in for loop got the right $pair.value');
    }
}

sub test2 (%h){
    for %h.pairs -> $pair {
        isa-ok($pair,Pair) ;
        is($pair.key, 'foo', 'in sub test2 got the right $pair.key');
        is($pair.value, 'bar', 'in sub test2 got the right $pair.value');
    }
}
test2 %hash;

# See thread "$pair[0]" on p6l started by Ingo Blechschmidt:
# L<"http://www.nntp.perl.org/group/perl.perl6.language/22593">

sub test3 (%h){
    for %h.pairs -> $pair {
        isa-ok($pair,Pair);
        isa-ok($pair[0], Pair, 'sub test3: $pair[0] is $pair');
        ok $pair[1] ~~ Failure, 'sub test3: $pair[1] is failure';
    }
}
test3 %hash;

=begin p6l

Hm, Hash::pair? Never heard of that.  --iblech

sub test4 (%h){
    for %h.pair -> $pair {
        isa-ok($pair,Pair);
        is($pair.key, 'foo', 'sub test4: access by unspecced "pair" got the right $pair.key');
        is($pair.value, 'bar', 'sub test4: access by unspecced "pair" got the right $pair.value');

    }
}
test4 %hash;

=end p6l

my $should_be_a_pair = (a => 25/1);
isa-ok $should_be_a_pair, Pair, "=> has correct precedence";

=begin discussion

Stated by Larry on p6l in:
L<"http://www.nntp.perl.org/group/perl.perl6.language/20122">

 "Oh, and we recently moved => to assignment precedence so it would
 more naturally be right associative, and to keep the non-chaining
 binaries consistently non-associative.  Also lets you say:

   key => $x ?? $y !! $z;

 plus it moves it closer to the comma that it used to be in Perl."

(iblech) XXX: this contradicts current S03 so I could be wrong.

Note, "non-chaining binary" was later renamed to "structural infix".

=end discussion

{
  # This should always work.
  my %x = ( "Zaphod" => (0 ?? 1 !! 2), "Ford" => 42 );
  is %x{"Zaphod"}, 2, "Zaphod is 2";
  is %x{"Ford"},  42, "Ford is 42";

  # This should work only if => is lower precedence than ?? !!
  my %z = ( "Zaphod" => 0 ?? 1 !! 2, "Ford" => 42 );
  is %z{"Zaphod"}, 2, "Zaphod is still 2";
  is %z{"Ford"},  42, "Ford is still 42";
}

# This is per the pairs-behave-like-one-element-hashes-rule.
# (I asked p6l once, but the "thread" got warnocked.  --iblech)
# (I asked p6l again, now the thread did definitely not get warnocked:
# L<"http://groups.google.de/group/perl.perl6.language/browse_thread/thread/e0e44be94bd31792/6de6667398a4d2c7?q=perl6.language+Stringification+pairs&">
# Also see L<"http://www.nntp.perl.org/group/perl.perl6.language/23224">
{
  my $pair = (a => 1);
  is ~$pair, "a\t1", "pairs stringify correctly (1)";
  is "$pair", "a\t1", "pairs stringify correctly (2)";
}

{
  my $pair = (a => [1,2,3]);
  is ~$pair, "a\t1 2 3", "pairs with arrayrefs as values stringify correctly (1)";
  is "$pair", "a\t1 2 3", "pairs with arrayrefs as values stringify correctly (2)";
}

# Per Larry L<"http://www.nntp.perl.org/group/perl.perl6.language/23525">:
#   Actually, it looks like the bug is probably that => is forcing
#   stringification on its left argument too agressively.  It should only do
#   that for an identifier.
{
  my $arrayref = [< a b c >];
  my $hashref  = { :d(1), :e(2) };

  my $pair = ($arrayref => $hashref);
  is ~$pair.key,   ~$arrayref, "=> should not stringify the key (1)";
  is ~$pair.value, ~$hashref,  "=> should not stringify the key (2)";

  push $pair.key, "d";
  $pair.value<f> = 3;
  is ~$pair.key,   ~$arrayref, "=> should not stringify the key (3)";
  is ~$pair.value, ~$hashref,  "=> should not stringify the key (4)";
  is +$pair.key,            4, "=> should not stringify the key (5)";
  is +$pair.value,          3, "=> should not stringify the key (6)";
}

{
  my $arrayref = [< a b c >];
  my $hashref  = { :d(1), :e(2) };

  my $pair = ($arrayref => $hashref);
  sub pair_key (Pair $pair) { $pair.key }

  is ~pair_key($pair), ~$arrayref,
    "the keys of pairs should not get auto-stringified when passed to a sub (1)";

  push $pair.key, "d";
  is ~pair_key($pair), ~$arrayref,
    "the keys of pairs should not get auto-stringified when passed to a sub (2)";
  is +pair_key($pair),          4,
    "the keys of pairs should not get auto-stringified when passed to a sub (3)";
}

# Per S02:1704
{
  my ($key, $val) = <key val>;
  my $pair        = ($key => $val);

  throws-like { $pair.key = "KEY" },
    X::Assignment::RO,
    "setting .key dies";
  is $pair.key,         "key",   "attempt to set .key doesn't change the key";
  is $key,              "key",   "attempt to set .key does not change the original var either";

  lives-ok { $pair.value = "VAL" }, "setting .value does not die";
  is $pair.value,          "VAL",   "setting .value actually changes the value";
  is $val,                 "VAL",   "setting .value does change the original var as it was itemized";
}

##  These tests really belong in a different test file -- probably
##  something in S06.  --pmichaud
# L<S06/Named arguments/In other words :$when is shorthand for :when($when)>
#
{
    my $item = 'bar';
    my $pair = (:$item);
    ok($pair eqv (item => $item), ':$foo syntax works');

    my @arr  = <a b c d e f>;
    $pair = (:@arr);
    ok($pair eqv (arr => @arr), ':@foo syntax works');

    my %hash = foo => 'bar', baz => 'qux';
    $pair = (:%hash);
    ok($pair eqv (hash => %hash), ':%foo syntax works');
}

{
    my sub code {return 42}
    my $pair = (:&code);
    ok($pair eqv (code => &code), ':&foo syntax works');
}

# RT #67218
{
    eval-lives-ok ':a()',    'can parse ":a()"';
    lives-ok     {; :a() }, 'can execute ":a()"';

    eval-lives-ok ':a[]',    'can parse ":a[]"';
    lives-ok     {; :a[] }, 'can execute ":a[]"';

    eval-lives-ok '(a => ())',    'can parse "(a => ())"';
    lives-ok     { (a => ()) }, 'can execute "(a => ())"';

    eval-lives-ok '(a => [])',    'can parse "(a => [])"';
    lives-ok     { (a => []) }, 'can execute "(a => [])"';
}

{
    is (a => 3).antipair.key, 3, 'Pair.antipair.key';
    isa-ok (a => 3).antipair.key, Int, 'Pair.antipair.key type';
    is (a => 3).antipair.value, 'a', 'Pair.antipair.value';
}

{
    is (a => [3,4]).invert.elems, 2, 'Pair.invert splits positional values';
    is (a => [3,4]).invert».key, '3 4', 'Pair.invert splits positional values and preserves order';
    isa-ok (a => [3,4]).invert[0].key, Int, 'Pair.invert.key type';
    is (a => [3,4]).invert».value, 'a a', 'Pair.invert splits positional values and dups keys';

    is ~<a b c>.pairs.invert.map({ .key ~ '|' ~ .value}),
        'a|0 b|1 c|2', 'list of array pairs can be inverted';
    is { a => (1,2), b => <x y z> }.pairs.invert.sort.gist, '(1 => a 2 => a x => b y => b z => b)', 'list of hash pairs can be inverted';
}

# RT #123215
{
    cmp-ok (:a(2) :b(3) :c(4)), "eqv", ( a => 2, b => 3, c => 4 ),
        "chained colonpairs in parens build a list of pairs";
    cmp-ok {:a(2) :b(3) :c(4)}<a b c>, "eqv", ( 2, 3, 4 ),
        "chained colonpairs in curlies construct hashes with more than one element";
}

{
    is ((Nil) => Nil).gist, 'Nil => Nil', "both key and value can convey a raw Nil";
    is ((Mu) => Mu).gist, '(Mu) => (Mu)', "both key and value can convey a Mu type";
    is ((Any) => Any).gist, '(Any) => (Any)', "both key and value can convey an Any type";
    is ((Junction) => Junction).gist, '(Junction) => (Junction)', "both key and value can convey a Junction type";
    is ((1|2|3) => 1&2&3).gist, 'any(1, 2, 3) => all(1, 2, 3)', "both key and value can convey a Junction object";
}

{
    my $p = Pair.new("foo",my Int $);
    isa-ok $p.value, Int;
    is ($p.value = 42), 42, 'can assign integer value and return that';
    is $p.value, 42, 'the expected Int value was set';
    throws-like { $p.value = "bar" },
      X::TypeCheck::Assignment,
      'cannot assign a Str to an Int';
}

# RT #126369
{
    my $y = 42;
    $y := :$y;
    is-deeply $y, 'y' => 42, 'pair binding';
}

# RT #128860
{
    throws-like { (1,2,3).invert },
	X::TypeCheck, got => Int, expected => Pair,
	"List.invert maps via a required Pair binding";
}

# https://irclog.perlgeek.de/perl6-dev/2017-01-23#i_13971002
is-deeply (:42a)<foo>, Nil, 'accessing non-existent key on a Pair returns Nil';

{
    my $p = :foo<bar>;
    cmp-ok   $p.Pair, '===', $p,   '.Pair on Pair:D is identity';
    cmp-ok Pair.Pair, '===', Pair, '.Pair on Pair:U is identity';
}

subtest 'Pair.ACCEPTS' => {
    my @true = <a a a z>.Bag, <a a a z>.BagHash, <a a a z z>.Mix,
        <a a a z z>.MixHash, %(:3a, :5z), Map.new((:3a, :5z)), :3a.Pair, :3z.Pair;
    my @false = <a z>.Bag, <a z>.BagHash, <a z>.Set, <a z>.SetHash,
        <a z>.Mix, <a z>.MixHash, %(:a, :z), Map.new((:a, :z)), :a.Pair, :z.Pair;
    plan 6 + @true + @false;
    my $p = :3a;
    is-deeply $p.ACCEPTS($_), True,  "{.perl} (True)"  for @true;
    is-deeply $p.ACCEPTS($_), False, "{.perl} (False)" for @false;
    is-deeply :a.Pair.ACCEPTS(<a z>.Set    ), True, 'Set (True)';
    is-deeply :a.Pair.ACCEPTS(<a z>.SetHash), True, 'SetHash (True)';

    class Foo { method foo { 42 }; method bar { False } }
    is-deeply :42foo.ACCEPTS(Foo), True,  'custom class (True, 1)';
    is-deeply :foo  .ACCEPTS(Foo), True,  'custom class (True, 2)';
    is-deeply :!bar .ACCEPTS(Foo), True,  'custom class (True, 3)';
    is-deeply :bar  .ACCEPTS(Foo), False, 'custom class (False)';
}

subtest 'Pair.invert' => {
    my @tests = [ a  => 42, (42 => 'a',).Seq ], [ 42 => 70, (70 => 42, ).Seq ],
        [ foo => (bar => meow => 42), ((bar => meow => 42) => 'foo',).Seq    ],
        [ # .invert expands Iterables
            <a b c> => <d e f>,
            (:d(<a b c>), :e(<a b c>), :f(<a b c>)).Seq,
        ],;

    plan 3 + @tests;
    is-deeply .[0].invert, .[1], .[0].perl for @tests;


    # Hashes are also Iterables, but don't guarantee order here:
    is-deeply (%(<a b c d>) => %(<e f g h>)).invert.sort,
      (:e<f> => %(<a b c d>), :g<h> => %(<a b c d>)).Seq.sort,
      (%(<a b c d>) => %(<e f g h>)).perl;

    subtest '(Any) => (Mu)' => {
        plan 4;
        given ((Any) => (Mu)).invert {
            .cache;
            isa-ok $_, Seq,      "return's type";
            is-deeply .elems, 1, "return's number of elements";
            is .[0].key,   Mu,   '.key';
            is .[0].value, Any,  '.value';
        }
    }

    subtest '(Mu) => (Any)' => {
        plan 4;
        given ((Mu) => (Any)).invert {
            .cache;
            isa-ok $_, Seq,      "return's type";
            is-deeply .elems, 1, "return's number of elements";
            is .[0].key,   Any,  '.key';
            is .[0].value, Mu,   '.value';
        }
    }
}

# https://irclog.perlgeek.de/perl6-dev/2017-06-15#i_14734597
subtest 'Pair.perl with type objects' => {
  plan 5;
  cmp-ok Pair.new('foo', Bool).perl.EVAL, &[!eqv], :!foo.Pair,
      'roundtrip of Bool:U .value does not eqv :!foo';

  is-deeply .perl.EVAL, $_, .perl for Pair.new(Str, Str),
      Pair.new(Rat, Num), Pair.new(Bool, Bool), Pair.new(Numeric, Numeric)
}

# https://github.com/rakudo/rakudo/commit/5031dab3ac
subtest 'Clone of Pair does not share .WHICH' => {
    plan 2;
    my $v = 100;
    (my $p := foo => $v).WHICH;
    my $clone := $p.clone;
    cmp-ok $clone.WHICH, &[!===], $p.WHICH, 'clone, same value';
    $v = 200;
    cmp-ok $clone.WHICH, &[!===], $p.WHICH, 'clone, different value';
}

# https://github.com/rakudo/rakudo/issues/1500
{
    my Pair $p;
    is-deeply ($p .= new :key<foo> :value<bar>), :foo<bar>.Pair,
        'fake-infix adverbs (named args) on a construct inside args to another routine';
}

# vim: ft=perl6
