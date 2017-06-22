use v6;
use Test;

use lib 't/spec/packages';
use Test::Iterator;

plan 12 * 6;

for 
    (1..26),       "int range",
    (1^..26),      "^int range",
    (1..^26),      "int^ range",
    (1^..^26),     "^int^ range",
    ("a".."z"),    "string range",
    ("a"^.."z"),   "^string range",
    ("a"..^"z"),   "string^ range",
    ("a"^..^"z"),  "^string^ range",
    (1.1..5.5),    "rat range",
    (1.1^..5.5),   "^rat range",
    (1.1..^5.5),   "rat^ range",
    (1.1^..^5.5),  "^rat^ range"

-> $r, $case {
    my @pairs = $r.pairs;
    iterator-ok( { $r.iterator },
      "$case", @pairs.map: { .value } );
    iterator-ok( { $r.kv.iterator },
      "$case.kv", @pairs.map: { |(.key,.value) } );
    iterator-ok( { $r.keys.iterator },
      "$case.keys", @pairs.map: { .key } );
    iterator-ok( { $r.values.iterator },
      "$case.values", @pairs.map: { .value } );
    iterator-ok( { $r.pairs.iterator },
      "$case.pairs", @pairs );
    iterator-ok( { $r.antipairs.iterator },
      "$case.antipairs", @pairs.map: { .antipair });
}

#vim: ft=perl6
