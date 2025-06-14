use v6.d;
use Test;
plan 2;

=begin pod

Basic tests for the log(), log2(), and log10() builtins in 6.c

=end pod

is log(-Inf), NaN, 'log(-Inf) = NaN';
is log10(-Inf), NaN, 'log10(-Inf) = NaN';

# vim: expandtab shiftwidth=4
