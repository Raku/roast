use v6;
use Test;

plan 54;

sub showset($s) { $s.keys.sort.join(' ') }
sub showkv($x) { $x.sort.map({ .key ~ ':' ~ .value }).join(' ') }

# "We're more of the love, blood, and rhetoric school. Well, we can do you blood
# and love without the rhetoric, and we can do you blood and rhetoric without
# the love, and we can do you all three concurrent or consecutive. But we can't
# give you love and rhetoric without the blood. Blood is compulsory. They're all
# blood, you see." -- Tom Stoppard

my $s = set <blood love>;
my $ks = SetHash.new(<blood rhetoric>);
my $b = bag <blood blood rhetoric love love>;
my $kb = BagHash.new(<blood love love>);

# Bag Union tests moved to set_union.t

# Bag Intersection tests moved to set_intersection.t

# symmetric difference

sub symmetric-difference($a, $b) {
    ($a (|) $b) (-) ($b (&) $a)
}

is showkv($s (^) $b), showkv(symmetric-difference($s, $b)), "Bag symmetric difference with Set is correct";
isa-ok ($s (^) $b), Bag, "... and it's actually a Bag";
is showkv($b (^) $s), showkv(symmetric-difference($s, $b)), "Set symmetric difference with Bag is correct";
isa-ok ($b (^) $s), Bag, "... and it's actually a Bag";

is showkv($s (^) $kb), showkv(symmetric-difference($s, $kb)), "BagHash symmetric difference with Set is correct";
isa-ok ($s (^) $kb), Bag, "... and it's actually a Bag";
is showkv($kb (^) $s), showkv(symmetric-difference($s, $kb)), "Set symmetric difference with BagHash is correct";
isa-ok ($kb (^) $s), Bag, "... and it's actually a Bag";

# Bag multiplication tests moved to set_multiply.t

# Bag addition tests moved to set_addition.t

# for https://rt.perl.org/Ticket/Display.html?id=122810
ok bag(my @large_arr = ("a"...*)[^50000]), "... a large array goes into a bar - I mean bag - with 50k elems and lives";

# msubset
{
    ok $kb ≼ $b, "Our keybag is a msubset of our bag";
    nok $b ≼ $kb, "Our bag is not a msubset of our keybag";
    ok $b ≼ $b, "Our bag is a msubset of itself";
    ok $kb ≼ $kb, "Our keybag is a msubset of itself";
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
    
    is showkv([⊎] @d), '', "Bag sum reduce works on nothing";
    is showkv([⊎] $s), showkv($s.Bag), "Bag sum reduce works on one set";
    is showkv([⊎] $s, $b), 'blood:3 love:3 rhetoric:1', "Bag sum reduce works on two sets";
    is showkv([⊎] $s, $b, $kb), 'blood:4 love:5 rhetoric:1', "Bag sum reduce works on three sets";

    is showkv([(+)] @d), '', "Bag sum reduce works on nothing";
    is showkv([(+)] $s), showkv($s.Bag), "Bag sum reduce works on one set";
    is showkv([(+)] set(), $s), showkv($s.Bag), "Bag sum reduce works on an empty set and a set";
    is showkv([(+)] bag(), $s), showkv($s.Bag), "Bag sum reduce works on an empty bag and a set";
    is showkv([(+)] $s, $b), 'blood:3 love:3 rhetoric:1', "Bag sum reduce works on a set and a bag";
    is showkv([(+)] $s, $b, $kb), 'blood:4 love:5 rhetoric:1', "Bag sum reduce works on a set, a bag, and a baghash";

    is showkv([⊍] @d), '', "Bag multiply reduce works on nothing";
    is showkv([⊍] $s), showkv($s.Bag), "Bag multiply reduce works on one set";
    is showkv([⊍] $s, $b), 'blood:2 love:2', "Bag multiply reduce works on two sets";
    is showkv([⊍] $s, $b, $kb), 'blood:2 love:4', "Bag multiply reduce works on three sets";

    is showkv([(.)] @d), '', "Bag multiply reduce works on nothing";
    is showkv([(.)] $s), showkv($s.Bag), "Bag multiply reduce works on one set";
    is showkv([(.)] $s, $b), 'blood:2 love:2', "Bag multiply reduce works on two sets";
    is showkv([(.)] $s, $b, $kb), 'blood:2 love:4', "Bag multiply reduce works on three sets";

    is showkv([(^)] @d), '', "Bag symmetric difference reduce works on nothing";
    is showkv([(^)] $s), showkv($s), "Set symmetric difference reduce works on one set";
    isa-ok ([(^)] $s), Set, "Set symmetric difference reduce works on one set, yields set";
    is showkv([(^)] $b), showkv($b), "Bag symmetric difference reduce works on one bag";
    isa-ok ([(^)] $b), Bag, "Bag symmetric difference reduce works on one bag, yields bag";
    is showkv([(^)] $s, $b), 'blood:1 love:1 rhetoric:1', "Bag symmetric difference reduce works on a bag and a set";
    isa-ok ([(^)] $s, $b), Bag, "... and produces a Bag";
    is showkv([(^)] $b, $s), 'blood:1 love:1 rhetoric:1', "... and is actually symmetric";
    isa-ok ([(^)] $b, $s), Bag, "... and still produces a Bag that way too";
    is showkv([(^)] $s, $ks, $kb), 'love:1 rhetoric:1', "Bag symmetric difference reduce works on three bags";
    isa-ok ([(^)] $s, $ks, $kb), Bag, "Bag symmetric difference reduce works on three bags";
}

# vim: ft=perl6
