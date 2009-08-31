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
#?rakudo todo 'Rat.new does not simplify fractions yet' 
is(~(Rat.new(2,4)), "1/2", "Reduce to simplest form in constructor");

# Test basic math
#?rakudo todo 'Result of addition is not simplified'
is(~(1 div 4 + 1 div 4), "1/2", "1/4 + 1/4 = 1/2");
is(~(1 div 4 + 1), "5/4", "1/4 + 1 = 5/4");
is(~(1 + 1 div 4), "5/4", "1 + 1/4 = 5/4");


done_testing;

# vim: ft=perl6
