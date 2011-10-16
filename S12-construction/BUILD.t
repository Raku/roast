use v6;
use Test;

plan 7;

# L<S12/Semantics of C<bless>/The default BUILD and BUILDALL>


class Parent {
    has Str $.gather  is rw = '';
    has Int $.parent-counter is rw = 0;
    has Int $.child-counter is rw = 0;
    submethod BUILD (:$a) {
        $.parent-counter++;
        $.gather ~= "Parent(a): ($a)";
    }
}

class Child is Parent {
    submethod BUILD (:$a, :$b) {
        $.child-counter++;
        $.gather ~= " | Child(a, b): ($a, $b)";
    }
}

my $obj = Child.new(:b(5), :a(7));

is $obj.parent-counter, 1, "Called Parent's BUILD method once";
is $obj.child-counter, 1, "Called Child's BUILD method once";
is $obj.gather, 'Parent(a): (7) | Child(a, b): (7, 5)', 
    'submethods were called in right order (Parent first)';

# assigning to attributes during BUILD
# multiple inheritance
{
    class A_Parent1 {
        submethod BUILD() {
            $.reg('A_Parent1');
        }
    }

    class A_Parent2 {
        submethod BUILD() {
            $.reg('A_Parent2');
        }
    }

    class A_Child is A_Parent1 is A_Parent2 {
        submethod BUILD() {
            $.reg('A_Child');
        }
    }

    class A_GrandChild is A_Child {
        has $.initlist;
        method reg($x) { $!initlist ~= $x };
        submethod BUILD() {
            $.reg('A_GrandChild');
        }
    }

    my $x;
    lives_ok { $x = A_GrandChild.new() }, 
        "can call child's methods in parent's BUILD";
    ok ?($x.initlist eq 'A_Parent1A_Parent2A_ChildA_GrandChild' 
                | 'A_Parent2A_Parent1A_ChildA_GrandChild'),
    'initilized called in the right order (MI)';
}

# RT #63900
{
    class RT63900_P {
        has %.counter is rw;
        submethod BUILD {
            %.counter{ 'BUILD' }++;
        }
    }
    class RT63900_C is RT63900_P {
    }

    my $c = RT63900_C.new();
    is $c.counter<BUILD>, 1, 'BUILD called once';
}

#?rakudo skip 'method BUILD should warn'
{
    BEGIN { @*INC.push: 't/spec/packages' }
    use Test::Util;
    is_run
        'class Foo { method BUILD() { ... } }',
        { out => '', err => /BUILD/ & /submethod/ },
        'method BUILD produces a compile-time warning';
}

# vim: ft=perl6
