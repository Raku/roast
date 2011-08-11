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
isa_ok($foo, Foo, 'basic instantiation of declared class' );
ok( ! $in_destructor,    'destructor should not fire while object is active' );

my $child = Child.new();
undefine $child;

# no guaranteed timely destruction, so replace $a and try to force some GC here
for 1 .. 100
{
    $foo = Foo.new();
}

ok( $in_destructor, '... only when object goes away everywhere'               );
is( +@destructor_order, 2, '... only as many as available DESTROY submethods' );
is(  @destructor_order[0], 'Child',  'Child DESTROY should fire first'        );
is(  @destructor_order[1], 'Parent', '... then parent'                        );

# vim: ft=perl6
