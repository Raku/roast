use v6;
use Test;

plan 4;

sub showset($s) { $s.keys.sort.join(' ') }

my $s = set <I'm afraid it isn't your day>;
my $ks = KeySet.new(<I'm afraid it is>); # Tom Stoppard
my $b = bag <Whoever remains for long here in this earthly life will enjoy and endure more than enough>; # Seamus Heaney
my $kb = KeyBag.new(<None of us have all the heaven we want>); # Donald McCaig

ok "afraid" ∈ $s, "afraid is an element of Set";
ok "afraid" ∈ $ks, "afraid is an element of KeySet";
ok "earthly" ∈ $b, "earthly is an element of Bag";
ok "heaven" ∈ $kb, "heaven is an element of KeyBag";

# vim: ft=perl6
