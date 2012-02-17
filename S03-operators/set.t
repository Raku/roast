use v6;
use Test;

plan 212;

sub showset($s) { $s.keys.sort.join(' ') }

my $s = set <I'm afraid it isn't your day>;
my $ks = KeySet.new(<I'm afraid it is>); # Tom Stoppard
my $b = bag <Whoever remains for long here in this earthly life will enjoy and endure more than enough>; # Seamus Heaney
my $kb = KeyBag.new(<Come, take your bread with joy, and your wine with a glad heart>); # Ecclesiastes 9:7

# Is an element of

ok "afraid" ∈ $s, "afraid is an element of Set";
ok "afraid" ∈ $ks, "afraid is an element of KeySet";
ok "earthly" ∈ $b, "earthly is an element of Bag";
ok "your" ∈ $kb, "heaven is an element of KeyBag";
ok "d" ∈ <a b c d e>, "d is an element of a b c d e";

ok "afraid" (elem) $s, "afraid is an element of Set (texas)";
ok "afraid" (elem) $ks, "afraid is an element of KeySet (texas)";
ok "earthly" (elem) $b, "earthly is an element of Bag (texas)";
ok "your" (elem) $kb, "heaven is an element of KeyBag (texas)";
ok "d" (elem) <a b c d e>, "d is an element of a b c d e (texas)";

# Is not an element of

ok "marmoset" ∉ $s, "marmoset is not an element of Set";
ok "marmoset" ∉ $ks, "marmoset is not an element of KeySet";
ok "marmoset" ∉ $b, "marmoset is not an element of Bag";
ok "marmoset" ∉ $kb, "marmoset is not an element of KeyBag";
ok "marmoset" ∉ <a b c d e>, "marmoset is not an element of a b c d e";

ok "hogwash" !(elem) $s, "hogwash is not an element of Set (texas)";
ok "hogwash" !(elem) $ks, "hogwash is not an element of KeySet (texas)";
ok "hogwash" !(elem) $b, "hogwash is not an element of Bag (texas)";
ok "hogwash" !(elem) $kb, "hogwash is not an element of KeyBag (texas)";
ok "hogwash" !(elem) <a b c d e>, "hogwash is not an element of a b c d e (texas)";

# Contains

ok $s ∋ "afraid", "afraid is contained by Set";
ok $ks ∋ "afraid", "afraid is contained by KeySet";
ok $b ∋ "earthly", "earthly is contained by Bag";
ok $kb ∋ "your", "heaven is contained by KeyBag";
ok <a b c d e> ∋ "d", "d is contained by a b c d e";

ok $s (cont) "afraid", "afraid is contained by Set";
ok $ks (cont) "afraid", "afraid is contained by KeySet";
ok $b (cont) "earthly", "earthly is contained by Bag";
ok $kb (cont) "your", "heaven is contained by KeyBag";
ok <a b c d e> (cont) "d", "d is contained by a b c d e";

# Does not contain

ok $s ∌ "marmoset", "marmoset is not contained by Set";
ok $ks ∌ "marmoset", "marmoset is not contained by KeySet";
ok $b ∌ "marmoset", "marmoset is not contained by Bag";
ok $kb ∌ "marmoset", "marmoset is not contained by KeyBag";
ok <a b c d e> ∌ "marmoset", "marmoset is not contained by a b c d e";

ok $s !(cont) "marmoset", "marmoset is not contained by Set";
ok $ks !(cont) "marmoset", "marmoset is not contained by KeySet";
ok $b !(cont) "marmoset", "marmoset is not contained by Bag";
ok $kb !(cont) "marmoset", "marmoset is not contained by KeyBag";
ok <a b c d e> !(cont) "marmoset", "marmoset is not contained by a b c d e";

# Union

is showset($s ∪ $s), showset($s), "Set union with itself yields self";
isa_ok ($s ∪ $s), Set, "... and it's actually a Set";
is showset($ks ∪ $ks), showset($ks), "KeySet union with itself yields self (as Set)";
isa_ok ($ks ∪ $ks), Set, "... and it's actually a Set";
is showset($b ∪ $b), showset($b), "Bag union with itself yields self (as Set)";
isa_ok ($b ∪ $b), Set, "... and it's actually a Set";
is showset($kb ∪ $kb), showset($kb), "KeyBag union with itself yields (as Set)";
isa_ok ($kb ∪ $kb), Set, "... and it's actually a Set";

is showset($s ∪ $ks), showset(set <I'm afraid it is isn't your day>), "Set union with KeySet works";
isa_ok ($s ∪ $ks), Set, "... and it's actually a Set";
is showset($s ∪ $b), showset(set($s, $b)), "Set union with Bag works";
isa_ok ($s ∪ $b), Set, "... and it's actually a Set";
is showset($s ∪ $kb), showset(set($s, $kb)), "Set union with KeyBag works";
isa_ok ($s ∪ $kb), Set, "... and it's actually a Set";
is showset($ks ∪ <blue green>), showset(set <I'm afraid it is blue green>), "KeySet union with array of strings works";
isa_ok ($ks ∪ <blue green>), Set, "... and it's actually a Set";

is showset($s (|) $ks), showset(set <I'm afraid it is isn't your day>), "Set union with KeySet works (texas)";
isa_ok ($s (|) $ks), Set, "... and it's actually a Set (texas)";
is showset($s (|) $b), showset(set($s, $b)), "Set union with Bag works (texas)";
isa_ok ($s (|) $b), Set, "... and it's actually a Set (texas)";
is showset($s (|) $kb), showset(set($s, $kb)), "Set union with KeyBag works (texas)";
isa_ok ($s (|) $kb), Set, "... and it's actually a Set (texas)";
is showset($ks (|) <blue green>), showset(set <I'm afraid it is blue green>), "KeySet union with array of strings works (texas)";
isa_ok ($ks (|) <blue green>), Set, "... and it's actually a Set (texas)";

# Intersection

is showset($s ∩ $s), showset($s), "Set intersection with itself yields self";
isa_ok ($s ∩ $s), Set, "... and it's actually a Set";
is showset($ks ∩ $ks), showset($ks), "KeySet intersection with itself yields self (as Set)";
isa_ok ($ks ∩ $ks), Set, "... and it's actually a Set";
is showset($b ∩ $b), showset($b), "Bag intersection with itself yields self (as Set)";
isa_ok ($b ∩ $b), Set, "... and it's actually a Set";
is showset($kb ∩ $kb), showset($kb), "KeyBag intersection with itself yields self (as Set)";
isa_ok ($kb ∩ $kb), Set, "... and it's actually a Set";

is showset($s ∩ $ks), showset(set <I'm afraid it>), "Set intersection with KeySet works";
isa_ok ($s ∩ $ks), Set, "... and it's actually a Set";
is showset($s ∩ $b), showset(∅), "Set intersection with Bag works";
isa_ok ($s ∩ $b), Set, "... and it's actually a Set";
is showset($s ∩ $kb), showset(set <your>), "Set intersection with KeyBag works";
isa_ok ($s ∩ $kb), Set, "... and it's actually a Set";
is showset($kb ∩ <glad green bread>), showset(set <glad bread>), "KeyBag intersection with array of strings works";
isa_ok ($kb ∩ <glad green bread>), Set, "... and it's actually a Set";

is showset($s (&) $ks), showset(set <I'm afraid it>), "Set intersection with KeySet works (texas)";
isa_ok ($s (&) $ks), Set, "... and it's actually a Set (texas)";
is showset($s (&) $b), showset(∅), "Set intersection with Bag works (texas)";
isa_ok ($s (&) $b), Set, "... and it's actually a Set (texas)";
is showset($s (&) $kb), showset(set <your>), "Set intersection with KeyBag works (texas)";
isa_ok ($s (&) $kb), Set, "... and it's actually a Set (texas)";
is showset($kb (&) <glad green bread>), showset(set <glad bread>), "KeyBag intersection with array of strings works (texas)";
isa_ok ($kb (&) <glad green bread>), Set, "... and it's actually a Set (texas)";

# set subtraction

is showset($s (-) $s), showset(∅), "Set subtracted from Set is correct";
isa_ok ($s (-) $s), Set, "... and it's actually a Set";

is showset($s (-) $ks), showset(set <isn't your day>), "KeySet subtracted from Set is correct";
isa_ok ($s (-) $ks), Set, "... and it's actually a Set";
is showset($ks (-) $s), showset(set <is>), "Set subtracted from KeySet is correct";
isa_ok ($ks (-) $s), Set, "... and it's actually a Set";

is showset($b (-) $s), showset($b), "Set subtracted from Bag is correct";
isa_ok ($b (-) $s), Set, "... and it's actually a Set";
is showset($s (-) $b), showset($s), "Bag subtracted from Set is correct";
isa_ok ($s (-) $b), Set, "... and it's actually a Set";

is showset($s (-) $kb), showset(set <I'm afraid it isn't day>), "KeyBag subtracted from Set is correct";
isa_ok ($s (-) $kb), Set, "... and it's actually a Set";
is showset($kb (-) $s), showset(set <Come, take bread with joy, and wine with a glad heart>), "Set subtracted from KeyBag is correct";
isa_ok ($kb (-) $s), Set, "... and it's actually a Set";

# symmetric difference

is showset($s (^) $s), showset(∅), "Set symmetric difference with Set is correct";
isa_ok ($s (^) $s), Set, "... and it's actually a Set";

is showset($s (^) $ks), showset(set <is isn't your day>), "KeySet symmetric difference with Set is correct";
isa_ok ($s (^) $ks), Set, "... and it's actually a Set";
is showset($ks (^) $s), showset(set <is isn't your day>), "Set symmetric difference with KeySet is correct";
isa_ok ($ks (^) $s), Set, "... and it's actually a Set";

is showset($s (^) $b), showset(set($s, $b)), "Bag symmetric difference with Set is correct";
isa_ok ($s (^) $b), Set, "... and it's actually a Set";
is showset($b (^) $s), showset(set($s, $b)), "Set symmetric difference with Bag is correct";
isa_ok ($b (^) $s), Set, "... and it's actually a Set";

is showset($s (^) $kb), showset(set($s, $kb) (-) set <your>), "KeyBag subtracted from Set is correct";
isa_ok ($s (^) $kb), Set, "... and it's actually a Set";
is showset($kb (^) $s), showset(set($s, $kb) (-) set <your>), "Set subtracted from KeyBag is correct";
isa_ok ($kb (^) $s), Set, "... and it's actually a Set";

# is subset of

ok <your day> ⊆ $s, "'Your day' is subset of Set";
ok $s ⊆ $s, "Set is subset of itself";
ok $s ⊆ <I'm afraid it isn't your day old chum>, "Set is subset of string";

ok ($ks (-) set <is>) ⊆ $ks, "Set is subset of KeySet";
ok $ks ⊆ $ks, "KeySet is subset of itself";
ok $ks ⊆ <I'm afraid it is my day>, "KeySet is subset of string";

nok $s ⊆ $b, "Set is not a subset of Bag";
ok $b ⊆ $b, "Bag is subset of itself";
nok $b ⊆ $s, "Bag is not a subset of Set";

nok $s ⊆ $kb, "Set is not a subset of KeyBag";
ok $kb ⊆ $kb, "KeyBag is subset of itself";
nok $kb ⊆ $s, "KeyBag is not a subset of Set";

ok <your day> (<=) $s, "'Your day' is subset of Set";
ok $s (<=) $s, "Set is subset of itself";
ok $s (<=) <I'm afraid it isn't your day old chum>, "Set is subset of string";

ok ($ks (-) set <is>) (<=) $ks, "Set is subset of KeySet (texas)";
ok $ks (<=) $ks, "KeySet is subset of itself (texas)";
ok $ks (<=) <I'm afraid it is my day>, "KeySet is subset of string (texas)";

nok $s (<=) $b, "Set is not a subset of Bag (texas)";
ok $b (<=) $b, "Bag is subset of itself (texas)";
nok $b (<=) $s, "Bag is not a subset of Set (texas)";

nok $s (<=) $kb, "Set is not a subset of KeyBag (texas)";
ok $kb (<=) $kb, "KeyBag is subset of itself (texas)";
nok $kb (<=) $s, "KeyBag is not a subset of Set (texas)";

# is not a subset of

nok <your day> ⊈ $s, "'Your day' is subset of Set";
nok $s ⊈ $s, "Set is subset of itself";
nok $s ⊈ <I'm afraid it isn't your day old chum>, "Set is subset of string";

nok ($ks (-) set <is>) ⊈ $ks, "Set is subset of KeySet";
nok $ks ⊈ $ks, "KeySet is subset of itself";
nok $ks ⊈ <I'm afraid it is my day>, "KeySet is subset of string";

ok $s ⊈ $b, "Set is not a subset of Bag";
nok $b ⊈ $b, "Bag is subset of itself";
ok $b ⊈ $s, "Bag is not a subset of Set";

ok $s ⊈ $kb, "Set is not a subset of KeyBag";
nok $kb ⊈ $kb, "KeyBag is subset of itself";
ok $kb ⊈ $s, "KeyBag is not a subset of Set";

nok <your day> !(<=) $s, "'Your day' is subset of Set (texas)";
nok $s !(<=) $s, "Set is subset of itself (texas)";
nok $s !(<=) <I'm afraid it isn't your day old chum>, "Set is subset of string (texas)";

nok ($ks (-) set <is>) !(<=) $ks, "Set is subset of KeySet (texas)";
nok $ks !(<=) $ks, "KeySet is subset of itself (texas)";
nok $ks !(<=) <I'm afraid it is my day>, "KeySet is subset of string (texas)";

ok $s !(<=) $b, "Set is not a subset of Bag (texas)";
nok $b !(<=) $b, "Bag is subset of itself (texas)";
ok $b !(<=) $s, "Bag is not a subset of Set (texas)";

ok $s !(<=) $kb, "Set is not a subset of KeyBag (texas)";
nok $kb !(<=) $kb, "KeyBag is subset of itself (texas)";
ok $kb !(<=) $s, "KeyBag is not a subset of Set (texas)";

# is proper subset of

ok <your day> ⊂ $s, "'Your day' is proper subset of Set";
nok $s ⊂ $s, "Set is not proper subset of itself";
ok $s ⊂ <I'm afraid it isn't your day old chum>, "Set is proper subset of string";

ok ($ks (-) set <is>) ⊂ $ks, "Set is proper subset of KeySet";
nok $ks ⊂ $ks, "KeySet is not proper subset of itself";
ok $ks ⊂ <I'm afraid it is my day>, "KeySet is proper subset of string";

nok $s ⊂ $b, "Set is not a proper subset of Bag";
nok $b ⊂ $b, "Bag is not proper subset of itself";
nok $b ⊂ $s, "Bag is not a proper subset of Set";

nok $s ⊂ $kb, "Set is not a proper subset of KeyBag";
nok $kb ⊂ $kb, "KeyBag is not proper subset of itself";
nok $kb ⊂ $s, "KeyBag is not a proper subset of Set";

ok <your day> (<) $s, "'Your day' is proper subset of Set";
nok $s (<) $s, "Set is not proper subset of itself";
ok $s (<) <I'm afraid it isn't your day old chum>, "Set is proper subset of string";

ok ($ks (-) set <is>) (<) $ks, "Set is proper subset of KeySet (texas)";
nok $ks (<) $ks, "KeySet is not proper subset of itself (texas)";
ok $ks (<) <I'm afraid it is my day>, "KeySet is proper subset of string (texas)";

nok $s (<) $b, "Set is not a proper subset of Bag (texas)";
nok $b (<) $b, "Bag is not proper subset of itself (texas)";
nok $b (<) $s, "Bag is not a proper subset of Set (texas)";

nok $s (<) $kb, "Set is not a proper subset of KeyBag (texas)";
nok $kb (<) $kb, "KeyBag is not proper subset of itself (texas)";
nok $kb (<) $s, "KeyBag is not a proper subset of Set (texas)";

# is not a proper subset of

nok <your day> ⊄ $s, "'Your day' is proper subset of Set";
ok $s ⊄ $s, "Set is not proper subset of itself";
nok $s ⊄ <I'm afraid it isn't your day old chum>, "Set is proper subset of string";

nok ($ks (-) set <is>) ⊄ $ks, "Set is proper subset of KeySet";
ok $ks ⊄ $ks, "KeySet is not proper subset of itself";
nok $ks ⊄ <I'm afraid it is my day>, "KeySet is proper subset of string";

ok $s ⊄ $b, "Set is not a proper subset of Bag";
ok $b ⊄ $b, "Bag is not proper subset of itself";
ok $b ⊄ $s, "Bag is not a proper subset of Set";

ok $s ⊄ $kb, "Set is not a proper subset of KeyBag";
ok $kb ⊄ $kb, "KeyBag is not proper subset of itself";
ok $kb ⊄ $s, "KeyBag is not a proper subset of Set";

nok <your day> !(<) $s, "'Your day' is proper subset of Set (texas)";
ok $s !(<) $s, "Set is not proper subset of itself (texas)";
nok $s !(<) <I'm afraid it isn't your day old chum>, "Set is proper subset of string (texas)";

nok ($ks (-) set <is>) !(<) $ks, "Set is proper subset of KeySet (texas)";
ok $ks !(<) $ks, "KeySet is not proper subset of itself (texas)";
nok $ks !(<) <I'm afraid it is my day>, "KeySet is proper subset of string (texas)";

ok $s !(<) $b, "Set is not a proper subset of Bag (texas)";
ok $b !(<) $b, "Bag is not proper subset of itself (texas)";
ok $b !(<) $s, "Bag is not a proper subset of Set (texas)";

ok $s !(<) $kb, "Set is not a proper subset of KeyBag (texas)";
ok $kb !(<) $kb, "KeyBag is not proper subset of itself (texas)";
ok $kb !(<) $s, "KeyBag is not a proper subset of Set (texas)";

# my $s = set <I'm afraid it isn't your day>;
# my $ks = KeySet.new(<I'm afraid it is>); # Tom Stoppard
# my $b = bag <Whoever remains for long here in this earthly life will enjoy and endure more than enough>; # Seamus Heaney
# my $kb = KeyBag.new(<Come, take your bread with joy, and your wine with a glad heart>); # Ecclesiastes 9:7



# vim: ft=perl6
