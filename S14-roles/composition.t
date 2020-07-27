use v6;
use Test;
plan 49;

# L<S14/Roles/"Roles may be composed into a class at compile time">

role rA {
    method mA1 {
        'mA1';
    }
    method mA2 {
        'mA2';
    }
};

role rB {
    method mB1 {
        'mB1';
    }
    method mB2 {
        'mB2';
    }
};

class C1 does rA {
    method mC1 {
        'mC1';
    }
};

my $x = C1.new();

is $x.mC1,      'mC1',      'Can call method of class with mixed in role';
is $x.mA1,      'mA1',      'Call first method from role';
is $x.mA2,      'mA2',      'Call second method from role';

class C2 does rA does rB {
    method mC2 {
        'mC2';
    }
}

my $y = C2.new();

is $y.mC2,      'mC2',      'Can call method of class with two roles mixed in';
is $y.mA1,      'mA1',      'Can call mixed in method (two roles) 1';
is $y.mA2,      'mA2',      'Can call mixed in method (two roles) 2';
is $y.mB1,      'mB1',      'Can call mixed in method (two roles) 3';
is $y.mB2,      'mB2',      'Can call mixed in method (two roles) 4';

ok C2 ~~ rA, 'class matches first role';
ok C2 ~~ rB, 'class matches second role';
ok rA !~~ C2, 'first role does not match class';
ok rB !~~ C2, 'second role does not match class';

# https://github.com/Raku/old-issue-tracker/issues/803
role RT64002 does rA does rB {}
ok RT64002 ~~ rA, 'role matches first role it does';
ok RT64002 ~~ rB, 'role matches second role it does';
ok rA !~~ RT64002, 'role not matched by first role it does';
ok rB !~~ RT64002, 'role not matched by second role it does';

{
    class D1 does rA {
        method mA1 {
            'D1.mA1';
        }
    }

    my $z = D1.new();

    is $z.mA1,      'D1.mA1',   'Can override method in a role with method in a class';
}

# diamond composition
# https://github.com/Raku/old-issue-tracker/issues/2593
{
    role DA { 
        method foo { "OH HAI" };
    }
    role DB does DA { }
    role DC does DA { }
    class DD does DB does DC { };
    is DD.new.foo, 'OH HAI', 'diamond role composition';
    class DE is DB is DC { };
    is DE.new.foo, 'OH HAI', 'same with punning and inheritance';
}

# https://github.com/Raku/old-issue-tracker/issues/1371
{
    role RT69919 {
        my $lex = 'Luthor';
        method rt69919 { return $lex }
    }
    class IL does RT69919 {}

    is IL.new.rt69919, 'Luthor', 'access lexical declared in role from method called via class that does the role';
}


# inheritance through role composition - specced in A12
# https://github.com/Raku/old-issue-tracker/issues/1303
{
    class irA {};
    role  irB is   irA {};
    class irC does irB {};
    ok irC ~~ irB, 'role composition worked';
    ok irC ~~ irA, 'role composition transported inheritance';

}

# https://github.com/Raku/old-issue-tracker/issues/1512
{
    role RT72856A { method foo {} };
    role RT72856B { method foo {} };
    try { EVAL 'class RT72856C does RT72856A does RT72856B {}' };
    ok $! ~~ /foo/,
        'method of the same name from two different roles collide in a class composition';
    ok $! ~~ /RT72856A/, 'colliding role mentioned in error (1)';
    ok $! ~~ /RT72856B/, 'colliding role mentioned in error (2)';
}

# https://github.com/Raku/old-issue-tracker/issues/1666
{
    role UsesSettingSub {
        method doit() {
            uc 'a';
        }
    }
    class ClassUsesSettingSub does UsesSettingSub { };
    is ClassUsesSettingSub.new.doit, 'A',
        'can use a sub from the setting in a method composed from a role';
}

# https://github.com/Raku/old-issue-tracker/issues/894
{
    my class A {
        method foo { "OH HAI" }
        method aie { "AIE!" }
    }

    {
        my role B { has A $.bar handles 'aie' }
        my class C does B { }
        is C.new.aie, 'AIE!', 'literal handles from role is composed (1)';
        throws-like { C.new.foo }, X::Method::NotFound,
             'literal handles from role is composed (2)';
    }

    {
        my role B { has A $.bar handles * }
        my class C does B { }
        is C.new.foo, 'OH HAI', 'wildcard handles from role is composed (1)';
        is C.new.aie, 'AIE!', 'wildcard handles from role is composed (2)';
    }

    eval-dies-ok q:to/END/, 'attributes conflict in role composition';
        my role B {
            has A $.bar handles "aie"
        }
        my class C does B {
            has A $.bar handles "foo"
        }
        END
}

# https://github.com/Raku/old-issue-tracker/issues/3795
{
    my role R1 {
        multi method m(Int $x) { ... }
        multi method m(Str $x) { ... }
    }
    my class C1 does R1 {
        multi method m(Int $x) { 42 }
        multi method m(Str $x) { 'the answer' }
    }
    is C1.m(1), 42, 'stubbed multi in role implemented in class can be called (1)';
    is C1.m('x'), 'the answer', 'stubbed multi in role implemented in class can be called (2)';
    my $msg;
    dies-ok { EVAL 'my class C2 does R1 { }'; CATCH { $msg = .message } },
        'must implement stubbed multi methods in roles (1)';
    ok $msg ~~ /required/, 'must implement stubbed multi methods in roles (2)';

    my role R2 {
        multi method m(Int $x) { 99 }
        multi method m(Str $x) { 'ice cream' }
    }
    my class C3 does R1 does R2 {
    }
    is C3.m(1), 99, 'another role can provided required multi implementation (1)';
    is C3.m('x'), 'ice cream', 'another role can provided required multi implementation (2)';

    my class C4 does R1 does R2 {
        multi method m(Int $x) { 69 }
    }
    is C4.m(1), 69, 'class can override multi method from role';
    is C4.m('x'), 'ice cream', 'other multi candidates from role survive';

    my role R3 {
        multi method m(Int $x) { 101 }
        multi method m(Str $x) { 'dalmatians' }
    }
    dies-ok { EVAL 'my class C5 does R2 does R3 { }'; CATCH { $msg = .message } },
        'multis with same sig are composition conflicts (1)';
    ok $msg ~~ /'multiple roles'/, 'multis with same sig are composition conflicts (2)';
    my class C6 does R2 does R3 {
        multi method m(Int $x) { 11 }
        multi method m(Str $x) { 'pipers' }
    }
    is C6.m(1), 11, 'class can resolve conflicts from multis by implementing method (1)';
    is C6.m(1), 11, 'class can resolve conflicts from multis by implementing method (2)';

    my role R4 does R1 { }
    dies-ok { EVAL 'my class C7 does R4 { }'; CATCH { $msg = .message } },
        'stubbed method from role brought in by role must be satisfied (1)';
    ok $msg ~~ /required/, 'stubbed method from role brought in by role must be satisfied (2)';

    my class C8 does R4 {
        multi method m(Int $x) { 40 }
        multi method m(Str $x) { 'days' }
    }
    is C8.m(1), 40, 'class can satisfy stub from role brought in by role (1)';
    is C8.m('x'), 'days', 'class can satisfy stub from role brought in by role (2)';

    my class C9 does R4 does R2 { }
    is C9.m(1), 99, 'another role can provided indirectly required multi implementation (1)';
    is C9.m('x'), 'ice cream', 'another role can provided indirectly required multi implementation (2)';
}

{
    my multi sub trait_mod:<is>(Method:D \meth, :$also!) {
        meth.package.^add_method($also.Str, meth);
    }

    my role DoubleMethod {
        method test () is also<test-me> {
        }
    }

    my class RoleTarget does DoubleMethod {
    }
}

# vim: expandtab shiftwidth=4
