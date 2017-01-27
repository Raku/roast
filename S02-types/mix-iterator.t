use v6;
use Test;

use lib 't/spec/packages';
use Test::Iterator;

plan 2 * 7;

# Test iterators coming from Mixes

for 
    (a => 1.1, b => 2.2, c => 3.3, d => 4.4).Mix,       "Mix",
    (a => 1.1, b => 2.2, c => 3.3, d => 4.4).MixHash,   "MixHash"

-> $m, $case {
    my @pairs = $m.pairs;
    iterator-ok( { $m.iterator },
      "$case", @pairs );
    iterator-ok( { $m.kv.iterator },
      "$case.kv", @pairs.map: { |(.key,.value) } );
    iterator-ok( { $m.keys.iterator },
      "$case.keys", @pairs.map: { .key } );
    iterator-ok( { $m.values.iterator },
      "$case.values", @pairs.map: { .value } );
    iterator-ok( { $m.pairs.iterator },
      "$case.pairs", @pairs );
    iterator-ok( { $m.antipairs.iterator },
      "$case.antipairs", @pairs.map: { .antipair });
    iterator-ok( { $m.invert.iterator },
      "$case.invert", @pairs.map: { .antipair });
}

#vim: ft=perl6
