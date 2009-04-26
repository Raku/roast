use v6;
use Test;
plan 53;

# L<S32::Numeric/Num/"=item abs">

=begin pod

Basic tests for the abs() builtin

=end pod

for 0, 0.0, 1, 50, 60.0, 99.99 {
    is(abs($_), $_, "got the right absolute value for $_");
#?rakudo skip 'named args'
    is(abs(:x($_)), $_, "got the right absolute value for $_");
    is(WHAT abs($_), WHAT $_, "got the right data type("~WHAT($_)~") of absolute value for $_");
}
for -1, -50, -60.0, -99.99 {
    is(abs($_), -$_, "got the right absolute value for $_");
#?rakudo skip 'named args'
    is(abs(:x($_)), -$_, "got the right absolute value for $_");
    is(WHAT abs($_), WHAT $_, "got the right data type("~WHAT($_)~") of absolute value for $_");
}

for 0, 0.0, 1, 50, 60.0, 99.99 {
    is(.abs, $_, 'got the right absolute value for $_='~$_);
    is(WHAT .abs, WHAT $_, 'got the right data type('~WHAT($_)~') of absolute value for $_='~$_);
}
for -1, -50, -60.0, -99.99 {
    is(.abs, -$_, 'got the right absolute value for $_='~$_);
    is(WHAT .abs, WHAT $_, 'got the right data type('~WHAT($_)~') of absolute value for $_='~$_);
}

is( abs(NaN), NaN, 'absolute value of NaN is NaN');
is( abs(Inf), Inf, 'absolute value of Inf is Inf');
is( abs(-Inf), Inf, 'absolute value of -Inf is Inf');

# vim: ft=perl6
