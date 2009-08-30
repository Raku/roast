use v6;
use Test;
plan 16;

# L<S32::Numeric/Num/"=item sqrt">

=begin pod

Basic tests for the sqrt() builtin

=end pod

is_approx(sqrt(2), 1.4142135623730951, 'got the square root of 2');
is_approx(sqrt(5), 2.23606797749979,   'got the square root of 5');
is_approx(sqrt(42), 6.48074069840786, 'got the square root of 42');
is_approx(sqrt(1/42), 0.1543033499620919, 'got the square root of 1/42');
is_approx(sqrt(1e2),10, 'got square root of 1e2');

is(sqrt(-1), NaN, 'sqrt(-1) is NaN');
is(sqrt(NaN), NaN, 'sqrt(NaN) is NaN');
is(sqrt(Inf), Inf, 'sqrt(Inf) is Inf');
is(sqrt(-Inf), NaN, 'sqrt(-Inf) is NaN');

is(sqrt(-0.0), -0.0, 'sqrt preserves sign of zero');

#?rakudo skip 'named args'
{
   is_approx(sqrt(:x(2)), 1.4142135623730951, 'got the square root of 2 with named args');
   is_approx(sqrt(:x(5)), 2.23606797749979,   'got the square root of 5 with named args');
   is(sqrt(:x(-1)), NaN, 'sqrt(:x(-1)) is NaN');
}

# The spec specifies a branch cut in the complex plane of -pi <= theta <= pi
is_approx(sqrt(-1 +0i), 1i, 'got the square root of -1+0i');

is_approx(sqrt(1i), (1+1i)/sqrt(2), 'got the square root of 1i');
is_approx(sqrt(-1i), (1-1i)/sqrt(2), 'got the square root of -1i');

# vim: ft=perl6
