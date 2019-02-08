use v6;
use lib $?FILE.IO.parent(2).add("packages/Roles/lib");

use Test;

plan 4;

# GH #2613
use GH2613;
my class TestGH2613 does R1 { }

ok TestGH2613.^does(R1), "class typecheck against short role name";
ok TestGH2613.^does(GH2613::R1), "class typecheck against full role name";
ok TestGH2613 ~~ R1, "class smartmatches against short role name";
ok TestGH2613 ~~ GH2613::R1, "class smartmatches against full role name";
