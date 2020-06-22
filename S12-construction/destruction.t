use v6;

use Test;

plan 6;

# L<S12/"Semantics of C<bless>"/"DESTROY and DESTROYALL work the
# same way, only in reverse">

my $in_destructor = 0;
my @destructor_order;

class Foo
{
    submethod DESTROY { $in_destructor++ }
}

class Parent
{
    submethod DESTROY { push @destructor_order, 'Parent' }
}

class Child is Parent
{
    submethod DESTROY { push @destructor_order, 'Child' }
}

my $foo = Foo.new();
isa-ok($foo, Foo, 'basic instantiation of declared class' );
ok( ! $in_destructor,    'destructor should not fire while object is active' );

my $child = Child.new();
$child = Nil;

# no guaranteed timely destruction, so replace $a and try to force some GC here
await Promise.anyof(
    Promise.in(5),
    start {
        loop
        {
            my $foo = Foo.new;
            my $chld = Child.new unless +@destructor_order;
            last if $in_destructor && @destructor_order;
        }
    }
);

#?rakudo.jvm todo "doesn't work, yet"
ok( $in_destructor, '... only when object goes away everywhere'                          );
is( +@destructor_order % 2, 0, '... only a multiple of the available DESTROY submethods' );
#?rakudo.jvm todo "expected: 'Child', got: (Any)"
is(  @destructor_order[0], 'Child',  'Child DESTROY should fire first'                   );
#?rakudo.jvm todo "expected: 'Parent', got: (Any)"
is(  @destructor_order[1], 'Parent', '... then parent'                                   );

# vim: expandtab shiftwidth=4
