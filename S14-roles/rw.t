use v6;
use Test;

plan 6;

role R1 is rw {
    has $.r1;
    has $.r1-ro is readonly;
}

sub test-R1(Mu \type, Str $msg?) is test-assertion {
    my $title = $msg // "rw/ro";
    subtest $title => {
        plan 4;
        my $obj = type.new(r1 => 41, r1-ro => 12);

        lives-ok { $obj.r1++ }, "'is rw' on a role is being repsected";
        is $obj.r1, 42, "attribute value has really changed";
        dies-ok { $obj.r1-ro++ }, "'is readonly' overrides 'is rw' on role";
        is $obj.r1-ro, 12, "read only attribute didn't change";
    }
}

subtest "Default is readonly" => {
    plan 4;

    my role R2 {
        has $.r2;
    }

    dies-ok { R2.new.r2 = 0 }, "pun of a role preserves default readonly";
    my role R3 does R2 { }
    dies-ok { R3.new.r2 = 0 }, "pun of a role doing role preserves default readonly";
    my class C1 does R2 { }
    dies-ok { C1.new.r2 = 0 }, "class consuming a role repsects default readonly";
    my class C2 does R3 { }
    dies-ok { C2.new.r2 = 0 }, "class consuming a role doing a role repsects default readonly";
}

subtest "Puning" => {
    plan 1;
    test-R1 R1;
}

subtest "Pun of a role doing role" => {
    plan 1;
    my role R3 does R1 { };
    test-R1 R3;
}

subtest "Class consuming role" => {
    plan 1;
    my class C1 does R1 { }
    test-R1 C1;
}

subtest "Class consuming role doing a role" => {
    plan 1;
    my role R3 does R1 { }
    my class C2 does R3 { }
    test-R1 C2;
}

subtest "use 'also is rw'" => {
    my role R3 {
        has $.r1;
        also is rw;
        has $.r1-ro is readonly;
    }
    test-R1 R3, "role puning";
    my role R4 does R3 { }
    test-R1 R4, "role doing role puning";
}

# vim: expandtab shiftwidth=4
