use v6;

use Test;

plan 19;

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
    lives_ok {
        $val = $foo.noargs.();
    }, "... '.' + parentheses after method", :todo<bug>;
    is($val, 42, '... we got the value correctly', :todo<feature>);
}

#?rakudo skip 'parse error (or test error?)'
{
    my $val;
    lives_ok {
        $val = $foo.noargs\ .();
    }, "... <unspace> + '.' + parentheses after method", :todo<bug>;
    is($val, 42, '... we got the value correctly', :todo<feature>);
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

