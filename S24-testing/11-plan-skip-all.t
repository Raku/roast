use v6;
use Test;
plan skip-all => "Testing skippage of `plan skip-all`";

plan 1;
flunk "`plan skip-all` did not exit the test file";

# vim: expandtab shiftwidth=4 ft=perl6
