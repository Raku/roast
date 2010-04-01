use v6;
use Test;
plan 50;

# L<S32::Numeric/Numeric/"=item abs">

=begin pod

Basic tests for the abs() builtin

=end pod

# In the next two blocks of tests, make an exception for type checking
# on Ints, because right now Ints in Rakudo are still mostly treated
# as Parrot Integers, and Integer.abs returns a Num. -- colomon

for 0, 0 / 1, 0.0e0, 1, 50, 60.0e0, 99.99 {
    is(abs($_), $_, "got the right absolute value for $_");
    is(.abs, $_, 'got the right absolute value for $_='~$_);
    #?rakudo skip 'named args'
    is(abs(:x($_)), $_, "got the right absolute value for $_");

    unless $_ ~~ Int {
        ok(abs($_) ~~ $_.WHAT, "got the right data type (" ~ $_.WHAT ~ ") of absolute value for $_");
        ok($_.abs ~~ $_.WHAT, 'got the right data type (' ~ $_.WHAT ~ ') of absolute value for $_='~$_);
    }
}

for -1, -50, -60.0e0, -9999 / 100 {
    is(abs($_), -$_, "got the right absolute value for $_");
    is(.abs, -$_, 'got the right absolute value for $_='~$_);
    #?rakudo skip 'named args'
    is(abs(:x($_)), -$_, "got the right absolute value for $_");

    unless $_ ~~ Int {
        ok(abs($_) ~~ $_.WHAT, "got the right data type (" ~ $_.WHAT ~ ") of absolute value for $_");
        ok($_.abs ~~ $_.WHAT, 'got the right data type (' ~ $_.WHAT ~ ') of absolute value for $_='~$_);
    }
}

is( abs(NaN), NaN, 'absolute value of NaN is NaN');
is( abs(Inf), Inf, 'absolute value of Inf is Inf');
is( abs(-Inf), Inf, 'absolute value of -Inf is Inf');

is( abs("-10"), 10, 'absolute value of "-10" is 10');

is( abs(70596).WHAT, 70596.abs.WHAT, 'abs(x).WHAT parses as x.abs.WHAT' );

done_testing;

# vim: ft=perl6
