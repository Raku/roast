use v6.c;
use Test;

plan 3;

subtest "Metamethod basics" => {
    plan 2;
    my class Foo {
        method ^get-arg(\obj) { obj }
        method ^get-self(\obj) { self }
        method ^get-value { "metamethod" }
    }

    my sub basic-checks(\invocant, $message) is test-assertion {
        subtest $message => {
            plan 6;
            throws-like { invocant."^get-value"() },
                        X::Method::NotFound,
                        "metamethod is not installed on the class itself";
            if ok invocant.HOW.^can('get-value'), "metaobject can user-defined method" {
                is invocant.HOW.get-value, "metamethod", "metamethod is available on metaobject";
                isa-ok invocant.^get-self, Metamodel::ClassHOW, "metamethod's self is a metaobject";
                cmp-ok invocant.HOW, '===', invocant.^get-self, "metamethod self is invocant class' metaobject";
                cmp-ok invocant, '===', invocant.^get-arg, "metamethod default argument is the invocant";
            }
            else {
                skip-rest "no way to test metamethod when it's not on HOW";
            }
        }
    }

    basic-checks(Foo, "On a class");
    my $foo = Foo.new;
    basic-checks($foo, "On a class instance");
}

subtest "Inheritance" => {
    plan 2;

    my class C1 {
        method ^get-value($) { "from C1" }
    }

    my class C2 is C1 { }

    if ok C2.HOW.^can('get-value'), "a child class inherits parent's metamethod" {
        is C2.^get-value, "from C1", "child class inherits its parent metamethod";
    }
    else {
        skip-rest "no way to test metamethod when it's not on child's HOW";
    }
}

subtest "Role consumption" => {
    plan 2;

    my role R {
        method ^get-value { "from R" };
    }

    my class C does R { }

#?rakudo todo "metamethods in roles are not implemented yet"
    ok C.HOW.^can('get-value'), "a class consuming a role with metamethod gets it";
#?rakudo skip "metamethods in roles are not implemented yet"
    is C.^get-value, "from R", "class gets its metamethod from the consumed role";
}

done-testing;
