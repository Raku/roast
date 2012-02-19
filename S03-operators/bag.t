use v6;
use Test;

plan 48;

sub showkv($x) {
    $x.keys.sort.map({ $^k ~ ':' ~ $x{$^k} }).join(' ')
}

# "We're more of the love, blood, and rhetoric school. Well, we can do you blood
# and love without the rhetoric, and we can do you blood and rhetoric without
# the love, and we can do you all three concurrent or consecutive. But we can't
# give you love and rhetoric without the blood. Blood is compulsory. They're all
# blood, you see." -- Tom Stoppard

my $s = set <blood love>;
my $ks = KeySet.new(<blood rhetoric>);
my $b = bag { blood => 2, rhetoric => 1, love => 2 };
my $kb = KeyBag.new({ blood => 1, love => 2 });

# Bag multiplication

is showkv($s ⊍ $s), "blood:1 love:1", "Bag multiplication with itself yields self";
isa_ok ($s ⊍ $s), Bag, "... and it's actually a Bag";
is showkv($ks ⊍ $ks), "blood:1 rhetoric:1", "Bag multiplication with itself yields self";
isa_ok ($ks ⊍ $ks), Bag, "... and it's actually a Bag";
is showkv($b ⊍ $b), "blood:2 love:2 rhetoric:1", "Bag multiplication with itself yields self";
isa_ok ($b ⊍ $b), Bag, "... and it's actually a Bag";
is showkv($kb ⊍ $kb), "blood:1 love:2", "Bag multiplication with itself yields self";
isa_ok ($kb ⊍ $kb), Bag, "... and it's actually a Bag";

is showkv($s ⊍ $ks), "blood:1", "Bag multiplication (Set / KeySet) works";
isa_ok ($s ⊍ $ks), Bag, "... and it's actually a Bag";
is showkv($s ⊍ $b), "blood:1 love:1", "Bag multiplication (Set / Bag) works";
isa_ok ($s ⊍ $b), Bag, "... and it's actually a Bag";
is showkv($ks ⊍ $b), "blood:1 rhetoric:1", "Bag multiplication (KeySet / Bag) works";
isa_ok ($ks ⊍ $b), Bag, "... and it's actually a Bag";
is showkv($kb ⊍ $b), "blood:1 love:2", "Bag multiplication (KeyBag / Bag) works";
isa_ok ($kb ⊍ $b), Bag, "... and it's actually a Bag";

is showkv($s (.) $ks), "blood:1", "Bag multiplication (Set / KeySet) works (texas)";
isa_ok ($s (.) $ks), Bag, "... and it's actually a Bag (texas)";
is showkv($s (.) $b), "blood:1 love:1", "Bag multiplication (Set / Bag) works (texas)";
isa_ok ($s (.) $b), Bag, "... and it's actually a Bag (texas)";
is showkv($ks (.) $b), "blood:1 rhetoric:1", "Bag multiplication (KeySet / Bag) works (texas)";
isa_ok ($ks (.) $b), Bag, "... and it's actually a Bag (texas)";
is showkv($kb (.) $b), "blood:1 love:2", "Bag multiplication (KeyBag / Bag) works (texas)";
isa_ok ($kb (.) $b), Bag, "... and it's actually a Bag";

# Bag addition

is showkv($s ⊎ $s), "blood:2 love:2", "Bag addition with itself yields twice self";
isa_ok ($s ⊎ $s), Bag, "... and it's actually a Bag";
is showkv($ks ⊎ $ks), "blood:2 rhetoric:2", "Bag addition with itself yields twice self";
isa_ok ($ks ⊎ $ks), Bag, "... and it's actually a Bag";
is showkv($b ⊎ $b), "blood:4 love:4 rhetoric:2", "Bag addition with itself yields twice self";
isa_ok ($b ⊎ $b), Bag, "... and it's actually a Bag";
is showkv($kb ⊎ $kb), "blood:2 love:4", "Bag addition with itself yields twice self";
isa_ok ($kb ⊎ $kb), Bag, "... and it's actually a Bag";

# my $s = set <blood love>;
# my $ks = KeySet.new(<blood rhetoric>);
# my $b = bag { blood => 2, rhetoric => 1, love => 2 };
# my $kb = KeyBag.new({ blood => 1, love => 2 });

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


# vim: ft=perl6
