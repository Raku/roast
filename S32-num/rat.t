use v6;

use Test;

plan *;

# Basic tests functions specific to rational numbers.

is(~(Rat.new(2,3)), "2/3", "Rats stringify properly");
is(~(Rat.new(-1,7)), "-1/7", "Rats stringify properly");
is(~(Rat.new(1,-7)), "-1/7", "Negative signs move to numerator");



done_testing;

# vim: ft=perl6
