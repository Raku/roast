use v6;
use Test;

# L<S03/Item assignment precedence>

plan 12;

# Tests for binding public and private instance and class attributes

# Public instance attributes
{
    my $var = 42;
    class Klass1 { has $.x; method bind { $.x := $var } }

    my $obj1 = Klass1.new;
    try { $obj1.bind() };

    is $obj1.x, 42, "binding public instance attribute (1)", :todo<bug>;
    $var = 23;
    is $obj1.x, 23, "binding public instance attribute (2)", :todo<bug>;
    $obj1.x = 19;
    is $var,    19, "binding public instance attribute (3)", :todo<bug>;
}

# Private instance attributes
{
    my $var = 42;
    class Klass2 {
        has $x;
        method bind { $x := $var }
        method get_x { try { $x } }
        method set_x ($new_x) { try { $x = $new_x } }
    }

    my $obj2 = Klass2.new;
    try { $obj2.bind() };

    is $obj2.get_x, 42, "binding private instance attribute (1)", :todo<bug>;
    $var = 23;
    is $obj2.get_x, 23, "binding private instance attribute (2)", :todo<bug>;
    $obj2.set_x(19);
    is $var,    19,     "binding private instance attribute (3)", :todo<bug>;
}

# Public class attributes
{
    my $var = 42;
    class Klass3 { our $.x; method bind { $.x := $var } }

    try { Klass3.bind() };

    is try { Klass3.x }, 42, "binding public class attribute (1)", :todo<bug>;
    $var = 23;
    is try { Klass3.x }, 23, "binding public class attribute (2)", :todo<bug>;
    try { Klass3.x = 19 };
    is $var,    19,  "binding public class attribute (3)", :todo<bug>;
}

# Private class attributes
{
    my $var = 42;
    class Klass4 {
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

