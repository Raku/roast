use v6;
use Test;

plan 3;

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

# vim: ft=perl6
