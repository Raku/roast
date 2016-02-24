use v6.c;

# Checking that testing is sane: Test.pm

use Test;

plan 1;

my $x = '0';
ok $x == $x;

# vim: expandtab shiftwidth=4 ft=perl6
