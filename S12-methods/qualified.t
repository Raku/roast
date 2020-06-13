use v6;

use Test;

plan 7;

subtest "simple" => {
    plan 5;

    my class Parent {
        method me {
            self;
        }
    }

    my class Child is Parent {
        method myself {
            self.Parent::me();
        }
    }

    my role R {
        method me {
            self;
        }
    }

    my class Consumer does R {
        method myself {
            self.R::me();
        }
    }

    my $child = Child.new;
    is( $child.myself, $child, 'Qualified method calls should use the original self' );

    my $consumer = Consumer.new;
    is( $consumer.myself, $consumer, 'Qualified method calls should use the original self' );

    is-deeply (-42).::Int::abs, 42, 'qualified method call with starting colons';
    throws-like { (42).::Str::abs }, X::Method::InvalidQualifier, 'InvalidQualifier thrown with starting colons';

    # https://github.com/Raku/old-issue-tracker/issues/5823
    throws-like '.::', X::Syntax::Malformed, 'empty name in qualified method call';
}

subtest "inheritance" => {
    # rakudo github issue #2657
    plan 6;

    my class Parent {
        method me {
            self
        }
    }

    my role R0 {
            method on_R0 {
                "R0::on_R0"
            }
    }

    my role R1 does R0 is Parent {
        method foo {
            "R1::foo"
        }
    }

    my class Foo does R1 {
        method foo {
            "Foo::foo » " ~ self.R1::foo;
        }
    }

    my class Bar is Foo {
        method bar {
            "Bar::bar » " ~ self.Foo::foo
        }
        method via_R1 {
            "Bar::via_R1 » " ~ self.R1::foo
        }

        method via_R0 {
            "Bar::via_R0 » " ~ self.R0::on_R0
        }

        method myself {
            self.Parent::me
        }
    }

    my $inst = Bar.new;
    is( $inst.foo, "Foo::foo » R1::foo", "Qualification in a parent's method was failing");
    is( $inst.bar, "Bar::bar » Foo::foo » R1::foo", "Qualification in a parent via a child's method");
    is( $inst.via_R1, "Bar::via_R1 » R1::foo", "Indirect qualification to a role of parent class");
    is( $inst.via_R0, "Bar::via_R0 » R0::on_R0", "Indirect qualification to a role on a role of parent class");
    is( $inst.myself, $inst, "Indirect qualification to a role's parent on a intermediate parent" );
    is( $inst.R0::on_R0, "R0::on_R0", "Indirect qualification on the object");
}

subtest "puned role" => {
    # rakudo github issue #2659
    plan 2;
    my role R1 {
        method foo {
            "R1::foo"
        }
    }
    my class Foo is R1 {
        method foo {
            "Foo::foo » " ~ callsame;
        }
    }
    my class Bar is Foo { }

    my $inst = Foo.new;
    is( $inst.foo, "Foo::foo » R1::foo", "callsame works for a punned role" );
    $inst = Bar.new;
    is( $inst.foo, "Foo::foo » R1::foo", "callsame works for a punned role via a child class" );
}

subtest "run-time does" => {
    plan 1;
    # rakudo github issue #2282
    my role Foo1 { method foo { "Foo1::foo"; } }
    my role Foo2 { method foo { "Foo2::foo"; } }
    my role Foo3 { method foo { "Foo3::foo"; } }

    my class Foo { method foo { "Foo::foo"; } }

    class Bar is Foo does Foo1 {
        method foo {
            my @res;
            @res.push: "Bar::foo";
            @res.push: self.Foo::foo;
            @res.push: self.Foo1::foo;

            self does Foo2;
            @res.push: self.Foo::foo;
            @res.push: self.Foo1::foo;
            @res.push: self.Foo2::foo;

            self does Foo3;
            @res.push: self.Foo::foo;
            @res.push: self.Foo1::foo;
            @res.push: self.Foo2::foo;
            @res.push: self.Foo3::foo;
            @res
        }
    }

    my $inst = Bar.new;
    is-deeply( $inst.foo, [<Bar::foo Foo::foo Foo1::foo Foo::foo Foo1::foo Foo2::foo Foo::foo Foo1::foo Foo2::foo Foo3::foo>], "Dynamic application of roles" );
}

subtest "simple parameterized role" => {
    plan 1;
    my role Bar::R[::T] {
        method of-type {
            T.^name
        }
    }

    my class Foo does Bar::R[Str] {
        method foo {
            self.Bar::R::of-type
        }
    }

    is Foo.new.foo, 'Str', "parameterized type is resolved by its base name";
}

subtest "parameterizations and inheritance" => {
    plan 4;
    my sub type-sig(Mu \tobj, Mu $type = Nil) {
        tobj.^name ~ ($type ~~ Nil ?? "" !! "[" ~ $type.^name ~ "]")
    }
    my class C1 { ... }
    my role R1[::T] {
        method of-type {
            type-sig($?ROLE, T)
        }
        method to-str {
            "R2:" ~ self.C1::to-str
        }
    }

    my role R1 {
        method of-type {
            type-sig($?ROLE)
        }
    }

    my role R2 does R1[Bool] {
        my class CR2 does R1[Set] {
            method of-type {
                type-sig($?CLASS), |self.R1::of-type
            }
        }
        method of-type {
            type-sig($?ROLE), |self.R1::of-type
        }
        method CR2-of-type {
            CR2.new.of-type
        }
    }

    my role R2[::T] does R1[::T] {
        method of-type {
            type-sig($?ROLE, T), |self.R1::of-type
        }
    }

    # Despite R2 does R1 there is no ambiguity here because C1 resolves against it's immediate roles
    my class C1 does R1[Int] does R2[Num] {
        method of-type {
            type-sig($?CLASS), |self.R1::of-type, |self.R2::of-type
        }
        method to-str {
            "class C1"
        }
    }

    my class C2 is C1 does R2 {
        method of-type {
            type-sig($?CLASS), |callsame, |self.R2::of-type
        }
    }

    my class C3 is C1 {
        method C1-R1-of-type {
            self.R1::of-type;
        }
    }

    is-deeply C2.new.of-type, ("C2", "C1", "R1[Int]", "R2[Num]", "R1[Num]", "R2", "R1[Bool]"), "relaxed qualified calls to parameterized roles";
    is C2.new.to-str, "R2:class C1", "dispatch from role code on a class parent";
    is C2.new.CR2-of-type, ("R2::CR2", "R1[Set]"), "dispatching in a class private to a role";
    is C3.new.C1-R1-of-type, "R1[Int]", "dispatching to parent's role";
}

subtest "relaxed dispatch ambiguities" => {
    plan 2;
    my role R1[::T] {
        method of-type {
            "R1"
        }
    }
    my class C1 does R1[Int] does R1[Str] {
        method of-type {
            self.R1::of-type;
        }
    }

    my role R2 does R1[Int] does R1[Bool] {
        method of-type {
            self.R1::of-type
        }
    }

    my class C2 does R2 {
    }

    throws-like { C1.new.of-type }, X::AdHoc, "ambiguous relaxed role resolution in class throws",
                message => 'Ambiguous concretization lookup for R1';
    throws-like { C2.new.of-type }, X::AdHoc, "ambiguous relaxed role resolution in role throws",
                message => 'Ambiguous concretization lookup for R1';
}

done-testing;
# vim: expandtab shiftwidth=4
