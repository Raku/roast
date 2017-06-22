use v6;
use Test;

use lib 't/spec/packages';
use Test::Iterator;

plan 4 * 7;

# Test iterators coming from Hashes

for 
    (my % = "a" .. "z" Z=> 1..26),          "hash",
    (my %{Any} = "a" .. "z" Z=> 1..26),     "hash\{Any}",
    (my Int % = "a" .. "z" Z=> 1..26),      "Int Hash",
    (my Int %{Any} = "a" .. "z" Z=> 1..26), "Int Hash\{Any}"

-> %h, $case {
    my @pairs = %h.pairs;
    iterator-ok( { %h.iterator },
      "$case", @pairs );
    iterator-ok( { %h.kv.iterator },
      "$case.kv", @pairs.map: { |(.key,.value) } );
    iterator-ok( { %h.keys.iterator },
      "$case.keys", @pairs.map: { .key } );
    iterator-ok( { %h.values.iterator },
      "$case.values", @pairs.map: { .value } );
    iterator-ok( { %h.pairs.iterator },
      "$case.pairs", @pairs );
    iterator-ok( { %h.antipairs.iterator },
      "$case.antipairs", @pairs.map: { .antipair });
    iterator-ok( { %h.invert.iterator },
      "$case.invert", @pairs.map: { .antipair });
}

#vim: ft=perl6
