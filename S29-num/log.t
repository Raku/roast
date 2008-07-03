use v6;
use Test;
plan 11;

=begin pod

Basic tests for the log() and log10() builtins

=end pod

# L<S29/Num/"=item log">

is_approx(log(5), 1.6094379124341003, 'got the log of 5');
is_approx(log(0.1), -2.3025850929940455, 'got the log of 0.1');

# L<S29/Num/"=item log10">

is_approx(log10(5), 0.6989700043360187, 'got the log10 of 5');
is_approx(log10(0.1), -0.9999999999999998, 'got the log10 of 0.1');

# please add tests for complex numbers
#
# The closest I could find to documentation is here: http://tinyurl.com/27pj7c
# I use 1i instead of i since I don't know if a bare i will be supported
 
# log(exp(i pi)) = i pi log(exp(1)) = i pi
#?pugs 2 todo 'feature'
#?rakudo 2 todo 'complex log()'
is_approx(log(-1 + 0i,), 0 + 1i * pi, "got the log of -1");
is_approx(log10(-1 + 0i), 0 + 1i * pi / log(10), "got the log10 of -1");

# log(exp(1+i pi)) = 1 + i pi
#?pugs 2 todo 'feature'
#?rakudo 2 todo 'complex log()'
is_approx(log(-exp(1)) + 0i, 1 + 1i * pi, "got the log of -e");
is_approx(log10(-10 + 0i), 1 + 1i * pi / log(10), "got the log10 of -10");

#?pugs todo 'feature'
#?rakudo 3 todo 'complex log()'
is_approx(log((1+1i) / sqrt(2)), 1 + 1i * pi / 4, "got log of exp(i pi/4)");
is_approx(log(1i), 1i * pi / 2, "got the log of i (complex unit)");
#?pugs todo 'feature'
is_approx(log(-1i), 1i * pi * 1.5, "got the log of -i (complex unit)");

# TODO: please add more testcases for log10 of complex numbers
