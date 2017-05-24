use v6;
use Test;

# things we need to check being an element of
my $s    = set <I'm afraid it isn't your day>;
my $sh   = SetHash.new(<I'm afraid it is>); # Tom Stoppard  # hl '
my $b    = bag <Whoever remains for long here in this earthly life>;
my $bh   = BagHash.new(<Come, take your bread with joy>);
my $m    = (about => pi, before => tau).Mix;
my $mh   = (cure => e, dosage => 42).MixHash;
my $map  = (effective => 42, factual => 666).Map;
my $hash = (global => 77, happiness => 999).Hash;
my $objh = Hash[Any,Any].new((ideas => 56, jocular => 13));
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
  "quick",   $list,
;

# Things we need to check for not being an element of
# Note that we check the modifiable things twice: once being initialized
# without any elements, and once initialized with elements, but with the
# elements removed before testing.  This should shake out any problems
# that could pop up with internal hashes not being initialized.
my @notelem =
  $s,    set(),
  $sh,   SetHash.new,        { (my $a = <a>.SetHash)<a> = False; $a },
  $b,    bag(),
  $bh,   BagHash.new,        { (my $a = <a>.BagHash)<a> = 0; $a },
  $m,    mix,
  $mh,   MixHash.new,        { (my $a = <a>.MixHash)<a> = 0; $a },
  $map,  Map.new,
  $hash, Hash.new,           { my %h = a => 42; %h<a>:delete; %h },
  $objh, Hash[Any,Any].new,  { my %o := :{ a => 42 }; %o<a>:delete; %o },
  $list, List.new,           # Iterable
;

plan 2 * (2 * @elem/2 + 2 * @notelem) + 2 * (2 * @elem/2 + 2 * @notelem);

# is an element of / contains
for
  &infix:<∈>,      "∈",      &infix:<∋>,      "∋",
  &infix:<(elem)>, "(elem)", &infix:<(cont)>, "(cont)"
-> &op, $name, &rop, $rname {
    for @elem -> $left, $right {
        ok op($left,$right),  "$left is $name of $right.^name()";
        ok rop($right,$left), "$right.^name() $rname $left";
    }
    for @notelem -> $right {
        nok op("marmoset",$right),  "marmoset is NOT $name of $right.^name()";
        nok rop($right,"marmoset"), "$right.^name() NOT $rname marmoset";
    }
}

# is not an element of / does not contain
for
  &infix:<∉>,       "∉",       &infix:<∌>,      "∌",
  &infix:<!(elem)>, "!(elem)", &infix:<!(cont)>, "!(cont)"
-> &op, $name, &rop, $rname {
    for @elem -> $left, $right {
        nok op($left,$right),  "$left is NOT $name of $right.^name()";
        nok rop($right,$left), "$right.^name() NOT $rname $left";
    }
    for @notelem -> $right {
        ok op("marmoset",$right),  "marmoset is $name of $right.^name()";
        ok rop($right,"marmoset"), "$right.^name() $rname marmoset";
    }
}

# vim: ft=perl6
