use v6;

use Test;

plan 4;

my $tracker = '';

class Parent {
    has $.x;
    submethod TWEAK() {
        $tracker ~= "Parent.TWEAK\n";
        $!x *=2;
    }
}

class Child is Parent {
    has $.y;
    submethod TWEAK(:$y) {
        $tracker ~= "Child.TWEAK\n";
        $!y = 2 * $y;
    }
}

my $c = Child.new(x => 1, y => 2);

is $c.y, 4, 'Child.TWEAK effect on attributes';
is $c.x, 2, 'Parent.TWEAK effect on attributes';
is $tracker, "Parent.TWEAK\nChild.TWEAK\n", "Order of initilization";

# R#2174
{
    role Foo {
        has $!z;
        method TWEAK() {
            $!z = 42;
        }
    };
    class A does Foo {
        method z { $!z }
    }
    is A.new.z, 42, 'did the private attribute get assigned';
}

# vim: expandtab shiftwidth=4
