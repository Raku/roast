use v6.d;
use Test;
plan 2;

# L<S32::Numeric/Real/"=item sqrt">

=begin pod

Basic tests for the sqrt() builtin in 6.c

=end pod

is sqrt(-1),   NaN, 'sqrt(-1) is NaN';
is sqrt(-Inf), NaN, 'sqrt(-Inf) is NaN';

# vim: expandtab shiftwidth=4
