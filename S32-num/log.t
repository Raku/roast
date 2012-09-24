use v6;
use Test;
plan 29;

=begin pod

Basic tests for the log() and log10() builtins

=end pod

my $log_5 = 940945/584642;
my $log_one_tenth = -254834/110673;
my $log10_5 = 49471/70777;
my $log10_one_tenth = -1;
my $pi = 312689/99532;

# L<S32::Numeric/Numeric/"=item log">

is_approx(log(5), $log_5, 'got the log of 5');
is_approx(log(0.1), $log_one_tenth, 'got the log of 0.1');

# with given base:
#?pugs 3 skip 'No compatible multi variant found: "&log"'
is_approx(log(8, 2), 3, 'log(8, 2) is 3'); 
is_approx(log(42, 23),  1.192051192, 'log(42, 23)');

# with non-Num
is_approx(log("42", "23"),  1.192051192, 'log(42, 23) with strings');

# L<S32::Numeric/Numeric/"=item log10">

is_approx(log10(5), $log10_5, 'got the log10 of 5');
is_approx(log10(0.1), $log10_one_tenth, 'got the log10 of 0.1');

is( log(0), -Inf, 'log(0) = -Inf');

is( log(Inf), Inf, 'log(Inf) = Inf');
is( log(-Inf), NaN, 'log(-Inf) = NaN');
is( log(NaN), NaN, 'log(NaN) = NaN');

is( log10(0), -Inf, 'log10(0) = -Inf');
is( log10(Inf), Inf, 'log10(Inf) = Inf');
is( log10(-Inf), NaN, 'log10(-Inf) = NaN');
is( log10(NaN), NaN, 'log10(NaN) = NaN');


# please add tests for complex numbers
#
# The closest I could find to documentation is here: http://tinyurl.com/27pj7c
# I use 1i instead of i since I don't know if a bare i will be supported

# log(exp(i pi)) = i pi log(exp(1)) = i pi
is_approx(log(-1 + 0i,), 0 + 1i * $pi, "got the log of -1");
is_approx(log10(-1 + 0i), 0 + 1i * $pi / log(10), "got the log10 of -1");

# log(exp(1+i pi)) = 1 + i pi
is_approx(log(-exp(1) + 0i), 1 + 1i * $pi, "got the log of -e");
is_approx(log10(-10 + 0i), 1 + 1i * $pi / log(10), "got the log10 of -10");
is_approx(log10(10), 1.0, 'log10(10)=1');

is_approx(log((1+1i) / sqrt(2)), 0 + 1i * $pi / 4, "got log of exp(i pi/4)");
is_approx(log(1i), 1i * $pi / 2, "got the log of i (complex unit)");

is_approx(log10(1i), 1i * $pi / (2*log(10)), 'got the log10 of i');
is_approx(log10((1+1i) / sqrt(2)), 0 + 1i * $pi / (4*log(10)), "got log10 of exp(i pi/4)");

is_approx(log(-1i), -0.5i * $pi , "got the log of -i (complex unit)");
is_approx(log10(-1i), -0.5i * $pi / log(10), "got the log10 of -i (complex unit)");

# TODO: please add more testcases for log10 of complex numbers

is_approx( (-1i).log10(), -0.5i*$pi / log(10), " (i).log10 = - i  * pi/(2 log(10))");
isa_ok( log10(-1+0i), Complex, 'log10 of a complex returns a complex, not a list');

#?rakudo todo 'HugeInt.log'
is_approx (10 ** 1000).log10, 1000, "Can take the log of very large Ints";

# vim: ft=perl6
