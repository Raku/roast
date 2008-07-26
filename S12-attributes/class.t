use v6;

use Test;

plan 2;

class Foo {
    my $.x is rw;
}
my $x = Foo.new();
$x.x = 42;
is($x.x, 42, "class attribute accessors work");
my $y = Foo.new();
is($y.x, 42, "class attributes shared by all instances");
