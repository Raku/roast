use Test;

plan 6;

# L<S12/"Semantics of C<bless>"/"DESTROY and DESTROYALL work the
# same way, only in reverse">

my $in_destructor = 0;
my $order_lock = Lock.new;
my @destructor_order;

class Foo
{
    submethod DESTROY { $in_destructor++ }
}

class Parent
{
    submethod DESTROY { $order_lock.protect: { push @destructor_order, "Parent" ~ self } }
}

class Child is Parent
{
    submethod DESTROY { $order_lock.protect: { push @destructor_order, "Child" ~ self } }
}

my $foo = Foo.new();
isa-ok($foo, Foo, 'basic instantiation of declared class' );
ok( ! $in_destructor,    'destructor should not fire while object is active' );

my $child = Child.new();
$child = Nil;

if $*VM.name eq 'jvm' {
    skip-rest "Hangs on JVM backend";
}
else {
    # no guaranteed timely destruction, so try to force some GC here
    await start {
        loop
        {
            # Non-MoarVM backends currently warn for this method, so surpress that
            quietly $*VM.request-garbage-collection;

            my $foo = Foo.new;
            my $chld = Child.new unless +@destructor_order;
            last if $in_destructor && @destructor_order;
        }
    };

    #?rakudo.jvm todo "doesn't work, yet"
    ok( $in_destructor, '... only when object goes away everywhere'                          );
    $order_lock.protect: {
        is( +@destructor_order % 2, 0, '... only a multiple of the available DESTROY submethods' )
            or diag @destructor_order;
        my $seen = SetHash.new;
        for @destructor_order {
            if /Parent/ {
                if $seen{$_.subst('Parent', 'Child')} {
                    pass "Parent after child";
                }
                else {
                    #?rakudo.jvm todo "doesn't work, yet"
                    flunk "Found a parent but no corresponding child constructor call";
                    diag @destructor_order;
                }
            }
            if /Child/ {
                $seen{$_} = True;
            }
        }
    }
}

# vim: expandtab shiftwidth=4
