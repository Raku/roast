use v6;

use Test;

plan 3;

=begin pod

Roles with names containing double colons and doing of them.

=end pod

role A::B {
    method foo { "Foo" }
};

#?rakudo todo 'nom regression'
is(A::B.WHAT, 'B()', 'A::B.WHAT stringifies to short name B');

class X does A::B {
}
class X::Y does A::B {
}

is(X.new.foo,    'Foo', 'Composing namespaced role to non-namespaced class');
is(X::Y.new.foo, 'Foo', 'Composing namespaced role to namespaced class');

# vim: ft=perl6
