use v6;
use Test;

plan 128;

sub showset($b) { $b.keys.sort.join(' ') }

sub showkv($x) {
    $x.keys.sort.map({ $^k ~ ':' ~ $x{$k} }).join(' ')
}

# "We're more of the love, blood, and rhetoric school. Well, we can do you blood
# and love without the rhetoric, and we can do you blood and rhetoric without
# the love, and we can do you all three concurrent or consecutive. But we can't
# give you love and rhetoric without the blood. Blood is compulsory. They're all
# blood, you see." -- Tom Stoppard

my $b = bag <blood love>;
my $bh = BagHash.new(<blood rhetoric>);
my $m = ("blood" => 1.1, "rhetoric" => 1, "love" => 1.2).Mix;
my $mh = MixHash.new-from-pairs("blood" => 1.1, "love" => 1.3);

# Mix Union

is showkv($m ∪ $m), showkv($m), "Mix union with itself yields self";
isa_ok ($m ∪ $m), Mix, "... and it's actually a Mix";
is showkv($mh ∪ $mh), showkv($mh), "MixHash union with itself yields (as Mix)";
isa_ok ($mh ∪ $mh), Mix, "... and it's actually a Mix";

is showkv($b ∪ $m), "blood:1.1 love:1.2 rhetoric:1", "Bag union with Mix works";
isa_ok ($b ∪ $m), Mix, "... and it's actually a Mix";
is showkv($b ∪ $mh), "blood:1.1 love:1.3", "Bag union with MixHash works";
isa_ok ($b ∪ $mh), Mix, "... and it's actually a Mix";

is showkv($b (|) $m), "blood:1.1 love:1.2 rhetoric:1", "Bag union with Mix works (texas)";
isa_ok ($b (|) $m), Mix, "... and it's actually a Mix";
is showkv($b (|) $mh), "blood:1.1 love:1.3", "Bag union with MixHash works (texas)";
isa_ok ($b (|) $mh), Mix, "... and it's actually a Mix";

# Mix Intersection

is showkv($m ∩ $m), showkv($m), "Mix intersection with itself yields self (as Mix)";
isa_ok ($m ∩ $m), Mix, "... and it's actually a Mix";
is showkv($mh ∩ $mh), showkv($mh), "MixHash intersection with itself yields self (as Mix)";
isa_ok ($mh ∩ $mh), Mix, "... and it's actually a Mix";

is showkv($b ∩ $m), "blood:1 love:1", "Bag intersection with Mix works";
isa_ok ($b ∩ $m), Mix, "... and it's actually a Mix";
is showkv($b ∩ $mh), "blood:1 love:1", "Bag intersection with MixHash works";
isa_ok ($b ∩ $mh), Mix, "... and it's actually a Mix";
#?niecza todo 'Right now this works as $mh ∩ glag ∩ green ∩ blood.  Test may be wrong'
is showkv($mh ∩ <glad green blood>), "blood:1", "MixHash intersection with array of strings works";
isa_ok ($mh ∩ <glad green blood>), Mix, "... and it's actually a Mix";

is showkv($b (&) $m), "blood:1 love:1", "Bag intersection with Mix works (texas)";
isa_ok ($b (&) $m), Mix, "... and it's actually a Mix";
is showkv($b (&) $mh), "blood:1 love:1", "Bag intersection with MixHash works (texas)";
isa_ok ($b (&) $mh), Mix, "... and it's actually a Mix";
#?niecza todo 'Right now this works as $mh ∩ glag ∩ green ∩ blood.  Test may be wrong?'
is showkv($mh (&) <glad green blood>), "blood:1", "MixHash intersection with array of strings works (texas)";
isa_ok ($mh (&) <glad green blood>), Mix, "... and it's actually a Mix";

# symmetric difference

sub symmetric-difference($a, $m) {
    ($a (|) $m) (-) ($m (&) $a)
}

#?rakudo 8 skip "Rakudo update in progress, but not done yet"

is showkv($b (^) $m), showkv(symmetric-difference($b, $m)), "Mix symmetric difference with Bag is correct";
isa_ok ($b (^) $m), Mix, "... and it's actually a Mix";
is showkv($m (^) $b), showkv(symmetric-difference($b, $m)), "Bag symmetric difference with Mix is correct";
isa_ok ($m (^) $b), Mix, "... and it's actually a Mix";

#?niecza todo "Test is wrong, implementation is wrong"
is showkv($b (^) $mh), showkv(symmetric-difference($b, $mh)), "MixHash symmetric difference with Bag is correct";
isa_ok ($b (^) $mh), Mix, "... and it's actually a Mix";
#?niecza todo "Test is wrong, implementation is wrong"
is showkv($mh (^) $b), showkv(symmetric-difference($b, $mh)), "Bag symmetric difference with MixHash is correct";
isa_ok ($mh (^) $b), Mix, "... and it's actually a Mix";

# Mix multiplication

is showkv($m ⊍ $m), "blood:1.21 love:1.44 rhetoric:1", "Mix multiplication with itself yields self squared";
isa_ok ($m ⊍ $m), Mix, "... and it's actually a Mix";
is showkv($mh ⊍ $mh), "blood:1.21 love:1.69", "MixHash multiplication with itself yields self squared";
isa_ok ($mh ⊍ $mh), Mix, "... and it's actually a Mix";

is showkv($b ⊍ $m), "blood:1.1 love:1.2", "Mix multiplication (Bag / Mix) works";
isa_ok ($b ⊍ $m), Mix, "... and it's actually a Mix";
is showkv($bh ⊍ $m), "blood:1.1 rhetoric:1", "Mix multiplication (BagHash / Mix) works";
isa_ok ($bh ⊍ $m), Mix, "... and it's actually a Mix";
is showkv($mh ⊍ $m), "blood:1.21 love:1.56", "Mix multiplication (MixHash / Mix) works";
isa_ok ($mh ⊍ $m), Mix, "... and it's actually a Mix";

is showkv($b (.) $m), "blood:1.1 love:1.2", "Mix multiplication (Bag / Mix) works (texas)";
isa_ok ($b (.) $m), Mix, "... and it's actually a Mix (texas)";
is showkv($bh (.) $m), "blood:1.1 rhetoric:1", "Mix multiplication (BagHash / Mix) works (texas)";
isa_ok ($bh (.) $m), Mix, "... and it's actually a Mix (texas)";
is showkv($mh (.) $m), "blood:1.21 love:1.56", "Mix multiplication (MixHash / Mix) works (texas)";
isa_ok ($mh (.) $m), Mix, "... and it's actually a Mix";

# Mix addition

is showkv($m ⊎ $m), "blood:2.2 love:2.4 rhetoric:2", "Mix addition with itself yields twice self";
isa_ok ($m ⊎ $m), Mix, "... and it's actually a Mix";
is showkv($mh ⊎ $mh), "blood:2.2 love:2.6", "Mix addition with itself yields twice self";
isa_ok ($mh ⊎ $mh), Mix, "... and it's actually a Mix";

is showkv($b ⊎ $m), "blood:2.1 love:2.2 rhetoric:1", "Mix addition (Bag / Mix) works";
isa_ok ($b ⊎ $m), Mix, "... and it's actually a Mix";
is showkv($bh ⊎ $m), "blood:2.1 love:1.2 rhetoric:2", "Mix addition (BagHash / Mix) works";
isa_ok ($bh ⊎ $m), Mix, "... and it's actually a Mix";
is showkv($mh ⊎ $m), "blood:2.2 love:2.5 rhetoric:1", "Mix addition (MixHash / Mix) works";
isa_ok ($mh ⊎ $m), Mix, "... and it's actually a Mix";

is showkv($b (+) $m), "blood:2.1 love:2.2 rhetoric:1", "Mix addition (Bag / Mix) works (texas)";
isa_ok ($b (+) $m), Mix, "... and it's actually a Mix (texas)";
is showkv($bh (+) $m), "blood:2.1 love:1.2 rhetoric:2", "Mix addition (BagHash / Mix) works (texas)";
isa_ok ($bh (+) $m), Mix, "... and it's actually a Mix (texas)";
is showkv($mh (+) $m), "blood:2.2 love:2.5 rhetoric:1", "Mix addition (MixHash / Mix) works (texas)";
isa_ok ($mh (+) $m), Mix, "... and it's actually a Mix";

# for https://rt.perl.org/Ticket/Display.html?id=122810
ok mix(my @large_arr = ("a"...*)[^50000]), "... a large array goes into a bar - I mean mix - with 50k elems and lives";

# msubset
{
    # adding a local MixHash here to avoid redoing all of the multiplication/addition return values
    my $mh = MixHash.new-from-pairs("blood" => 1.1, "love" => 1.3, "rhetoric" => 2.2);

    nok $mh ≼ $m, "Our MixHash is not a msubset of our Mix";
    ok $m ≼ $mh, "Our Mix is a msubset of our MixHash";
    ok $m ≼ $m, "Our Mix is a msubset of itself";
    ok $mh ≼ $mh, "Our MixHash is a msubset of itself";
    #?niecza 4 skip '(<+) NYI - https://github.com/sorear/niecza/issues/178'
    nok $mh (<+) $m, "Our MixHash is not a msubset of our Mix (texas)";
    ok $m (<+) $mh, "Our Mix is a msubset of our MixHash (texas)";
    ok $m (<+) $m, "Our Mix is a msubset of itself (texas)";
    ok $mh (<+) $mh, "Our MixHash is a msubset of itself (texas)";
}

# msuperset
{
    # adding a local MixHash here to avoid redoing all of the multiplication/addition return values
    my $mh = MixHash.new-from-pairs("blood" => 1.1, "love" => 1.3, "rhetoric" => 2.2);

    ok $mh ≽ $m, "Our MixHash is a msuperset of our Mix";
    nok $m ≽ $mh, "Our Mix is not a msuperset of our MixHash";
    ok $m ≽ $m, "Our mix is a msuperset of itself";
    ok $mh ≽ $mh, "Our keymix is a msuperset of itself";
    #?niecza 4 skip '(>+) NYI - https://github.com/sorear/niecza/issues/178'
    ok $mh (>+) $m, "Our MixHash is a msuperset of our Mix (Texas)";
    nok $m (>+) $mh, "Our Mix is not a msuperset of our MixHash (Texas)";
    ok $m (>+) $m, "Our Mix is a msuperset of itself (Texas)";
    ok $mh (>+) $mh, "Our MixHash is a msuperset of itself (Texas)";
}

{

    my $b     = mix "e" => 1.1;
    my $bub   = mix "n" => 2.2, "e" => 2.2, "d" => 2.2;
    my $buper = mix "n" => 2.2, "e" => 4.4, "d" => 2.2, "y" => 2.2;

    #?rakudo 15 skip 'submix behavior still under discussion'
    ok $b ⊂ $bub, "⊂ - {$b.gist} is a strict submix of {$bub.gist}";
    ok $bub ⊄ $buper, "⊄ - {$bub.gist} is not a strict submix of {$buper.gist}";
    ok $bub ⊆ $buper, "⊆ - {$bub.gist} is a submix of {$buper.gist}";
    ok $buper ⊈ $bub, "⊈ - {$buper.gist} is not a submix of {$bub.gist}";
    ok $bub ⊃ $b, "⊃ - {$bub.gist} is a strict supermix of {$b.gist}";
    ok $buper ⊅ $bub, "⊅ - {$buper.gist} is not a strict supermix of {$bub.gist}";
    ok $buper ⊇ $bub, "⊇ - {$buper.gist} is a supermix of {$bub.gist}"; 
    ok $bub ⊉ $buper, "⊉ - {$bub.gist} is not a supermix of {$buper.gist}";
    ok $b (<) $bub, "(<) - {$b.gist} is a strict submix of {$bub.gist} (texas)";
    ok $bub !(<) $buper, "!(<) - {$bub.gist} is not a strict submix of {$buper.gist} (texas)";
    ok $bub (>) $b, "(>) - {$bub.gist} is a strict supermix of {$b.gist} (texas)";
    ok $buper !(>) $bub, "!(>) - {$buper.gist} is not a strict supermix of {$bub.gist}";
    ok $bub (<=) $buper, "(<=) - {$bub.gist} submix {$buper.gist} (texas)";
    ok $buper !(<=) $bub, "!(<=) - {$buper.gist} is not a submix of {$bub.gist} (texas)";
    ok $buper (>=) $bub, "(>=) - {$buper.gist} is a supermix of {$bub.gist} (texas)"; 
    ok $bub !(>=) $buper, "!(>=) - {$bub.gist} is not a supermix of {$buper.gist} (texas)";
}

{
    # my $b = set <blood love>;
    # my $bh = BagHash.new(<blood rhetoric>);
    # my $m = mix <blood blood rhetoric love love>;
    # my $mh = MixHash.new(<blood love love>);
    my @d;
    
    is showkv([⊎] @d), showkv(∅), "Mix sum reduce works on nothing";
    is showkv([⊎] $b), showkv($b.Mix), "Mix sum reduce works on one set";
    is showkv([⊎] $b, $m), showkv({ blood => 2.1, love => 2.2, rhetoric => 1 }), "Mix sum reduce works on two sets";
    is showkv([⊎] $b, $m, $mh), showkv({ blood => 3.2, love => 3.5, rhetoric => 1 }), "Mix sum reduce works on three sets";

    is showkv([(+)] @d), showkv(∅), "Mix sum reduce works on nothing (Texas)";
    is showkv([(+)] $m), showkv($m), "Mix sum reduce works on one set (Texas)";
    is showkv([(+)] $b, $m), showkv({ blood => 2.1, love => 2.2, rhetoric => 1 }), "Mix sum reduce works on two sets (Texas)";
    is showkv([(+)] $b, $m, $mh), showkv({ blood => 3.2, love => 3.5, rhetoric => 1 }), "Mix sum reduce works on three sets (Texas)";

    is showkv([⊍] @d), showkv(∅), "Mix multiply reduce works on nothing";
    is showkv([⊍] $b), showkv($b.Mix), "Mix multiply reduce works on one set";
    is showkv([⊍] $b, $m), showkv({ blood => 1.1, love => 1.2 }), "Mix multiply reduce works on two sets";
    is showkv([⊍] $b, $m, $mh), showkv({ blood => 1.21, love => 1.56 }), "Mix multiply reduce works on three sets";

    is showkv([(.)] @d), showkv(∅), "Mix multiply reduce works on nothing (Texas)";
    is showkv([(.)] $b), showkv($b.Mix), "Mix multiply reduce works on one set (Texas)";
    is showkv([(.)] $b, $m), showkv({ blood => 1.1, love => 1.2 }), "Mix multiply reduce works on two sets (Texas)";
    is showkv([(.)] $b, $m, $mh), showkv({ blood => 1.21, love => 1.56 }), "Mix multiply reduce works on three sets (Texas)";

    #?rakudo 5 skip "Crashing"
    is showkv([(^)] @d), showset(∅), "Mix symmetric difference reduce works on nothing";
    is showkv([(^)] $b), showset($b), "Bag symmetric difference reduce works on one set";
    isa_ok showkv([(^)] $b), Bag, "Bag symmetric difference reduce works on one set, yields set";
    is showkv([(^)] $m), showkv($m), "Mix symmetric difference reduce works on one mix";
    isa_ok showkv([(^)] $m), Mix, "Mix symmetric difference reduce works on one mix, yields mix";
    #?rakudo 4 skip "Wrong answer at the moment"
    is showkv([(^)] $b, $m), showkv({ blood => 1, love => 1, rhetoric => 1 }), "Mix symmetric difference reduce works on a mix and a set";
    isa_ok showkv([(^)] $b, $m), Mix, "... and produces a Mix";
    is showkv([(^)] $m, $b), showkv({ blood => 1, love => 1, rhetoric => 1 }), "... and is actually symmetric";
    isa_ok showkv([(^)] $m, $b), Mix, "... and still produces a Mix that way too";
    #?rakudo 2 skip "Crashing"
    is showkv([(^)] $b, $m, $mh), showkv({ blood => 1, love => 1, rhetoric => 1 }), "Mix symmetric difference reduce works on three mixs";
    isa_ok showkv([(^)] $b, $m, $mh), Mix, "Mix symmetric difference reduce works on three mixs";
}

# vim: ft=perl6
