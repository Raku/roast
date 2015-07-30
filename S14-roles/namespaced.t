use v6;

use Test;

plan 11;

=begin pod

Roles with names containing double colons and doing of them.

=end pod

role A::B {
    method foo { "Foo" }
};

#?rakudo todo 'nom regression RT #124750'
is(A::B.WHAT.gist, '(B)', 'A::B.WHAT stringifies to short name B');

class Z does A::B {
}
class Z::Y does A::B {
}

is(Z.new.foo,    'Foo', 'Composing namespaced role to non-namespaced class');
is(Z::Y.new.foo, 'Foo', 'Composing namespaced role to namespaced class');

# RT #73390
throws-like 'my role R { class C { } }', X::Declaration::OurScopeInRole, declaration => 'class';
throws-like 'my role R { subset Pint of Int; }', X::Declaration::OurScopeInRole, declaration => 'subset';
throws-like 'my role R { enum Tea <green black fruit> }', X::Declaration::OurScopeInRole, declaration => 'enum';
throws-like 'my role R { constant Answer = 42; }', X::Declaration::OurScopeInRole, declaration => 'constant';

# RT #100468
throws-like 'my role R { role R2 { } }', X::Declaration::OurScopeInRole, declaration => 'role';

# RT #88750
throws-like 'my role R { our sub foo() { } }', X::Declaration::OurScopeInRole, declaration => 'sub';
throws-like 'my role R { our method foo() { } }', X::Declaration::OurScopeInRole, declaration => 'method';

# RT #76450
throws-like 'my role R { our $bar }', X::Declaration::OurScopeInRole, declaration => 'variable';

# vim: ft=perl6
