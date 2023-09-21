use v6.c;
# WARNING:
# This is a generated file and should not be edited directly.
# look into generate-tests.pl instead

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
        self.bless(:$value);
    }

    multi method Numeric() {
        self.value;
    }
}

class DifferentReal is Real {
    has $.value;

    multi method new($value is copy) {
        self.bless(:$value);
    }

    multi method Bridge() {
        self.value.Num;
    }
}            



# cos tests

for @cosines -> $angle
{
    
    my $desired-result = $angle.value;

    # Num.cos tests -- very thorough
    is-approx($angle.key().cos, $desired-result, 
              "Num.cos - {$angle.key()}");

    # Complex.cos tests -- also very thorough
    my Complex $zp0 = $angle.key + 0.0i;
    my Complex $sz0 = $desired-result + 0i;
    my Complex $zp1 = $angle.key + 1.0i;
    my Complex $sz1 = { (exp($_ * 1i) + exp(-$_ * 1i)) / 2 }($zp1);
    my Complex $zp2 = $angle.key + 2.0i;
    my Complex $sz2 = { (exp($_ * 1i) + exp(-$_ * 1i)) / 2 }($zp2);
    
    is-approx($zp0.cos, $sz0, "Complex.cos - $zp0");
    is-approx($zp1.cos, $sz1, "Complex.cos - $zp1");
    is-approx($zp2.cos, $sz2, "Complex.cos - $zp2");
}


{
    is(cos(Inf), NaN, "cos(Inf) -");
    is(cos(-Inf), NaN, "cos(-Inf) -");
}
        
{
    # Num tests
    is-approx(cos((-7.8539816).Num), 0, "cos(Num) - -7.8539816");
}

{
    # Rat tests
    is-approx((-5.4977871).Rat(1e-9).cos, 0.707106781186548, "Rat.cos - -5.4977871");
    is-approx(cos((-2.0943951).Rat(1e-9)), -0.5, "cos(Rat) - -2.0943951");
}

{
    # Complex tests
    is-approx(cos((-1.57079632680947+2i).Complex), -5.48212707989036e-11+3.62686040784702i, "cos(Complex) - -1.57079632680947+2i");
}

{
    # Str tests
    is-approx((-1.0471976).Str.cos, 0.5, "Str.cos - -1.0471976");
    is-approx(cos((-0.7853982).Str), 0.707106781186548, "cos(Str) - -0.7853982");
}

{
    # NotComplex tests
    is-approx(NotComplex.new(0+2i).cos, 3.76219569108363+-0i, "NotComplex.cos - 0+2i");
    is-approx(cos(NotComplex.new(0.785398163404734+2i)), 2.66027408529666-2.56457758882432i, "cos(NotComplex) - 0.785398163404734+2i");
}

{
    # DifferentReal tests
    is-approx(DifferentReal.new(1.5707963).cos, 0, "DifferentReal.cos - 1.5707963");
    is-approx(cos(DifferentReal.new(2.3561945)), -0.707106781186548, "cos(DifferentReal) - 2.3561945");
}

{
    # FatRat tests
    is-approx((3.141593).FatRat.cos, -1, "FatRat.cos - 3.141593");
    is-approx(cos((3.9269908).FatRat), -0.707106781186548, "cos(FatRat) - 3.9269908");
}


# acos tests

for @cosines -> $angle
{
    
    my $desired-result = $angle.value;

    # Num.acos tests -- thorough
    is-approx($desired-result.Num.acos.cos, $desired-result, 
              "Num.acos - {$angle.key()}");
    
    # Num.acos(Complex) tests -- thorough
    for ($desired-result + 0i, $desired-result + .5i, $desired-result + 2i) -> $z {
        is-approx($z.acos.cos, $z, 
                  "Complex.acos - $z");
    }
}
        
{
    # Num tests
    is-approx(acos((0.707106781186548).Num), 0.7853982, "acos(Num) - 0.7853982");
}

{
    # Rat tests
    is-approx(((0.707106781186548).Rat(1e-9)).acos, 0.7853982, "Rat.acos - 0.7853982");
    is-approx(acos((0.707106781186548).Rat(1e-9)), 0.7853982, "acos(Rat) - 0.7853982");
}

{
    # Complex tests
    is-approx(acos((0.785398163404734+2i).Complex), 1.22945740853541-1.49709293866352i, "acos(Complex) - 1.22945740853541-1.49709293866352i");
}

{
    # Str tests
    is-approx(((0.707106781186548).Str).acos, 0.7853982, "Str.acos - 0.7853982");
    is-approx(acos((0.707106781186548).Str), 0.7853982, "acos(Str) - 0.7853982");
}

{
    # NotComplex tests
    is-approx((NotComplex.new(0.785398163404734+2i)).acos, 1.22945740853541-1.49709293866352i, "NotComplex.acos - 1.22945740853541-1.49709293866352i");
    is-approx(acos(NotComplex.new(0.785398163404734+2i)), 1.22945740853541-1.49709293866352i, "acos(NotComplex) - 1.22945740853541-1.49709293866352i");
}

{
    # DifferentReal tests
    is-approx((DifferentReal.new(0.707106781186548)).acos, 0.7853982, "DifferentReal.acos - 0.7853982");
    is-approx(acos(DifferentReal.new(0.707106781186548)), 0.7853982, "acos(DifferentReal) - 0.7853982");
}

{
    # FatRat tests
    is-approx(((0.707106781186548).FatRat).acos, 0.7853982, "FatRat.acos - 0.7853982");
    is-approx(acos((0.707106781186548).FatRat), 0.7853982, "acos(FatRat) - 0.7853982");
}

done-testing;

# vim: ft=perl6 nomodifiable
