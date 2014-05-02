use v6;
use Test;

plan 9;

# L<S12/Semantics of C<bless>/The default BUILD and BUILDALL>

{
    my Str $calls = '';
    my Str $gather = '';
    my Int $parent-counter = 0;
    my Int $child-counter = 0;
    
    class Parent {
        submethod BUILD (:$a) {
            $parent-counter++;
            $calls ~= "Parent";
            $gather ~= "Parent(a): ($a)";
        }
    }

    class Child is Parent {
        submethod BUILD (:$a, :$b) {
            $child-counter++;
            $calls ~= " | Child";
            $gather ~= " | Child(a, b): ($a, $b)";
        }
    }

    my $obj = Child.new(:b(5), :a(7));

    is $parent-counter, 1, "Called Parent's BUILD method once";
    is $child-counter, 1, "Called Child's BUILD method once";
    is $calls, 'Parent | Child', 
        'submethods were called in right order (Parent first)';
    #?niecza todo "Worrisome"
    is $gather, 'Parent(a): (7) | Child(a, b): (7, 5)', 
        'submethods were called with the correct arguments';
}

# assigning to attributes during BUILD
# multiple inheritance
{
    my $initlist = '';
    sub reg($x) { $initlist ~= $x };
    
    class A_Parent1 {
        submethod BUILD() {
            reg('A_Parent1');
        }
    }

    class A_Parent2 {
        submethod BUILD() {
            reg('A_Parent2');
        }
    }

    class A_Child is A_Parent1 is A_Parent2 {
        submethod BUILD() {
            reg('A_Child');
        }
    }

    class A_GrandChild is A_Child {
        submethod BUILD() {
            reg('A_GrandChild');
        }
    }

    my $x;
    lives_ok { $x = A_GrandChild.new() }, 
        "can call child's methods in parent's BUILD";
    ok ?($initlist eq 'A_Parent1A_Parent2A_ChildA_GrandChild' 
                    | 'A_Parent2A_Parent1A_ChildA_GrandChild'),
    'initilized called in the right order (MI)';
}

# RT #63900
{
    # I think this test is obsolete given the above tests, but maybe I'm missing something
    my %counter;
    class RT63900_P {
        submethod BUILD {
            %counter{ 'BUILD' }++;
        }
    }
    class RT63900_C is RT63900_P {
    }

    my $c = RT63900_C.new();
    is %counter<BUILD>, 1, 'BUILD called once';
}

#?rakudo todo 'method BUILD should warn'
#?niecza todo
{
    use lib 't/spec/packages';
    use Test::Util;
    is_run
        'class Foo { method BUILD() { ... } }',
        { out => '', err => /BUILD/ & /submethod/ },
        'method BUILD produces a compile-time warning';
}

# RT #95340
{
    class C { has %!p; submethod BUILD(:%!p) {} };
    lives_ok { C.new }, 'can call BUILD without providing a value for a !-twigiled named parameter';
}

# vim: ft=perl6
