use v6;
use Test;

use lib 't/spec/packages';
use Test::Iterator;

plan 2 * 6;

for 
    ("a".."z").Set,       "Set",
    ("a".."z").SetHash,   "SetHash"

-> $s, $case {
    my @pairs = $s.pairs;
    iterator-ok( { $s.iterator },
      "$case", @pairs );
    iterator-ok( { $s.kv.iterator },
      "$case.kv", @pairs.map: { |(.key,.value) } );
    iterator-ok( { $s.keys.iterator },
      "$case.keys", @pairs.map: { .key } );
    iterator-ok( { $s.values.iterator },
      "$case.values", @pairs.map: { .value } );
    iterator-ok( { $s.pairs.iterator },
      "$case.pairs", @pairs );
    iterator-ok( { $s.antipairs.iterator },
      "$case.antipairs", @pairs.map: { .antipair });
}

#vim: ft=perl6
