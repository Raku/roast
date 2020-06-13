use v6;
use Test;

plan 16;

# quick check that type objects stringify correctly - this has been a problem
# for Niecza in the past

# XXX Should ~Set and Set.Str return something specific?  For now
# just make sure they don't die

is Set.gist, '(Set)', 'Set.gist';
is Set.raku, 'Set', 'Set.raku';
is Set.Str, "", "Set.Str is empty string";
is ~Set, "", "~Set is empty string";

is SetHash.gist, '(SetHash)', 'SetHash.gist';
is SetHash.raku, 'SetHash', 'SetHash.raku';
is SetHash.Str, "", "SetHash.Str is empty string";
is ~SetHash, "", "~SetHash is empty string";

is Bag.gist, '(Bag)', 'Bag.gist';
is Bag.raku, 'Bag', 'Bag.raku';
is Bag.Str, "", "Bag.Str is empty string";
is ~Bag, "", "~Bag is empty string";

is BagHash.gist, '(BagHash)', 'BagHash.gist';
is BagHash.raku, 'BagHash', 'BagHash.raku';
is BagHash.Str, "", "BagHash.Str is empty string";
is ~BagHash, "", "~BagHash is empty string";

# vim: expandtab shiftwidth=4
