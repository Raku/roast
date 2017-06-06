use v6;
use Test;

plan 40;

sub showset($s) { $s.keys.sort.join(' ') }
sub showkv($x) { $x.sort.map({ .key ~ ':' ~ .value }).join(' ') }

my $s = set <I'm afraid it isn't your day>;
my $sh = SetHash.new(<I'm afraid it is>); # Tom Stoppard
my $b = bag <Whoever remains for long here in this earthly life will enjoy and endure more than enough>; # Seamus Heaney
my $bh = BagHash.new(<Come, take your bread with joy, and your wine with a glad heart>); # Ecclesiastes 9:7

# Union tests moved to union.t

# Intersection tests moved to intersection.t

# set subtraction

is showset($s (-) $s), showset(∅), "Set subtracted from Set is correct";
isa-ok ($s (-) $s), Set, "... and it's actually a Set";

is showset($s (-) $sh), showset(set <isn't your day>), "SetHash subtracted from Set is correct";
isa-ok ($s (-) $sh), Set, "... and it's actually a Set";
is showset($sh (-) $s), showset(set <is>), "Set subtracted from SetHash is correct";
isa-ok ($sh (-) $s), Set, "... and it's actually a Set";

is showkv($b (-) $s), showkv($b), "Set subtracted from Bag is correct";
isa-ok ($b (-) $s), Bag, "... and it's actually a Bag";
is showset($s (-) $b), showset($s), "Bag subtracted from Set is correct";
isa-ok ($s (-) $b), Bag, "... and it's actually a Bag";

is showset($s (-) $bh), showset(set <I'm afraid it isn't day>), "BagHash subtracted from Set is correct";
isa-ok ($s (-) $bh), Bag, "... and it's actually a Bag";
is showkv($bh (-) $s), showkv(<Come, take your bread with joy, and wine with a glad heart>.Bag), "Set subtracted from BagHash is correct";
isa-ok ($bh (-) $s), Bag, "... and it's actually a Bag";

# symmetric difference

is showset($s (^) $s), showset(∅), "Set symmetric difference with Set is correct";
isa-ok ($s (^) $s), Set, "... and it's actually a Set";

is showset($s (^) $sh), showset(set <is isn't your day>), "SetHash symmetric difference with Set is correct";
isa-ok ($s (^) $sh), Set, "... and it's actually a Set";
is showset($sh (^) $s), showset(set <is isn't your day>), "Set symmetric difference with SetHash is correct";
isa-ok ($sh (^) $s), Set, "... and it's actually a Set";

# RT #122882
is showset($s (^) $s (^) $s), showset(∅), "Set symmetric difference with 3+ args (RT #122882)";
is showset(<a b> (^) <b c> (^) <a d> (^) <a e>), showset(set <c d e>), "Set symmetric difference with 3+ args (RT #122882)";

# symmetric difference with Bag moved to bag.t

# is subset of moved to subset.t

# is proper subset of moved to proper-subset.t

# is not a proper subset of moved to proper-subset.t

# is superset of moved to subset.t

# is not a superset of moved to proper-subset.t

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
    throws-like 'set;', Exception,
        'set listop called without arguments dies (1)',
        message => { m/'Function "set" may not be called without arguments'/ };
    throws-like 'set<a b c>;', X::Syntax::Confused,
        'set listop called without arguments dies (2)',
        message => { m/'Use of non-subscript brackets after "set" where postfix is expected'/ };
}

# vim: ft=perl6
