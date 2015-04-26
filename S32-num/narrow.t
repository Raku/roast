use v6;
use Test;

plan 9;

# Complex
is     (1+2i).narrow,     1+2i, 'narrow on complex with imaginary part != 0';
isa-ok (2.5e0+0i).narrow, Num,  'narrow on complex without imaginary part (Num)';
isa-ok (2+0i).narrow,     Int,  'narrow on complex without imaginary part (Int)';

# Num
is     2.2e0.narrow, 2.2e0, 'narrow on non-integer Num is a no-op';
is     2e0.narrow,   2,     'narrow on integer Num';
isa-ok 2e0.narrow,   Int,   'narrow on integer Num (type)';

# Rat
is     1.5.narrow, 1.5, 'narrow on Rat with denominator != 1';
is     2.0.narrow, 2,   'narrow on Rat with denominator 1 (value)';
isa-ok 2.0.narrow, Int, 'narrow on Rat with denominator 1 (type)';
