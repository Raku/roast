use v6.d;

# Checking that testing is sane: Test.pm6

use Test;

plan 1;

my $x = '0';
ok $x == $x;

# vim: expandtab shiftwidth=4 ft=perl6
