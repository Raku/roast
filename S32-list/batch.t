use v6;
use Test;

plan 4;

is ^10 .batch(3).join('|'),  "0 1 2|3 4 5|6 7 8|9", "does .batch(3) work";
is ^10 .batch(20).join('|'), "0 1 2 3 4 5 6 7 8 9", "does .batch(20) work";
is ^10 .batch(1).join('|'),  "0|1|2|3|4|5|6|7|8|9", "does .batch(1) work";

throws-like( { ^10 .batch(0) }, X::OutOfRange,
  "does 0 as batch-size throw",
  got => 0 );
