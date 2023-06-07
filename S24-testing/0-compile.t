# Checking that testing is sane: Test.rakumod

use Test;

plan 1;

my $x = '0';
ok $x == $x;

# vim: expandtab shiftwidth=4
