use v6;
use Test;
plan 49;

# L<S32::Numeric/Numeric/"=item abs">

=begin pod

Basic tests for the abs() builtin

=end pod

for 0, 0 / 1, 0.0e0, 1, 50, 60.0e0, 99.99 -> $x {
    is(abs($x), $x, "got the right absolute value for $x");
    is($x.abs, $x, 'got the right absolute value for $x='~$x);

    is (abs($x)).WHAT.gist, $x.WHAT.gist, 'type of abs($x) agrees with type of $x';
    is $x.abs.WHAT.gist, $x.WHAT.gist, 'type of $x.abs agrees with type of $x';
}

for -1, -50, -60.0e0, -9999 / 100 {
    is(abs($_), -$_, "got the right absolute value for $_");
    is(.abs, -$_, 'got the right absolute value for $_='~$_);

    is (abs($_)).WHAT.gist, $_.WHAT.gist, 'type of abs($_) agrees with type of $_';
    is $_.abs.WHAT.gist, $_.WHAT.gist, 'type of $_.abs agrees with type of $_';
}

is( abs(NaN), NaN, 'absolute value of NaN is NaN');
is( abs(Inf), Inf, 'absolute value of Inf is Inf');
is( abs(-Inf), Inf, 'absolute value of -Inf is Inf');

is( abs("-10"), 10, 'absolute value of "-10" is 10');

#?rakudo skip "abs(70596).WHAT parsing as abs(70596.WHAT)"
is( abs(70596).WHAT.gist, 70596.abs.WHAT.gist, 'abs(x).WHAT parses as x.abs.WHAT' );

done;

# vim: ft=perl6
