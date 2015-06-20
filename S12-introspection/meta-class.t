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

ok(Foo.HOW.can(Foo, 'bar'), '... Foo can bar');
#?rakudo skip 'precedence of HOW RT #125015'
ok(HOW(Foo).can(Foo, 'bar'), '... Foo can bar (anthoer way)');
ok(Foo.^can('bar'), '... Foo can bar (as class method)');
ok(Foo.HOW.isa(Foo, Foo), '... Foo is-a Foo (of course)');
ok(Foo.^isa(Foo), '... Foo is-a Foo (of course) (as class method)');

lives-ok { 4.HOW.HOW }, 'Can access meta class of meta class';

# L<S12/Introspection/Class traits may include:>

is Foo.^name(), 'Foo', '... the name() property is Foo';
#?rakudo skip '.version, version number parsing RT #125017'
is Foo.^version(), v0.0.1, '... the version() property is 0.0.1';
#?rakudo skip '.layout RT #125018'
is Foo.^layout, P6opaque, '^.layout';

# RT #115208
eval-lives-ok "True.HOW.say", "can output the .gist of a .HOW";

# RT #114130
{
    throws-like 'Any.HOW(Foo)', X::Syntax::Argument::MOPMacro;
}

# RT #121885
class IntrospectAtBEGINTime {
    is BEGIN { IntrospectAtBEGINTime.^name }, 'IntrospectAtBEGINTime', '.^foo works at BEGIN time';
}

# vim: ft=perl6
