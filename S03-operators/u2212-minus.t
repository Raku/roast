use v6;
use Test;

# Tests for U+2212 minus operator
plan 54;

#####
##### Infix
#####

{
    is-deeply infix:<−>(  ),   0, 'infix:<−>() returns zero';
    is-deeply infix:<−>(42), -42, 'infix:<−>(arg) negates arg';
    is-deeply quietly { class {} − class {} },
        0, 'infix, Custom class, Custom class';
}

{
    is-deeply 42e0 − 40e0,              2e0,    'infix, Num:D, Num:D';
    is-deeply 42e0 − 40.0,              2e0,    'infix, Num:D, Rat:D';
    is-deeply 42e0 − 40,                2e0,    'infix, Num:D, Int:D';
    is-deeply 42e0 − <40+2i>,           <2-2i>, 'infix, Num:D, Complex:D';
    is-deeply 42e0 − (my int $ = 40  ), 2e0,    'infix, Num:D, int';
    is-deeply 42e0 − (my num $ = 40e0), 2e0,    'infix, Num:D, num';
}

{
    is-deeply 42.0 − 40e0,              2e0,    'infix, Rat:D, Num:D';
    is-deeply 42.0 − 40.0,              2.0,    'infix, Rat:D, Rat:D';
    is-deeply 42.0 − 40,                2.0,    'infix, Rat:D, Int:D';
    is-deeply 42.0 − <40+2i>,           <2-2i>, 'infix, Rat:D, Complex:D';
    is-deeply 42.0 − (my int $ = 40  ), 2.0,    'infix, Rat:D, int';
    is-deeply 42.0 − (my num $ = 40e0), 2e0,    'infix, Rat:D, num';
}

{
    is-deeply 42   − 40e0,              2e0,    'infix, Int:D, Num:D';
    is-deeply 42   − 40.0,              2.0,    'infix, Int:D, Rat:D';
    is-deeply 42   − 40,                2,      'infix, Int:D, Int:D';
    is-deeply 42   − <40+2i>,           <2-2i>, 'infix, Int:D, Complex:D';
    is-deeply 42   − (my int $ = 40  ), 2,      'infix, Int:D, int';
    is-deeply 42   − (my num $ = 40e0), 2e0,    'infix, Int:D, num';
}

{
    is-deeply <42+3i> − 40e0,              <2+3i>, 'infix, Complex:D, Num:D';
    is-deeply <42+3i> − 40.0,              <2+3i>, 'infix, Complex:D, Rat:D';
    is-deeply <42+3i> − 40,                <2+3i>, 'infix, Complex:D, Int:D';
    is-deeply <42+3i> − <40+2i>,           <2+1i>, 'infix, Complex:D, Complex:D';
    is-deeply <42+3i> − (my int $ = 40  ), <2+3i>, 'infix, Complex:D, int';
    is-deeply <42+3i> − (my num $ = 40e0), <2+3i>, 'infix, Complex:D, num';
}

{
    is-deeply (my int $ = 42) − 40e0,              2e0,    'infix, int, Num:D';
    is-deeply (my int $ = 42) − 40.0,              2.0,    'infix, int, Rat:D';
    is-deeply (my int $ = 42) − 40,                2,      'infix, int, Int:D';
    is-deeply (my int $ = 42) − <40+2i>,           <2-2i>, 'infix, int, Complex:D';
    is-deeply (my int $ = 42) − (my int $ = 40  ), 2,      'infix, int, int';
    is-deeply (my int $ = 42) − (my num $ = 40e0), 2e0,    'infix, int, num';
}

{
    is-deeply (my num $ = 42e0) − 40e0,              2e0,    'infix, num, Num:D';
    is-deeply (my num $ = 42e0) − 40,                2e0,    'infix, num, Int:D';
    is-deeply (my num $ = 42e0) − 40.0,              2e0,    'infix, num, Rat:D';
    is-deeply (my num $ = 42e0) − <40+2i>,           <2-2i>, 'infix, num, Complex:D';
    is-deeply (my num $ = 42e0) − (my int $ = 40  ), 2e0,    'infix, num, int';
    is-deeply (my num $ = 42e0) − (my num $ = 40e0), 2e0,    'infix, num, num';
}

{
    is-deeply ^42 − 2,     -2..^40,   'infix, Range:D, Int:D';
    is-deeply ^42 − 2e0, -2e0..^40e0, 'infix, Range:D, Num:D';
    is-deeply ^42 − 2.0, -2.0..^40.0, 'infix, Range:D, Rat:D';
}

{
    constant $i1 = Date.new(:2015year).DateTime.Instant;
    constant $i2 = Date.new(:2016year).DateTime.Instant;
    is-deeply $i2 − $i1, Duration.new(31536001), 'infix, Instant:D, Instant:D';
    is-deeply $i2 − 31536001, $i1, 'infix, Instant:D, Real:D';
}

{
    constant $d1 = Duration.new(40);
    constant $d2 = Duration.new(42.5);
    is-deeply $d2 − 42,  Duration.new( .5), 'infix, Duration:D, Int:D';
    is-deeply $d2 − $d1, Duration.new(2.5), 'infix, Duration:D, Duration:D';
}

{
    constant $d1 = Date.new(:2015year);
    constant $d2 = Date.new(:2016year);
    is-deeply $d2 − 365, $d1, 'infix, Date:D, Int:D';
    is-deeply $d2 − $d1, 365, 'infix, Date:D, Date:D';
}

#####
##### Prefix
#####

{
    is-deeply quietly { −class {} }, 0, 'prefix, Custom class';

    # Note: the tests below use U+2212 minus for expected and check against
    # ASCII minus version
    is-deeply −42, -42, 'prefix, Int';
    is-deeply −42.0, -42.0, 'prefix, Rat';
    is-deeply −42e0, -42e0, 'prefix, Num';
    is-deeply −<42+2i>, -<42+2i>, 'prefix, Complex';
    is-deeply −Duration.new(42), -Duration.new(42), 'prefix, Duration';
}
