use v6;

use Test;

plan 17;

=begin pod

Very basic meta-class tests from L<S12/Introspection>

=end pod

class Foo:ver<0.0.1>:auth<ority> {
    method bar ($param) returns Str {
        return "baz" ~ $param
    }
};

# L<S12/Introspection/should be called through the meta object>

ok(Foo.HOW.can(Foo, 'bar'), '... Foo can bar');
ok(HOW(Foo).can(Foo, 'bar'), '... Foo can bar (anthoer way)');
ok(Foo.^can('bar'), '... Foo can bar (as class method)');
ok(Foo.HOW.isa(Foo, Foo), '... Foo is-a Foo (of course)');
ok(Foo.^isa(Foo), '... Foo is-a Foo (of course) (as class method)');

lives-ok { 4.HOW.HOW }, 'Can access meta class of meta class';

# L<S12/Introspection/Class traits may include:>

is Foo.^name(), 'Foo', '... the name() property is Foo';
is Foo.^ver(), v0.0.1, '... the ver() property is 0.0.1';
is Foo.^auth(), 'ority', '... the auth() property is ority';
is Foo.REPR, 'P6opaque', '.REPR';

subtest { plan 3;
    my module M:ver<1.2.3>:auth<me> {};
    is M.^name, 'M',     '.name is correct';
    is M.^ver,  '1.2.3', '.ver is correct';
    is M.^auth, 'me',    '.auth is correct';
}, 'metamethods on a module';

# RT #128579
subtest { plan 2;
    my package P:ver<1.2.3>:auth<me> {};
    throws-like { P.^ver  }, X::Method::NotFound, '.ver is absent';
    throws-like { P.^auth }, X::Method::NotFound, '.auth is absent';
}, 'ID metamethods on a package are absent by design';


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

# RT #80694
{
    my class A {
        method foo { 'abc' };
        A.^add_method('bar', A.^can('foo'));
    }
    dies-ok { A.new().bar() }, 'Using .^add_method with what .^can returns (a list) will never work';
}
{
    my class A {
        method foo { 'abc' };
        A.^add_method('bar', A.^lookup('foo'));
    }
    is A.new().bar(), 'abc', 'Can .^add_method what .^lookup returns under another name and it works';
}

# vim: ft=perl6
