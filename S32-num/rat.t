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
#?rakudo 3 todo 'Rat.new does not simplify fractions yet' 
is(~(Rat.new(2,4)), "1/2", "Reduce to simplest form in constructor");
is(~(Rat.new(39,33)), "13/11", "Reduce to simplest form in constructor");
is(~(Rat.new(0,33)), "0/1", "Reduce to simplest form in constructor");

# Test basic math
#?rakudo todo 'Result of addition is not simplified'
is(~(1 div 4 + 1 div 4), "1/2", "1/4 + 1/4 = 1/2");
is(~(1 div 4 + 2 div 7), "15/28", "1/4 + 2/7 = 15/28");
is(~(1 div 4 + 1), "5/4", "1/4 + 1 = 5/4");
is(~(1 + 1 div 4), "5/4", "1 + 1/4 = 5/4");
#?rakudo 2 todo 'Subtraction is broken'
is(~(1 div 4 - 1 div 4), "0/1", "1/4 - 1/4 = 0/1");
is(~(1 div 4 - 3 div 4), "-1/2", "1/4 - 3/4 = -1/2");

done_testing;

# vim: ft=perl6
