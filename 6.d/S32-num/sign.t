use v6.d;
use Test;
plan 1;

# L<S32::Numeric/Real/"=item sign">

=begin pod

Basic tests for the sign() builtin in 6.c

=end pod

throws-like { sign(3+4i) }, X::Numeric::Real;

# vim: expandtab shiftwidth=4
