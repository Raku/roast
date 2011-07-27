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



# cotan tests

my $iter_count = 0;
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

is(cotan(Inf), NaN, "cotan(Inf) -");
is(cotan(-Inf), NaN, "cotan(-Inf) -");
        
# Num tests
is_approx(cotan((-3.92699081702367).Num), -0.999999999927141, "cotan(Num) - -3.92699081702367");
is_approx(cotan(:x((-0.523598775603156).Num)), -1.73205080754945, "cotan(:x(Num)) - -0.523598775603156");

# Rat tests
is_approx((0.523598775603156).Rat(1e-9).cotan, 1.73205080754945, "Rat.cotan - 0.523598775603156");
is_approx(cotan((0.785398163404734).Rat(1e-9)), 0.999999999985428, "cotan(Rat) - 0.785398163404734");
is_approx(cotan(:x((1.57079632680947).Rat(1e-9))), -1.45716159658652e-11, "cotan(:x(Rat)) - 1.57079632680947");

# Complex tests
is_approx(cotan((2.3561944902142 + 2i).Complex), -0.0366189934737451 - 0.999329299740667i, "cotan(Complex) - 2.3561944902142 + 2i");
is_approx(cotan(:x((3.92699081702367 + 2i).Complex)), 0.036618993473589 - 0.999329299736401i, "cotan(:x(Complex)) - 3.92699081702367 + 2i");

# Str tests
is_approx((4.7123889804284).Str.cotan, -4.37150699422006e-11, "Str.cotan - 4.7123889804284");
is_approx(cotan((5.49778714383314).Str), -1.000000000102, "cotan(Str) - 5.49778714383314");
is_approx(cotan(:x((6.80678408284103).Str)), 1.7320508073163, "cotan(:x(Str)) - 6.80678408284103");

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

    is_approx(NotComplex.new(10.2101761242615 + 2i).cotan, 0.0366189934734326 - 0.999329299732135i, "NotComplex.cotan - 10.2101761242615 + 2i");
    is_approx(cotan(NotComplex.new(-3.92699081702367 + 2i)), -0.036618993473589 - 0.999329299736401i, "cotan(NotComplex) - -3.92699081702367 + 2i");
    is_approx(cotan(:x(NotComplex.new(-0.523598775603156 + 2i))), -0.0323044569586672 - 1.01796777743797i, "cotan(:x(NotComplex)) - -0.523598775603156 + 2i");
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

    is_approx(DifferentReal.new(0.523598775603156).cotan, 1.73205080754945, "DifferentReal.cotan - 0.523598775603156");
    is_approx(cotan(DifferentReal.new(0.785398163404734)), 0.999999999985428, "cotan(DifferentReal) - 0.785398163404734");
    is_approx(cotan(:x(DifferentReal.new(1.57079632680947))), -1.45716159658652e-11, "cotan(:x(DifferentReal)) - 1.57079632680947");
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
        is_approx(cotan(acotan($z)), $z, 
                  "acotan(Complex) - {$angle.key()}");
        is_approx($z.acotan.cotan, $z, 
                  "Complex.acotan - {$angle.key()}");
    }
}
        
# Num tests
is_approx(acotan((1.73205080754945).Num), 0.523598775603156, "acotan(Num) - 0.523598775603156");
is_approx(acotan(:x((0.999999999985428).Num)), 0.785398163404734, "acotan(:x(Num)) - 0.785398163404734");

# Rat tests
is_approx(((1.73205080754945).Rat(1e-9)).acotan, 0.523598775603156, "Rat.acotan - 0.523598775603156");
is_approx(acotan((0.999999999985428).Rat(1e-9)), 0.785398163404734, "acotan(Rat) - 0.785398163404734");
is_approx(acotan(:x((1.73205080754945).Rat(1e-9))), 0.523598775603156, "acotan(:x(Rat)) - 0.523598775603156");

# Complex tests
is_approx(acotan((0.785398163404734 + 2i).Complex), 0.204860490024916 - 0.445759203696597i, "acotan(Complex) - 0.204860490024916 - 0.445759203696597i");
is_approx(acotan(:x((0.523598775603156 + 2i).Complex)), 0.154777736124053 - 0.496236956634457i, "acotan(:x(Complex)) - 0.154777736124053 - 0.496236956634457i");

# Str tests
is_approx(((0.999999999985428).Str).acotan, 0.785398163404734, "Str.acotan - 0.785398163404734");
is_approx(acotan((1.73205080754945).Str), 0.523598775603156, "acotan(Str) - 0.523598775603156");
is_approx(acotan(:x((0.999999999985428).Str)), 0.785398163404734, "acotan(:x(Str)) - 0.785398163404734");

# NotComplex tests
is_approx((NotComplex.new(0.523598775603156 + 2i)).acotan, 0.154777736124053 - 0.496236956634457i, "NotComplex.acotan - 0.154777736124053 - 0.496236956634457i");
is_approx(acotan(NotComplex.new(0.785398163404734 + 2i)), 0.204860490024916 - 0.445759203696597i, "acotan(NotComplex) - 0.204860490024916 - 0.445759203696597i");
is_approx(acotan(:x(NotComplex.new(0.523598775603156 + 2i))), 0.154777736124053 - 0.496236956634457i, "acotan(:x(NotComplex)) - 0.154777736124053 - 0.496236956634457i");

# DifferentReal tests
is_approx((DifferentReal.new(0.999999999985428)).acotan, 0.785398163404734, "DifferentReal.acotan - 0.785398163404734");
is_approx(acotan(DifferentReal.new(1.73205080754945)), 0.523598775603156, "acotan(DifferentReal) - 0.523598775603156");
is_approx(acotan(:x(DifferentReal.new(0.999999999985428))), 0.785398163404734, "acotan(:x(DifferentReal)) - 0.785398163404734");

done;

# vim: ft=perl6 nomodifiable
