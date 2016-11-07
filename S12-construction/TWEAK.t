use v6;

use Test;

plan 3;

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
