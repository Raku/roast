use v6;
use Test;

# This test file tests the following set operators:
#   (<)   is a proper subset of (Texas)
#   ⊂     is a proper subset of
#   ⊄     is NOT a proper subset of
#   (>)   is a proper superset of (Texas)
#   ⊃     is a proper superset of
#   ⊅     is NOT a proper superset of

# things we need to check being a proper subset of
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
my @pss =

# simple cases that where left should be proper subset of right
  <d c e>.Set,             $s,
  <E D C>.Set,             $sh,
  <c b c>.Bag,             $b,
  <B C C>.BagHash,         $bh,
  (about => e).Mix,        $m,
  (minus => -e).Mix,       $m,
  (dosage => tau).MixHash, $mh,
  (minus => -1).MixHash,   $mh,
  "factual",               $map,
  "global",                $hash,
  "ideas",                 $objh,
  "quick",                 $list,

# more specific cases where left should be proper subset of right
  <a b>.Bag,      <a b c>.Bag,
  <a b>.Mix,      <a b c>.Mix,
  <a b>.Set,      <a b b c>.Bag,    # .Bag -> .Set
  <a b b>.Bag,    <a b c>.Set,      # .Bag -> .Set
  <a b>.Set,      <a a b b c>.Mix,  # .Mix -> .Set
  <a b b>.Mix,    <a b c>.Set,      # .Mix -> .Set
  <a b>.Bag,      <a a b b c>.Mix,  # .Bag -> .Mix
  <a b>.Mix,      <a a b b c>.Bag,  # .Bag -> .Mix

# negatives in Mix less than non-existing
  (a => -1).Mix,  bag(),
  (a => -1).Mix,  mix(),
  (a => -2).Mix,  (a => -1).Mix,

# empties always proper subset of not-empties
  set(),          <a>.Set,
  bag(),          <a>.Bag,
  mix(),          <a>.Mix,

# various Map coercions that should be ok
  {},             {a=>1},
  {a=>0},         {a=>1},
  {},             :{a=>1},
  {a=>0},         :{a=>1},
  :{},            {a=>1},
  :{a=>0},        {a=>1},
  :{},            :{a=>1},
  :{a=>0},        :{a=>1},
;

# Things we need to check for not being a proper subset of.  Uses a Set with
# "marmoset" if not a Pair.  In case of a Pair, the .value is used instead.
# Note that we check the modifiable things twice: once being initialized
# without any elements, and once initialized with elements, but with the
# elements removed before testing.  This should shake out any problems
# that could pop up with internal hashes not being initialized.
my @notpss =
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

  (a => -1).Mix => set(), # set forces set semantics
  (a => 1).Mix  => bag(), # positives in Mix with bag not proper subset
  (a => 1).Mix  => mix(), # positives in Mix with mix not proper subset
  (a => -1).Mix => (a => -2).Mix,  # right hand more negative

# non-empties never subset of empties
  <a>.Set => set(),
  <a>.Bag => bag(),
  <a>.Mix => mix(),
  mix() => (a => -1).Mix, # not a proper subset because of negative weight

# various Map coercions that shouldn't be ok
  {},        {},
  {a=>0},    {},
  {},        :{},
  {a=>0},    :{},
  :{},       {},
  :{a=>0},   {},
  :{},       :{},
  :{a=>0},   :{},
;

plan 4 * (2 * @pss/2 + 4 * @notpss) + 2 * (2 * @pss/2 + 4 * @notpss);

my $marmoset = <marmoset>.Set;

# is subset of / superset of
for
  &infix:<⊂>,         "⊂", &infix:<⊃>,         "⊃",
  &infix:<<(<)>>,   "(<)", &infix:<<(>)>>,   "(>)",
  &infix:<R⊃>,       "R⊃", &infix:<R⊂>,       "R⊂",
  &infix:<<R(>)>>, "R(>)", &infix:<<R(<)>>, "R(<)"
-> &op, $name, &rop, $rname {
    for @pss -> $left, $right {
#exit dd $left, $right, $name, True unless
        is-deeply op($left,$right), True,
          "$left is $name of $right.^name()";
#exit dd $right, $left, $rname, True unless
        is-deeply rop($right,$left), True,
          "$right.^name() $rname $left";
    }
    for @notpss {
        if $_ ~~ Pair {
#exit dd $.key, .value, $name, False unless
            is-deeply op(.key,.value), False,
              "$_.value() is NOT $name of $_.key.^name()";
#exit dd $.value, .key, $rname, False unless
            is-deeply rop(.value,.key), False,
              "$_.key.^name() NOT $rname $_.value()";
        }

        # assume $marmoset
        else {
#exit dd $marmoset, $_, $name, False unless
            is-deeply op($marmoset,$_), False,
              "marmoset is NOT $name of $_.^name()";
#exit dd $_, $marmoset, $rname, False unless
            is-deeply rop($_,$marmoset), False,
              "$_.^name() NOT $rname marmoset";
        }

        # identity check
        is-deeply op($_,$_),  False, "$_.^name() NOT $name same";
        is-deeply rop($_,$_), False, "$_.^name() NOT $rname same";
    }
}

# is not a subset of / is not a superset of
for
  &infix:<⊄>,   "⊈", &infix:<⊅>,   "⊅",
  &infix:<R⊅>, "R⊅", &infix:<R⊄>, "R⊈"
-> &op, $name, &rop, $rname {
    for @pss -> $left, $right {
#exit dd $left, $right, $name, False unless
        is-deeply op($left,$right), False,
          "$left is NOT $name of $right.^name()";
#exit dd $right, $left, $rname, False unless
        is-deeply rop($right,$left), False,
          "$right.^name() NOT $rname $left";
    }
    for @notpss {
        if $_ ~~ Pair {
#exit dd $.key, .value, $name, True unless
            is-deeply op(.key,.value), True,
              "$_.value() is NOT $name of $_.key.^name()";
#exit dd $.value, .key, $rname, True unless
            is-deeply rop(.value,.key), True,
              "$_.key.^name() NOT $rname $_.value()";
        }

        # assume $marmoset
        else {
#exit dd $marmoset, $_, $name, True unless
            is-deeply op($marmoset,$_), True,
              "marmoset is NOT $name of $_.^name()";
#exit dd $_, $marmoset, $rname, True unless
            is-deeply rop($_,$marmoset), True,
              "$_.^name() NOT $rname marmoset";
        }

        # identity check
        is-deeply op($_,$_),  True, "$_.^name() $name same";
        is-deeply rop($_,$_), True, "$_.^name() $rname same";
    }
}

# vim: ft=perl6
