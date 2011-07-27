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



# cosh tests

my $iter_count = 0;
for @coshes -> $angle
{
    
    my $desired-result = $angle.value;

    # Num.cosh tests -- very thorough
    is_approx($angle.key().cosh, $desired-result, 
              "Num.cosh - {$angle.key()}");

    # Complex.cosh tests -- also very thorough
    my Complex $zp0 = $angle.key + 0.0i;
    my Complex $sz0 = $desired-result + 0i;
    my Complex $zp1 = $angle.key + 1.0i;
    my Complex $sz1 = { (exp($_) + exp(-$_)) / 2 }($zp1);
    my Complex $zp2 = $angle.key + 2.0i;
    my Complex $sz2 = { (exp($_) + exp(-$_)) / 2 }($zp2);
    
    is_approx($zp0.cosh, $sz0, "Complex.cosh - $zp0");
    is_approx($zp1.cosh, $sz1, "Complex.cosh - $zp1");
    is_approx($zp2.cosh, $sz2, "Complex.cosh - $zp2");
}

{
    is(cosh(Inf), Inf, "cosh(Inf) -");
    is(cosh(-Inf), Inf, "cosh(-Inf) -");
}
        
{
    # Num tests
    is_approx(cosh((-6.28318530723787).Num), 267.746761499354, "cosh(Num) - -6.28318530723787");
    is_approx(cosh(:x((-3.92699081702367).Num)), 25.3868611932849, "cosh(:x(Num)) - -3.92699081702367");
}

{
    # Rat tests
    is_approx((-0.523598775603156).Rat(1e-9).cosh, 1.14023832107909, "Rat.cosh - -0.523598775603156");
    is_approx(cosh((0).Rat(1e-9)), 1, "cosh(Rat) - 0");
    is_approx(cosh(:x((0.523598775603156).Rat(1e-9))), 1.14023832107909, "cosh(:x(Rat)) - 0.523598775603156");
}

{
    # Complex tests
    is_approx(cosh((0.785398163404734 + 2i).Complex), -0.551231882156447 + 0.789880270046195i, "cosh(Complex) - 0.785398163404734 + 2i");
    is_approx(cosh(:x((1.57079632680947 + 2i).Complex)), -1.04418668623968 + 2.09256517025804i, "cosh(:x(Complex)) - 1.57079632680947 + 2i");
}

{
    # Str tests
    is_approx((2.3561944902142).Str.cosh, 5.32275214963423, "Str.cosh - 2.3561944902142");
    is_approx(cosh((3.14159265361894).Str), 11.5919532758581, "cosh(Str) - 3.14159265361894");
    is_approx(cosh(:x((3.92699081702367).Str)), 25.3868611932849, "cosh(:x(Str)) - 3.92699081702367");
}

{
    # NotComplex tests
    is_approx(NotComplex.new(4.7123889804284 + 2i).cosh, -23.1641398700872 + 50.6064005308964i, "NotComplex.cosh - 4.7123889804284 + 2i");
    is_approx(cosh(NotComplex.new(5.49778714383314 + 2i)), -50.8021984580908 + 111.001104449219i, "cosh(NotComplex) - 5.49778714383314 + 2i");
    is_approx(cosh(:x(NotComplex.new(6.28318530723787 + 2i))), -111.421967793698 + 243.459743211402i, "cosh(:x(NotComplex)) - 6.28318530723787 + 2i");
}

{
    # DifferentReal tests
    is_approx(DifferentReal.new(6.80678408284103).cosh, 451.980088132576, "DifferentReal.cosh - 6.80678408284103");
    is_approx(cosh(DifferentReal.new(-6.28318530723787)), 267.746761499354, "cosh(DifferentReal) - -6.28318530723787");
    is_approx(cosh(:x(DifferentReal.new(-3.92699081702367))), 25.3868611932849, "cosh(:x(DifferentReal)) - -3.92699081702367");
}


# acosh tests

for @coshes -> $angle
{
    
    my $desired-result = $angle.value;

    # Num.acosh tests -- thorough
    is_approx($desired-result.Num.acosh.cosh, $desired-result, 
              "Num.acosh - {$angle.key()}");
    
    # Num.acosh(Complex) tests -- thorough
    for ($desired-result + 0i, $desired-result + .5i, $desired-result + 2i) -> $z {
        is_approx(cosh(acosh($z)), $z, 
                  "acosh(Complex) - {$angle.key()}");
        is_approx($z.acosh.cosh, $z, 
                  "Complex.acosh - {$angle.key()}");
    }
}
        
{
    # Num tests
    is_approx(acosh((1.14023832107909).Num), 0.523598775603156, "acosh(Num) - 0.523598775603156");
    is_approx(acosh(:x((1.32460908925833).Num)), 0.785398163404734, "acosh(:x(Num)) - 0.785398163404734");
}

{
    # Rat tests
    is_approx(((1.14023832107909).Rat(1e-9)).acosh, 0.523598775603156, "Rat.acosh - 0.523598775603156");
    is_approx(acosh((1.32460908925833).Rat(1e-9)), 0.785398163404734, "acosh(Rat) - 0.785398163404734");
    is_approx(acosh(:x((1.14023832107909).Rat(1e-9))), 0.523598775603156, "acosh(:x(Rat)) - 0.523598775603156");
}

{
    # Complex tests
    is_approx(acosh((0.785398163404734 + 2i).Complex), 1.49709293866352 + 1.22945740853541i, "acosh(Complex) - 1.49709293866352 + 1.22945740853541i");
    is_approx(acosh(:x((0.523598775603156 + 2i).Complex)), 1.46781890096429 + 1.33960563114198i, "acosh(:x(Complex)) - 1.46781890096429 + 1.33960563114198i");
}

{
    # Str tests
    is_approx(((1.32460908925833).Str).acosh, 0.785398163404734, "Str.acosh - 0.785398163404734");
    is_approx(acosh((1.14023832107909).Str), 0.523598775603156, "acosh(Str) - 0.523598775603156");
    is_approx(acosh(:x((1.32460908925833).Str)), 0.785398163404734, "acosh(:x(Str)) - 0.785398163404734");
}

{
    # NotComplex tests
    is_approx((NotComplex.new(0.523598775603156 + 2i)).acosh, 1.46781890096429 + 1.33960563114198i, "NotComplex.acosh - 1.46781890096429 + 1.33960563114198i");
    is_approx(acosh(NotComplex.new(0.785398163404734 + 2i)), 1.49709293866352 + 1.22945740853541i, "acosh(NotComplex) - 1.49709293866352 + 1.22945740853541i");
    is_approx(acosh(:x(NotComplex.new(0.523598775603156 + 2i))), 1.46781890096429 + 1.33960563114198i, "acosh(:x(NotComplex)) - 1.46781890096429 + 1.33960563114198i");
}

{
    # DifferentReal tests
    is_approx((DifferentReal.new(1.32460908925833)).acosh, 0.785398163404734, "DifferentReal.acosh - 0.785398163404734");
    is_approx(acosh(DifferentReal.new(1.14023832107909)), 0.523598775603156, "acosh(DifferentReal) - 0.523598775603156");
    is_approx(acosh(:x(DifferentReal.new(1.32460908925833))), 0.785398163404734, "acosh(:x(DifferentReal)) - 0.785398163404734");
}

done;

# vim: ft=perl6 nomodifiable
