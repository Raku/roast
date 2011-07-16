use v6;
use Test;
plan 72;

# L<S32::Numeric/Numeric/"=item exp">

=begin pod

Basic tests for the exp() builtin

=end pod

# SHOULD: test method forms of exp as well.

my $e_to_the_fifth = 5497075/37039;
my $pi = 312689/99532;

{
    is_approx(5.exp, $e_to_the_fifth, '5.exp == e to the fifth');
    is_approx(5.Rat.exp, $e_to_the_fifth, '5.Rat.exp == e to the fifth');
    is_approx(5.Num.exp, $e_to_the_fifth, '5.Num.exp == e to the fifth');
    is_approx(0.exp, 1, '0.exp == 1');

    is_approx((1i*$pi).exp, -1, '(i pi).exp == -1');
    is_approx((-1i*$pi).exp, -1, '(-i pi).exp == -1');

    is_approx(5.exp(2), 32, '5.exp(2) == 32');
    is_approx(5.Rat.exp(2), 32, '5.Rat.exp == 32');
    is_approx(5.Num.exp(2), 32, '5.Num.exp == 32');
    is_approx(0.exp(2), 1, '0.exp(2) == 1');

    is_approx((1i*$pi).exp(2), 2 ** (1i*$pi), '(i pi).exp(2) == 2 ** (1i*$pi)');
    is_approx((-1i*$pi).exp(2), 2 ** (-1i*$pi), '(-i pi).exp(2) == 2 ** (-1i*$pi)');
    is_approx(2.exp(1i*$pi), (1i*$pi) ** 2, '(2).exp(i pi) == (1i*$pi) ** 2');
}

is_approx(exp(5), $e_to_the_fifth, 'got the exponential of 5');
is_approx(exp(0), 1, 'exp(0) == 1');
is_approx(exp(-1),  0.3678794, '1/e is correct');
is(exp(Inf), 'Inf', 'exp(Inf) == Inf');
is(exp(-Inf), 0, 'exp(-Inf) == 0');
is(exp(NaN), NaN, 'exp(NaN) == NaN');
is_approx(exp(log(100)),100, 'e^(log(100))=100');

is_approx((1i*$pi).exp, -1, '(i $pi).exp == -1');
is_approx(exp(1i*$pi), -1, 'exp(i $pi) == -1');
is_approx(exp(-1i*$pi), -1, 'exp(-i $pi) == -1');

is_approx(exp(5, 2), 32, 'got 32');
is_approx(exp(0, 2), 1, 'exp(0, 2) == 1');
is_approx(exp(-1, 2),  1/2, '1/2 is correct');
is(exp(Inf, 2), 'Inf', 'exp(Inf) == Inf');
is(exp(-Inf, 2), 0, 'exp(-Inf) == 0');
is(exp(NaN, 2), NaN, 'exp(NaN) == NaN');
is_approx(exp(log(100, 2), 2),100, 'e^(log(100, 2), 2)=100');

is_approx(exp(1i*$pi, 2), 2 ** (1i*$pi), 'exp(i $pi, 2) == 2 ** (1i*$pi)');
is_approx(exp(-1i*$pi, 2), 2 ** (-1i*$pi), 'exp(-i $pi, 2) == 2 ** (-1i*$pi)');

{
    for 1 ... 20 {
	    my $arg = 2.0 * $pi / $_;
	    is_approx(exp(1i * $arg), cos($arg) + 1i * sin($arg), 'ex$pi == cos + i sin No. ' ~ $_);
	    is_approx(exp(1i * $arg) * exp(-1i * $arg), 1, 'exp(ix) * exp(-ix) == 1 No. ' ~ $_);
    }
}
# vim: ft=perl6
