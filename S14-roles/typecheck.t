use Test;
use lib $*PROGRAM.parent(2).add("packages/Roles/lib");

plan 11;

# GH #2613
use GH2613;
my class TestGH2613 does R1 { }

ok TestGH2613.^does(R1), "class typecheck against short role name";
ok TestGH2613.^does(GH2613::R1), "class typecheck against full role name";
ok TestGH2613 ~~ R1, "class smartmatches against short role name";
ok TestGH2613 ~~ GH2613::R1, "class smartmatches against full role name";

# GH #2714
{
    my role R2714 { }
    my class C2714 does R2714 { }

    my class C2714_1 is C2714 { }
    my class C2714_2 is C2714 { }

    my role R2714_1 is C2714_1 { }
    my role R2714_1[::T] is C2714_2 { }

    ok R2714_1 ~~ C2714_1, "Role group matches a parent class of its non-parameterized member";
    ok R2714_1 ~~ C2714, "Role group matches a parent of parent of its non-parameterized member";
    ok R2714_1 ~~ R2714, "Role group matches a role of parent of its non-parameterized member";
    nok R2714_1 ~~ C2714_2, "Role group doesn't match a parent class of a parameterized member";

    my \r = R2714_1[Int];
    ok r ~~ C2714_2, "Curryied role matches its parent class";
    ok r ~~ C2714, "Curried role matches a parent of its parent class";
    ok r ~~ R2714, "Curried role matches a role of its parent class";
}

# vim: expandtab shiftwidth=4
