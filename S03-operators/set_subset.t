use v6;
use Test;

# This test file tests the following set operators:
#   (<=)  is a subset of (Texas)
#   ⊆     is a subset of
#   ⊈     is NOT a subset of
#   (>=)  is a superset of (Texas)
#   ⊇     is a superset of
#   ⊉     is NOT a superset of

# things we need to check being a subset of
my $s    = <a b c d e>.Set;
my $sh   = <A B C D E>.SetHash;
my $b    = <a b b c c c d d d d e e e e e>.Bag;
my $bh   = <A B B C C C D D D D E E E E E>.BagHash;
my $m    = (about => pi, before => e).Mix;
my $mh   = (cure => tau, dosage => 42).MixHash;
my $map  = (effective => 42, factual => 666).Map;
my $hash = (global => 77, 999 => "happiness").Hash;
my $objh = Hash[Any,Any].new((ideas => 56, 13 => "jocular"));
my $list = <the quick brown fox>;
my @sse =

# simple cases that where left should be subset of right
  <d c e>.Set,             $s,
  <E D C>.Set,             $sh,
  <c b c>.Bag,             $b,
  <B B C>.BagHash,         $bh,
  (about => e).Mix,        $m,
  (dosage => tau).MixHash, $mh,
  "factual",               $map,
  "global",                $hash,
  "ideas",                 $objh,
  "quick",                 $list,

# more specific cases where left should be subset of right
  <a b>.Set,      <a b b c>.Bag,    # .Bag -> .Set
  <a b b>.Bag,    <a b c>.Set,      # .Bag -> .Set
  <a b>.Set,      <a b b c>.Mix,    # .Mix -> .Set
  <a b b>.Mix,    <a b c>.Set,      # .Mix -> .Set
  <a b>.Bag,      <a b b c>.Mix,    # .Bag -> .Mix
  <a b>.Mix,      <a b b c>.Bag,    # .Bag -> .Mix

# negatives in Mix
  (a => -1).Mix,  (a => -1).Mix,  # value not important
  (a => -2).Mix,  (a => -1).Mix,  # value not important
  (a => -1).Mix,  (a => -2).Mix,  # value not important
  mix(),          (a => -1).Mix,  # value not important

# empties always subset of not-empties
  set(),          <a>.Set,
  bag(),          <a>.Bag,
  mix(),          <a>.Mix,

# coercions of Maps
  {},             {},
  {},             {a=>0},
  {a=>0},         {},
  {a=>1},         {a=>1},
  {},             :{},
  {},             :{a=>0},
  {a=>0},         :{},
  {a=>1},         :{a=>1},
  :{},            {},
  :{},            {a=>0},
  :{a=>0},        {},
  :{a=>1},        {a=>1},
  :{},            :{},
  :{},            :{a=>0},
  :{a=>0},        :{},
  :{a=>1},        :{a=>1},
;

# Things we need to check for not being a subset of.  Uses a Set with
# "marmoset" if not a Pair.  In case of a Pair, the .value is used instead.
# Note that we check the modifiable things twice: once being initialized
# without any elements, and once initialized with elements, but with the
# elements removed before testing.  This should shake out any problems
# that could pop up with internal hashes not being initialized.
my @notsse =
  $s,
  set(),
  $sh,
  SetHash.new,
  do { (my $a = <a>.SetHash)<a> = False; $a },
  $b,
  bag(),
  $bh,
  BagHash.new,
  do { (my $a = <a>.BagHash)<a> = 0; $a },
  $m,
  mix(),
  $mh,
  MixHash.new,
  do { (my $a = <a>.MixHash)<a> = 0; $a },
  $map,
  Map.new,
  $hash,
  Hash.new,
  do { my %h = a => 42; %h<a>:delete; %h },
  $objh,
  Hash[Any,Any].new,
  do { my %o := :{ a => 42 }; %o<a>:delete; %o },
  $list,
  List.new,

  (a =>  1).Mix => set(), # a not on right
  (a => -1).Mix => set(), # a not on right
  (a =>  1).Mix => bag(), # a not on right
  (a => -1).Mix => bag(), # a not on right
  (a =>  1).Mix => mix(), # a not on right
  (a => -1).Mix => mix(), # a not on right

# non-empties not subset of empties
  <a>.Set => set(),
  <a>.Bag => bag(),
  <a>.Mix => mix(),

# coercions of Maps
  {a => 1} => {},
  {a => 1} => {a => 0},
;

plan 4 * (2 * @sse/2 + 4 * @notsse) + 2 * (2 * @sse/2 + 4 * @notsse);

my $marmoset = <marmoset>.Set;

# is subset of / superset of
for
  &infix:<⊆>,           "⊆", &infix:<⊇>,       "⊇",
  &infix:<<(<=)>>,   "(<=)", &infix:<<(>=)>>,  "(>=)",
  &infix:<R⊇>,         "R⊇", &infix:<R⊆>,      "R⊆",
  &infix:<<R(>=)>>, "(R>=)", &infix:<<R(<=)>>, "(R<=)"
-> &op, $name, &rop, $rname {
    for @sse -> $left, $right {
#exit dd $left, $name, $right, True unless
        is-deeply op($left,$right), True,
          "$left is $name of $right.^name()";
#exit dd $right, $rname, $left, True unless
        is-deeply rop($right,$left), True,
          "$right.^name() $rname $left";
    }
    for @notsse {
        if $_ ~~ Pair {
#exit dd .key, $name, .value, False unless
            is-deeply op(.key,.value), False,
              "$_.value() is NOT $name of $_.key.^name()";
#exit dd .value, $rname, .key, False unless
            is-deeply rop(.value,.key), False,
              "$_.key.^name() NOT $rname $_.value()";
        }

        # assume $marmoset
        else {
#exit dd $marmoset, $name, $_, False unless
            is-deeply op($marmoset,$_), False,
              "marmoset is NOT $name of $_.^name()";
#exit dd $_, $name, $marmoset, False unless
            is-deeply rop($_,$marmoset), False,
              "$_.^name() NOT $rname marmoset";
        }

        # identity check
        is-deeply op($_,$_),  True, "$_.^name() $name same";
        is-deeply rop($_,$_), True, "$_.^name() $rname same";
    }
}

# is not a subset of / is not a superset of
for
  &infix:<⊈>,   "⊈", &infix:<⊉>,   "⊉",
  &infix:<R⊉>, "R⊉", &infix:<R⊈>, "R⊈"
-> &op, $name, &rop, $rname {
    for @sse -> $left, $right {
#exit dd $left, $name, $right, False unless
        is-deeply op($left,$right), False,
          "$left is NOT $name of $right.^name()";
#exit dd $right, $rname, $left, False unless
        is-deeply rop($right,$left), False,
          "$right.^name() NOT $rname $left";
    }
    for @notsse {
        if $_ ~~ Pair {
#exit dd .key, $name, .value, True unless
            is-deeply op(.key,.value), True,
              "$_.value() is NOT $name of $_.key.^name()";
#exit dd .value, $rname, .key, True unless
            is-deeply rop(.value,.key), True,
              "$_.key.^name() NOT $rname $_.value()";
        }

        # assume $marmoset
        else {
#exit dd $marmoset, $name, $_, True unless
            is-deeply op($marmoset,$_), True,
              "marmoset is NOT $name of $_.^name()";
#exit dd $_, $name, $marmoset, True unless
            is-deeply rop($_,$marmoset), True,
              "$_.^name() NOT $rname marmoset";
        }

        # identity check
        is-deeply op($_,$_),  False, "$_.^name() NOT $name same";
        is-deeply rop($_,$_), False, "$_.^name() NOT $rname same";
    }
}

# vim: ft=perl6
