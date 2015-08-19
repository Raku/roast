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



# tan tests

for @sines -> $angle
{
    next if abs(cos($angle.key())) < 1e-6;
    my $desired-result = sin($angle.key()) / cos($angle.key());

    # Num.tan tests -- very thorough
    is_approx($angle.key().tan, $desired-result, 
              "Num.tan - {$angle.key()}");

    # Complex.tan tests -- also very thorough
    my Complex $zp0 = $angle.key + 0.0i;
    my Complex $sz0 = $desired-result + 0i;
    my Complex $zp1 = $angle.key + 1.0i;
    my Complex $sz1 = { sin($_) / cos($_) }($zp1);
    my Complex $zp2 = $angle.key + 2.0i;
    my Complex $sz2 = { sin($_) / cos($_) }($zp2);
    
    is_approx($zp0.tan, $sz0, "Complex.tan - $zp0");
    is_approx($zp1.tan, $sz1, "Complex.tan - $zp1");
    is_approx($zp2.tan, $sz2, "Complex.tan - $zp2");
}


{
    is(tan(Inf), NaN, "tan(Inf) -");
    is(tan(-Inf), NaN, "tan(-Inf) -");
}
        
{
    # Num tests
    is_approx(tan((-6.283185).Num), -5.82864638634609e-11, "tan(Num) - -6.283185");
}

{
    # Rat tests
    is_approx((-3.9269908).Rat(1e-9).tan, -1.00000000007286, "Rat.tan - -3.9269908");
    is_approx(tan((-0.5235988).Rat(1e-9)), -0.577350269196102, "tan(Rat) - -0.5235988");
}

{
    # Complex tests
    is_approx(tan((0+2i).Complex), 0+0.964027580075817i, "tan(Complex) - 0+2i");
}

{
    # Str tests
    is_approx((0.5235988).Str.tan, 0.577350269196102, "Str.tan - 0.5235988");
    is_approx(tan((0.7853982).Str), 1.00000000001457, "tan(Str) - 0.7853982");
}

{
    # NotComplex tests
    is_approx(NotComplex.new(2.3561944902142+2i).tan, -0.0366189934736279+0.999329299737467i, "NotComplex.tan - 2.3561944902142+2i");
    is_approx(tan(NotComplex.new(3.14159265361894+2i)), 2.05899337486384e-12+0.964027580075817i, "tan(NotComplex) - 3.14159265361894+2i");
}

{
    # DifferentReal tests
    is_approx(DifferentReal.new(3.9269908).tan, 1.00000000007286, "DifferentReal.tan - 3.9269908");
    is_approx(tan(DifferentReal.new(5.4977871)), -0.999999999897998, "tan(DifferentReal) - 5.4977871");
}

{
    # FatRat tests
    is_approx((6.283185).FatRat.tan, 5.82864638634609e-11, "FatRat.tan - 6.283185");
    is_approx(tan((6.8067841).FatRat), 0.577350269273818, "tan(FatRat) - 6.8067841");
}


# atan tests

for @sines -> $angle
{
    next if abs(cos($angle.key())) < 1e-6;
    my $desired-result = sin($angle.key()) / cos($angle.key());

    # Num.atan tests -- thorough
    is_approx($desired-result.Num.atan.tan, $desired-result, 
              "Num.atan - {$angle.key()}");
    
    # Num.atan(Complex) tests -- thorough
    for ($desired-result + 0i, $desired-result + .5i, $desired-result + 2i) -> $z {
        is_approx($z.atan.tan, $z, 
                  "Complex.atan - $z");
    }
}
        
{
    # Num tests
    is_approx(atan((0.577350269196102).Num), 0.5235988, "atan(Num) - 0.5235988");
}

{
    # Rat tests
    is_approx(((1.00000000001457).Rat(1e-9)).atan, 0.7853982, "Rat.atan - 0.7853982");
    is_approx(atan((0.577350269196102).Rat(1e-9)), 0.5235988, "atan(Rat) - 0.5235988");
}

{
    # Complex tests
    is_approx(atan((0.785398163404734+2i).Complex), 1.36593583676998+0.445759203696597i, "atan(Complex) - 1.36593583676998+0.445759203696597i");
}

{
    # Str tests
    is_approx(((0.577350269196102).Str).atan, 0.5235988, "Str.atan - 0.5235988");
    is_approx(atan((1.00000000001457).Str), 0.7853982, "atan(Str) - 0.7853982");
}

{
    # NotComplex tests
    is_approx((NotComplex.new(0.523598775603156+2i)).atan, 1.41601859067084+0.496236956634457i, "NotComplex.atan - 1.41601859067084+0.496236956634457i");
    is_approx(atan(NotComplex.new(0.785398163404734+2i)), 1.36593583676998+0.445759203696597i, "atan(NotComplex) - 1.36593583676998+0.445759203696597i");
}

{
    # DifferentReal tests
    is_approx((DifferentReal.new(0.577350269196102)).atan, 0.5235988, "DifferentReal.atan - 0.5235988");
    is_approx(atan(DifferentReal.new(1.00000000001457)), 0.7853982, "atan(DifferentReal) - 0.7853982");
}

{
    # FatRat tests
    is_approx(((0.577350269196102).FatRat).atan, 0.5235988, "FatRat.atan - 0.5235988");
    is_approx(atan((1.00000000001457).FatRat), 0.7853982, "atan(FatRat) - 0.7853982");
}

done-testing;

# vim: ft=perl6 nomodifiable
