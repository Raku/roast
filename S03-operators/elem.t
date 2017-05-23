use v6;
use Test;

plan 40;

my $s = set <I'm afraid it isn't your day>;
my $sh = SetHash.new(<I'm afraid it is>); # Tom Stoppard  # hl '
my $b = bag <Whoever remains for long here in this earthly life will enjoy and endure more than enough>; # Seamus Heaney
my $bh = BagHash.new(<Come, take your bread with joy, and your wine with a glad heart>); # Ecclesiastes 9:7

# Is an element of

for &infix:<∈>, "∈", &infix:<(elem)>, "(elem)" -> &op, $name {
    for
      "afraid",  $s,
      "afraid",  $sh,
      "earthly", $b,
      "your",    $bh,
      "d",       <a b c d e>
    -> $left, $right {
        ok op($left,$right), "$left is $name of $right.^name()";
    }
}

# Is not an element of

for &infix:<∉>, "∉", &infix:<!(elem)>, "!(elem)" -> &op, $name {
    for
      "marmoset", $s,
      "marmoset", $sh,
      "marmoset", $b,
      "marmoset", $bh,
      "marmoset", <a b c d e>
    -> $left, $right {
        ok op($left,$right), "$left is $name of $right.^name()";
    }
}

# Contains

for &infix:<∋>, "∋", &infix:<(cont)>, "(cont)" -> &op, $name {
    for
      $s,          "afraid",
      $sh,         "afraid",
      $b,          "earthly",
      $bh,         "your",
      <a b c d e>, "d"
    -> $left, $right {
        ok op($left,$right), "$left.^name() $name $right";
    }
}

# Does not contain

for &infix:<∌>, "∌", &infix:<!(cont)>, "!(cont)" -> &op, $name {
    for
      $s,          "marmoset",
      $sh,         "marmoset",
      $b,          "marmoset",
      $bh,         "marmoset",
      <a b c d e>, "marmoset"
    -> $left, $right {
        ok op($left,$right), "$left.^name() $name $right";
    }
}

# vim: ft=perl6
