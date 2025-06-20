use v6.d;
use Test;

my @nan-test-values = e, 1e1, π, τ, 1e20, 1e100, 1e200, 1e1000, ∞;

plan 2 * @nan-test-values;

for @nan-test-values.map({|($_, -$_)}) -> $x {
    cmp-ok atanh(my num $ = $x), '===', NaN, "atanh($x) is a NaN";
}

# vim: expandtab shiftwidth=4
