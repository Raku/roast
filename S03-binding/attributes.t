use v6;
use Test;

# L<S03/Item assignment precedence>

plan 16;

# Tests for binding instance and class attributes
# note that only attributes themselves ($!foo) can be bound,
# not accessors ($.foo)

{
    my $var = 42;
    my class Klass1 { has $.x; method bind { $!x := $var } }

    my $obj1 = Klass1.new;
    lives-ok { $obj1.bind() }, 'attribute binding lives';

    is $obj1.x, 42, 'binding $!x instance attribute (1)';
    $var = 23;
    is $obj1.x, 23, 'binding $!x instance attribute (2)';
}

{
    my $var = 42;
    my class Klass2 {
        has $x;
        method bind { $x := $var }
        method get_x { $x }
        method set_x ($new_x) { $x = $new_x }
    }

    my $obj2 = Klass2.new;
    $obj2.bind();

    is $obj2.get_x, 42, 'binding $x instance attribute (1)';
    $var = 23;
    is $obj2.get_x, 23, 'binding $x instance attribute (2)';
    $obj2.set_x(19);
    is $var,    19,     'binding $x instance attribute (3)';
}

# Public class attributes
#?rakudo skip 'class attributes'
{
    my $var = 42;
    my class Klass3 { our $.x; method bind { $!x := $var } }

    try { Klass3.bind() };

    is try { Klass3.x }, 42, "binding public class attribute (1)";
    $var = 23;
    is try { Klass3.x }, 23, "binding public class attribute (2)";
    try { Klass3.x = 19 };
    is $var,    19,  "binding public class attribute (3)";
}

# Private class attributes
{
    my $var = 42;
    my class Klass4 {
        our $x;
        method bind { $x := $var }
        method get_x { $x }
        method set_x ($new_x) { $x = $new_x }
    }

    try { Klass4.bind() };

    is Klass4.get_x, 42, "binding private class attribute (1)";
    $var = 23;
    is Klass4.get_x, 23, "binding private class attribute (2)";
    Klass4.set_x(19);
    is $var,    19,      "binding private class attribute (3)";
}

# R#2130
{
    my role Foo { method bar { 42 } }
    my class A {
        has $.scalar does Foo;
        has @.array  does Foo;
        has %.hash   does Foo;
        has &.code   does Foo;
    }

    my $a = A.new;
    is $a.scalar.bar, 42, 'is the scalar attribute mixed in?';
    is $a.array.bar,  42, 'is the array attribute mixed in?';
    is $a.hash.bar,   42, 'is the hash attribute mixed in?';
    is $a.code.bar,   42, 'is the code attribute mixed in?';
}

# vim: expandtab shiftwidth=4
