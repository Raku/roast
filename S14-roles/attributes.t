use v6.c;
use Test;

plan 3;

subtest "Basics" => {
    plan 7;
    # L<S14/Roles/"Roles may have attributes">

    {
        my role R1 {
            has $!a1;
            has $.a2 is rw;
        };

        my class C1 does R1 {
            method set_a1($val) {
                $!a1 = $val;
            }
            method get_a1 {
                $!a1
            }
        };

        my $x = C1.new();

        $x.set_a1('abc');
        is $x.get_a1,   'abc',      'Can set and get class-private attr from role';

        $x.a2 = 'xyz';
        is $x.a2,       'xyz',      'Public attribute gets accessor/mutator composed';
    }


    my role R2 {
        has Int $!a;
    }

    throws-like 'class C3 does R2 { has $!a }', Exception, 'Roles with conflicing attributes';
    throws-like 'class C2 does R2 { has Int $!a }', Exception, 'Same name, same type will also conflicts';

    my role R3 {
        has $.x = 42;
    }
    my class C4 does R3 { }
    is C4.new.x, 42, 'initializing attributes in a role works';

    my role R4 { has @!foo; method bar() { @!foo } }
    my class C5 does R4 {
        has $.baz;
    }
    is C5.new().bar(), [], 'Composing an attribute into a class that already has one works';

    {
        my role R6 {
            has %!e;
            method el() { %!e<a> };
            submethod BUILD(:%!e) { };
        }
        my class C6 does R6 { };
        is C6.new(e => { a => 42 }).el, 42, 'can use :%!role_attr in BUILD signature';
    }
}

subtest "Multi-path consumption" => {
    plan 3;
    # Attrbiute from common role consumed by two other roles must not result in a conflict
    eval-lives-ok q<
        my role R0 {
            has $.foo;
        };
        my role R1 does R0 { };
        my role R2 does R0 { };
        my class C does R1 does R2 { }
    >, "indirect double-consumption of the same role doesn't result in conflicting attribute";
    eval-lives-ok q<
        my role R0[::T] {
            has T $.foo;
        };
        my role R1 does R0[Int] { };
        my role R2 does R0[Int] { };
        my class C does R1 does R2 { }
    >, "indirect double-consumption of parameterized role doesn't result in conflicting attribute";
    eval-lives-ok q<
        my role R0[::T] {
            has T $.foo;
        };
        my role R1[::T] does R0[T] { };
        my role R2[::T] does R0[T] { };
        my class C does R1[Str] does R2[Str] { }
    >, "indirect double-consumption via parameterized roles doesn't result in conflicting attribute";
}

# GH rakudo/rakudo#3382
# Entities defined in classes are prioritized over role stuff. For example, a method from role can't override class'
# attribute accessor; etc.
subtest "Class prioritization" => {
    plan 2;

    my role R {
        has $.r1 = pi;
        method c1 { 666 }
    }
    my class C does R {
        has $.c1 = 42;
        method r1 { e }
    }

    my $inst = C.new;
    is $inst.c1, 42, "a method from role doesn't override class attribute accessor";
    is $inst.r1, e, "a method from class overrides role's attribute accessor";
}

# vim: expandtab shiftwidth=4
