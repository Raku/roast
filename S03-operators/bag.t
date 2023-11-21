use v6.c;
use Test;

plan 128;

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
isa-ok ($kb ∪ $kb), BagHash, "... and it's actually a BagHash";

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
isa-ok ($kb ∩ $kb), BagHash, "... and it's actually a BagHash";

is showkv($s ∩ $b), "blood:1 love:1", "Set intersection with Bag works";
isa-ok ($s ∩ $b), Bag, "... and it's actually a Bag";
is showkv($s ∩ $kb), "blood:1 love:1", "Set intersection with BagHash works";
isa-ok ($s ∩ $kb), Bag, "... and it's actually a Bag";
#?niecza todo 'Right now this works as $kb ∩ glag ∩ green ∩ blood.  Test may be wrong'
is showkv($kb ∩ <glad green blood>), "blood:1", "BagHash intersection with array of strings works";
isa-ok ($kb ∩ <glad green blood>), BagHash, "... and it's actually a BagHash";

is showkv($s (&) $b), "blood:1 love:1", "Set intersection with Bag works (texas)";
isa-ok ($s (&) $b), Bag, "... and it's actually a Bag";
is showkv($s (&) $kb), "blood:1 love:1", "Set intersection with BagHash works (texas)";
isa-ok ($s (&) $kb), Bag, "... and it's actually a Bag";
#?niecza todo 'Right now this works as $kb ∩ glag ∩ green ∩ blood.  Test may be wrong?'
is showkv($kb (&) <glad green blood>), "blood:1", "BagHash intersection with array of strings works (texas)";
isa-ok ($kb (&) <glad green blood>), BagHash, "... and it's actually a BagHash";

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
isa-ok ($kb (^) $s), BagHash, "... and it's actually a BagHashh";

# Bag multiplication

is showkv($s ⊍ $s), "blood:1 love:1", "Bag multiplication with itself yields self squared";
isa-ok ($s ⊍ $s), Bag, "... and it's actually a Bag";
is showkv($ks ⊍ $ks), "blood:1 rhetoric:1", "Bag multiplication with itself yields self squared";
isa-ok ($ks ⊍ $ks), BagHash, "... and it's actually a BagHash";
is showkv($b ⊍ $b), "blood:4 love:4 rhetoric:1", "Bag multiplication with itself yields self squared";
isa-ok ($b ⊍ $b), Bag, "... and it's actually a Bag";
is showkv($kb ⊍ $kb), "blood:1 love:4", "Bag multiplication with itself yields self squared";
isa-ok ($kb ⊍ $kb), BagHash, "... and it's actually a BagHash";

is showkv($s ⊍ $ks), "blood:1", "Bag multiplication (Set / SetHash) works";
isa-ok ($s ⊍ $ks), Bag, "... and it's actually a Bag";
is showkv($s ⊍ $b), "blood:2 love:2", "Bag multiplication (Set / Bag) works";
isa-ok ($s ⊍ $b), Bag, "... and it's actually a Bag";
is showkv($ks ⊍ $b), "blood:2 rhetoric:1", "Bag multiplication (SetHash / Bag) works";
isa-ok ($ks ⊍ $b), BagHash, "... and it's actually a BagHash";
is showkv($kb ⊍ $b), "blood:2 love:4", "Bag multiplication (BagHash / Bag) works";
isa-ok ($kb ⊍ $b), BagHash, "... and it's actually a BagHash";

is showkv($s (.) $ks), "blood:1", "Bag multiplication (Set / SetHash) works (texas)";
isa-ok ($s (.) $ks), Bag, "... and it's actually a Bag (texas)";
is showkv($s (.) $b), "blood:2 love:2", "Bag multiplication (Set / Bag) works (texas)";
isa-ok ($s (.) $b), Bag, "... and it's actually a Bag (texas)";
is showkv($ks (.) $b), "blood:2 rhetoric:1", "Bag multiplication (SetHash / Bag) works (texas)";
isa-ok ($ks (.) $b), BagHash, "... and it's actually a BagHash (texas)";
is showkv($kb (.) $b), "blood:2 love:4", "Bag multiplication (BagHash / Bag) works (texas)";
isa-ok ($kb (.) $b), BagHash, "... and it's actually a BagHash";

# Bag addition

is showkv($s ⊎ $s), "blood:2 love:2", "Bag addition with itself yields twice self";
isa-ok ($s ⊎ $s), Bag, "... and it's actually a Bag";
is showkv($ks ⊎ $ks), "blood:2 rhetoric:2", "Bag addition with itself yields twice self";
isa-ok ($ks ⊎ $ks), BagHash, "... and it's actually a BagHash";
is showkv($b ⊎ $b), "blood:4 love:4 rhetoric:2", "Bag addition with itself yields twice self";
isa-ok ($b ⊎ $b), Bag, "... and it's actually a Bag";
is showkv($kb ⊎ $kb), "blood:2 love:4", "Bag addition with itself yields twice self";
isa-ok ($kb ⊎ $kb), BagHash, "... and it's actually a BagHash";

is showkv($s ⊎ $ks), "blood:2 love:1 rhetoric:1", "Bag addition (Set / SetHash) works";
isa-ok ($s ⊎ $ks), Bag, "... and it's actually a Bag";
is showkv($s ⊎ $b), "blood:3 love:3 rhetoric:1", "Bag addition (Set / Bag) works";
isa-ok ($s ⊎ $b), Bag, "... and it's actually a Bag";
is showkv($ks ⊎ $b), "blood:3 love:2 rhetoric:2", "Bag addition (SetHash / Bag) works";
isa-ok ($ks ⊎ $b), BagHash, "... and it's actually a BagHash";
is showkv($kb ⊎ $b), "blood:3 love:4 rhetoric:1", "Bag addition (BagHash / Bag) works";
isa-ok ($kb ⊎ $b), BagHash, "... and it's actually a BagHash";

is showkv($s (+) $ks), "blood:2 love:1 rhetoric:1", "Bag addition (Set / SetHash) works (texas)";
isa-ok ($s (+) $ks), Bag, "... and it's actually a Bag (texas)";
is showkv($s (+) $b), "blood:3 love:3 rhetoric:1", "Bag addition (Set / Bag) works (texas)";
isa-ok ($s (+) $b), Bag, "... and it's actually a Bag (texas)";
is showkv($ks (+) $b), "blood:3 love:2 rhetoric:2", "Bag addition (SetHash / Bag) works (texas)";
isa-ok ($ks (+) $b), BagHash, "... and it's actually a BagHash (texas)";
is showkv($kb (+) $b), "blood:3 love:4 rhetoric:1", "Bag addition (BagHash / Bag) works (texas)";
isa-ok ($kb (+) $b), BagHash, "... and it's actually a BagHash";

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
    
    is showkv([⊎] @d), showkv(∅), "Bag sum reduce works on nothing";
    is showkv([⊎] $s), showkv($s.Bag), "Bag sum reduce works on one set";
    is showkv([⊎] $s, $b), showkv({ blood => 3, rhetoric => 1, love => 3 }), "Bag sum reduce works on two sets";
    is showkv([⊎] $s, $b, $kb), showkv({ blood => 4, rhetoric => 1, love => 5 }), "Bag sum reduce works on three sets";

    is showkv([(+)] @d), showkv(∅), "Bag sum reduce works on nothing";
    is showkv([(+)] $s), showkv($s.Bag), "Bag sum reduce works on one set";
    is showkv([(+)] $s, $b), showkv({ blood => 3, rhetoric => 1, love => 3 }), "Bag sum reduce works on two sets";
    is showkv([(+)] $s, $b, $kb), showkv({ blood => 4, rhetoric => 1, love => 5 }), "Bag sum reduce works on three sets";

    is showkv([⊍] @d), showkv(∅), "Bag multiply reduce works on nothing";
    is showkv([⊍] $s), showkv($s.Bag), "Bag multiply reduce works on one set";
    is showkv([⊍] $s, $b), showkv({ blood => 2, love => 2 }), "Bag multiply reduce works on two sets";
    is showkv([⊍] $s, $b, $kb), showkv({ blood => 2, love => 4 }), "Bag multiply reduce works on three sets";

    is showkv([(.)] @d), showkv(∅), "Bag multiply reduce works on nothing";
    is showkv([(.)] $s), showkv($s.Bag), "Bag multiply reduce works on one set";
    is showkv([(.)] $s, $b), showkv({ blood => 2, love => 2 }), "Bag multiply reduce works on two sets";
    is showkv([(.)] $s, $b, $kb), showkv({ blood => 2, love => 4 }), "Bag multiply reduce works on three sets";

    is showkv([(^)] @d), showset(∅), "Bag symmetric difference reduce works on nothing";
    #?rakudo todo "NYI"
    is showkv([(^)] $s), showset($s), "Set symmetric difference reduce works on one set";
    #?rakudo todo "NYI"
    isa-ok showkv([(^)] $s), Set, "Set symmetric difference reduce works on one set, yields set";
    is showkv([(^)] $b), showkv($b), "Bag symmetric difference reduce works on one bag";
    #?rakudo todo "NYI"
    isa-ok showkv([(^)] $b), Bag, "Bag symmetric difference reduce works on one bag, yields bag";
    is showkv([(^)] $s, $b), showkv({ blood => 1, love => 1, rhetoric => 1 }), "Bag symmetric difference reduce works on a bag and a set";
    #?rakudo todo "Wrong answer at the moment"
    isa-ok showkv([(^)] $s, $b), Bag, "... and produces a Bag";
    is showkv([(^)] $b, $s), showkv({ blood => 1, love => 1, rhetoric => 1 }), "... and is actually symmetric";
    #?rakudo todo "Wrong answer at the moment"
    isa-ok showkv([(^)] $b, $s), Bag, "... and still produces a Bag that way too";
    #?rakudo 2 todo "Crashing"
    is showkv([(^)] $s, $b, $kb), showkv({ blood => 1, love => 1, rhetoric => 1 }), "Bag symmetric difference reduce works on three bags";
    isa-ok showkv([(^)] $s, $b, $kb), Bag, "Bag symmetric difference reduce works on three bags";
}

# vim: ft=perl6
