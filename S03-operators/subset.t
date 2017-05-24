use v6;
use Test;

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
  (minus => -e).Mix,       $m,
  (dosage => tau).MixHash, $mh,
  (minus => -1).MixHash,   $mh,
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

# negatives in Mix less than non-existing
  (a => -1).Mix,  bag(),
  (a => -1).Mix,  mix(),
  (a => -2).Mix,  (a => -1).Mix,
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
  mix,
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
  $list, List.new,
;

plan 2 * (2 * @sse/2 + 4 * @notsse) + 2 * (2 * @sse/2 + 4 * @notsse);

my $marmoset = <marmoset>.Set;

# is subset of / superset of
for
  &infix:<⊆>,      "⊆",    &infix:<⊇>,      "⊇",
  &infix:<<(<=)>>, "(<=)", &infix:<<(>=)>>, "(>=)"
-> &op, $name, &rop, $rname {
    for @sse -> $left, $right {
        is-deeply op($left,$right), True,
          "$left is $name of $right.^name()";
        is-deeply rop($right,$left), True,
          "$right.^name() $rname $left";
    }
    for @notsse {
        if $_ ~~ Pair {
            is-deeply op(.value,.key), False,
              "$_.value() is NOT $name of $_.key.^name()";
            is-deeply rop(.key,.value), False,
              "$_.key.^name() NOT $rname $_.value()";
        }

        # assume $marmoset
        else {
            is-deeply op($marmoset,$_), False,
              "marmoset is NOT $name of $_.^name()";
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
  &infix:<⊈>,       "⊈",     &infix:<⊉>,      "⊉",
  &infix:<<!(<=)>>, "!(<=)", &infix:<<!(>=)>>, "!(>=)"
-> &op, $name, &rop, $rname {
    for @sse -> $left, $right {
        is-deeply op($left,$right), False,
          "$left is NOT $name of $right.^name()";
        is-deeply rop($right,$left), False,
          "$right.^name() NOT $rname $left";
    }
    for @notsse {
        if $_ ~~ Pair {
            is-deeply op(.value,.key), True,
              "$_.value() is NOT $name of $_.key.^name()";
            is-deeply rop(.key,.value), True,
              "$_.key.^name() NOT $rname $_.value()";
        }

        # assume $marmoset
        else {
            is-deeply op($marmoset,$_), True,
              "marmoset is NOT $name of $_.^name()";
            is-deeply rop($_,$marmoset), True,
              "$_.^name() NOT $rname marmoset";
        }

        # identity check
        is-deeply op($_,$_),  False, "$_.^name() NOT $name same";
        is-deeply rop($_,$_), False, "$_.^name() NOT $rname same";
    }
}

# vim: ft=perl6
