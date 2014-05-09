use v6;

use Test;

plan 13;

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
#?rakudo skip 'precedence of HOW'
ok(HOW(Foo).can(Foo, 'bar'), '... Foo can bar (anthoer way)');
#?rakudo skip 'precedence of prefix:<^>'
ok(^Foo.can(Foo, 'bar'), '... Foo can bar (another way)');
ok(Foo.^can('bar'), '... Foo can bar (as class method)');
ok(Foo.HOW.isa(Foo, Foo), '... Foo is-a Foo (of course)');
ok(Foo.^isa(Foo), '... Foo is-a Foo (of course) (as class method)');

lives_ok { 4.HOW.HOW }, 'Can access meta class of meta class';

# L<S12/Introspection/Class traits may include:>

is Foo.^name(), 'Foo', '... the name() property is Foo';
#?rakudo skip '.version, version number parsing'
is Foo.^version(), v0.0.1, '... the version() property is 0.0.1';
#?rakudo skip '.layout'
is Foo.^layout, P6opaque, '^.layout';

# RT #115208
eval_lives_ok "True.HOW.say", "can output the .gist of a .HOW";

# RT #114130
{
    use lib "t/spec/packages";
    use Test::Util;
    throws_like 'Any.HOW(Foo)', X::Syntax::Argument::MOPMacro;
}

done;

# vim: ft=perl6
