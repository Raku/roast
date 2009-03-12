use v6;

use Test;

plan 26;

=begin pod

Very basic instance method tests from L<S12/"Methods">

=end pod

# L<S12/"Methods" /"either the dot notation or indirect object notation:">
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
#?rakudo skip 'parse error'
lives_ok { $val = doit $foo: 1,2,3; }, '... indirect method invocation works';
#?rakudo skip 'test dependency'
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
    #?rakudo todo 'method should not be usable as sub'
    dies_ok( { Zoo.new.c }, "meth(%h) is not a valid method call syntax");
}

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
    #?rakudo todo 'RT #61480'
    lives_ok { $obj.m('a', :y<b>, :z<b>) }, 'additional named args are ignored';
    #?rakudo skip 'RT #61480'
    is $obj.m('a', :y<b>, :z<b>), 'a|b', '... same, but test value';

    # and the same with class methods

    is MethodTester.m('a'),        'a|',   'basic sanity 1 (class method)';
    is MethodTester.m('a', :y<b>), 'a|b',  'basic sanity 2 (class method)';
    #?rakudo todo 'RT #61480'
    lives_ok { MethodTester.m('a', :y<b>, :z<b>) }, 
             'additional named args are ignored (class method)';
    #?rakudo skip 'RT #61480'
    is MethodTester.m('a', :y<b>, :z<b>), 'a|b', 
       '... same, but test value (class method)';
}
