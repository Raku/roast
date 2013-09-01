use v6;
use Test;

plan 296;

sub showset($s) { $s.keys.sort.join(' ') }
sub showkv($x) { $x.keys.sort.map({ $^k ~ ':' ~ $x{$k} }).join(' ') }

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

is showset($s ∪ $ks), showset(set <I'm afraid it is isn't your day>), "Set union with KeySet works";
isa_ok ($s ∪ $ks), Set, "... and it's actually a Set";
is showset($ks ∪ <blue green>), showset(set <I'm afraid it is blue green>), "KeySet union with array of strings works";
isa_ok ($ks ∪ <blue green>), Set, "... and it's actually a Set";

is showset($s (|) $ks), showset(set <I'm afraid it is isn't your day>), "Set union with KeySet works (texas)";
isa_ok ($s (|) $ks), Set, "... and it's actually a Set (texas)";
is showset($ks (|) <blue green>), showset(set <I'm afraid it is blue green>), "KeySet union with array of strings works (texas)";
isa_ok ($ks (|) <blue green>), Set, "... and it's actually a Set (texas)";

# Intersection

#?rakudo todo 'huh?'
is showset($s ∩ $s), showset($s), "Set intersection with itself yields self";
isa_ok ($s ∩ $s), Set, "... and it's actually a Set";
#?rakudo todo 'huh?'
is showset($ks ∩ $ks), showset($ks), "KeySet intersection with itself yields self (as Set)";
isa_ok ($ks ∩ $ks), Set, "... and it's actually a Set";
#?rakudo todo 'huh?'
is showset($s ∩ $ks), showset(set <I'm afraid it>), "Set intersection with KeySet works";
isa_ok ($s ∩ $ks), Set, "... and it's actually a Set";

#?rakudo todo 'huh?'
is showset($s (&) $ks), showset(set <I'm afraid it>), "Set intersection with KeySet works (texas)";
isa_ok ($s (&) $ks), Set, "... and it's actually a Set (texas)";

# set subtraction

#?rakudo skip "∅ NYI"
is showset($s (-) $s), showset(∅), "Set subtracted from Set is correct";
isa_ok ($s (-) $s), Set, "... and it's actually a Set";

#?rakudo todo 'huh?'
is showset($s (-) $ks), showset(set <isn't your day>), "KeySet subtracted from Set is correct";
isa_ok ($s (-) $ks), Set, "... and it's actually a Set";
#?rakudo todo 'huh?'
is showset($ks (-) $s), showset(set <is>), "Set subtracted from KeySet is correct";
isa_ok ($ks (-) $s), Set, "... and it's actually a Set";

#?rakudo 2 skip "expected Any, got Mu"
is showkv($b (-) $s), showkv($b), "Set subtracted from Bag is correct";
isa_ok ($b (-) $s), Bag, "... and it's actually a Bag";
#?rakudo todo 'huh?'
is showset($s (-) $b), showset($s), "Bag subtracted from Set is correct";
isa_ok ($s (-) $b), Set, "... and it's actually a Set";

#?rakudo todo 'huh?'
is showset($s (-) $kb), showset(set <I'm afraid it isn't day>), "KeyBag subtracted from Set is correct";
isa_ok ($s (-) $kb), Set, "... and it's actually a Set";
#?rakudo 2 skip "expected Any, got Mu"
is showkv($kb (-) $s), showkv(<Come, take your bread with joy, and wine with a glad heart>.Bag), "Set subtracted from KeyBag is correct";
isa_ok ($kb (-) $s), Bag, "... and it's actually a Bag";

# symmetric difference

#?rakudo skip "∅ NYI"
is showset($s (^) $s), showset(∅), "Set symmetric difference with Set is correct";
isa_ok ($s (^) $s), Set, "... and it's actually a Set";

#?rakudo todo 'huh?'
is showset($s (^) $ks), showset(set <is isn't your day>), "KeySet symmetric difference with Set is correct";
isa_ok ($s (^) $ks), Set, "... and it's actually a Set";
#?rakudo todo 'huh?'
is showset($ks (^) $s), showset(set <is isn't your day>), "Set symmetric difference with KeySet is correct";
isa_ok ($ks (^) $s), Set, "... and it's actually a Set";

#?rakudo todo 'huh?'
is showset($s (^) $b), showset($s (|) $b), "Bag symmetric difference with Set is correct";
isa_ok ($s (^) $b), Set, "... and it's actually a Set";
#?rakudo todo 'huh?'
is showset($b (^) $s), showset($s (|) $b), "Set symmetric difference with Bag is correct";
isa_ok ($b (^) $s), Set, "... and it's actually a Set";

#?niecza todo "Test is wrong, implementation is wrong"
#?rakudo skip 'expected Any, got Mu'
is showset($s (^) $kb), showset(($s (|) $kb) (-) set <your>), "KeyBag subtracted from Set is correct";
isa_ok ($s (^) $kb), Set, "... and it's actually a Set";
#?niecza todo "Test is wrong, implementation is wrong"
#?rakudo skip 'expected Any, got Mu'
is showset($kb (^) $s), showset(($s (|) $kb) (-) set <your>), "Set subtracted from KeyBag is correct";
isa_ok ($kb (^) $s), Set, "... and it's actually a Set";

# is subset of

ok <your day> ⊆ $s, "'Your day' is subset of Set";
ok $s ⊆ $s, "Set is subset of itself";
ok $s ⊆ <I'm afraid it isn't your day old chum>, "Set is subset of string";

#?rakudo todo 'huh?'
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

#?rakudo todo 'huh?'
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

#?rakudo todo 'huh?'
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

#?rakudo todo 'huh?'
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

#?rakudo todo 'huh?'
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

#?rakudo todo 'huh?'
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

#?rakudo todo 'huh?'
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

#?rakudo todo 'huh?'
nok ($ks (-) set <is>) !(<) $ks, "Set is proper subset of KeySet (texas)";
ok $ks !(<) $ks, "KeySet is not proper subset of itself (texas)";
nok $ks !(<) <I'm afraid it is my day>, "KeySet is proper subset of string (texas)";

ok $s !(<) $b, "Set is not a proper subset of Bag (texas)";
ok $b !(<) $b, "Bag is not proper subset of itself (texas)";
ok $b !(<) $s, "Bag is not a proper subset of Set (texas)";

ok $s !(<) $kb, "Set is not a proper subset of KeyBag (texas)";
ok $kb !(<) $kb, "KeyBag is not proper subset of itself (texas)";
ok $kb !(<) $s, "KeyBag is not a proper subset of Set (texas)";

# is superset of

ok <your day> R⊇ $s, "'Your day' is reversed superset of Set";
ok $s R⊇ $s, "Set is reversed superset of itself";
ok $s R⊇ <I'm afraid it isn't your day old chum>, "Set is reversed superset of string";

#?rakudo todo 'huh?'
ok ($ks (-) set <is>) R⊇ $ks, "Set is reversed superset of KeySet";
ok $ks R⊇ $ks, "KeySet is reversed superset of itself";
ok $ks R⊇ <I'm afraid it is my day>, "KeySet is reversed superset of string";

nok $s R⊇ $b, "Set is not a reversed superset of Bag";
ok $b R⊇ $b, "Bag is reversed superset of itself";
nok $b R⊇ $s, "Bag is not a reversed superset of Set";

nok $s R⊇ $kb, "Set is not a reversed superset of KeyBag";
ok $kb R⊇ $kb, "KeyBag is reversed superset of itself";
nok $kb R⊇ $s, "KeyBag is not a reversed superset of Set";

ok <your day> R(>=) $s, "'Your day' is reversed superset of Set";
ok $s R(>=) $s, "Set is reversed superset of itself";
ok $s R(>=) <I'm afraid it isn't your day old chum>, "Set is reversed superset of string";

#?rakudo todo 'huh?'
ok ($ks (-) set <is>) R(>=) $ks, "Set is reversed superset of KeySet (texas)";
ok $ks R(>=) $ks, "KeySet is reversed superset of itself (texas)";
ok $ks R(>=) <I'm afraid it is my day>, "KeySet is reversed superset of string (texas)";

nok $s R(>=) $b, "Set is not a reversed superset of Bag (texas)";
ok $b R(>=) $b, "Bag is reversed superset of itself (texas)";
nok $b R(>=) $s, "Bag is not a reversed superset of Set (texas)";

nok $s R(>=) $kb, "Set is not a reversed superset of KeyBag (texas)";
ok $kb R(>=) $kb, "KeyBag is reversed superset of itself (texas)";
nok $kb R(>=) $s, "KeyBag is not a reversed superset of Set (texas)";

# is not a superset of

nok <your day> R⊉ $s, "'Your day' is reversed superset of Set";
nok $s R⊉ $s, "Set is reversed superset of itself";
nok $s R⊉ <I'm afraid it isn't your day old chum>, "Set is reversed superset of string";

#?rakudo todo 'huh?'
nok ($ks (-) set <is>) R⊉ $ks, "Set is reversed superset of KeySet";
nok $ks R⊉ $ks, "KeySet is reversed superset of itself";
nok $ks R⊉ <I'm afraid it is my day>, "KeySet is reversed superset of string";

ok $s R⊉ $b, "Set is not a reversed superset of Bag";
nok $b R⊉ $b, "Bag is reversed superset of itself";
ok $b R⊉ $s, "Bag is not a reversed superset of Set";

ok $s R⊉ $kb, "Set is not a reversed superset of KeyBag";
nok $kb R⊉ $kb, "KeyBag is reversed superset of itself";
ok $kb R⊉ $s, "KeyBag is not a reversed superset of Set";

nok <your day> !R(>=) $s, "'Your day' is reversed superset of Set (texas)";
nok $s !R(>=) $s, "Set is reversed superset of itself (texas)";
nok $s !R(>=) <I'm afraid it isn't your day old chum>, "Set is reversed superset of string (texas)";

#?rakudo todo 'huh?'
nok ($ks (-) set <is>) !R(>=) $ks, "Set is reversed superset of KeySet (texas)";
nok $ks !R(>=) $ks, "KeySet is reversed superset of itself (texas)";
nok $ks !R(>=) <I'm afraid it is my day>, "KeySet is reversed superset of string (texas)";

ok $s !R(>=) $b, "Set is not a reversed superset of Bag (texas)";
nok $b !R(>=) $b, "Bag is reversed superset of itself (texas)";
ok $b !R(>=) $s, "Bag is not a reversed superset of Set (texas)";

ok $s !R(>=) $kb, "Set is not a reversed superset of KeyBag (texas)";
nok $kb !R(>=) $kb, "KeyBag is reversed superset of itself (texas)";
ok $kb !R(>=) $s, "KeyBag is not a reversed superset of Set (texas)";

# is proper superset of

ok <your day> R⊃ $s, "'Your day' is reversed proper superset of Set";
nok $s R⊃ $s, "Set is not reversed proper superset of itself";
ok $s R⊃ <I'm afraid it isn't your day old chum>, "Set is reversed proper superset of string";

#?rakudo todo 'huh?'
ok ($ks (-) set <is>) R⊃ $ks, "Set is reversed proper superset of KeySet";
nok $ks R⊃ $ks, "KeySet is not reversed proper superset of itself";
ok $ks R⊃ <I'm afraid it is my day>, "KeySet is reversed proper superset of string";

nok $s R⊃ $b, "Set is not a reversed proper superset of Bag";
nok $b R⊃ $b, "Bag is not reversed proper superset of itself";
nok $b R⊃ $s, "Bag is not a reversed proper superset of Set";

nok $s R⊃ $kb, "Set is not a reversed proper superset of KeyBag";
nok $kb R⊃ $kb, "KeyBag is not reversed proper superset of itself";
nok $kb R⊃ $s, "KeyBag is not a reversed proper superset of Set";

ok <your day> R(>) $s, "'Your day' is reversed proper superset of Set";
nok $s R(>) $s, "Set is not reversed proper superset of itself";
ok $s R(>) <I'm afraid it isn't your day old chum>, "Set is reversed proper superset of string";

#?rakudo todo 'huh?'
ok ($ks (-) set <is>) R(>) $ks, "Set is reversed proper superset of KeySet (texas)";
nok $ks R(>) $ks, "KeySet is not reversed proper superset of itself (texas)";
ok $ks R(>) <I'm afraid it is my day>, "KeySet is reversed proper superset of string (texas)";

nok $s R(>) $b, "Set is not a reversed proper superset of Bag (texas)";
nok $b R(>) $b, "Bag is not reversed proper superset of itself (texas)";
nok $b R(>) $s, "Bag is not a reversed proper superset of Set (texas)";

nok $s R(>) $kb, "Set is not a reversed proper superset of KeyBag (texas)";
nok $kb R(>) $kb, "KeyBag is not reversed proper superset of itself (texas)";
nok $kb R(>) $s, "KeyBag is not a reversed proper superset of Set (texas)";

# is not a proper superset of

nok <your day> R⊅ $s, "'Your day' is reversed proper superset of Set";
ok $s R⊅ $s, "Set is not reversed proper superset of itself";
nok $s R⊅ <I'm afraid it isn't your day old chum>, "Set is reversed proper superset of string";

#?rakudo todo 'huh?'
nok ($ks (-) set <is>) R⊅ $ks, "Set is reversed proper superset of KeySet";
ok $ks R⊅ $ks, "KeySet is not reversed proper superset of itself";
nok $ks R⊅ <I'm afraid it is my day>, "KeySet is reversed proper superset of string";

ok $s R⊅ $b, "Set is not a reversed proper superset of Bag";
ok $b R⊅ $b, "Bag is not reversed proper superset of itself";
ok $b R⊅ $s, "Bag is not a reversed proper superset of Set";

ok $s R⊅ $kb, "Set is not a reversed proper superset of KeyBag";
ok $kb R⊅ $kb, "KeyBag is not reversed proper superset of itself";
ok $kb R⊅ $s, "KeyBag is not a reversed proper superset of Set";

nok <your day> !R(>) $s, "'Your day' is reversed proper superset of Set (texas)";
ok $s !R(>) $s, "Set is not reversed proper superset of itself (texas)";
nok $s !R(>) <I'm afraid it isn't your day old chum>, "Set is reversed proper superset of string (texas)";

#?rakudo todo 'huh?'
nok ($ks (-) set <is>) !R(>) $ks, "Set is reversed proper superset of KeySet (texas)";
ok $ks !R(>) $ks, "KeySet is not reversed proper superset of itself (texas)";
nok $ks !R(>) <I'm afraid it is my day>, "KeySet is reversed proper superset of string (texas)";

ok $s !R(>) $b, "Set is not a reversed proper superset of Bag (texas)";
ok $b !R(>) $b, "Bag is not reversed proper superset of itself (texas)";
ok $b !R(>) $s, "Bag is not a reversed proper superset of Set (texas)";

ok $s !R(>) $kb, "Set is not a reversed proper superset of KeyBag (texas)";
ok $kb !R(>) $kb, "KeyBag is not reversed proper superset of itself (texas)";
ok $kb !R(>) $s, "KeyBag is not a reversed proper superset of Set (texas)";

#?rakudo skip 'Reduction and set operators'
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

# vim: ft=perl6
