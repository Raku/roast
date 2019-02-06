use v6;

use Test;

plan 4;

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

    # RT #130181
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

# vim: ft=perl6
