use v6;
use Test;

use lib 't/spec/packages';
use Test::Iterator;

plan 2 * 7;

# Test iterators coming from Bags

for 
    <a b b c c c d d d d>.Bag,       "Bag",
    <a b b c c c d d d d>.BagHash,   "BagHash"

-> $b, $case {
    my @pairs = $b.pairs;
    iterator-ok( { $b.iterator },
      "$case", @pairs );
    iterator-ok( { $b.kv.iterator },
      "$case.kv", @pairs.map: { |(.key,.value) } );
    iterator-ok( { $b.keys.iterator },
      "$case.keys", @pairs.map: { .key } );
    iterator-ok( { $b.values.iterator },
      "$case.values", @pairs.map: { .value } );
    iterator-ok( { $b.pairs.iterator },
      "$case.pairs", @pairs );
    iterator-ok( { $b.antipairs.iterator },
      "$case.antipairs", @pairs.map: { .antipair });
    iterator-ok( { $b.invert.iterator },
      "$case.invert", @pairs.map: { .antipair });
}

#vim: ft=perl6
