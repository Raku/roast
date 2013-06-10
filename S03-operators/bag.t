use v6;
use Test;

plan 84;

sub showkv($x) {
    $x.keys.sort.map({ $^k ~ ':' ~ $x{$k} }).join(' ')
}

# "We're more of the love, blood, and rhetoric school. Well, we can do you blood
# and love without the rhetoric, and we can do you blood and rhetoric without
# the love, and we can do you all three concurrent or consecutive. But we can't
# give you love and rhetoric without the blood. Blood is compulsory. They're all
# blood, you see." -- Tom Stoppard

my $s = set <blood love>;
my $ks = <blood rhetoric>.KeySet;
my $b = { blood => 2, rhetoric => 1, love => 2 }.Bag;
my $kb = { blood => 1, love => 2 }.KeyBag;

# Bag Union

#?rakudo 8 skip "∪ NYI"
is showkv($b ∪ $b), showkv($b), "Bag union with itself yields self";
isa_ok ($b ∪ $b), Bag, "... and it's actually a Bag";
is showkv($kb ∪ $kb), showkv($kb), "KeyBag union with itself yields (as Bag)";
isa_ok ($kb ∪ $kb), Bag, "... and it's actually a Bag";

is showkv($s ∪ $b), "blood:2 love:2 rhetoric:1", "Set union with Bag works";
isa_ok ($s ∪ $b), Bag, "... and it's actually a Bag";
is showkv($s ∪ $kb), "blood:1 love:2", "Set union with KeyBag works";
isa_ok ($s ∪ $kb), Bag, "... and it's actually a Bag";

is showkv($s (|) $b), "blood:2 love:2 rhetoric:1", "Set union with Bag works (texas)";
isa_ok ($s (|) $b), Bag, "... and it's actually a Bag";
is showkv($s (|) $kb), "blood:1 love:2", "Set union with KeyBag works (texas)";
isa_ok ($s (|) $kb), Bag, "... and it's actually a Bag";

# Bag Intersection

#?rakudo 10 skip "∩ NYI"
is showkv($b ∩ $b), showkv($b), "Bag intersection with itself yields self (as Bag)";
isa_ok ($b ∩ $b), Bag, "... and it's actually a Bag";
is showkv($kb ∩ $kb), showkv($kb), "KeyBag intersection with itself yields self (as Bag)";
isa_ok ($kb ∩ $kb), Bag, "... and it's actually a Bag";

is showkv($s ∩ $b), "blood:1 love:1", "Set intersection with Bag works";
isa_ok ($s ∩ $b), Bag, "... and it's actually a Bag";
is showkv($s ∩ $kb), "blood:1 love:1", "Set intersection with KeyBag works";
isa_ok ($s ∩ $kb), Bag, "... and it's actually a Bag";
is showkv($kb ∩ <glad green blood>), "blood:1", "KeyBag intersection with array of strings works";
isa_ok ($kb ∩ <glad green blood>), Bag, "... and it's actually a Bag";

is showkv($s (&) $b), "blood:1 love:1", "Set intersection with Bag works (texas)";
isa_ok ($s (&) $b), Bag, "... and it's actually a Bag";
is showkv($s (&) $kb), "blood:1 love:1", "Set intersection with KeyBag works (texas)";
isa_ok ($s (&) $kb), Bag, "... and it's actually a Bag";
is showkv($kb (&) <glad green blood>), "blood:1", "KeyBag intersection with array of strings works (texas)";
isa_ok ($kb (&) <glad green blood>), Bag, "... and it's actually a Bag";

# Bag multiplication

#?rakudo 16 skip "∩ NYI"
is showkv($s ⊍ $s), "blood:1 love:1", "Bag multiplication with itself yields self squared";
isa_ok ($s ⊍ $s), Bag, "... and it's actually a Bag";
is showkv($ks ⊍ $ks), "blood:1 rhetoric:1", "Bag multiplication with itself yields self squared";
isa_ok ($ks ⊍ $ks), Bag, "... and it's actually a Bag";
is showkv($b ⊍ $b), "blood:4 love:4 rhetoric:1", "Bag multiplication with itself yields self squared";
isa_ok ($b ⊍ $b), Bag, "... and it's actually a Bag";
is showkv($kb ⊍ $kb), "blood:1 love:4", "Bag multiplication with itself yields self squared";
isa_ok ($kb ⊍ $kb), Bag, "... and it's actually a Bag";

is showkv($s ⊍ $ks), "blood:1", "Bag multiplication (Set / KeySet) works";
isa_ok ($s ⊍ $ks), Bag, "... and it's actually a Bag";
is showkv($s ⊍ $b), "blood:2 love:2", "Bag multiplication (Set / Bag) works";
isa_ok ($s ⊍ $b), Bag, "... and it's actually a Bag";
is showkv($ks ⊍ $b), "blood:2 rhetoric:1", "Bag multiplication (KeySet / Bag) works";
isa_ok ($ks ⊍ $b), Bag, "... and it's actually a Bag";
is showkv($kb ⊍ $b), "blood:2 love:4", "Bag multiplication (KeyBag / Bag) works";
isa_ok ($kb ⊍ $b), Bag, "... and it's actually a Bag";

is showkv($s (.) $ks), "blood:1", "Bag multiplication (Set / KeySet) works (texas)";
isa_ok ($s (.) $ks), Bag, "... and it's actually a Bag (texas)";
is showkv($s (.) $b), "blood:2 love:2", "Bag multiplication (Set / Bag) works (texas)";
isa_ok ($s (.) $b), Bag, "... and it's actually a Bag (texas)";
is showkv($ks (.) $b), "blood:2 rhetoric:1", "Bag multiplication (KeySet / Bag) works (texas)";
isa_ok ($ks (.) $b), Bag, "... and it's actually a Bag (texas)";
is showkv($kb (.) $b), "blood:2 love:4", "Bag multiplication (KeyBag / Bag) works (texas)";
isa_ok ($kb (.) $b), Bag, "... and it's actually a Bag";

# Bag addition

#?rakudo 16 skip "⊎ NYI"
is showkv($s ⊎ $s), "blood:2 love:2", "Bag addition with itself yields twice self";
isa_ok ($s ⊎ $s), Bag, "... and it's actually a Bag";
is showkv($ks ⊎ $ks), "blood:2 rhetoric:2", "Bag addition with itself yields twice self";
isa_ok ($ks ⊎ $ks), Bag, "... and it's actually a Bag";
is showkv($b ⊎ $b), "blood:4 love:4 rhetoric:2", "Bag addition with itself yields twice self";
isa_ok ($b ⊎ $b), Bag, "... and it's actually a Bag";
is showkv($kb ⊎ $kb), "blood:2 love:4", "Bag addition with itself yields twice self";
isa_ok ($kb ⊎ $kb), Bag, "... and it's actually a Bag";

is showkv($s ⊎ $ks), "blood:2 love:1 rhetoric:1", "Bag addition (Set / KeySet) works";
isa_ok ($s ⊎ $ks), Bag, "... and it's actually a Bag";
is showkv($s ⊎ $b), "blood:3 love:3 rhetoric:1", "Bag addition (Set / Bag) works";
isa_ok ($s ⊎ $b), Bag, "... and it's actually a Bag";
is showkv($ks ⊎ $b), "blood:3 love:2 rhetoric:2", "Bag addition (KeySet / Bag) works";
isa_ok ($ks ⊎ $b), Bag, "... and it's actually a Bag";
is showkv($kb ⊎ $b), "blood:3 love:4 rhetoric:1", "Bag addition (KeyBag / Bag) works";
isa_ok ($kb ⊎ $b), Bag, "... and it's actually a Bag";

is showkv($s (+) $ks), "blood:2 love:1 rhetoric:1", "Bag addition (Set / KeySet) works (texas)";
isa_ok ($s (+) $ks), Bag, "... and it's actually a Bag (texas)";
is showkv($s (+) $b), "blood:3 love:3 rhetoric:1", "Bag addition (Set / Bag) works (texas)";
isa_ok ($s (+) $b), Bag, "... and it's actually a Bag (texas)";
is showkv($ks (+) $b), "blood:3 love:2 rhetoric:2", "Bag addition (KeySet / Bag) works (texas)";
isa_ok ($ks (+) $b), Bag, "... and it's actually a Bag (texas)";
is showkv($kb (+) $b), "blood:3 love:4 rhetoric:1", "Bag addition (KeyBag / Bag) works (texas)";
isa_ok ($kb (+) $b), Bag, "... and it's actually a Bag";

# msubset

#?rakudo skip "No msubset yet"
{
    ok $kb ≼ $b, "Our keybag is a msubset of our bag";
    nok $b ≼ $kb, "Our keybag is not a msubset of our bag";
    ok $b ≼ $b, "Our bag is a msubset of itself";
    ok $kb ≼ $kb, "Our keybag is a msubset of itself";
}

# msuperset

#?rakudo skip "No msuperset yet"
{
    nok $kb ≽ $b, "Our keybag is not a msuperset of our bag";
    ok $b ≽ $kb, "Our keybag is not a msuperset of our bag";
    ok $b ≽ $b, "Our bag is a msuperset of itself";
    ok $kb ≽ $kb, "Our keybag is a msuperset of itself";
}

# vim: ft=perl6
