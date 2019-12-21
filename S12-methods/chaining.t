use v6;

use Test;

plan 17;

# L<S03/"Changes to Perl operators"/"-> becomes .">

class Foo {
    has $.num;

    method bar ($self: $num) returns Foo {
        $!num = $num;
        return $self;
    }

    method baz ($self: $num) returns Foo {
        $!num += $num;
        return $self;
    }
}

my $foo = Foo.new(:num<10>);
isa-ok($foo, Foo);

# do some sanity checking to make sure it does
# all that we expect it too first.

is($foo.num(), 10, '... got the right num value');

my $_foo1 = $foo.bar(20);
isa-ok($_foo1, Foo);
ok($_foo1 === $foo, '... $_foo1 and $foo are the same instances');

is($foo.num(), 20, '... got the right num value');

my $_foo2 = $foo.baz(20);
isa-ok($_foo2, Foo);
ok( ([===]($foo, $_foo2, $_foo1)), '... $_foo1, $_foo2 and $foo are the same instances');

is($foo.num(), 40, '... got the right num value');

# now lets try it with chained methods ...

my $_foo3;
lives-ok {
    $_foo3 = $foo.bar(10).baz(5);
}, '... method chaining works';

isa-ok($_foo3, Foo);
ok( ([===]($_foo3, $_foo2, $_foo1, $foo)),
    '... $_foo3, $_foo1, $_foo2 and $foo are the same instances');

is($foo.num(), 15, '... got the right num value');

# test attribute accessors, too
is($foo.baz(7).baz(6).num, 28, 'chained an auto-generated accessor');

throws-like 'Foo->new', X::Obsolete, 'Perl -> is dead (class constructor)';
throws-like '$foo->num', X::Obsolete, 'Perl -> is dead (method call)';

# L<S03/"Changes to Perl operators"/"-> becomes .">
# L<S12/"Open vs Closed Classes"/"though you have to be explicit">
{
    # (A => (B => Mu)) => (C => Mu))
    # ((A B) C)

    my $cons = [=>] ( [=>] |<A B>, Mu ), <C>, Mu;

    my $p = $cons.key;
    ok( $cons.key.key =:= $p.key, 'chaining through temp variable' );
    ok( $cons.key.key =:= $cons.key.key, 'chaining through Any return');
}

# vim: ft=perl6
