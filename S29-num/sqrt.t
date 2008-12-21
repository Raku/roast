use v6;
use Test;
plan 7;

# L<S29/Num/"=item sqrt">

=begin pod

Basic tests for the sqrt() builtin

=end pod

is_approx(sqrt(2), 1.4142135623730951, 'got the square root of 2');
is_approx(sqrt(5), 2.23606797749979,   'got the square root of 5');
is(sqrt(-1), NaN, 'sqrt(-1) is NaN');

# The spec specifies a branch cut in the complex plane of -pi <= theta <= pi
is_approx(sqrt(-1 +0i), 1i, 'got the square root of -1+0i');

#?rakudo skip 'eval not implemented'
{
    my $i = -1;
    is_approx(eval("sqrt($i.i)"), 1i, 'got the square root of -1.i');
}

is_approx(sqrt(1i), (1+1i)/sqrt(2), 'got the square root of 1i');
is_approx(sqrt(-1i), (1-1i)/sqrt(2), 'got the square root of -1i');
