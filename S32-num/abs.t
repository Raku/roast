use v6;
use Test;
plan 60;

# L<S32::Numeric/Num/"=item abs">

=begin pod

Basic tests for the abs() builtin

=end pod

for 0, 0 / 1, 0.0e0, 1, 50, 60.0e0, 99.99 {
    is(abs($_), $_, "got the right absolute value for $_");
    is(.abs, $_, 'got the right absolute value for $_='~$_);
    #?rakudo skip 'named args'
    is(abs(:x($_)), $_, "got the right absolute value for $_");

    #?rakudo 2 todo 'WHAT aspect is wrong for Ints'
    ok(abs($_) ~~ $_.WHAT, "got the right data type (" ~ $_.WHAT ~ ") of absolute value for $_");
    ok($_.abs ~~ $_.WHAT, 'got the right data type (' ~ $_.WHAT ~ ') of absolute value for $_='~$_);
}
for -1, -50, -60.0e0, -9999 / 100 {
    is(abs($_), -$_, "got the right absolute value for $_");
    is(.abs, -$_, 'got the right absolute value for $_='~$_);
    #?rakudo skip 'named args'
    is(abs(:x($_)), -$_, "got the right absolute value for $_");

    #?rakudo 2 todo 'WHAT aspect is wrong for Ints'
    is(abs($_) ~~ $_.WHAT, "got the right data type (" ~ $_.WHAT ~ ") of absolute value for $_");
    is($_.abs ~~ $_.WHAT, 'got the right data type (' ~ $_.WHAT ~ ') of absolute value for $_='~$_);
}

#?rakudo 3 skip "abs(NaN or Inf) leads to infinite recursion in Rakudo-ng"
is( abs(NaN), NaN, 'absolute value of NaN is NaN');
is( abs(Inf), Inf, 'absolute value of Inf is Inf');
is( abs(-Inf), Inf, 'absolute value of -Inf is Inf');

#?rakudo skip 'abs("-10") NYI in Rakudo-ng'
is( abs("-10"), 10, 'absolute value of "-10" is 10');

#?rakudo todo 'RT 70596'
is( abs(70596).WHAT, 70596.abs.WHAT, 'abs(x).WHAT parses as x.abs.WHAT' );

done_testing;

# vim: ft=perl6
