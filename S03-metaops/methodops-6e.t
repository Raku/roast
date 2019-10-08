use v6.e.PREVIEW;
use Test;

plan 2;

sub batch-call(Any:U \type, @expected, $desc, Str:D :$meth-name = 'foo', Str:D :$no-meth-name = 'bar', Capture:D :$args = \()) {
    subtest "Batch Call on {type.^name}: $desc" => {
        plan 8;
        my $obj = type.new;

        my @res = $obj.+"$meth-name"();
        is-deeply @res.List, @expected.List, '&infix:<.+>';

        @res = $obj.-"$meth-name"();
        is-deeply @res.List, @expected.reverse.List, '&infix:<.->';

        @res = $obj.?+"$meth-name"();
        is-deeply @res.List, @expected.List, '&infix:<.?+>';

        @res = $obj.?-"$meth-name"();
        is-deeply @res.List, @expected.reverse.List, '&infix:<.?->';

        throws-like { $obj.+"$no-meth-name"() }, X::Method::NotFound, '&infix:<.+> dies on missing method';
        throws-like { $obj.-"$no-meth-name"() }, X::Method::NotFound, '&infix:<.-> dies on missing method';
        lives-ok { $obj.?+"$no-meth-name"() }, q<&infix:<.?+> doesn't die on missing method>;
        lives-ok { $obj.?-"$no-meth-name"() }, q<&infix:<.?-> doesn't die on missing method>;
    }
}

subtest "Class-only" => {
    plan 3;
    my class C0 {
        method foo {
            $?CLASS.^name
        }
    }
    my class C1 is C0 {
        method foo {
            $?CLASS.^name;
        }
    }
    my class C2 is C1 {
        method foo {
            $?CLASS.^name
        }
    }
    batch-call C2, <C2 C1 C0>, "linear class structure";

    my class C3 is C1 {
        submethod foo {
            $?CLASS.^name
        }
    }
    my class C4 is C3 is C2 {
        method foo {
            $?CLASS.^name
        }
    }
    batch-call C4, <C4 C3 C2 C1 C0>, "multiple inheritance and submethod";

    my class C5 is hidden is C2 {
        submethod foo {
            $?CLASS.^name
        }
    }
    my class C6 is C5 {
        submethod foo {
            $?CLASS.^name
        }
    }
    batch-call C6, <C6 C5 C2 C1 C0>, "with hidden class";
}

subtest "Classes and roles" => {
    my role R0 {
        submethod foo {
            $?ROLE.^name
        }
    }
    my role R1 {
        method foo {
            "method from role" # method on roles are ignored
        }
    }
    my class C0 does R1 does R0 {
        submethod foo {
            $?CLASS.^name
        }
    }
    batch-call C0, <C0 R0>, "class and submethod from a role";

    my role R2 {
        submethod foo {
            $?ROLE.^name
        }
    }
    my class C1 does R2 is C0 {
        submethod foo {
            $?CLASS.^name
        }
    }
    batch-call C1, <C1 R2 C0 R0>, "inheritance and roles";

    my class C2 does R0 { }
    batch-call C2, <R0>.List, "only a submethod on role";

    my class C3 does R1 { }
    batch-call C3, "method from role".List, "a method from role but on class";

    my role R4a does R0 {
        submethod foo {
            $?ROLE.^name
        }
    }
    my role R4b does R0 {
        submethod foo {
            $?ROLE.^name
        }
    }
    my role R4c does R4b does R4a {
        submethod foo {
            $?ROLE.^name
        }
    }
    my class C4 does R4c {
        submethod foo {
            $?CLASS.^name
        }
    }
    my class C5 does R2 is C4 { };
    note C5.^mro(:roles).map( *.^name );
    note C5.^concretizations.map( *.^name );
    batch-call C4, <C4 R4c R4b R4a R0>, "role multi-consumption";
}

done-testing;
