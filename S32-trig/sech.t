# WARNING:
# This is a generated file and should not be edited directly.
# look into generate-tests.pl instead

use v6;
use Test;
BEGIN { @*INC.push("t/spec/packages/") };
use TrigTestSupport;


# sech tests

my $iter_count = 0;
for TrigTest::cosines() -> $angle
{
    next if abs(cosh($angle.num())) < 1e-6;
    my $desired-result = 1.0 / cosh($angle.num());

    # Num.sech tests -- very thorough
    is_approx($angle.num().sech, $desired-result, 
              "Num.sech - {$angle.num()}");

    # Complex.sech tests -- also very thorough
    my Complex $zp0 = $angle.num + 0.0i;
    my Complex $sz0 = $desired-result + 0i;
    my Complex $zp1 = $angle.num + 1.0i;
    my Complex $sz1 = { 1.0 / cosh($_) }($zp1);
    my Complex $zp2 = $angle.num + 2.0i;
    my Complex $sz2 = { 1.0 / cosh($_) }($zp2);
    
    is_approx($zp0.sech, $sz0, "Complex.sech - $zp0");
    is_approx($zp1.sech, $sz1, "Complex.sech - $zp1");
    is_approx($zp2.sech, $sz2, "Complex.sech - $zp2");
}

is(sech(Inf), 0, "sech(Inf) -");
is(sech(-Inf), 0, "sech(-Inf) -");
        
# Num tests
is_approx(sech((-7.85398163404734).Num), 0.000776406290791195, "sech(Num) - -7.85398163404734");
is_approx(sech(:x((-5.49778714383314).Num)), 0.00819151235926221, "sech(:x(Num)) - -5.49778714383314");

# Rat tests
is_approx((-2.09439510241262).Rat(1e-9).sech, 0.242610328725292, "Rat.sech - -2.09439510241262");
is_approx(sech((-1.57079632680947).Rat(1e-9)), 0.398536815333061, "sech(Rat) - -1.57079632680947");
is_approx(sech(:x((-1.04719755120631).Rat(1e-9))), 0.624887966291348, "sech(:x(Rat)) - -1.04719755120631");

# Complex tests
is_approx(sech((-0.785398163404734 + 2i).Complex), -0.594148775843208 + 0.851377452397526i, "sech(Complex) - -0.785398163404734 + 2i");
is_approx(sech(:x((0 + 2i).Complex)), -2.40299796172238 + -0i, "sech(:x(Complex)) - 0 + 2i");

# Str tests
is_approx((0.785398163404734).Str.sech, 0.754939708710524, "Str.sech - 0.785398163404734");
is_approx(sech((1.57079632680947).Str), 0.398536815333061, "sech(Str) - 1.57079632680947");
is_approx(sech(:x((2.3561944902142).Str)), 0.187872734233684, "sech(:x(Str)) - 2.3561944902142");

{
    # NotComplex tests

    class NotComplex is Cool {
        has $.value;

        multi method new(Complex $value is copy) {
            self.bless(*, :$value);
        }

        multi method Numeric() {
            self.value;
        }
    }

    is_approx(NotComplex.new(3.14159265361894 + 2i).sech, -0.0361218942926504 - 0.0786335422219265i, "NotComplex.sech - 3.14159265361894 + 2i");
    is_approx(sech(NotComplex.new(3.92699081702367 + 2i)), -0.016413269655411 - 0.035835814522277i, "sech(NotComplex) - 3.92699081702367 + 2i");
    is_approx(sech(:x(NotComplex.new(4.7123889804284 + 2i))), -0.00747812852392195 - 0.0163373718784962i, "sech(:x(NotComplex)) - 4.7123889804284 + 2i");
}

{
    # DifferentReal tests

    class DifferentReal is Real {
        has $.value;

        multi method new($value is copy) {
            self.bless(*, :$value);
        }

        multi method Bridge() {
            self.value;
        }
    }            

    is_approx(DifferentReal.new(5.23598775603156).sech, 0.0106428295621644, "DifferentReal.sech - 5.23598775603156");
    is_approx(sech(DifferentReal.new(8.63937979745208)), 0.000353993272864057, "sech(DifferentReal) - 8.63937979745208");
    is_approx(sech(:x(DifferentReal.new(10.9955742876663))), 3.3551563035587e-05, "sech(:x(DifferentReal)) - 10.9955742876663");
}


# asech tests

for TrigTest::cosines() -> $angle
{
    next if abs(cosh($angle.num())) < 1e-6;
    my $desired-result = 1.0 / cosh($angle.num());

    # Num.asech tests -- thorough
    is_approx($desired-result.Num.asech.sech, $desired-result, 
              "Num.asech - {$angle.num()}");
    
    # Num.asech(Complex) tests -- thorough
    for ($desired-result + 0i, $desired-result + .5i, $desired-result + 2i) -> $z {
        is_approx(sech(asech($z)), $z, 
                  "asech(Complex) - {$angle.num()}");
        is_approx($z.asech.sech, $z, 
                  "Complex.asech - {$angle.num()}");
    }
}
        
# Num tests
is_approx(asech((0.754939708710524).Num), 0.785398163404734, "asech(Num) - 0.785398163404734");
is_approx(asech(:x((0.754939708710524).Num)), 0.785398163404734, "asech(:x(Num)) - 0.785398163404734");

# Rat tests
is_approx(((0.754939708710524).Rat(1e-9)).asech, 0.785398163404734, "Rat.asech - 0.785398163404734");
is_approx(asech((0.754939708710524).Rat(1e-9)), 0.785398163404734, "asech(Rat) - 0.785398163404734");
is_approx(asech(:x((0.754939708710524).Rat(1e-9))), 0.785398163404734, "asech(:x(Rat)) - 0.785398163404734");

# Complex tests
is_approx(asech((0.785398163404734 + 2i).Complex), 0.425586400480703 - 1.41436665336946i, "asech(Complex) - 0.425586400480703 - 1.41436665336946i");
is_approx(asech(:x((0.785398163404734 + 2i).Complex)), 0.425586400480703 - 1.41436665336946i, "asech(:x(Complex)) - 0.425586400480703 - 1.41436665336946i");

# Str tests
is_approx(((0.754939708710524).Str).asech, 0.785398163404734, "Str.asech - 0.785398163404734");
is_approx(asech((0.754939708710524).Str), 0.785398163404734, "asech(Str) - 0.785398163404734");
is_approx(asech(:x((0.754939708710524).Str)), 0.785398163404734, "asech(:x(Str)) - 0.785398163404734");

# NotComplex tests
is_approx((NotComplex.new(0.785398163404734 + 2i)).asech, 0.425586400480703 - 1.41436665336946i, "NotComplex.asech - 0.425586400480703 - 1.41436665336946i");
is_approx(asech(NotComplex.new(0.785398163404734 + 2i)), 0.425586400480703 - 1.41436665336946i, "asech(NotComplex) - 0.425586400480703 - 1.41436665336946i");
is_approx(asech(:x(NotComplex.new(0.785398163404734 + 2i))), 0.425586400480703 - 1.41436665336946i, "asech(:x(NotComplex)) - 0.425586400480703 - 1.41436665336946i");

# DifferentReal tests
is_approx((DifferentReal.new(0.754939708710524)).asech, 0.785398163404734, "DifferentReal.asech - 0.785398163404734");
is_approx(asech(DifferentReal.new(0.754939708710524)), 0.785398163404734, "asech(DifferentReal) - 0.785398163404734");
is_approx(asech(:x(DifferentReal.new(0.754939708710524))), 0.785398163404734, "asech(:x(DifferentReal)) - 0.785398163404734");

done;

# vim: ft=perl6 nomodifiable
