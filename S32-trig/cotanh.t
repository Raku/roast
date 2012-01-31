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



# cotanh tests

for @sines -> $angle
{
    next if abs(sinh($angle.key())) < 1e-6;
    my $desired-result = cosh($angle.key()) / sinh($angle.key());

    # Num.cotanh tests -- very thorough
    is_approx($angle.key().cotanh, $desired-result, 
              "Num.cotanh - {$angle.key()}");

    # Complex.cotanh tests -- also very thorough
    my Complex $zp0 = $angle.key + 0.0i;
    my Complex $sz0 = $desired-result + 0i;
    my Complex $zp1 = $angle.key + 1.0i;
    my Complex $sz1 = { cosh($_) / sinh ($_) }($zp1);
    my Complex $zp2 = $angle.key + 2.0i;
    my Complex $sz2 = { cosh($_) / sinh ($_) }($zp2);
    
    is_approx($zp0.cotanh, $sz0, "Complex.cotanh - $zp0");
    is_approx($zp1.cotanh, $sz1, "Complex.cotanh - $zp1");
    is_approx($zp2.cotanh, $sz2, "Complex.cotanh - $zp2");
}

#?niecza todo "Inf results wrong"
{
    is(cotanh(Inf), 1, "cotanh(Inf) -");
    is(cotanh(-Inf), -1, "cotanh(-Inf) -");
}
        
{
    # Num tests
    is_approx(cotanh((-6.28318530723787).Num), -1.00000697470903, "cotanh(Num) - -6.28318530723787");
}

{
    # Rat tests
    is_approx((-3.92699081702367).Rat(1e-9).cotanh, -1.0007767079283, "Rat.cotanh - -3.92699081702367");
    is_approx(cotanh((-0.523598775603156).Rat(1e-9)), -2.08128336391745, "cotanh(Rat) - -0.523598775603156");
}

{
    # Complex tests
    is_approx(cotanh((0.523598775603156 + 2i).Complex), 0.554305939075667 + 0.335770114695529i, "cotanh(Complex) - 0.523598775603156 + 2i");
}

{
    # Str tests
    is_approx((0.785398163404734).Str.cotanh, 1.52486861881241, "Str.cotanh - 0.785398163404734");
    is_approx(cotanh((1.57079632680947).Str), 1.09033141072462, "cotanh(Str) - 1.57079632680947");
}

{
    # NotComplex tests
    is_approx(NotComplex.new(2.3561944902142 + 2i).cotanh, 0.988233985768855 + 0.0134382542728859i, "NotComplex.cotanh - 2.3561944902142 + 2i");
    is_approx(cotanh(NotComplex.new(3.14159265361894 + 2i)), 0.997557712093238 + 0.00281967717213006i, "cotanh(NotComplex) - 3.14159265361894 + 2i");
}

{
    # DifferentReal tests
    is_approx(DifferentReal.new(3.92699081702367).cotanh, 1.0007767079283, "DifferentReal.cotanh - 3.92699081702367");
    is_approx(cotanh(DifferentReal.new(4.7123889804284)), 1.000161412061, "cotanh(DifferentReal) - 4.7123889804284");
}

#?rakudo skip "FatRat math NYI"
{
    # FatRat tests
    is_approx((5.49778714383314).FatRat.cotanh, 1.00003355212591, "FatRat.cotanh - 5.49778714383314");
    is_approx(cotanh((6.28318530723787).FatRat), 1.00000697470903, "cotanh(FatRat) - 6.28318530723787");
}


# acotanh tests

for @sines -> $angle
{
    next if abs(sinh($angle.key())) < 1e-6;
    my $desired-result = cosh($angle.key()) / sinh($angle.key());

    # Num.acotanh tests -- thorough
    is_approx($desired-result.Num.acotanh.cotanh, $desired-result, 
              "Num.acotanh - {$angle.key()}");
    
    # Num.acotanh(Complex) tests -- thorough
    for ($desired-result + 0i, $desired-result + .5i, $desired-result + 2i) -> $z {
        is_approx($z.acotanh.cotanh, $z, 
                  "Complex.acotanh - $z");
    }
}
        
{
    # Num tests
    is_approx(acotanh((2.08128336391745).Num), 0.523598775603156, "acotanh(Num) - 0.523598775603156");
}

{
    # Rat tests
    is_approx(((1.52486861881241).Rat(1e-9)).acotanh, 0.785398163404734, "Rat.acotanh - 0.785398163404734");
    is_approx(acotanh((2.08128336391745).Rat(1e-9)), 0.523598775603156, "acotanh(Rat) - 0.523598775603156");
}

{
    # Complex tests
    is_approx(acotanh((0.785398163404734 + 2i).Complex), 0.143655432578432 - 0.417829353993379i, "acotanh(Complex) - 0.143655432578432 - 0.417829353993379i");
}

{
    # Str tests
    is_approx(((2.08128336391745).Str).acotanh, 0.523598775603156, "Str.acotanh - 0.523598775603156");
    is_approx(acotanh((1.52486861881241).Str), 0.785398163404734, "acotanh(Str) - 0.785398163404734");
}

{
    # NotComplex tests
    is_approx((NotComplex.new(0.523598775603156 + 2i)).acotanh, 0.100612672097949 - 0.442426473062511i, "NotComplex.acotanh - 0.100612672097949 - 0.442426473062511i");
    is_approx(acotanh(NotComplex.new(0.785398163404734 + 2i)), 0.143655432578432 - 0.417829353993379i, "acotanh(NotComplex) - 0.143655432578432 - 0.417829353993379i");
}

{
    # DifferentReal tests
    is_approx((DifferentReal.new(2.08128336391745)).acotanh, 0.523598775603156, "DifferentReal.acotanh - 0.523598775603156");
    is_approx(acotanh(DifferentReal.new(1.52486861881241)), 0.785398163404734, "acotanh(DifferentReal) - 0.785398163404734");
}

#?rakudo skip "FatRat math NYI"
{
    # FatRat tests
    is_approx(((2.08128336391745).FatRat).acotanh, 0.523598775603156, "FatRat.acotanh - 0.523598775603156");
    is_approx(acotanh((1.52486861881241).FatRat), 0.785398163404734, "acotanh(FatRat) - 0.785398163404734");
}

done;

# vim: ft=perl6 nomodifiable
