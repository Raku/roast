use v6;

use lib $?FILE.IO.parent(2).add("packages");

use Test;
use Test::Util;

plan 14;

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
    lives-ok { $x = A_GrandChild.new() }, 
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

#?rakudo todo 'method BUILD should warn RT #124642'
{
    is_run
        'class Foo { method BUILD() { ... } }',
        { out => '', err => /BUILD/ & /submethod/ },
        'method BUILD produces a compile-time warning';
}

# RT #95340
{
    class C { has %!p; submethod BUILD(:%!p) {} };
    lives-ok { C.new }, 'can call BUILD without providing a value for a !-twigiled named parameter';
}

# RT #123407
{
    lives-ok {
        role A { has $!a; submethod BUILD(:$!a) {}}; class B does A {}; B.new
    }, 'BUILD provided by role can use attributes in signature';
}

# RT #128393
{
    class Foo {
        submethod BUILD { fail "noway" }
    }
    dies-ok { Foo.new }, "Foo.new dies when sunk";
    ok Foo.new // "ok", "Foo.new can be caught as a Failure";
}

# RT #104980
{
    class rt104980 {
        has str $.x;
        has int8 $.y;
        method BUILD(:$!x, :$!y) { }
    };
    my str $s = 'foo';
    my int8 $i = 42;
    is-deeply rt104980.new(:x<foo>,:y(42)).x, $s, "BUILD with a native typed attribute (str)";
    is-deeply rt104980.new(:x<foo>,:y(42)).y, $i, "BUILD with a native typed attribute (int8)";
}

# vim: ft=perl6
