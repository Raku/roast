use v6;

use Test;

plan 34;

=begin pod

Very basic instance method tests from L<S12/"Methods">

=end pod

# L<S12/"Method calls" /"either the dot notation or indirect object notation:">
class Foo {
  method doit ($a, $b, $c) { $a + $b + $c }
  method noargs () { 42 }
  method nobrackets { 'mice' }
  method callsmethod1() { self.noargs(); }
  method callsmethod2 { self.noargs(); }
}

my $foo = Foo.new();
is($foo.doit(1,2,3), 6, "dot method invocation");

my $val;
#?rakudo 2 skip 'indirect object notation'
lives_ok { $val = doit $foo: 1,2,3; }, '... indirect method invocation works';
is($val, 6, '... got the right value for indirect method invocation');

is($foo.noargs, 42, "... no parentheses after method");
is($foo.noargs(), 42, "... parentheses after method");

{
    my $val;
    lives_ok { $val = $foo.noargs\ (); }, "... <unspace> + parentheses after method";
    is($val, 42, '... we got the value correctly');
}

{
    my $val;
    lives_ok { $val = $foo.nobrackets() }, 'method declared with no brackets';
    is($val, 'mice', '... we got the value correctly');
}

{
    my $val;
    lives_ok { $val = $foo.callsmethod1() }, 'method calling method';
    is($val, 42, '... we got the value correctly');
};

{
    my $val;
    lives_ok { $val = $foo.callsmethod2() }, 'method calling method with no brackets';
    is($val, 42, '... we got the value correctly');
};

{
    # This test could use peer review to make sure it complies with the spec.
    class Zoo {
        method a () { my %s; %s.b }
        method c () { my %s; b(%s) }
        method b () { 1 }
    }
    dies_ok( { Zoo.new.a }, "can't call current object methods on lexical data structures");
    dies_ok( { Zoo.new.c }, "meth(%h) is not a valid method call syntax");
}
# doesn't match, but defines "b"
sub b() { die "oops" }

# this used to be a Rakudo bug, RT #62046
{
    class TestList {
        method list {
            'method list';
        }
    }
    is TestList.new.list, 'method list', 'can call a method "list"';
}

# Test that methods allow additional named arguments
# http://irclog.perlgeek.de/perl6/2009-01-28#i_870566

{
    class MethodTester {
        method m ($x, :$y = '')  {
            "$x|$y";
        }
    }

    my $obj = MethodTester.new;

    is $obj.m('a'),        'a|',   'basic sanity 1';
    is $obj.m('a', :y<b>), 'a|b',  'basic sanity 2';
    lives_ok { $obj.m('a', :y<b>, :z<b>) }, 'additional named args are ignored';
    is $obj.m('a', :y<b>, :z<b>), 'a|b', '... same, but test value';

    # and the same with class methods

    is MethodTester.m('a'),        'a|',   'basic sanity 1 (class method)';
    is MethodTester.m('a', :y<b>), 'a|b',  'basic sanity 2 (class method)';
    lives_ok { MethodTester.m('a', :y<b>, :z<b>) }, 
             'additional named args are ignored (class method)';
    is MethodTester.m('a', :y<b>, :z<b>), 'a|b', 
       '... same, but test value (class method)';
}

# test that public attributes don't interfere with private methods of the same
# name (RT #61774)

{
    class PrivVsAttr {
        has @something is rw;
        method doit {
            @something = <1 2 3>;
            self!something;
        }
        method !something {
            'private method'
        }
    }

    my PrivVsAttr $a .= new;
    is $a.doit, 'private method',
       'call to private method in presence of attribute';
}

# used to be RT #69206

class AnonInvocant {
    method me(::T $:) {
        T;
    }
}

is AnonInvocant.new().me, AnonInvocant, 'a typed $: as invocant is OK';

# check that sub foo() is available from withing method foo();
# RT #74014

{
    my $tracker = '';
    sub foo($x) {
        $tracker = $x;
    }
    class MSClash {
        method foo($x) {
            foo($x);
        }
    }
    MSClash.new.foo('bla');
    is $tracker, 'bla', 'can call a sub of the same name as the current method';
}

# usage of *%_ in in methods

{
    my $tracker = '';
    sub track(:$x) {
        $tracker = $x;
    }
    class PercentUnderscore {
        method t(*%_) {
            track(|%_);
        }
    }
    lives_ok { PercentUnderscore.new.t(:x(5)) }, 'can use %_ in a method';
    is $tracker, 5, ' ... and got right result';
}

{
    my $tracker = '';
    sub track(:$x) {
        $tracker = $x;
    }

    class ImplicitPercentUnderscore {
        method t {
            track(|%_);
        }
    }
    lives_ok { ImplicitPercentUnderscore.new.t(:x(5)) }, 'can use %_ in a method (implicit)';
    is $tracker, 5, ' ... and got right result (implicit)';
}

# RT #72940
{
    class X {
        method x(*@_) { @_[0] };
    }
    is X.new.x('5'), '5', 'can use explicit @_ in method signature';

}

{
    class Y {
        method y(Whatever) { 1; };
    }
    is Y.new.y(*), 1, 'Can dispatch y(*)';
}

{
    class InvocantTypeCheck {
        method x(Int $a:) {   #OK not used
            42;
        }
    }
    dies_ok { InvocantTypeCheck.new.x() }, 'Invocant type is checked';
}

# vim: ft=perl6
