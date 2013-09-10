use v6;
use Test;

plan 108;

sub showkv($x) {
    $x.keys.sort.map({ $^k ~ ':' ~ $x{$k} }).join(' ')
}

# "We're more of the love, blood, and rhetoric school. Well, we can do you blood
# and love without the rhetoric, and we can do you blood and rhetoric without
# the love, and we can do you all three concurrent or consecutive. But we can't
# give you love and rhetoric without the blood. Blood is compulsory. They're all
# blood, you see." -- Tom Stoppard

my $s = set <blood love>;
my $ks = KeySet.new(<blood rhetoric>);
my $b = bag <blood blood rhetoric love love>;
my $kb = KeyBag.new(<blood love love>);

# Bag Union

#?rakudo todo 'huh?'
is showkv($b ∪ $b), showkv($b), "Bag union with itself yields self";
isa_ok ($b ∪ $b), Bag, "... and it's actually a Bag";
#?rakudo todo 'huh?'
is showkv($kb ∪ $kb), showkv($kb), "KeyBag union with itself yields (as Bag)";
isa_ok ($kb ∪ $kb), Bag, "... and it's actually a Bag";

#?rakudo todo 'huh?'
is showkv($s ∪ $b), "blood:2 love:2 rhetoric:1", "Set union with Bag works";
isa_ok ($s ∪ $b), Bag, "... and it's actually a Bag";
#?rakudo todo 'huh?'
is showkv($s ∪ $kb), "blood:1 love:2", "Set union with KeyBag works";
isa_ok ($s ∪ $kb), Bag, "... and it's actually a Bag";

#?rakudo todo 'huh?'
is showkv($s (|) $b), "blood:2 love:2 rhetoric:1", "Set union with Bag works (texas)";
isa_ok ($s (|) $b), Bag, "... and it's actually a Bag";
#?rakudo todo 'huh?'
is showkv($s (|) $kb), "blood:1 love:2", "Set union with KeyBag works (texas)";
isa_ok ($s (|) $kb), Bag, "... and it's actually a Bag";

# Bag Intersection

is showkv($b ∩ $b), showkv($b), "Bag intersection with itself yields self (as Bag)";
isa_ok ($b ∩ $b), Bag, "... and it's actually a Bag";
is showkv($kb ∩ $kb), showkv($kb), "KeyBag intersection with itself yields self (as Bag)";
isa_ok ($kb ∩ $kb), Bag, "... and it's actually a Bag";

is showkv($s ∩ $b), "blood:1 love:1", "Set intersection with Bag works";
isa_ok ($s ∩ $b), Bag, "... and it's actually a Bag";
is showkv($s ∩ $kb), "blood:1 love:1", "Set intersection with KeyBag works";
isa_ok ($s ∩ $kb), Bag, "... and it's actually a Bag";
#?niecza todo 'Right now this works as $kb ∩ glag ∩ green ∩ blood.  Test may be wrong'
is showkv($kb ∩ <glad green blood>), "blood:1", "KeyBag intersection with array of strings works";
isa_ok ($kb ∩ <glad green blood>), Bag, "... and it's actually a Bag";

is showkv($s (&) $b), "blood:1 love:1", "Set intersection with Bag works (texas)";
isa_ok ($s (&) $b), Bag, "... and it's actually a Bag";
is showkv($s (&) $kb), "blood:1 love:1", "Set intersection with KeyBag works (texas)";
isa_ok ($s (&) $kb), Bag, "... and it's actually a Bag";
#?niecza todo 'Right now this works as $kb ∩ glag ∩ green ∩ blood.  Test may be wrong?'
is showkv($kb (&) <glad green blood>), "blood:1", "KeyBag intersection with array of strings works (texas)";
isa_ok ($kb (&) <glad green blood>), Bag, "... and it's actually a Bag";

# Bag multiplication

#?rakudo todo 'huh?'
is showkv($s ⊍ $s), "blood:1 love:1", "Bag multiplication with itself yields self squared";
isa_ok ($s ⊍ $s), Bag, "... and it's actually a Bag";
#?rakudo todo 'huh?'
is showkv($ks ⊍ $ks), "blood:1 rhetoric:1", "Bag multiplication with itself yields self squared";
isa_ok ($ks ⊍ $ks), Bag, "... and it's actually a Bag";
#?rakudo todo 'huh?'
is showkv($b ⊍ $b), "blood:4 love:4 rhetoric:1", "Bag multiplication with itself yields self squared";
isa_ok ($b ⊍ $b), Bag, "... and it's actually a Bag";
#?rakudo todo 'huh?'
is showkv($kb ⊍ $kb), "blood:1 love:4", "Bag multiplication with itself yields self squared";
isa_ok ($kb ⊍ $kb), Bag, "... and it's actually a Bag";

#?rakudo todo 'huh?'
is showkv($s ⊍ $ks), "blood:1", "Bag multiplication (Set / KeySet) works";
isa_ok ($s ⊍ $ks), Bag, "... and it's actually a Bag";
#?rakudo todo 'huh?'
is showkv($s ⊍ $b), "blood:2 love:2", "Bag multiplication (Set / Bag) works";
isa_ok ($s ⊍ $b), Bag, "... and it's actually a Bag";
#?rakudo todo 'huh?'
is showkv($ks ⊍ $b), "blood:2 rhetoric:1", "Bag multiplication (KeySet / Bag) works";
isa_ok ($ks ⊍ $b), Bag, "... and it's actually a Bag";
#?rakudo todo 'huh?'
is showkv($kb ⊍ $b), "blood:2 love:4", "Bag multiplication (KeyBag / Bag) works";
isa_ok ($kb ⊍ $b), Bag, "... and it's actually a Bag";

#?rakudo todo 'huh?'
is showkv($s (.) $ks), "blood:1", "Bag multiplication (Set / KeySet) works (texas)";
isa_ok ($s (.) $ks), Bag, "... and it's actually a Bag (texas)";
#?rakudo todo 'huh?'
is showkv($s (.) $b), "blood:2 love:2", "Bag multiplication (Set / Bag) works (texas)";
isa_ok ($s (.) $b), Bag, "... and it's actually a Bag (texas)";
#?rakudo todo 'huh?'
is showkv($ks (.) $b), "blood:2 rhetoric:1", "Bag multiplication (KeySet / Bag) works (texas)";
isa_ok ($ks (.) $b), Bag, "... and it's actually a Bag (texas)";
#?rakudo todo 'huh?'
is showkv($kb (.) $b), "blood:2 love:4", "Bag multiplication (KeyBag / Bag) works (texas)";
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

#?rakudo skip 'Reduction and bag operators'
{
    # my $s = set <blood love>;
    # my $ks = KeySet.new(<blood rhetoric>);
    # my $b = bag <blood blood rhetoric love love>;
    # my $kb = KeyBag.new(<blood love love>);
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
}

# vim: ft=perl6
