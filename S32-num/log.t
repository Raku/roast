use Test;
plan 34;

=begin pod

Basic tests for the log(), log2(), and log10() builtins

=end pod

my $log_5 = 940945/584642;
my $log_one_tenth = -254834/110673;

# Note the log2 of negative numbers is undefined, and the log2 of
# numbers less than one approaches zero as the numbers approach
# zero. See a graph of the function of this 'binary logarithm' on
# Wikipedia (https://en.m.wikipedia.org/wiki/Binary_algorithm).

my $log2_1 = 0;
my $log2_2 = 1;
my $log2_4 = 2;
my $log2_8 = 3;

# Conversion from other bases:
#   log2 n = ln n / ln 2 = log10 n / log10 2
#      or approximately:
#   log2n ~= 1.442695 ln n ~= 3.321928 log10 n
my $log2_5 = log(5) / log(2);
my $log2_one_tenth = log(0.1) / log(2);

my $log10_5 = 49471/70777;
my $log10_one_tenth = -1;

my $pi = 312689/99532;

# L<S32::Numeric/Numeric/"=item log">

is-approx(log(5), $log_5, 'got the log of 5');
is-approx(log(0.1), $log_one_tenth, 'got the log of 0.1');

# with given base:
is-approx(log(8, 2), 3, 'log(8, 2) is 3');
is-approx(log(42, 23),  1.192051192, 'log(42, 23)');

# with non-Num
is-approx(log("42", "23"),  1.192051192, 'log(42, 23) with strings');

# L<S32::Numeric/Numeric/"=item log10">

is-approx(log2(5), $log2_5, 'got the log2 of 5');
is-approx(log2(0.1), $log2_one_tenth, 'got the log2 of 0.1');

is-approx(log10(5), $log10_5, 'got the log10 of 5');
is-approx(log10(0.1), $log10_one_tenth, 'got the log10 of 0.1');

is( log(0), -Inf, 'log(0) = -Inf');
is( log(Inf), Inf, 'log(Inf) = Inf');
#?rakudo todo 'better behaviour in 6.e+'
is( log(-Inf), 'Inf+3.141592653589793i', 'log(-Inf) = complex');
is( log(NaN), NaN, 'log(NaN) = NaN');

is( log2(Inf), Inf, 'log2(Inf) = Inf');
is( log2(NaN), NaN, 'log2(NaN) = NaN');

is( log10(0), -Inf, 'log10(0) = -Inf');
is( log10(Inf), Inf, 'log10(Inf) = Inf');
#?rakudo todo 'better behaviour in 6.e+'
is( log10(-Inf), 'Inf+1.3643763538418412i', 'log10(-Inf) = complex');
is( log10(NaN), NaN, 'log10(NaN) = NaN');


# The closest I could find to documentation is here: http://tinyurl.com/27pj7c
# I use 1i instead of i since I don't know if a bare i will be supported

# log(exp(i pi)) = i pi log(exp(1)) = i pi
is-approx(log(-1 + 0i,), 0 + 1i * $pi, "got the log of -1");
is-approx(log10(-1 + 0i), 0 + 1i * $pi / log(10), "got the log10 of -1");

# log(exp(1+i pi)) = 1 + i pi
is-approx(log(-exp(1) + 0i), 1 + 1i * $pi, "got the log of -e");

# Conversion from other bases:
#   log2 n = ln n / ln 2 = log10 n / log10 2
#      or approximately:
#   log2n ~= 1.442695 ln n ~= 3.321928 log10 n
my $log2_10 = log(10) / log(2);
is-approx(log2(10), $log2_10, 'log2(10)=?');
is-approx(log10(-10 + 0i), 1 + 1i * $pi / log(10), "got the log10 of -10");
is-approx(log10(10), 1.0, 'log10(10)=1');

is-approx(log((1+1i) / sqrt(2)), 0 + 1i * $pi / 4, "got log of exp(i pi/4)");
is-approx(log(1i), 1i * $pi / 2, "got the log of i (complex unit)");

#is-approx(log2(1i), 1i * $pi / (2*$log2_10), 'got the log2 of i');
#is-approx(log2((1+1i) / sqrt(2)), 0 + 1i * $pi / (4*log(10)), "got log2 of exp(i pi/4)");

is-approx(log10(1i), 1i * $pi / (2*log(10)), 'got the log10 of i');
is-approx(log10((1+1i) / sqrt(2)), 0 + 1i * $pi / (4*log(10)), "got log10 of exp(i pi/4)");

is-approx(log(-1i), -0.5i * $pi , "got the log of -i (complex unit)");
is-approx(log10(-1i), -0.5i * $pi / log(10), "got the log10 of -i (complex unit)");

# TODO: please add more testcases for log10 of complex numbers
# See new test file for issue #862: S34-num/complex-logarithms.t

# Conversion from other bases:
#   log2 n = ln n / ln 2 = log10 n / log10 2
#      or approximately:
#   log2n ~= 1.442695 ln n ~= 3.321928 log10 n

is-approx( (-1i).log10(), -0.5i*$pi / log(10), " (i).log10 = - i  * pi/(2 log(10))");
isa-ok( log10(-1+0i), Complex, 'log10 of a complex returns a complex, not a list');

#?rakudo todo 'HugeInt.log'
is-approx (10 ** 1000).log10, 1000, "Can take the log of very large Ints";

# vim: expandtab shiftwidth=4
