# from @librasteve, roast issue #862

# This should do the trick:

use v6;
use Test;

# Tests for log, log2, and log10 of complex numbers

# See good references at Wikipedia:
#
# https://en.wikipedia.org/
#   wiki/Binary_logarithm
#   wiki/Complex_logarithm
#   wiki/Complex_logarithm#Logarithms_to_other_bases

# Complex numbers to test
my $z1 =  1+i;
my $z2 = -1+i;
my $z3 = -2-3i;

# Expected values from independent reference

# Natural log
my $log_z1  = 0.34657359 + 0.785398163i;
my $log_z2  = 0.34657359 + 2.35619449i;
my $log_z3  = 1.28247468 - 2.15879893i;

# Log base 2
my $log2_z1 = log($z1) / log(2);
my $log2_z2 = log($z2) / log(2);
my $log2_z3 = log($z3) / log(2);

# Log base 10
my $log10_z1 = log($z1) / log(10);
my $log10_z2 = log($z2) / log(10);
my $log10_z3 = log($z3) / log(10);

# Start writing tests
plan 9;

# log (natural logarithm)
is-approx log($z1), $log_z1, "log(1+1i) approximately matches expected value";
is-approx log($z2), $log_z2, "log(-1+1i) approximately matches expected value";
is-approx log($z3), $log_z3, "log(-2-3i) approximately matches expected value";

# log2 (base 2 logarithm)
is-approx log2($z1), $log2_z1, "log2(1+1i) approximately matches expected value";
is-approx log2($z2), $log2_z2, "log2(-1+1i) approximately matches expected value";
is-approx log2($z3), $log2_z3, "log2(-2-3i) approximately matches expected value";

# log10 (base 10 logarithm)
is-approx log10($z1), $log10_z1, "log10(1+1i) approximately matches expected value";
is-approx log10($z2), $log10_z2, "log10(-1+1i) approximately matches expected value";
is-approx log10($z3), $log10_z3, "log10(-2-3i) approximately matches expected value";
