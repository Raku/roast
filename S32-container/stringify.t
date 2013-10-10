use v6;
use Test;

plan 16;

# quick check that type objects stringify correctly - this has been a problem
# for Niecza in the past

# XXX Should ~Set and Set.Str return something specific?  For now
# just make sure they don't die

is Set.gist, '(Set)', 'Set.gist';
is Set.perl, 'Set', 'Set.perl';
is Set.Str, "", "Set.Str is empty string";
is ~Set, "", "~Set is empty string";

#?niecza 4 skip 'SetHash'
is SetHash.gist, '(SetHash)', 'SetHash.gist';
is SetHash.perl, 'SetHash', 'SetHash.perl';
is SetHash.Str, "", "SetHash.Str is empty string";
is ~SetHash, "", "~SetHash is empty string";

is Bag.gist, '(Bag)', 'Bag.gist';
is Bag.perl, 'Bag', 'Bag.perl';
is Bag.Str, "", "Bag.Str is empty string";
is ~Bag, "", "~Bag is empty string";

#?niecza 4 skip 'BagHash'
is BagHash.gist, '(BagHash)', 'BagHash.gist';
is BagHash.perl, 'BagHash', 'BagHash.perl';
is BagHash.Str, "", "BagHash.Str is empty string";
is ~BagHash, "", "~BagHash is empty string";

# vim: ft=perl6
done;
