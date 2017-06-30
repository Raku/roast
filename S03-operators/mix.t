use v6;
use Test;

plan 82;

sub showset($b) { $b.keys.sort.join(' ') }
sub showkv($x) { $x.sort.map({ .key ~ ':' ~ .value }).join(' ') }

# "We're more of the love, blood, and rhetoric school. Well, we can do you blood
# and love without the rhetoric, and we can do you blood and rhetoric without
# the love, and we can do you all three concurrent or consecutive. But we can't
# give you love and rhetoric without the blood. Blood is compulsory. They're all
# blood, you see." -- Tom Stoppard

my $b = bag <blood love>;
my $bh = BagHash.new(<blood rhetoric>);
my $m = ("blood" => 1.1, "rhetoric" => 1, "love" => 1.2).Mix;
my $mh = MixHash.new-from-pairs("blood" => 1.1, "love" => 1.3);

# Mix Union tests moved to union.t

# Mix Intersection tests moved to intersection.t

# symmetric difference

sub symmetric-difference($a, $m) {
    ($a (|) $m) (-) ($m (&) $a)
}

is ($b (^) $m), symmetric-difference($b, $m), "Mix symmetric difference with Bag is correct";
isa-ok ($b (^) $m), Mix, "... and it's actually a Mix";
is ($m (^) $b), symmetric-difference($b, $m), "Bag symmetric difference with Mix is correct";
isa-ok ($m (^) $b), Mix, "... and it's actually a Mix";

is ($b (^) $mh), symmetric-difference($b, $mh), "MixHash symmetric difference with Bag is correct";
isa-ok ($b (^) $mh), Mix, "... and it's actually a Mix";
is ($mh (^) $b), symmetric-difference($b, $mh), "Bag symmetric difference with MixHash is correct";
isa-ok ($mh (^) $b), Mix, "... and it's actually a Mix";

# Mix multiplication

is showkv($m ⊍ $m), "blood:1.21 love:1.44 rhetoric:1", "Mix multiplication with itself yields self squared";
isa-ok ($m ⊍ $m), Mix, "... and it's actually a Mix";
is showkv($mh ⊍ $mh), "blood:1.21 love:1.69", "MixHash multiplication with itself yields self squared";
isa-ok ($mh ⊍ $mh), Mix, "... and it's actually a Mix";

is showkv($b ⊍ $m), "blood:1.1 love:1.2", "Mix multiplication (Bag / Mix) works";
isa-ok ($b ⊍ $m), Mix, "... and it's actually a Mix";
is showkv($bh ⊍ $m), "blood:1.1 rhetoric:1", "Mix multiplication (BagHash / Mix) works";
isa-ok ($bh ⊍ $m), Mix, "... and it's actually a Mix";
is showkv($mh ⊍ $m), "blood:1.21 love:1.56", "Mix multiplication (MixHash / Mix) works";
isa-ok ($mh ⊍ $m), Mix, "... and it's actually a Mix";

is showkv($b (.) $m), "blood:1.1 love:1.2", "Mix multiplication (Bag / Mix) works (texas)";
isa-ok ($b (.) $m), Mix, "... and it's actually a Mix (texas)";
is showkv($bh (.) $m), "blood:1.1 rhetoric:1", "Mix multiplication (BagHash / Mix) works (texas)";
isa-ok ($bh (.) $m), Mix, "... and it's actually a Mix (texas)";
is showkv($mh (.) $m), "blood:1.21 love:1.56", "Mix multiplication (MixHash / Mix) works (texas)";
isa-ok ($mh (.) $m), Mix, "... and it's actually a Mix";

# Mix addition tests moved to addition.t

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
    ok $mh (>+) $m, "Our MixHash is a msuperset of our Mix (Texas)";
    nok $m (>+) $mh, "Our Mix is not a msuperset of our MixHash (Texas)";
    ok $m (>+) $m, "Our Mix is a msuperset of itself (Texas)";
    ok $mh (>+) $mh, "Our MixHash is a msuperset of itself (Texas)";
}

{

    my $b     = (e => 1.1).Mix;
    my $bub   = (n => 2.2, e => 2.2, d => 2.2).Mix;
    my $buper = (n => 2.2, e => 4.4, d => 2.2, y => 2.2).Mix;

    ok $b ⊂ $bub, "⊂ - {$b.gist} is a strict submix of {$bub.gist}";
    ok $bub ⊄ $buper, "⊄ - {$bub.gist} is not a strict submix of {$buper.gist}";
    ok $bub ⊃ $b, "⊃ - {$bub.gist} is a strict supermix of {$b.gist}";
    ok $b (<) $bub, "(<) - {$b.gist} is a strict submix of {$bub.gist} (texas)";
    ok $bub !(<) $buper, "!(<) - {$bub.gist} is not a strict submix of {$buper.gist} (texas)";
    ok $bub (>) $b, "(>) - {$bub.gist} is a strict supermix of {$b.gist} (texas)";
    ok $buper !(>) $bub, "!(>) - {$buper.gist} is not a strict supermix of {$bub.gist}";
}

{
    my @d;
    # XXX: without this initialization, the test harness breaks on 196
    my $tm = %(blood => 2.1, love => 2.2, rhetoric => 1).Mix;

    is ([⊎] @d), ∅, "Mix sum reduce works on nothing";
    is ([⊎] $b), $b.Mix, "Mix sum reduce works on one bag";
    is ([⊎] $b, $m), %(blood => 2.1, love => 2.2, rhetoric => 1).Mix, "Mix sum reduce works on a bag and a mix";
    is ([⊎] $b, $m, $mh), %(blood => 3.2, love => 3.5, rhetoric => 1).Mix, "Mix sum reduce works on a bag, a mix, and a mixhash";
    is ([⊎] $mh, $m, $b), %(blood => 3.2, love => 3.5, rhetoric => 1).Mix, "Mix sum reduce works on a bag, a mix, and a mixhash and order doesn't matter";

    is ([(+)] @d), ∅, "Mix sum reduce works on nothing (Texas)";
    is ([(+)] $m), $m, "Mix sum reduce works on one set (Texas)";
    is ([(+)] bag(), $m), $m, "Mix sum reduce with an empty bag should be the value of the mix (Texas)";
    is ([(+)] $m, bag()), $m, "Mix sum reduce with an empty bag should be the value of the mix and is symmetric (Texas)";
    is ([(+)] $b, $m), %(blood => 2.1, love => 2.2, rhetoric => 1).Mix, "Mix sum reduce works on bag and mix sets (Texas)";
    is ([(+)] $m, $b), %(blood => 2.1, love => 2.2, rhetoric => 1).Mix, "Mix sum reduce works on bag and mix and is symmetric (Texas)";
    is ([(+)] $b, $m, $mh), %(blood => 3.2, love => 3.5, rhetoric => 1).Mix, "Mix sum reduce works on a bag, a mix, and a mixhash (Texas)";
    is ([(+)] $mh, $m, $b), %(blood => 3.2, love => 3.5, rhetoric => 1).Mix, "Mix sum reduce works on a bag, a mix, and a mixhash and order doesn't matter (Texas)";

    is ([⊍] @d), ∅, "Mix multiply reduce works on nothing";
    is ([⊍] $b), $b.Mix, "Mix multiply reduce works on one set";
    is ([⊍] $b, $m), %( blood => 1.1, love => 1.2 ).Mix, "Mix multiply reduce works on two sets";
    is ([⊍] $m, $b), %( blood => 1.1, love => 1.2 ).Mix, "Mix multiply reduce works on a bag and a mix and is symmetric";
    is ([⊍] $b, $m, $mh), %( blood => 1.21, love => 1.56 ).Mix, "Mix multiply reduce works on a bag, a mix, and a mixhash";
    is ([⊍] $m, $b, $mh), %( blood => 1.21, love => 1.56 ).Mix, "Mix multiply reduce works on a bag, a mix, and a mixhash and order doesn't matter";

    is ([(.)] @d), ∅, "Mix multiply reduce works on nothing (Texas)";
    is ([(.)] $b), $b.Mix, "Mix multiply reduce works on one set (Texas)";
    is ([(.)] $b, $m), %( blood => 1.1, love => 1.2 ).Mix, "Mix multiply reduce works on a bag and a mix (Texas)";
    is ([(.)] $m, $b), %( blood => 1.1, love => 1.2 ).Mix, "Mix multiply reduce works on a bag and a mix and is symmetric (Texas)";
    is ([(.)] $b, $m, $mh), %( blood => 1.21, love => 1.56 ).Mix, "Mix multiply reduce works on a bag, a mix, and a mixhash (Texas)";
    is ([(.)] $m, $b, $mh), %( blood => 1.21, love => 1.56 ).Mix, "Mix multiply reduce works on a bag, a mix, and a mixhash and order doesn't matter (Texas)";

    is ([(^)] @d), ∅, "Mix symmetric difference reduce works on nothing";
    is ([(^)] $m), $m, "Mix symmetric difference reduce works on one mix";
    isa-ok ([(^)] $m), Mix, "Mix symmetric difference reduce works on one mix, yields mix";
    is ([(^)] $b, $m), %(blood => 0.1, love => 0.2, :rhetoric).Mix, "Mix symmetric difference reduce works on a mix and a bag";
    isa-ok ([(^)] $b, $m), Mix, "... and produces a Mix";
    is ([(^)] $m, $b), %(blood => 0.1, love => 0.2, :rhetoric).Mix, "... and is actually symmetric";
    isa-ok ([(^)] $m, $b), Mix, "... and still produces a Mix that way too";
    is ([(^)] $b, $m, $mh), (blood => 1, love => 1.1, :rhetoric).Mix, "Mix symmetric difference reduce works on three mixes";
    isa-ok ([(^)] $b, $m, $mh), Mix, "Mix symmetric difference reduce works on three mixes produces a Mix";
}

# vim: ft=perl6
