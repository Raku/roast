use v6;
use Test;

# Test may seem weird, but Rakudo JVM fails it catastrophically at the moment.

plan 5;

for (1, 5) {
    for (2, 4) -> $k {
        ok $_ !%% 2, '$_ has a sensible value here';
    }
}

ok True, "Got here!";

# vim: ft=perl6
