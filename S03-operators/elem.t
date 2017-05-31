use v6;
use Test;

# This test file tests the following set operators:
#   (elem)  is an element of (Texas)
#   ∈       is an element of
#   ∉       is NOT an element of
#   (cont)  contains (Texas)
#   ∋       contains
#   ∌       does NOT contain

# things we need to check being an element of
my $s    = set <I'm afraid it isn't your day>;
my $sh   = SetHash.new(<I'm afraid it is>); # Tom Stoppard  # hl '
my $b    = bag <Whoever remains for long here in this earthly life>;
my $bh   = BagHash.new(<Come, take your bread with joy>);
my $m    = (about => pi, before => tau).Mix;
my $mh   = (cure => e, dosage => 42).MixHash;
my $map  = (effective => 42, factual => 666).Map;
my $hash = (global => 77, 999 => "happiness").Hash;
my $objh = Hash[Any,Any].new((ideas => 56, 13 => "jocular"));
my $list = <the quick brown fox>;
my @elem =
  "afraid",  $s,
  "afraid",  $sh,
  "earthly", $b,
  "your",    $bh,
  "before",  $m,
  "dosage",  $mh,
  "factual", $map,
  "global",  $hash,
  "ideas",   $objh,
  13,        $objh,
  "quick",   $list,
;

# Things we need to check for not being an element of.  Uses the string
# "marmoset" if not a Pair.  In case of a Pair, the .value is used instead.
# Note that we check the modifiable things twice: once being initialized
# without any elements, and once initialized with elements, but with the
# elements removed before testing.  This should shake out any problems
# that could pop up with internal hashes not being initialized.
my @notelem =
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
  $hash => 999,     # should never be able to find anything non Str:D
  Hash.new,
  do { my %h = a => 42; %h<a>:delete; %h },
  $objh,
  $objh => "13",    # should not match 13
  Hash[Any,Any].new,
  do { my %o := :{ a => 42 }; %o<a>:delete; %o },
  $list,
  List.new,
;

plan 4 * (2 * @elem/2 + 2 * @notelem) + 2 * (2 * @elem/2 + 2 * @notelem);

# is an element of / contains
for
  &infix:<∈>,             "∈", &infix:<∋>,             "∋",
  &infix:<(elem)>,   "(elem)", &infix:<(cont)>,   "(cont)",
  &infix:<R∋>,           "R∋", &infix:<R∈>,           "R∈",
  &infix:<R(cont)>, "R(cont)", &infix:<R(elem)>, "R(elem)"
-> &op, $name, &rop, $rname {
    for @elem -> $left, $right {
        is-deeply op($left,$right),  True, "$left is $name of $right.^name()";
        is-deeply rop($right,$left), True, "$right.^name() $rname $left";
    }
    for @notelem {
        if $_ ~~ Pair {
            is-deeply op(.value,.key), False,
              "$_.value() is NOT $name of $_.key.^name()";
            is-deeply rop(.key,.value), False,
              "$_.key.^name() NOT $rname $_.value()";
        }
        # assume "marmoset"
        else {
            is-deeply op("marmoset",$_), False,
              "marmoset is NOT $name of $_.^name()";
            is-deeply rop($_,"marmoset"), False,
              "$_.^name() NOT $rname marmoset";
        }
    }
}

# is not an element of / does not contain
for
  &infix:<∉>,   "∉", &infix:<∌>,   "∌",
  &infix:<R∌>, "R∌", &infix:<R∉>, "R∉"
-> &op, $name, &rop, $rname {
    for @elem -> $left, $right {
        is-deeply op($left,$right), False,
          "$left is NOT $name of $right.^name()";
        is-deeply rop($right,$left), False,
          "$right.^name() NOT $rname $left";
    }
    for @notelem {
        if $_ ~~ Pair {
            is-deeply op(.value,.key), True,
              "$_.value() is NOT $name of $_.key.^name()";
            is-deeply rop(.key,.value), True,
              "$_.key.^name() NOT $rname $_.value()";
        }
        # assume "marmoset"
        else {
            is-deeply op("marmoset",$_), True,
              "marmoset is NOT $name of $_.^name()";
            is-deeply rop($_,"marmoset"), True,
              "$_.^name() NOT $rname marmoset";
        }
    }
}

# vim: ft=perl6
