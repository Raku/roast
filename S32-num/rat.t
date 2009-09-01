use v6;

use Test;

plan *;

# Basic test functions specific to rational numbers.

# Test ~
is(~(Rat.new(2,3)), "2/3", "Rats stringify properly");
is(~(Rat.new(-1,7)), "-1/7", "Rats stringify properly");

# Test new
is(~(Rat.new(1,-7)), "-1/7", "Negative signs move to numerator");
is(~(Rat.new(-32,-33)), "32/33", "Double negatives cancel out");
is(~(Rat.new(2,4)), "1/2", "Reduce to simplest form in constructor");
is(~(Rat.new(39,33)), "13/11", "Reduce to simplest form in constructor");
is(~(Rat.new(0,33)), "0/1", "Reduce to simplest form in constructor");
is(~(Rat.new(1451234131,60)), "1451234131/60", "Reduce huge number to simplest form in constructor");

# Test basic math
is(~(1 / 4 + 1 / 4), "1/2", "1/4 + 1/4 = 1/2");
is(~(1 / 4 + 2 / 7), "15/28", "1/4 + 2/7 = 15/28");
is(~(1 / 4 + 1), "5/4", "1/4 + 1 = 5/4");
is(~(1 + 1 / 4), "5/4", "1 + 1/4 = 5/4");

is(~(1 / 4 - 1 / 4), "0/1", "1/4 - 1/4 = 0/1");
is(~(1 / 4 - 3 / 4), "-1/2", "1/4 - 3/4 = -1/2");
is(~(1 / 4 - 1), "-3/4", "1/4 - 1 = -3/4");
is(~(1 - 1 / 4), "3/4", "1 - 1/4 = 3/4");

is(~((2 / 3) * (5 / 4)), "5/6", "2/3 * 5/4 = 5/6");
is(~((2 / 3) * 2), "4/3", "2/3 * 2 = 4/3");
is(~(2 * (2 / 3)), "4/3", "2 * 2/3 = 4/3");

is(~((2 / 3) / (5 / 4)), "8/15", "2/3 / 5/4 = 8/15");
is(~((2 / 3) / 2), "1/3", "2/3 / 2 = 1/3");
is(~(2 / (1 / 3)), "3/2", "2 / 1/3 = 3/2");




done_testing;

# vim: ft=perl6
