use v6;

use Test;

plan 106;

# L<S02/Mutable types/A single key-to-value association>
# basic Pair

my $pair = 'foo' => 'bar';
isa_ok($pair, Pair);

# get key and value from the pair as many ways as possible

#?niecza 2 skip 'Invocant handling is NYI'
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

# Pair with a numeric value

my $pair2 = 'foo' => 2;
isa_ok($pair2, Pair);

is($pair2.value, 2, 'got the right value');

# Pair with a Pair value

my $pair3 = "foo" => ("bar" => "baz");
isa_ok($pair3, Pair);

my $pair3a = $pair3.value;
isa_ok($pair3a, Pair);
is($pair3a.key, 'bar', 'got right nested pair key');
is($pair3a.value, 'baz', 'got right nested pair key');

is($pair3.value.key, 'bar', 'got right nested pair key (method chaining)');
is($pair3.value.value, 'baz', 'got right nested pair key (method chaining)');

# Pair with a Pair key

my $pair4 = ("foo" => "bar") => "baz";
isa_ok($pair4, Pair);

is($pair4.value, 'baz', 'got the right value');

isa_ok($pair4.key, Pair);
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
    isa_ok(:foo.value, Bool, ':foo.value isa Bool');
    ok( (:foo), ':foo is True');
    ok( :foo.value, ':foo.value is True');
    is(:!foo.key, 'foo', 'got the right key :!foo.key');
    isa_ok(:!foo.value, Bool, ':!foo.value isa Bool');
    nok( :!foo.value, ':!foo.value is False');
}

# illustrate a bug

{
    my $var   = 'foo' => 'bar';
    sub test1 (Pair $pair) {
        isa_ok($pair,Pair);
        my $testpair = $pair;
        isa_ok($testpair,Pair); # new lvalue variable is also a Pair
        my $boundpair := $pair;
        isa_ok($boundpair,Pair); # bound variable is also a Pair
        is($pair.key, 'foo', 'in sub test1 got the right $pair.key');
        is($pair.value, 'bar', 'in sub test1 got the right $pair.value');

    }
    test1 $var;
}

my %hash  = ('foo' => 'bar');

{
    for  %hash.pairs -> $pair {
        isa_ok($pair,Pair) ;
        my $testpair = $pair;
        isa_ok($testpair, Pair); # new lvalue variable is also a Pair
        my $boundpair := $pair;
        isa_ok($boundpair,Pair); # bound variable is also a Pair
        is($pair.key, 'foo', 'in for loop got the right $pair.key');
        is($pair.value, 'bar', 'in for loop got the right $pair.value');
    }
}

sub test2 (%h){
    for %h.pairs -> $pair {
        isa_ok($pair,Pair) ;
        is($pair.key, 'foo', 'in sub test2 got the right $pair.key');
        is($pair.value, 'bar', 'in sub test2 got the right $pair.value');
    }
}
test2 %hash;

# See thread "$pair[0]" on p6l started by Ingo Blechschmidt:
# L<"http://www.nntp.perl.org/group/perl.perl6.language/22593">

sub test3 (%h){
    for %h.pairs -> $pair {
        isa_ok($pair,Pair);
        isa_ok($pair[0], Pair, 'sub test3: $pair[0] is $pair');
        #?niecza skip "Failure NYI"
        ok $pair[1] ~~ Failure, 'sub test3: $pair[1] is failure';
    }
}
test3 %hash;

=begin p6l

Hm, Hash::pair? Never heard of that.  --iblech

sub test4 (%h){
    for %h.pair -> $pair {
        isa_ok($pair,Pair);
        is($pair.key, 'foo', 'sub test4: access by unspecced "pair" got the right $pair.key');
        is($pair.value, 'bar', 'sub test4: access by unspecced "pair" got the right $pair.value');

    }
}
test4 %hash;

=end p6l

my $should_be_a_pair = (a => 25/1);
isa_ok $should_be_a_pair, Pair, "=> has correct precedence";

=begin discussion

Stated by Larry on p6l in:
L<"http://www.nntp.perl.org/group/perl.perl6.language/20122">

 "Oh, and we recently moved => to assignment precedence so it would
 more naturally be right associative, and to keep the non-chaining
 binaries consistently non-associative.  Also lets you say:

   key => $x ?? $y !! $z;

 plus it moves it closer to the comma that it used to be in Perl 5."

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

  #?rakudo.parrot todo "?"
  #?rakudo.jvm    todo "?"
  throws_like { $pair.key = "KEY" },
    X::Assignment::RO,
    "setting .key dies";
  is $pair.key,         "key",   "attempt to set .key doesn't change the key";
  #?niecza todo "setting .key changes original val!"
  is $key,              "key",   "attempt to set .key does not change the original var either";

  lives_ok { $pair.value = "VAL" }, "setting .value does not die";
  is $pair.value,          "VAL",   "setting .value actually changes the value";
  #?niecza todo "setting .key changes original val!"
  is $val,                 "val",   "setting .value does not change the original var";
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

#?niecza skip "eqv NYI for Pair"
{
    my sub code {return 42}
    $pair = (:&code);
    ok($pair eqv (code => &code), ':&foo syntax works');
}

# RT #67218
{
    eval_lives_ok ':a()',    'can parse ":a()"';
    lives_ok     {; :a() }, 'can execute ":a()"';

    eval_lives_ok ':a[]',    'can parse ":a[]"';
    lives_ok     {; :a[] }, 'can execute ":a[]"';

    eval_lives_ok '(a => ())',    'can parse "(a => ())"';
    lives_ok     { (a => ()) }, 'can execute "(a => ())"';

    eval_lives_ok '(a => [])',    'can parse "(a => [])"';
    lives_ok     { (a => []) }, 'can execute "(a => [])"';
}

{
    is (a => 3).antipair.key, 3, 'Pair.antipair.key';
    isa_ok (a => 3).antipair.key, Int, 'Pair.antipair.key type';
    is (a => 3).antipair.value, 'a', 'Pair.antipair.value';
}

{
    is (a => 3).invert[0].key, 3, 'Pair.invert.key';
    isa_ok (a => 3).invert[0].key, Int, 'Pair.invert.key type';
    is (a => 3).invert[0].value, 'a', 'Pair.invert.value';
}

{
    is (a => [3,4]).invert.elems, 2, 'Pair.invert splits positional values';
    is (a => [3,4]).invert».key, '3 4', 'Pair.invert splits positional values and preserves order';
    isa_ok (a => [3,4]).invert[0].key, Int, 'Pair.invert.key type';
    is (a => [3,4]).invert».value, 'a a', 'Pair.invert splits positional values and dups keys';
}

# RT #123215
#?rakudo.parrot skip 'RT #123215'
#?rakudo.jvm todo 'RT #123215'
{
    cmp_ok (:a(2) :b(3) :c(4)), "eqv", ( a => 2, b => 3, c => 4 ),
        "chained colonpairs in parens build a list of pairs";
    cmp_ok {:a(2) :b(3) :c(4)}<a b c>, "eqv", ( 2, 3, 4 ),
        "chained colonpairs in curlies construct hashes with more than one element";
}

# vim: ft=perl6
