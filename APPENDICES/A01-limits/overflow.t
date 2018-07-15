use v6;
use Test;
plan 3;

# RT #125938
throws-like '2**10000000000', X::Numeric::Overflow,
    'attempting to raise to a huge power throws';
throws-like '2**-10000000000', X::Numeric::Underflow,
    'attempting to raise to a huge negative power throws';

# RT #130369
throws-like '2**-999999', X::Numeric::Underflow,
    'attempting to raise to a large negative power throws';


# vim: ft=perl6
