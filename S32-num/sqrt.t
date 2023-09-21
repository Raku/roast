use v6.c;
use Test;
plan 18;

# L<S32::Numeric/Real/"=item sqrt">

=begin pod

Basic tests for the sqrt() builtin

=end pod

is-approx(sqrt(2), 1.41421356, 'got the square root of 2');
is-approx(sqrt(5) * sqrt(5), 5,   'got the square root of 5');
is-approx(sqrt(42) * sqrt(42), 42, 'got the square root of 42');
is-approx(sqrt(1/42) * sqrt(1/42), 1/42, 'got the square root of 1/42');
is-approx(sqrt(1e2),10, 'got square root of 1e2');

is-approx(2.sqrt, 1.41421356, 'got the square root of 2');
is-approx(5.sqrt * sqrt(5), 5,   'got the square root of 5');
is-approx(42.sqrt * sqrt(42), 42, 'got the square root of 42');
is-approx(1/42.sqrt * sqrt(1/42), 1/42, 'got the square root of 1/42');
is-approx(1e2.sqrt, 10, 'got square root of 1e2');

is(sqrt(-1), NaN, 'sqrt(-1) is NaN');
is(sqrt(NaN), NaN, 'sqrt(NaN) is NaN');
is(sqrt(Inf), Inf, 'sqrt(Inf) is Inf');
is(sqrt(-Inf), NaN, 'sqrt(-Inf) is NaN');

is(sqrt(-0.0e0), -0.0e0, 'sqrt preserves sign of Num zero');

# The spec specifies a branch cut in the complex plane of -pi <= theta <= pi
is-approx(sqrt(-1 +0i), 1i, 'got the square root of -1+0i');

is-approx(sqrt(1i), (1+1i)/sqrt(2), 'got the square root of 1i');
is-approx(sqrt(-1i), (1-1i)/sqrt(2), 'got the square root of -1i');

# vim: ft=perl6
