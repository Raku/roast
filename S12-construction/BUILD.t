use v6;
use Test;

plan 5;

class Parent {
    has Str $.gather  is rw = '';
    has Int $.parent-counter is rw = 0;
    has Int $.child-counter is rw = 0;
    submethod BUILD ($obj, :$a) {
        $.parent-counter++;
        $.gather ~= "Parent(a): ($a)";
    }
}

class Child is Parent {
    submethod BUILD ($obj, :$a, :$b) {
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
        submethod BUILD($obj) {
            say $obj.WHAT;
            $obj.reg('A_Parent1');
            say "in Parent1";
        }
    }

    class A_Parent2 {
        submethod BUILD($obj) {
            $obj.reg('A_Parent2');
        }
    }

    class A_Child is A_Parent1 is A_Parent2 {
        submethod BUILD($obj) {
            $obj.reg('A_Child');
        }
    }

    class A_GrandChild is A_Child {
        has $.initlist;
        method reg($x) { $!initlist ~= $x };
        submethod BUILD($obj) {
            $obj.reg('A_GrandChild');
        }
    }

    my $x;
    lives_ok { $x = A_GrandChild.new() }, 
        "can call child's methods in parent's BUILD";

    ok ?($x.reg eq 'A_Parent1A_Parent2A_ChildA_Grandchild' 
                | 'A_Parent1A_Parent2A_ChildA_Grandchild'),
    'initilized called in the right order (MI)';
}

# vim: ft=perl6
