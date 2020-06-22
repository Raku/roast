use v6.e.PREVIEW;
use Test;
plan 4;

# Since 6.e submethods are not composed into consuming classes.

role R0 {
    submethod foo {
        "R0::foo"
    }
}

role R1a {
    submethod foo {
        "R1a::foo"
    }
}

role R1 does R1a {
    submethod foo {
        "R1::foo"
    }
}

subtest "Single role" => {
    plan 2;

    my class C1 does R0 {
    }

    throws-like { C1.new.foo }, X::Method::NotFound, "no submethod on class",
                message => /:s No such method "'foo'" for invocant of type "'C1'"/;

    lives-ok { C1.new.R0::foo }, "class-qualified call finds the method in role";
}

subtest "Multi-role" => {
    plan 7;
    my class C2 does R0 does R1 {
    }

    my $c2 = C2.new;
    lives-ok { $c2.R0::foo }, "multi-role consumption, submethod on first role lives";
    lives-ok { $c2.R1::foo }, "multi-role consumption, submethod on second role lives";
    lives-ok { $c2.R1a::foo }, "multi-role consumption, submethod on indirect role lives";

    is $c2.R0::foo, 'R0::foo', "submethod from first role works";
    is $c2.R1::foo, 'R1::foo', "submethod from second role works";
    is $c2.R1a::foo, 'R1a::foo', "submethod from indirect role works";

    throws-like { $c2.foo }, X::Method::NotFound, "no submethod on class",
                message => /:s No such method "'foo'" for invocant of type "'C2'"/;
}
subtest "With class submethod" => {
    plan 5;
    my class C3 does R0 does R1 {
        submethod foo {
            "C3::foo"
        }
    }

    my $c3 = C3.new;
    lives-ok { $c3.R0::foo }, "multi-role consumption, submethod on first role lives";
    lives-ok { $c3.R1::foo }, "multi-role consumption, submethod on second role lives";

    is $c3.R0::foo, 'R0::foo', "submethod from first role works";
    is $c3.R1::foo, 'R1::foo', "submethod from second role works";

    is $c3.foo, 'C3::foo', 'submethod on class works';
}

subtest "Constructors in mixins" => {
    plan 4;
    my $was_in_b1_build = 0;
    my $was_in_b2_build = 0;
    role RoleB1  { submethod BUILD() { $was_in_b1_build++ } }
    role RoleB2  { submethod BUILD() { $was_in_b2_build++ } }
    class ClassB {}

    my $B = ClassB.new;
    is $was_in_b1_build, 0, "roles' BUILD submethods were not yet called (1)";
    is $was_in_b2_build, 0, "roles' BUILD submethods were not yet called (2)";

    $B does (RoleB1, RoleB2);
    is $was_in_b1_build, 1, "roles' BUILD submethods were called now (1)";
    is $was_in_b2_build, 1, "roles' BUILD submethods were called now (2)";
};

done-testing;

# vim: expandtab shiftwidth=4
