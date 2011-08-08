# WARNING:
# This is a generated file and should not be edited directly.
# look into generate-tests.pl instead

use v6;
use Test;

sub degrees-to-radians($x) {
    $x * (312689/99532) / 180;
}

my @sines = (
    degrees-to-radians(-360) => 0,
    degrees-to-radians(135 - 360) => 1/2*sqrt(2),
    degrees-to-radians(330 - 360) => -0.5,
    degrees-to-radians(0) => 0,
    degrees-to-radians(30) => 0.5,
    degrees-to-radians(45) => 1/2*sqrt(2),
    degrees-to-radians(90) => 1,
    degrees-to-radians(135) => 1/2*sqrt(2),
    degrees-to-radians(180) => 0,
    degrees-to-radians(225) => -1/2*sqrt(2),
    degrees-to-radians(270) => -1,
    degrees-to-radians(315) => -1/2*sqrt(2),
    degrees-to-radians(360) => 0,
    degrees-to-radians(30 + 360) => 0.5,
    degrees-to-radians(225 + 360) => -1/2*sqrt(2),
    degrees-to-radians(720) => 0
);

my @cosines = @sines.map({; $_.key - degrees-to-radians(90) => $_.value });

my @sinhes = @sines.grep({ $_.key < degrees-to-radians(500) }).map({; $_.key =>
                                                (exp($_.key) - exp(-$_.key)) / 2.0 });

my @coshes = @sines.grep({ $_.key < degrees-to-radians(500) }).map({; $_.key =>
                                                (exp($_.key) + exp(-$_.key)) / 2.0 });

class NotComplex is Cool {
    has $.value;

    multi method new(Complex $value is copy) {
        self.bless(*, :$value);
    }

    multi method Numeric() {
        self.value;
    }
}

class DifferentReal is Real {
    has $.value;

    multi method new($value is copy) {
        self.bless(*, :$value);
    }

    multi method Bridge() {
        self.value;
    }
}            



# sech tests

my $iter_count = 0;
for @cosines -> $angle
{
    next if abs(cosh($angle.key())) < 1e-6;
    my $desired-result = 1.0 / cosh($angle.key());

    # Num.sech tests -- very thorough
    is_approx($angle.key().sech, $desired-result, 
              "Num.sech - {$angle.key()}");

    # Complex.sech tests -- also very thorough
    my Complex $zp0 = $angle.key + 0.0i;
    my Complex $sz0 = $desired-result + 0i;
    my Complex $zp1 = $angle.key + 1.0i;
    my Complex $sz1 = { 1.0 / cosh($_) }($zp1);
    my Complex $zp2 = $angle.key + 2.0i;
    my Complex $sz2 = { 1.0 / cosh($_) }($zp2);
    
    is_approx($zp0.sech, $sz0, "Complex.sech - $zp0");
    is_approx($zp1.sech, $sz1, "Complex.sech - $zp1");
    is_approx($zp2.sech, $sz2, "Complex.sech - $zp2");
}

{
    is(sech(Inf), 0, "sech(Inf) -");
    is(sech(-Inf), 0, "sech(-Inf) -");
}
        
{
    # Num tests
    is_approx(sech((-7.85398163404734).Num), 0.000776406290791195, "sech(Num) - -7.85398163404734");
}

{
    # Rat tests
    is_approx((-5.49778714383314).Rat(1e-9).sech, 0.00819151235926221, "Rat.sech - -5.49778714383314");
    is_approx(sech((-2.09439510241262).Rat(1e-9)), 0.242610328725292, "sech(Rat) - -2.09439510241262");
}

{
    # Complex tests
    is_approx(sech((-1.57079632680947 + 2i).Complex), -0.190922860876022 + 0.382612165180854i, "sech(Complex) - -1.57079632680947 + 2i");
}

{
    # Str tests
    is_approx((-1.04719755120631).Str.sech, 0.624887966291348, "Str.sech - -1.04719755120631");
    is_approx(sech((-0.785398163404734).Str), 0.754939708710524, "sech(Str) - -0.785398163404734");
}

{
    # NotComplex tests
    is_approx(NotComplex.new(0 + 2i).sech, -2.40299796172238 + -0i, "NotComplex.sech - 0 + 2i");
    is_approx(sech(NotComplex.new(0.785398163404734 + 2i)), -0.594148775843208 - 0.851377452397526i, "sech(NotComplex) - 0.785398163404734 + 2i");
}

{
    # DifferentReal tests
    is_approx(DifferentReal.new(1.57079632680947).sech, 0.398536815333061, "DifferentReal.sech - 1.57079632680947");
    is_approx(sech(DifferentReal.new(2.3561944902142)), 0.187872734233684, "sech(DifferentReal) - 2.3561944902142");
}


# asech tests

for @cosines -> $angle
{
    next if abs(cosh($angle.key())) < 1e-6;
    my $desired-result = 1.0 / cosh($angle.key());

    # Num.asech tests -- thorough
    is_approx($desired-result.Num.asech.sech, $desired-result, 
              "Num.asech - {$angle.key()}");
    
    # Num.asech(Complex) tests -- thorough
    for ($desired-result + 0i, $desired-result + .5i, $desired-result + 2i) -> $z {
        is_approx($z.asech.sech, $z, 
                  "Complex.asech - $z");
    }
}
        
{
    # Num tests
    is_approx(asech((0.754939708710524).Num), 0.785398163404734, "asech(Num) - 0.785398163404734");
}

{
    # Rat tests
    is_approx(((0.754939708710524).Rat(1e-9)).asech, 0.785398163404734, "Rat.asech - 0.785398163404734");
    is_approx(asech((0.754939708710524).Rat(1e-9)), 0.785398163404734, "asech(Rat) - 0.785398163404734");
}

{
    # Complex tests
    is_approx(asech((0.785398163404734 + 2i).Complex), 0.425586400480703 - 1.41436665336946i, "asech(Complex) - 0.425586400480703 - 1.41436665336946i");
}

{
    # Str tests
    is_approx(((0.754939708710524).Str).asech, 0.785398163404734, "Str.asech - 0.785398163404734");
    is_approx(asech((0.754939708710524).Str), 0.785398163404734, "asech(Str) - 0.785398163404734");
}

{
    # NotComplex tests
    is_approx((NotComplex.new(0.785398163404734 + 2i)).asech, 0.425586400480703 - 1.41436665336946i, "NotComplex.asech - 0.425586400480703 - 1.41436665336946i");
    is_approx(asech(NotComplex.new(0.785398163404734 + 2i)), 0.425586400480703 - 1.41436665336946i, "asech(NotComplex) - 0.425586400480703 - 1.41436665336946i");
}

{
    # DifferentReal tests
    is_approx((DifferentReal.new(0.754939708710524)).asech, 0.785398163404734, "DifferentReal.asech - 0.785398163404734");
    is_approx(asech(DifferentReal.new(0.754939708710524)), 0.785398163404734, "asech(DifferentReal) - 0.785398163404734");
}

done;

# vim: ft=perl6 nomodifiable
