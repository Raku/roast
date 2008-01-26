use v6-alpha;
use Test;
plan 7;

# L<S29/Num/"=item sqrt">

#?rakudo skip 'Cannot parse pod'
{
=pod 

Basic tests for the sqrt() builtin

=cut
}

is_approx(sqrt(2), 1.4142135623730951, 'got the square root of 2');
is_approx(sqrt(5), 2.23606797749979,   'got the square root of 5');
ok(sqrt(-1), NaN, 'sqrt(-1) is NaN');

#WARNING: there is currently no spec which of the complex roots should be
#returned. We should change that.
is_approx(sqrt(-1 +0i), 1i, 'got the square root of -1+0i');

{
    my $i = -1;
    is_approx(eval("sqrt($i.i)"), 1i, 'got the square root of -1.i');
}

is_approx(sqrt(1i), (1+1i)/sqrt(2), 'got the square root of 1i');
is_approx(sqrt(-1i), (1-1i)/sqrt(2), 'got the square root of -1i');
