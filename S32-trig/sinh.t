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



# sinh tests

my $iter_count = 0;
for @sinhes -> $angle
{
    
    my $desired-result = $angle.value;

    # Num.sinh tests -- very thorough
    is_approx($angle.key().sinh, $desired-result, 
              "Num.sinh - {$angle.key()}");

    # Complex.sinh tests -- also very thorough
    my Complex $zp0 = $angle.key + 0.0i;
    my Complex $sz0 = $desired-result + 0i;
    my Complex $zp1 = $angle.key + 1.0i;
    my Complex $sz1 = { (exp($_) - exp(-$_)) / 2 }($zp1);
    my Complex $zp2 = $angle.key + 2.0i;
    my Complex $sz2 = { (exp($_) - exp(-$_)) / 2 }($zp2);
    
    is_approx($zp0.sinh, $sz0, "Complex.sinh - $zp0");
    is_approx($zp1.sinh, $sz1, "Complex.sinh - $zp1");
    is_approx($zp2.sinh, $sz2, "Complex.sinh - $zp2");
}

{
    is(sinh(Inf), Inf, "sinh(Inf) -");
    is(sinh(-Inf), -Inf, "sinh(-Inf) -");
}
        
{
    # Num tests
    is_approx(sinh((-6.28318530723787).Num), -267.744894056622, "sinh(Num) - -6.28318530723787");
}

{
    # Rat tests
    is_approx((-3.92699081702367).Rat(1e-9).sinh, -25.367158320299, "Rat.sinh - -3.92699081702367");
    is_approx(sinh((-0.523598775603156).Rat(1e-9)), -0.547853473893578, "sinh(Rat) - -0.523598775603156");
}

{
    # Complex tests
    is_approx(sinh((0 + 2i).Complex), -0 + 0.909297426825682i, "sinh(Complex) - 0 + 2i");
}

{
    # Str tests
    is_approx((0.523598775603156).Str.sinh, 0.547853473893578, "Str.sinh - 0.523598775603156");
    is_approx(sinh((0.785398163404734).Str), 0.86867096149566, "sinh(Str) - 0.785398163404734");
}

{
    # NotComplex tests
    is_approx(NotComplex.new(1.57079632680947 + 2i).sinh, -0.957678258159807 + 2.28158953412064i, "NotComplex.sinh - 1.57079632680947 + 2i");
    is_approx(sinh(NotComplex.new(2.3561944902142 + 2i)), -2.17560397806036 + 4.83996483329327i, "sinh(NotComplex) - 2.3561944902142 + 2i");
}

{
    # DifferentReal tests
    is_approx(DifferentReal.new(3.14159265361894).sinh, 11.5487393575956, "DifferentReal.sinh - 3.14159265361894");
    is_approx(sinh(DifferentReal.new(3.92699081702367)), 25.367158320299, "sinh(DifferentReal) - 3.92699081702367");
}


# asinh tests

for @sinhes -> $angle
{
    
    my $desired-result = $angle.value;

    # Num.asinh tests -- thorough
    is_approx($desired-result.Num.asinh.sinh, $desired-result, 
              "Num.asinh - {$angle.key()}");
    
    # Num.asinh(Complex) tests -- thorough
    for ($desired-result + 0i, $desired-result + .5i, $desired-result + 2i) -> $z {
        is_approx(sinh(asinh($z)), $z, 
                  "asinh(Complex) - {$angle.key()}");
        is_approx($z.asinh.sinh, $z, 
                  "Complex.asinh - {$angle.key()}");
    }
}
        
{
    # Num tests
    is_approx(asinh((0.547853473893578).Num), 0.523598775603156, "asinh(Num) - 0.523598775603156");
}

{
    # Rat tests
    is_approx(((0.86867096149566).Rat(1e-9)).asinh, 0.785398163404734, "Rat.asinh - 0.785398163404734");
    is_approx(asinh((0.547853473893578).Rat(1e-9)), 0.523598775603156, "asinh(Rat) - 0.523598775603156");
}

{
    # Complex tests
    is_approx(asinh((0.785398163404734 + 2i).Complex), 1.41841325789332 + 1.15495109689711i, "asinh(Complex) - 1.41841325789332 + 1.15495109689711i");
}

{
    # Str tests
    is_approx(((0.547853473893578).Str).asinh, 0.523598775603156, "Str.asinh - 0.523598775603156");
    is_approx(asinh((0.86867096149566).Str), 0.785398163404734, "asinh(Str) - 0.785398163404734");
}

{
    # NotComplex tests
    is_approx((NotComplex.new(0.523598775603156 + 2i)).asinh, 1.365827718396 + 1.28093108055158i, "NotComplex.asinh - 1.365827718396 + 1.28093108055158i");
    is_approx(asinh(NotComplex.new(0.785398163404734 + 2i)), 1.41841325789332 + 1.15495109689711i, "asinh(NotComplex) - 1.41841325789332 + 1.15495109689711i");
}

{
    # DifferentReal tests
    is_approx((DifferentReal.new(0.547853473893578)).asinh, 0.523598775603156, "DifferentReal.asinh - 0.523598775603156");
    is_approx(asinh(DifferentReal.new(0.86867096149566)), 0.785398163404734, "asinh(DifferentReal) - 0.785398163404734");
}

done;

# vim: ft=perl6 nomodifiable
