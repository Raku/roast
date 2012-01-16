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

my @cosines = @sines.map({; $_.key - degrees-to-radians(90) => $_.value }); #OK

my @sinhes = @sines.grep({ $_.key < degrees-to-radians(500) }).map({; $_.key => #OK
                                                (exp($_.key) - exp(-$_.key)) / 2.0 });

my @coshes = @sines.grep({ $_.key < degrees-to-radians(500) }).map({; $_.key => #OK
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
        self.value.Num;
    }
}            



# cosh tests

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

#?niecza skip "Inf results wrong"
{
    is(cosh(Inf), Inf, "cosh(Inf) -");
    is(cosh(-Inf), Inf, "cosh(-Inf) -");
}
        
{
    # Num tests
    is_approx(cosh((-6.28318530723787).Num), 267.746761499354, "cosh(Num) - -6.28318530723787");
}

{
    # Rat tests
    is_approx((-3.92699081702367).Rat(1e-9).cosh, 25.3868611932849, "Rat.cosh - -3.92699081702367");
    is_approx(cosh((-0.523598775603156).Rat(1e-9)), 1.14023832107909, "cosh(Rat) - -0.523598775603156");
}

{
    # Complex tests
    is_approx(cosh((0 + 2i).Complex), -0.416146836547142 + 0i, "cosh(Complex) - 0 + 2i");
}

{
    # Str tests
    is_approx((0.523598775603156).Str.cosh, 1.14023832107909, "Str.cosh - 0.523598775603156");
    is_approx(cosh((0.785398163404734).Str), 1.32460908925833, "cosh(Str) - 0.785398163404734");
}

{
    # NotComplex tests
    is_approx(NotComplex.new(1.57079632680947 + 2i).cosh, -1.04418668623968 + 2.09256517025804i, "NotComplex.cosh - 1.57079632680947 + 2i");
    is_approx(cosh(NotComplex.new(2.3561944902142 + 2i)), -2.21504646879479 + 4.75378141873222i, "cosh(NotComplex) - 2.3561944902142 + 2i");
}

{
    # DifferentReal tests
    is_approx(DifferentReal.new(3.14159265361894).cosh, 11.5919532758581, "DifferentReal.cosh - 3.14159265361894");
    is_approx(cosh(DifferentReal.new(3.92699081702367)), 25.3868611932849, "cosh(DifferentReal) - 3.92699081702367");
}

#?rakudo skip "FatRat math NYI"
{
    # FatRat tests
    is_approx((4.7123889804284).FatRat.cosh, 55.6633808928716, "FatRat.cosh - 4.7123889804284");
    is_approx(cosh((5.49778714383314).FatRat), 122.077579345808, "cosh(FatRat) - 5.49778714383314");
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
        is_approx($z.acosh.cosh, $z, 
                  "Complex.acosh - $z");
    }
}
        
{
    # Num tests
    is_approx(acosh((1.14023832107909).Num), 0.523598775603156, "acosh(Num) - 0.523598775603156");
}

{
    # Rat tests
    is_approx(((1.32460908925833).Rat(1e-9)).acosh, 0.785398163404734, "Rat.acosh - 0.785398163404734");
    is_approx(acosh((1.14023832107909).Rat(1e-9)), 0.523598775603156, "acosh(Rat) - 0.523598775603156");
}

{
    # Complex tests
    is_approx(acosh((0.785398163404734 + 2i).Complex), 1.49709293866352 + 1.22945740853541i, "acosh(Complex) - 1.49709293866352 + 1.22945740853541i");
}

{
    # Str tests
    is_approx(((1.14023832107909).Str).acosh, 0.523598775603156, "Str.acosh - 0.523598775603156");
    is_approx(acosh((1.32460908925833).Str), 0.785398163404734, "acosh(Str) - 0.785398163404734");
}

{
    # NotComplex tests
    is_approx((NotComplex.new(0.523598775603156 + 2i)).acosh, 1.46781890096429 + 1.33960563114198i, "NotComplex.acosh - 1.46781890096429 + 1.33960563114198i");
    is_approx(acosh(NotComplex.new(0.785398163404734 + 2i)), 1.49709293866352 + 1.22945740853541i, "acosh(NotComplex) - 1.49709293866352 + 1.22945740853541i");
}

{
    # DifferentReal tests
    is_approx((DifferentReal.new(1.14023832107909)).acosh, 0.523598775603156, "DifferentReal.acosh - 0.523598775603156");
    is_approx(acosh(DifferentReal.new(1.32460908925833)), 0.785398163404734, "acosh(DifferentReal) - 0.785398163404734");
}

#?rakudo skip "FatRat math NYI"
{
    # FatRat tests
    is_approx(((1.14023832107909).FatRat).acosh, 0.523598775603156, "FatRat.acosh - 0.523598775603156");
    is_approx(acosh((1.32460908925833).FatRat), 0.785398163404734, "acosh(FatRat) - 0.785398163404734");
}

done;

# vim: ft=perl6 nomodifiable
