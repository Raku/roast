use v6;

use Test;

plan 13;

=begin pod

Classes with names containing double colons and nested classes.

=end pod

class Foo::Bar {
    method baz {
        return 42;
    }
}

{
    my $foobar = Foo::Bar.new();
    is($foobar.baz, 42, 'methods can be called on classes with namespaces with ::');
}

class A {
    class B {
        method x { 2 }
        has $.y = 'b';
        method z { $!y }
    };
    method x { 1 }
    has $.y = 'a';
    method z { $!y }
};
{
    ok(A.new,           'could instantiate outer class');
    is(A.new.x,    1,   'called correct method on class A');
    is(A.new.y,    'a', 'could access attribute in class A');
    is(A.new.z,    'a', 'method access correct attribute in class A');
    #?pugs 5 skip 'No such subroutine: &A::B'
    ok(A::B.new,        'could instantiate nested class');
    is(A::B.new.x, 2,   'called correct method on class A::B');
    is(A::B.new.y, 'b', 'could access attribute in class A::B');
    is(A::B.new.z, 'b', 'method access correct attribute in class A::B');
    eval_dies_ok(q{ B.new },  'class A::B not available outside of class as B');
}

class C {
    grammar D {
        rule test { a+ }
    }
}
#?pugs skip 'No such subroutine: &C::D'
{
    ok(C::D ~~ Grammar,            'C::D is a grammar');
    #?niecza skip 'Cannot dispatch to a method on D because it is not inherited or done by Cursor'
    ok('aaa' ~~ /<C::D::test>/,    'could call rule in nested grammar');
    #?niecza skip 'Cannot dispatch to a method on D because it is not inherited or done by Cursor'
    ok(!('bbb' ~~ /<C::D::test>/), 'rule in nested grammar behaves correctly');
}

# vim: ft=perl6
