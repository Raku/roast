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



# cotan tests

for @sines -> $angle
{
    next if abs(sin($angle.key())) < 1e-6;
    my $desired-result = cos($angle.key()) / sin($angle.key());

    # Num.cotan tests -- very thorough
    is_approx($angle.key().cotan, $desired-result, 
              "Num.cotan - {$angle.key()}");

    # Complex.cotan tests -- also very thorough
    my Complex $zp0 = $angle.key + 0.0i;
    my Complex $sz0 = $desired-result + 0i;
    my Complex $zp1 = $angle.key + 1.0i;
    my Complex $sz1 = { cos($_) / sin($_) }($zp1);
    my Complex $zp2 = $angle.key + 2.0i;
    my Complex $sz2 = { cos($_) / sin($_) }($zp2);
    
    is_approx($zp0.cotan, $sz0, "Complex.cotan - $zp0");
    is_approx($zp1.cotan, $sz1, "Complex.cotan - $zp1");
    is_approx($zp2.cotan, $sz2, "Complex.cotan - $zp2");
}


{
    is(cotan(Inf), NaN, "cotan(Inf) -");
    is(cotan(-Inf), NaN, "cotan(-Inf) -");
}
        
{
    # Num tests
    is_approx(cotan((-3.9269908).Num), -0.999999999927141, "cotan(Num) - -3.9269908");
}

{
    # Rat tests
    is_approx((-0.5235988).Rat(1e-9).cotan, -1.73205080754945, "Rat.cotan - -0.5235988");
    is_approx(cotan((0.5235988).Rat(1e-9)), 1.73205080754945, "cotan(Rat) - 0.5235988");
}

{
    # Complex tests
    is_approx(cotan((0.785398163404734+2i).Complex), 0.0366189934736669-0.999329299738534i, "cotan(Complex) - 0.785398163404734+2i");
}

{
    # Str tests
    is_approx((1.5707963).Str.cotan, -1.45716159658652e-11, "Str.cotan - 1.5707963");
    is_approx(cotan((2.3561945).Str), -1.00000000004372, "cotan(Str) - 2.3561945");
}

{
    # NotComplex tests
    is_approx(NotComplex.new(3.92699081702367+2i).cotan, 0.036618993473589-0.999329299736401i, "NotComplex.cotan - 3.92699081702367+2i");
    is_approx(cotan(NotComplex.new(4.7123889804284+2i)), -3.08850574993026e-12-0.964027580075817i, "cotan(NotComplex) - 4.7123889804284+2i");
}

{
    # DifferentReal tests
    is_approx(DifferentReal.new(5.4977871).cotan, -1.000000000102, "DifferentReal.cotan - 5.4977871");
    is_approx(cotan(DifferentReal.new(6.8067841)), 1.7320508073163, "cotan(DifferentReal) - 6.8067841");
}

{
    # FatRat tests
    is_approx((10.2101761).FatRat.cotan, 0.999999999810569, "FatRat.cotan - 10.2101761");
    is_approx(cotan((-3.9269908).FatRat), -0.999999999927141, "cotan(FatRat) - -3.9269908");
}


# acotan tests

for @sines -> $angle
{
    next if abs(sin($angle.key())) < 1e-6;
    my $desired-result = cos($angle.key()) / sin($angle.key());

    # Num.acotan tests -- thorough
    is_approx($desired-result.Num.acotan.cotan, $desired-result, 
              "Num.acotan - {$angle.key()}");
    
    # Num.acotan(Complex) tests -- thorough
    for ($desired-result + 0i, $desired-result + .5i, $desired-result + 2i) -> $z {
        is_approx($z.acotan.cotan, $z, 
                  "Complex.acotan - $z");
    }
}
        
{
    # Num tests
    is_approx(acotan((1.73205080754945).Num), 0.5235988, "acotan(Num) - 0.5235988");
}

{
    # Rat tests
    is_approx(((0.999999999985428).Rat(1e-9)).acotan, 0.7853982, "Rat.acotan - 0.7853982");
    is_approx(acotan((1.73205080754945).Rat(1e-9)), 0.5235988, "acotan(Rat) - 0.5235988");
}

{
    # Complex tests
    is_approx(acotan((0.785398163404734+2i).Complex), 0.204860490024916-0.445759203696597i, "acotan(Complex) - 0.204860490024916-0.445759203696597i");
}

{
    # Str tests
    is_approx(((1.73205080754945).Str).acotan, 0.5235988, "Str.acotan - 0.5235988");
    is_approx(acotan((0.999999999985428).Str), 0.7853982, "acotan(Str) - 0.7853982");
}

{
    # NotComplex tests
    is_approx((NotComplex.new(0.523598775603156+2i)).acotan, 0.154777736124053-0.496236956634457i, "NotComplex.acotan - 0.154777736124053-0.496236956634457i");
    is_approx(acotan(NotComplex.new(0.785398163404734+2i)), 0.204860490024916-0.445759203696597i, "acotan(NotComplex) - 0.204860490024916-0.445759203696597i");
}

{
    # DifferentReal tests
    is_approx((DifferentReal.new(1.73205080754945)).acotan, 0.5235988, "DifferentReal.acotan - 0.5235988");
    is_approx(acotan(DifferentReal.new(0.999999999985428)), 0.7853982, "acotan(DifferentReal) - 0.7853982");
}

{
    # FatRat tests
    is_approx(((1.73205080754945).FatRat).acotan, 0.5235988, "FatRat.acotan - 0.5235988");
    is_approx(acotan((0.999999999985428).FatRat), 0.7853982, "acotan(FatRat) - 0.7853982");
}

done-testing;

# vim: ft=perl6 nomodifiable
