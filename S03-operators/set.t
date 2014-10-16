use v6;
use Test;

plan 292;

sub showset($s) { $s.keys.sort.join(' ') }
sub showkv($x) { $x.keys.sort.map({ $^k ~ ':' ~ $x{$k} }).join(' ') }

my $s = set <I'm afraid it isn't your day>;
my $ks = SetHash.new(<I'm afraid it is>); # Tom Stoppard
my $b = bag <Whoever remains for long here in this earthly life will enjoy and endure more than enough>; # Seamus Heaney
my $kb = BagHash.new(<Come, take your bread with joy, and your wine with a glad heart>); # Ecclesiastes 9:7

# Is an element of

ok "afraid" ∈ $s, "afraid is an element of Set";
ok "afraid" ∈ $ks, "afraid is an element of SetHash";
ok "earthly" ∈ $b, "earthly is an element of Bag";
ok "your" ∈ $kb, "heaven is an element of BagHash";
ok "d" ∈ <a b c d e>, "d is an element of a b c d e";

ok "afraid" (elem) $s, "afraid is an element of Set (texas)";
ok "afraid" (elem) $ks, "afraid is an element of SetHash (texas)";
ok "earthly" (elem) $b, "earthly is an element of Bag (texas)";
ok "your" (elem) $kb, "heaven is an element of BagHash (texas)";
ok "d" (elem) <a b c d e>, "d is an element of a b c d e (texas)";

# Is not an element of

ok "marmoset" ∉ $s, "marmoset is not an element of Set";
ok "marmoset" ∉ $ks, "marmoset is not an element of SetHash";
ok "marmoset" ∉ $b, "marmoset is not an element of Bag";
ok "marmoset" ∉ $kb, "marmoset is not an element of BagHash";
ok "marmoset" ∉ <a b c d e>, "marmoset is not an element of a b c d e";

ok "hogwash" !(elem) $s, "hogwash is not an element of Set (texas)";
ok "hogwash" !(elem) $ks, "hogwash is not an element of SetHash (texas)";
ok "hogwash" !(elem) $b, "hogwash is not an element of Bag (texas)";
ok "hogwash" !(elem) $kb, "hogwash is not an element of BagHash (texas)";
ok "hogwash" !(elem) <a b c d e>, "hogwash is not an element of a b c d e (texas)";

# Contains

ok $s ∋ "afraid", "afraid is contained by Set";
ok $ks ∋ "afraid", "afraid is contained by SetHash";
ok $b ∋ "earthly", "earthly is contained by Bag";
ok $kb ∋ "your", "heaven is contained by BagHash";
ok <a b c d e> ∋ "d", "d is contained by a b c d e";

ok $s (cont) "afraid", "afraid is contained by Set";
ok $ks (cont) "afraid", "afraid is contained by SetHash";
ok $b (cont) "earthly", "earthly is contained by Bag";
ok $kb (cont) "your", "heaven is contained by BagHash";
ok <a b c d e> (cont) "d", "d is contained by a b c d e";

# Does not contain

ok $s ∌ "marmoset", "marmoset is not contained by Set";
ok $ks ∌ "marmoset", "marmoset is not contained by SetHash";
ok $b ∌ "marmoset", "marmoset is not contained by Bag";
ok $kb ∌ "marmoset", "marmoset is not contained by BagHash";
ok <a b c d e> ∌ "marmoset", "marmoset is not contained by a b c d e";

ok $s !(cont) "marmoset", "marmoset is not contained by Set";
ok $ks !(cont) "marmoset", "marmoset is not contained by SetHash";
ok $b !(cont) "marmoset", "marmoset is not contained by Bag";
ok $kb !(cont) "marmoset", "marmoset is not contained by BagHash";
ok <a b c d e> !(cont) "marmoset", "marmoset is not contained by a b c d e";

# Union

is showset($s ∪ $s), showset($s), "Set union with itself yields self";
isa_ok ($s ∪ $s), Set, "... and it's actually a Set";
is showset($ks ∪ $ks), showset($ks), "SetHash union with itself yields self (as Set)";
isa_ok ($ks ∪ $ks), Set, "... and it's actually a Set";

is showset($s ∪ $ks), showset(set <I'm afraid it is isn't your day>), "Set union with SetHash works";
isa_ok ($s ∪ $ks), Set, "... and it's actually a Set";
is showset($ks ∪ <blue green>), showset(set <I'm afraid it is blue green>), "SetHash union with array of strings works";
isa_ok ($ks ∪ <blue green>), Set, "... and it's actually a Set";

is showset($s (|) $ks), showset(set <I'm afraid it is isn't your day>), "Set union with SetHash works (texas)";
isa_ok ($s (|) $ks), Set, "... and it's actually a Set (texas)";
is showset($ks (|) <blue green>), showset(set <I'm afraid it is blue green>), "SetHash union with array of strings works (texas)";
isa_ok ($ks (|) <blue green>), Set, "... and it's actually a Set (texas)";

# Intersection

is showset($s ∩ $s), showset($s), "Set intersection with itself yields self";
isa_ok ($s ∩ $s), Set, "... and it's actually a Set";
is showset($ks ∩ $ks), showset($ks), "SetHash intersection with itself yields self (as Set)";
isa_ok ($ks ∩ $ks), Set, "... and it's actually a Set";
is showset($s ∩ $ks), showset(set <I'm afraid it>), "Set intersection with SetHash works";
isa_ok ($s ∩ $ks), Set, "... and it's actually a Set";

is showset($s (&) $ks), showset(set <I'm afraid it>), "Set intersection with SetHash works (texas)";
isa_ok ($s (&) $ks), Set, "... and it's actually a Set (texas)";

# set subtraction

is showset($s (-) $s), showset(∅), "Set subtracted from Set is correct";
isa_ok ($s (-) $s), Set, "... and it's actually a Set";

is showset($s (-) $ks), showset(set <isn't your day>), "SetHash subtracted from Set is correct";
isa_ok ($s (-) $ks), Set, "... and it's actually a Set";
is showset($ks (-) $s), showset(set <is>), "Set subtracted from SetHash is correct";
isa_ok ($ks (-) $s), Set, "... and it's actually a Set";

is showkv($b (-) $s), showkv($b), "Set subtracted from Bag is correct";
isa_ok ($b (-) $s), Bag, "... and it's actually a Bag";
is showset($s (-) $b), showset($s), "Bag subtracted from Set is correct";
isa_ok ($s (-) $b), Set, "... and it's actually a Set";

is showset($s (-) $kb), showset(set <I'm afraid it isn't day>), "BagHash subtracted from Set is correct";
isa_ok ($s (-) $kb), Set, "... and it's actually a Set";
is showkv($kb (-) $s), showkv(<Come, take your bread with joy, and wine with a glad heart>.Bag), "Set subtracted from BagHash is correct";
isa_ok ($kb (-) $s), Bag, "... and it's actually a Bag";

# symmetric difference

is showset($s (^) $s), showset(∅), "Set symmetric difference with Set is correct";
isa_ok ($s (^) $s), Set, "... and it's actually a Set";

is showset($s (^) $ks), showset(set <is isn't your day>), "SetHash symmetric difference with Set is correct";
isa_ok ($s (^) $ks), Set, "... and it's actually a Set";
is showset($ks (^) $s), showset(set <is isn't your day>), "Set symmetric difference with SetHash is correct";
isa_ok ($ks (^) $s), Set, "... and it's actually a Set";

# RT #122882
is showset($s (^) $s (^) $s), showset(∅), "Set symmetric difference with 3+ args (RT #122882)";
is showset(<a b> (^) <b c> (^) <a d> (^) <a e>), showset(set <c d e>), "Set symmetric difference with 3+ args (RT #122882)";

# symmetric difference with Bag moved to bag.t

# is subset of

ok <your day> ⊆ $s, "'Your day' is subset of Set";
ok $s ⊆ $s, "Set is subset of itself";
ok $s ⊆ <I'm afraid it isn't your day old chum>, "Set is subset of string";

ok ($ks (-) set <is>) ⊆ $ks, "Set is subset of SetHash";
ok $ks ⊆ $ks, "SetHash is subset of itself";
ok $ks ⊆ <I'm afraid it is my day>, "SetHash is subset of string";

nok $s ⊆ $b, "Set is not a subset of Bag";
ok $b ⊆ $b, "Bag is subset of itself";
nok $b ⊆ $s, "Bag is not a subset of Set";

nok $s ⊆ $kb, "Set is not a subset of BagHash";
ok $kb ⊆ $kb, "BagHash is subset of itself";
nok $kb ⊆ $s, "BagHash is not a subset of Set";

ok <your day> (<=) $s, "'Your day' is subset of Set";
ok $s (<=) $s, "Set is subset of itself";
ok $s (<=) <I'm afraid it isn't your day old chum>, "Set is subset of string";

ok ($ks (-) set <is>) (<=) $ks, "Set is subset of SetHash (texas)";
ok $ks (<=) $ks, "SetHash is subset of itself (texas)";
ok $ks (<=) <I'm afraid it is my day>, "SetHash is subset of string (texas)";

nok $s (<=) $b, "Set is not a subset of Bag (texas)";
ok $b (<=) $b, "Bag is subset of itself (texas)";
nok $b (<=) $s, "Bag is not a subset of Set (texas)";

nok $s (<=) $kb, "Set is not a subset of BagHash (texas)";
ok $kb (<=) $kb, "BagHash is subset of itself (texas)";
nok $kb (<=) $s, "BagHash is not a subset of Set (texas)";

# is not a subset of
nok <your day> ⊈ $s, "'Your day' is subset of Set";
nok $s ⊈ $s, "Set is subset of itself";
nok $s ⊈ <I'm afraid it isn't your day old chum>, "Set is subset of string";

nok ($ks (-) set <is>) ⊈ $ks, "Set is subset of SetHash";
nok $ks ⊈ $ks, "SetHash is subset of itself";
nok $ks ⊈ <I'm afraid it is my day>, "SetHash is subset of string";

ok $s ⊈ $b, "Set is not a subset of Bag";
nok $b ⊈ $b, "Bag is subset of itself";
ok $b ⊈ $s, "Bag is not a subset of Set";

ok $s ⊈ $kb, "Set is not a subset of BagHash";
nok $kb ⊈ $kb, "BagHash is subset of itself";
ok $kb ⊈ $s, "BagHash is not a subset of Set";

nok <your day> !(<=) $s, "'Your day' is subset of Set (texas)";
nok $s !(<=) $s, "Set is subset of itself (texas)";
nok $s !(<=) <I'm afraid it isn't your day old chum>, "Set is subset of string (texas)";

nok ($ks (-) set <is>) !(<=) $ks, "Set is subset of SetHash (texas)";
nok $ks !(<=) $ks, "SetHash is subset of itself (texas)";
nok $ks !(<=) <I'm afraid it is my day>, "SetHash is subset of string (texas)";

ok $s !(<=) $b, "Set is not a subset of Bag (texas)";
nok $b !(<=) $b, "Bag is subset of itself (texas)";
ok $b !(<=) $s, "Bag is not a subset of Set (texas)";

ok $s !(<=) $kb, "Set is not a subset of BagHash (texas)";
nok $kb !(<=) $kb, "BagHash is subset of itself (texas)";
ok $kb !(<=) $s, "BagHash is not a subset of Set (texas)";

# is proper subset of

ok <your day> ⊂ $s, "'Your day' is proper subset of Set";
nok $s ⊂ $s, "Set is not proper subset of itself";
ok $s ⊂ <I'm afraid it isn't your day old chum>, "Set is proper subset of string";

ok ($ks (-) set <is>) ⊂ $ks, "Set is proper subset of SetHash";
nok $ks ⊂ $ks, "SetHash is not proper subset of itself";
ok $ks ⊂ <I'm afraid it is my day>, "SetHash is proper subset of string";

nok $s ⊂ $b, "Set is not a proper subset of Bag";
nok $b ⊂ $b, "Bag is not proper subset of itself";
nok $b ⊂ $s, "Bag is not a proper subset of Set";

nok $s ⊂ $kb, "Set is not a proper subset of BagHash";
nok $kb ⊂ $kb, "BagHash is not proper subset of itself";
nok $kb ⊂ $s, "BagHash is not a proper subset of Set";

ok <your day> (<) $s, "'Your day' is proper subset of Set";
nok $s (<) $s, "Set is not proper subset of itself";
ok $s (<) <I'm afraid it isn't your day old chum>, "Set is proper subset of string";

ok ($ks (-) set <is>) (<) $ks, "Set is proper subset of SetHash (texas)";
nok $ks (<) $ks, "SetHash is not proper subset of itself (texas)";
ok $ks (<) <I'm afraid it is my day>, "SetHash is proper subset of string (texas)";

nok $s (<) $b, "Set is not a proper subset of Bag (texas)";
nok $b (<) $b, "Bag is not proper subset of itself (texas)";
nok $b (<) $s, "Bag is not a proper subset of Set (texas)";

nok $s (<) $kb, "Set is not a proper subset of BagHash (texas)";
nok $kb (<) $kb, "BagHash is not proper subset of itself (texas)";
nok $kb (<) $s, "BagHash is not a proper subset of Set (texas)";

# is not a proper subset of

nok <your day> ⊄ $s, "'Your day' is proper subset of Set";
ok $s ⊄ $s, "Set is not proper subset of itself";
nok $s ⊄ <I'm afraid it isn't your day old chum>, "Set is proper subset of string";

nok ($ks (-) set <is>) ⊄ $ks, "Set is proper subset of SetHash";
ok $ks ⊄ $ks, "SetHash is not proper subset of itself";
nok $ks ⊄ <I'm afraid it is my day>, "SetHash is proper subset of string";

ok $s ⊄ $b, "Set is not a proper subset of Bag";
ok $b ⊄ $b, "Bag is not proper subset of itself";
ok $b ⊄ $s, "Bag is not a proper subset of Set";

ok $s ⊄ $kb, "Set is not a proper subset of BagHash";
ok $kb ⊄ $kb, "BagHash is not proper subset of itself";
ok $kb ⊄ $s, "BagHash is not a proper subset of Set";

nok <your day> !(<) $s, "'Your day' is proper subset of Set (texas)";
ok $s !(<) $s, "Set is not proper subset of itself (texas)";
nok $s !(<) <I'm afraid it isn't your day old chum>, "Set is proper subset of string (texas)";

nok ($ks (-) set <is>) !(<) $ks, "Set is proper subset of SetHash (texas)";
ok $ks !(<) $ks, "SetHash is not proper subset of itself (texas)";
nok $ks !(<) <I'm afraid it is my day>, "SetHash is proper subset of string (texas)";

ok $s !(<) $b, "Set is not a proper subset of Bag (texas)";
ok $b !(<) $b, "Bag is not proper subset of itself (texas)";
ok $b !(<) $s, "Bag is not a proper subset of Set (texas)";

ok $s !(<) $kb, "Set is not a proper subset of BagHash (texas)";
ok $kb !(<) $kb, "BagHash is not proper subset of itself (texas)";
ok $kb !(<) $s, "BagHash is not a proper subset of Set (texas)";

# is superset of

ok <your day> R⊇ $s, "'Your day' is reversed superset of Set";
ok $s R⊇ $s, "Set is reversed superset of itself";
ok $s R⊇ <I'm afraid it isn't your day old chum>, "Set is reversed superset of string";

ok ($ks (-) set <is>) R⊇ $ks, "Set is reversed superset of SetHash";
ok $ks R⊇ $ks, "SetHash is reversed superset of itself";
ok $ks R⊇ <I'm afraid it is my day>, "SetHash is reversed superset of string";

nok $s R⊇ $b, "Set is not a reversed superset of Bag";
ok $b R⊇ $b, "Bag is reversed superset of itself";
nok $b R⊇ $s, "Bag is not a reversed superset of Set";

nok $s R⊇ $kb, "Set is not a reversed superset of BagHash";
ok $kb R⊇ $kb, "BagHash is reversed superset of itself";
nok $kb R⊇ $s, "BagHash is not a reversed superset of Set";

ok <your day> R(>=) $s, "'Your day' is reversed superset of Set";
ok $s R(>=) $s, "Set is reversed superset of itself";
ok $s R(>=) <I'm afraid it isn't your day old chum>, "Set is reversed superset of string";

ok ($ks (-) set <is>) R(>=) $ks, "Set is reversed superset of SetHash (texas)";
ok $ks R(>=) $ks, "SetHash is reversed superset of itself (texas)";
ok $ks R(>=) <I'm afraid it is my day>, "SetHash is reversed superset of string (texas)";

nok $s R(>=) $b, "Set is not a reversed superset of Bag (texas)";
ok $b R(>=) $b, "Bag is reversed superset of itself (texas)";
nok $b R(>=) $s, "Bag is not a reversed superset of Set (texas)";

nok $s R(>=) $kb, "Set is not a reversed superset of BagHash (texas)";
ok $kb R(>=) $kb, "BagHash is reversed superset of itself (texas)";
nok $kb R(>=) $s, "BagHash is not a reversed superset of Set (texas)";

# is not a superset of

nok <your day> R⊉ $s, "'Your day' is reversed superset of Set";
nok $s R⊉ $s, "Set is reversed superset of itself";
nok $s R⊉ <I'm afraid it isn't your day old chum>, "Set is reversed superset of string";

nok ($ks (-) set <is>) R⊉ $ks, "Set is reversed superset of SetHash";
nok $ks R⊉ $ks, "SetHash is reversed superset of itself";
nok $ks R⊉ <I'm afraid it is my day>, "SetHash is reversed superset of string";

ok $s R⊉ $b, "Set is not a reversed superset of Bag";
nok $b R⊉ $b, "Bag is reversed superset of itself";
ok $b R⊉ $s, "Bag is not a reversed superset of Set";

ok $s R⊉ $kb, "Set is not a reversed superset of BagHash";
nok $kb R⊉ $kb, "BagHash is reversed superset of itself";
ok $kb R⊉ $s, "BagHash is not a reversed superset of Set";

nok <your day> !R(>=) $s, "'Your day' is reversed superset of Set (texas)";
nok $s !R(>=) $s, "Set is reversed superset of itself (texas)";
nok $s !R(>=) <I'm afraid it isn't your day old chum>, "Set is reversed superset of string (texas)";

nok ($ks (-) set <is>) !R(>=) $ks, "Set is reversed superset of SetHash (texas)";
nok $ks !R(>=) $ks, "SetHash is reversed superset of itself (texas)";
nok $ks !R(>=) <I'm afraid it is my day>, "SetHash is reversed superset of string (texas)";

ok $s !R(>=) $b, "Set is not a reversed superset of Bag (texas)";
nok $b !R(>=) $b, "Bag is reversed superset of itself (texas)";
ok $b !R(>=) $s, "Bag is not a reversed superset of Set (texas)";

ok $s !R(>=) $kb, "Set is not a reversed superset of BagHash (texas)";
nok $kb !R(>=) $kb, "BagHash is reversed superset of itself (texas)";
ok $kb !R(>=) $s, "BagHash is not a reversed superset of Set (texas)";

# is proper superset of

ok <your day> R⊃ $s, "'Your day' is reversed proper superset of Set";
nok $s R⊃ $s, "Set is not reversed proper superset of itself";
ok $s R⊃ <I'm afraid it isn't your day old chum>, "Set is reversed proper superset of string";

ok ($ks (-) set <is>) R⊃ $ks, "Set is reversed proper superset of SetHash";
nok $ks R⊃ $ks, "SetHash is not reversed proper superset of itself";
ok $ks R⊃ <I'm afraid it is my day>, "SetHash is reversed proper superset of string";

nok $s R⊃ $b, "Set is not a reversed proper superset of Bag";
nok $b R⊃ $b, "Bag is not reversed proper superset of itself";
nok $b R⊃ $s, "Bag is not a reversed proper superset of Set";

nok $s R⊃ $kb, "Set is not a reversed proper superset of BagHash";
nok $kb R⊃ $kb, "BagHash is not reversed proper superset of itself";
nok $kb R⊃ $s, "BagHash is not a reversed proper superset of Set";

ok <your day> R(>) $s, "'Your day' is reversed proper superset of Set";
nok $s R(>) $s, "Set is not reversed proper superset of itself";
ok $s R(>) <I'm afraid it isn't your day old chum>, "Set is reversed proper superset of string";

ok ($ks (-) set <is>) R(>) $ks, "Set is reversed proper superset of SetHash (texas)";
nok $ks R(>) $ks, "SetHash is not reversed proper superset of itself (texas)";
ok $ks R(>) <I'm afraid it is my day>, "SetHash is reversed proper superset of string (texas)";

nok $s R(>) $b, "Set is not a reversed proper superset of Bag (texas)";
nok $b R(>) $b, "Bag is not reversed proper superset of itself (texas)";
nok $b R(>) $s, "Bag is not a reversed proper superset of Set (texas)";

nok $s R(>) $kb, "Set is not a reversed proper superset of BagHash (texas)";
nok $kb R(>) $kb, "BagHash is not reversed proper superset of itself (texas)";
nok $kb R(>) $s, "BagHash is not a reversed proper superset of Set (texas)";

# is not a proper superset of

nok <your day> R⊅ $s, "'Your day' is reversed proper superset of Set";
ok $s R⊅ $s, "Set is not reversed proper superset of itself";
nok $s R⊅ <I'm afraid it isn't your day old chum>, "Set is reversed proper superset of string";

nok ($ks (-) set <is>) R⊅ $ks, "Set is reversed proper superset of SetHash";
ok $ks R⊅ $ks, "SetHash is not reversed proper superset of itself";
nok $ks R⊅ <I'm afraid it is my day>, "SetHash is reversed proper superset of string";

ok $s R⊅ $b, "Set is not a reversed proper superset of Bag";
ok $b R⊅ $b, "Bag is not reversed proper superset of itself";
ok $b R⊅ $s, "Bag is not a reversed proper superset of Set";

ok $s R⊅ $kb, "Set is not a reversed proper superset of BagHash";
ok $kb R⊅ $kb, "BagHash is not reversed proper superset of itself";
ok $kb R⊅ $s, "BagHash is not a reversed proper superset of Set";

nok <your day> !R(>) $s, "'Your day' is reversed proper superset of Set (texas)";
ok $s !R(>) $s, "Set is not reversed proper superset of itself (texas)";
nok $s !R(>) <I'm afraid it isn't your day old chum>, "Set is reversed proper superset of string (texas)";

nok ($ks (-) set <is>) !R(>) $ks, "Set is reversed proper superset of SetHash (texas)";
ok $ks !R(>) $ks, "SetHash is not reversed proper superset of itself (texas)";
nok $ks !R(>) <I'm afraid it is my day>, "SetHash is reversed proper superset of string (texas)";

ok $s !R(>) $b, "Set is not a reversed proper superset of Bag (texas)";
ok $b !R(>) $b, "Bag is not reversed proper superset of itself (texas)";
ok $b !R(>) $s, "Bag is not a reversed proper superset of Set (texas)";

ok $s !R(>) $kb, "Set is not a reversed proper superset of BagHash (texas)";
ok $kb !R(>) $kb, "BagHash is not reversed proper superset of itself (texas)";
ok $kb !R(>) $s, "BagHash is not a reversed proper superset of Set (texas)";

{
    my $a = set <Zeus Hera Artemis Apollo Hades Aphrodite Ares Athena Hermes Poseidon Hephaestus>;
    my $b = set <Jupiter Juno Neptune Minerva Mars Venus Apollo Diana Vulcan Vesta Mercury Ceres>;
    my $c = [<Apollo Arclight Astor>];
    my @d;

    is showset([∪] @d), showset(∅), "Union reduce works on nothing";
    is showset([∪] $a), showset($a), "Union reduce works on one set";
    is showset([∪] $a, $b), showset(set($a.keys, $b.keys)), "Union reduce works on two sets";
    is showset([∪] $a, $b, $c), showset(set($a.keys, $b.keys, $c.values)), "Union reduce works on three sets";

    is showset([(|)] @d), showset(∅), "Union reduce works on nothing (texas)";
    is showset([(|)] $a), showset($a), "Union reduce works on one set (texas)";
    is showset([(|)] $a, $b), showset(set($a.keys, $b.keys)), "Union reduce works on two sets (texas)";
    is showset([(|)] $a, $b, $c), showset(set($a.keys, $b.keys, $c.values)), "Union reduce works on three sets (texas)";

    is showset([∩] @d), showset(∅), "Intersection reduce works on nothing";
    is showset([∩] $a), showset($a), "Intersection reduce works on one set";
    is showset([∩] $a, $b), showset(set("Apollo")), "Intersection reduce works on two sets";
    is showset([∩] $a, $b, $c), showset(set("Apollo")), "Intersection reduce works on three sets";

    is showset([(&)] @d), showset(∅), "Intersection reduce works on nothing (texas)";
    is showset([(&)] $a), showset($a), "Intersection reduce works on one set (texas)";
    is showset([(&)] $a, $b), showset(set("Apollo")), "Intersection reduce works on two sets (texas)";
    is showset([(&)] $a, $b, $c), showset(set("Apollo")), "Intersection reduce works on three sets (texas)";
}

# RT #117997
{
    throws_like 'set;', Exception,
        'set listop called without arguments dies (1)',
        message => { m/"The 'set' listop may not be called without arguments"/ };
    throws_like 'set<a b c>;', X::Comp::Group,
        'set listop called without arguments dies (2)',
        message => { m/"The 'set' listop may not be called without arguments"/ };
}

# vim: ft=perl6
