use v6;
use Test;

plan 130;

sub showset($s) { $s.keys.sort.join(' ') }

sub showkv($x) {
    $x.keys.sort.map({ $^k ~ ':' ~ $x{$k} }).join(' ')
}

# "We're more of the love, blood, and rhetoric school. Well, we can do you blood
# and love without the rhetoric, and we can do you blood and rhetoric without
# the love, and we can do you all three concurrent or consecutive. But we can't
# give you love and rhetoric without the blood. Blood is compulsory. They're all
# blood, you see." -- Tom Stoppard

my $s = set <blood love>;
my $ks = SetHash.new(<blood rhetoric>);
my $b = bag <blood blood rhetoric love love>;
my $kb = BagHash.new(<blood love love>);

# Bag Union

is showkv($b ∪ $b), showkv($b), "Bag union with itself yields self";
isa-ok ($b ∪ $b), Bag, "... and it's actually a Bag";
is showkv($kb ∪ $kb), showkv($kb), "BagHash union with itself yields (as Bag)";
isa-ok ($kb ∪ $kb), Bag, "... and it's actually a Bag";

is showkv($s ∪ $b), "blood:2 love:2 rhetoric:1", "Set union with Bag works";
isa-ok ($s ∪ $b), Bag, "... and it's actually a Bag";
is showkv($s ∪ $kb), "blood:1 love:2", "Set union with BagHash works";
isa-ok ($s ∪ $kb), Bag, "... and it's actually a Bag";

is showkv($s (|) $b), "blood:2 love:2 rhetoric:1", "Set union with Bag works (texas)";
isa-ok ($s (|) $b), Bag, "... and it's actually a Bag";
is showkv($s (|) $kb), "blood:1 love:2", "Set union with BagHash works (texas)";
isa-ok ($s (|) $kb), Bag, "... and it's actually a Bag";

# Bag Intersection

is showkv($b ∩ $b), showkv($b), "Bag intersection with itself yields self (as Bag)";
isa-ok ($b ∩ $b), Bag, "... and it's actually a Bag";
is showkv($kb ∩ $kb), showkv($kb), "BagHash intersection with itself yields self (as Bag)";
isa-ok ($kb ∩ $kb), Bag, "... and it's actually a Bag";

is showkv($s ∩ $b), "blood:1 love:1", "Set intersection with Bag works";
isa-ok ($s ∩ $b), Bag, "... and it's actually a Bag";
is showkv($s ∩ $kb), "blood:1 love:1", "Set intersection with BagHash works";
isa-ok ($s ∩ $kb), Bag, "... and it's actually a Bag";
#?niecza todo 'Right now this works as $kb ∩ glag ∩ green ∩ blood.  Test may be wrong'
is showkv($kb ∩ <glad green blood>), "blood:1", "BagHash intersection with array of strings works";
isa-ok ($kb ∩ <glad green blood>), Bag, "... and it's actually a Bag";

is showkv($s (&) $b), "blood:1 love:1", "Set intersection with Bag works (texas)";
isa-ok ($s (&) $b), Bag, "... and it's actually a Bag";
is showkv($s (&) $kb), "blood:1 love:1", "Set intersection with BagHash works (texas)";
isa-ok ($s (&) $kb), Bag, "... and it's actually a Bag";
#?niecza todo 'Right now this works as $kb ∩ glag ∩ green ∩ blood.  Test may be wrong?'
is showkv($kb (&) <glad green blood>), "blood:1", "BagHash intersection with array of strings works (texas)";
isa-ok ($kb (&) <glad green blood>), Bag, "... and it's actually a Bag";

# symmetric difference

sub symmetric-difference($a, $b) {
    ($a (|) $b) (-) ($b (&) $a)
}

is showkv($s (^) $b), showkv(symmetric-difference($s, $b)), "Bag symmetric difference with Set is correct";
isa-ok ($s (^) $b), Bag, "... and it's actually a Bag";
is showkv($b (^) $s), showkv(symmetric-difference($s, $b)), "Set symmetric difference with Bag is correct";
isa-ok ($b (^) $s), Bag, "... and it's actually a Bag";

#?niecza todo "Test is wrong, implementation is wrong"
is showkv($s (^) $kb), showkv(symmetric-difference($s, $kb)), "BagHash symmetric difference with Set is correct";
isa-ok ($s (^) $kb), Bag, "... and it's actually a Bag";
#?niecza todo "Test is wrong, implementation is wrong"
is showkv($kb (^) $s), showkv(symmetric-difference($s, $kb)), "Set symmetric difference with BagHash is correct";
isa-ok ($kb (^) $s), Bag, "... and it's actually a Bag";

# Bag multiplication

is showkv($s ⊍ $s), "blood:1 love:1", "Bag multiplication with itself yields self squared";
isa-ok ($s ⊍ $s), Bag, "... and it's actually a Bag";
is showkv($ks ⊍ $ks), "blood:1 rhetoric:1", "Bag multiplication with itself yields self squared";
isa-ok ($ks ⊍ $ks), Bag, "... and it's actually a Bag";
is showkv($b ⊍ $b), "blood:4 love:4 rhetoric:1", "Bag multiplication with itself yields self squared";
isa-ok ($b ⊍ $b), Bag, "... and it's actually a Bag";
is showkv($kb ⊍ $kb), "blood:1 love:4", "Bag multiplication with itself yields self squared";
isa-ok ($kb ⊍ $kb), Bag, "... and it's actually a Bag";

is showkv($s ⊍ $ks), "blood:1", "Bag multiplication (Set / SetHash) works";
isa-ok ($s ⊍ $ks), Bag, "... and it's actually a Bag";
is showkv($s ⊍ $b), "blood:2 love:2", "Bag multiplication (Set / Bag) works";
isa-ok ($s ⊍ $b), Bag, "... and it's actually a Bag";
is showkv($ks ⊍ $b), "blood:2 rhetoric:1", "Bag multiplication (SetHash / Bag) works";
isa-ok ($ks ⊍ $b), Bag, "... and it's actually a Bag";
is showkv($kb ⊍ $b), "blood:2 love:4", "Bag multiplication (BagHash / Bag) works";
isa-ok ($kb ⊍ $b), Bag, "... and it's actually a Bag";

is showkv($s (.) $ks), "blood:1", "Bag multiplication (Set / SetHash) works (texas)";
isa-ok ($s (.) $ks), Bag, "... and it's actually a Bag (texas)";
is showkv($s (.) $b), "blood:2 love:2", "Bag multiplication (Set / Bag) works (texas)";
isa-ok ($s (.) $b), Bag, "... and it's actually a Bag (texas)";
is showkv($ks (.) $b), "blood:2 rhetoric:1", "Bag multiplication (SetHash / Bag) works (texas)";
isa-ok ($ks (.) $b), Bag, "... and it's actually a Bag (texas)";
is showkv($kb (.) $b), "blood:2 love:4", "Bag multiplication (BagHash / Bag) works (texas)";
isa-ok ($kb (.) $b), Bag, "... and it's actually a Bag";

# Bag addition

is showkv($s ⊎ $s), "blood:2 love:2", "Bag addition with itself yields twice self";
isa-ok ($s ⊎ $s), Bag, "... and it's actually a Bag";
is showkv($ks ⊎ $ks), "blood:2 rhetoric:2", "Bag addition with itself yields twice self";
isa-ok ($ks ⊎ $ks), Bag, "... and it's actually a Bag";
is showkv($b ⊎ $b), "blood:4 love:4 rhetoric:2", "Bag addition with itself yields twice self";
isa-ok ($b ⊎ $b), Bag, "... and it's actually a Bag";
is showkv($kb ⊎ $kb), "blood:2 love:4", "Bag addition with itself yields twice self";
isa-ok ($kb ⊎ $kb), Bag, "... and it's actually a Bag";

is showkv($s ⊎ $ks), "blood:2 love:1 rhetoric:1", "Bag addition (Set / SetHash) works";
isa-ok ($s ⊎ $ks), Bag, "... and it's actually a Bag";
is showkv($s ⊎ $b), "blood:3 love:3 rhetoric:1", "Bag addition (Set / Bag) works";
isa-ok ($s ⊎ $b), Bag, "... and it's actually a Bag";
is showkv($ks ⊎ $b), "blood:3 love:2 rhetoric:2", "Bag addition (SetHash / Bag) works";
isa-ok ($ks ⊎ $b), Bag, "... and it's actually a Bag";
is showkv($kb ⊎ $b), "blood:3 love:4 rhetoric:1", "Bag addition (BagHash / Bag) works";
isa-ok ($kb ⊎ $b), Bag, "... and it's actually a Bag";

is showkv($s (+) $ks), "blood:2 love:1 rhetoric:1", "Bag addition (Set / SetHash) works (texas)";
isa-ok ($s (+) $ks), Bag, "... and it's actually a Bag (texas)";
is showkv($s (+) $b), "blood:3 love:3 rhetoric:1", "Bag addition (Set / Bag) works (texas)";
isa-ok ($s (+) $b), Bag, "... and it's actually a Bag (texas)";
is showkv($ks (+) $b), "blood:3 love:2 rhetoric:2", "Bag addition (SetHash / Bag) works (texas)";
isa-ok ($ks (+) $b), Bag, "... and it's actually a Bag (texas)";
is showkv($kb (+) $b), "blood:3 love:4 rhetoric:1", "Bag addition (BagHash / Bag) works (texas)";
isa-ok ($kb (+) $b), Bag, "... and it's actually a Bag";

# for https://rt.perl.org/Ticket/Display.html?id=122810
ok bag(my @large_arr = ("a"...*)[^50000]), "... a large array goes into a bar - I mean bag - with 50k elems and lives";

# msubset
{
    ok $kb ≼ $b, "Our keybag is a msubset of our bag";
    nok $b ≼ $kb, "Our bag is not a msubset of our keybag";
    ok $b ≼ $b, "Our bag is a msubset of itself";
    ok $kb ≼ $kb, "Our keybag is a msubset of itself";
    #?niecza 4 skip '(<+) NYI - https://github.com/sorear/niecza/issues/178'
    ok $kb (<+) $b, "Our keybag is a msubset of our bag (texas)";
    nok $b (<+) $kb, "Our bag is not a msubset of our keybag (texas)";
    ok $b (<+) $b, "Our bag is a msubset of itself (texas)";
    ok $kb (<+) $kb, "Our keybag is a msubset of itself (texas)";
}

# msuperset
{
    nok $kb ≽ $b, "Our keybag is not a msuperset of our bag";
    ok $b ≽ $kb, "Our keybag is not a msuperset of our bag";
    ok $b ≽ $b, "Our bag is a msuperset of itself";
    ok $kb ≽ $kb, "Our keybag is a msuperset of itself";
    #?niecza 4 skip '(>+) NYI - https://github.com/sorear/niecza/issues/178'
    nok $kb (>+) $b, "Our keybag is not a msuperset of our bag";
    ok $b (>+) $kb, "Our bag is a msuperset of our keybag";
    ok $b (>+) $b, "Our bag is a msuperset of itself";
    ok $kb (>+) $kb, "Our keybag is a msuperset of itself";
}

{
    # my $s = set <blood love>;
    # my $ks = SetHash.new(<blood rhetoric>);
    # my $b = bag <blood blood rhetoric love love>;
    # my $kb = BagHash.new(<blood love love>);
    my @d;
    
    is ([⊎] @d), (∅), "Bag sum reduce works on nothing";
    is ([⊎] $s), ($s.Bag), "Bag sum reduce works on one set";
    is ([⊎] $s, $b), %(blood => 3, rhetoric => 1, love => 3).Bag, "Bag sum reduce works on two sets";
    is ([⊎] $s, $b, $kb), %(blood => 4, rhetoric => 1, love => 5).Bag, "Bag sum reduce works on three sets";

    is ([(+)] @d), (∅), "Bag sum reduce works on nothing";
    is ([(+)] $s), ($s.Bag), "Bag sum reduce works on one set";
    is ([(+)] set(), $s), ($s.Bag), "Bag sum reduce works on an empty set and a set";
    is ([(+)] bag(), $s), ($s.Bag), "Bag sum reduce works on an empty bag and a set";
    is ([(+)] $s, $b), %(blood => 3, rhetoric => 1, love => 3).Bag, "Bag sum reduce works on a set and a bag";
    is ([(+)] $s, $b, $kb), %(blood => 4, rhetoric => 1, love => 5).Bag, "Bag sum reduce works on a set, a bag, and a baghash";

    is ([⊍] @d), (∅), "Bag multiply reduce works on nothing";
    is ([⊍] $s), ($s.Bag), "Bag multiply reduce works on one set";
    is ([⊍] $s, $b), %(blood => 2, love => 2).Bag, "Bag multiply reduce works on two sets";
    is ([⊍] $s, $b, $kb), %(blood => 2, love => 4).Bag, "Bag multiply reduce works on three sets";

    is ([(.)] @d), (∅), "Bag multiply reduce works on nothing";
    is ([(.)] $s), ($s.Bag), "Bag multiply reduce works on one set";
    is ([(.)] $s, $b), %(blood => 2, love => 2).Bag, "Bag multiply reduce works on two sets";
    is ([(.)] $s, $b, $kb), %(blood => 2, love => 4).Bag, "Bag multiply reduce works on three sets";

    is ([(^)] @d), ∅, "Bag symmetric difference reduce works on nothing";
    is ([(^)] $s), $s, "Set symmetric difference reduce works on one set";
    isa-ok ([(^)] $s), Set, "Set symmetric difference reduce works on one set, yields set";
    is ([(^)] $b), $b, "Bag symmetric difference reduce works on one bag";
    isa-ok ([(^)] $b), Bag, "Bag symmetric difference reduce works on one bag, yields bag";
    is ([(^)] $s, $b), %(blood => 1, love => 1, rhetoric => 1).Bag, "Bag symmetric difference reduce works on a bag and a set";
    isa-ok ([(^)] $s, $b), Bag, "... and produces a Bag";
    is ([(^)] $b, $s), %(blood => 1, love => 1, rhetoric => 1).Bag, "... and is actually symmetric";
    isa-ok ([(^)] $b, $s), Bag, "... and still produces a Bag that way too";
    is ([(^)] $s, $ks, $kb), %(blood => 1, love => 1, rhetoric => 1).Bag, "Bag symmetric difference reduce works on three bags";
    isa-ok ([(^)] $s, $ks, $kb), Bag, "Bag symmetric difference reduce works on three bags";
}

# vim: ft=perl6
