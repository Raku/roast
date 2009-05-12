use v6;

use Test;

plan 12;

=begin pod

Very basic meta-class tests from L<S12/Introspection>

=end pod

class Foo:ver<0.0.1> {
    method bar ($param) returns Str {
        return "baz" ~ $param
    }
};

# L<S12/Introspection/should be called through the meta object>

#?pugs emit skip_rest('meta class NYI');
#?pugs emit exit;

ok(Foo.HOW.can(Foo, 'bar'), '... Foo can bar');
ok(Foo.^can('bar'), '... Foo can bar (as class method)');
ok(Foo.HOW.isa(Foo, Foo), '... Foo is-a Foo (of course)');
ok(Foo.^isa(Foo), '... Foo is-a Foo (of course) (as class method)');

# L<S12/Introspection/Class traits may include:>

#?rakudo skip '.name'
is Foo.^name(), 'Foo', '... the name() property is Foo';
#?rakudo skip '.version, version number parsing'
is Foo.^version(), v0.0.1, '... the version() property is 0.0.1';
ok Foo.^parents()[0] === Foo, '... the isa() property returns Foo as the first parent class';
#?rakudo skip '.layout'
is Foo.^layout, P6opaque, '^.layout';

# L<S12/Introspection/"get the method list of MyClass">

# NOTE: I am guessing on some of this here, but it's a start for now

my @methods = Foo.new().^methods();
is @methods[0].name, 'bar', '... our first method is bar';
ok @methods[0].signature.perl ~~ /'$param'/, '... our first methods signature is $param';
is @methods[0].returns, Str, '... our first method returns a Str';
#?rakudo skip '.multi'
ok !@methods[0].multi, '... our first method is not a multimethod';

