use v6;
use Test;

# L<S03/Item assignment precedence>

plan 12;

# Tests for binding instance and class attributes
# note that only attributes themselves ($!foo) can be bound,
# not accessors ($.foo)

{
    my $var = 42;
    class Klass1 { has $.x; method bind { $!x := $var } }

    my $obj1 = Klass1.new;
    lives_ok { $obj1.bind() }, 'attribute binding lives';

    #?pugs 3 todo 'bug'
    is $obj1.x, 42, 'binding $!x instance attribute (1)';
    $var = 23;
    is $obj1.x, 23, 'binding $!x instance attribute (2)';
}

{
    my $var = 42;
    class Klass2 {
        has $x;
        method bind { $x := $var }
        method get_x { $x }
        method set_x ($new_x) { $x = $new_x }
    }

    my $obj2 = Klass2.new;
    $obj2.bind();

    #?pugs 3 todo 'bug'
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
    class Klass3 { our $.x; method bind { $.x := $var } }

    try { Klass3.bind() };

    #?pugs 3 todo 'bug'
    is try { Klass3.x }, 42, "binding public class attribute (1)";
    $var = 23;
    is try { Klass3.x }, 23, "binding public class attribute (2)";
    try { Klass3.x = 19 };
    is $var,    19,  "binding public class attribute (3)";
}

# Private class attributes
#?rakudo skip 'class attributes'
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


# vim: ft=perl6
