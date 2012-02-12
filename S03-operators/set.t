use v6;
use Test;

plan 23;

sub showset($s) { $s.keys.sort.join(' ') }

my $s = set <I'm afraid it isn't your day>;
my $ks = KeySet.new(<I'm afraid it is>); # Tom Stoppard
my $b = bag <Whoever remains for long here in this earthly life will enjoy and endure more than enough>; # Seamus Heaney
my $kb = KeyBag.new(<Come, take your bread with joy, and your wine with a glad heart>); # Ecclesiastes 9:7

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

ok "marmoset" ∉ $s, "marmoset is not an element of Set";
ok "marmoset" ∉ $ks, "marmoset is not an element of KeySet";
ok "marmoset" ∉ $b, "marmoset is not an element of Bag";
ok "marmoset" ∉ $kb, "marmoset is not an element of KeyBag";
ok "marmoset" ∉ <a b c d e>, "marmoset is not an element of a b c d e";

# ok "hogwash" !(elem) $s, "hogwash is not an element of Set (texas)";
# ok "hogwash" !(elem) $ks, "hogwash is not an element of KeySet (texas)";
# ok "hogwash" !(elem) $b, "hogwash is not an element of Bag (texas)";
# ok "hogwash" !(elem) $kb, "hogwash is not an element of KeyBag (texas)";
# ok "hogwash" !(elem) <a b c d e>, "hogwash is not an element of a b c d e (texas)";

is showset($s ∪ $s), showset($s), "Set union with itself yields self";
isa_ok ($s ∪ $s), Set, "... and it's actually a Set";
is showset($ks ∪ $ks), showset($ks), "KeySet union with itself yields self (as Set)";
isa_ok ($ks ∪ $ks), Set, "... and it's actually a Set";
is showset($b ∪ $b), showset($b), "Bag union with itself yields self (as Set)";
isa_ok ($b ∪ $b), Set, "... and it's actually a Set";
is showset($kb ∪ $kb), showset($kb), "KeyBag union with itself yields (as Set)";
isa_ok ($kb ∪ $kb), Set, "... and it's actually a Set";

# vim: ft=perl6
