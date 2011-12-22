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



# cosec tests

my $iter_count = 0;
for @sines -> $angle
{
    next if abs(sin($angle.key())) < 1e-6;
    my $desired-result = 1.0 / sin($angle.key());

    # Num.cosec tests -- very thorough
    is_approx($angle.key().cosec, $desired-result, 
              "Num.cosec - {$angle.key()}");

    # Complex.cosec tests -- also very thorough
    my Complex $zp0 = $angle.key + 0.0i;
    my Complex $sz0 = $desired-result + 0i;
    my Complex $zp1 = $angle.key + 1.0i;
    my Complex $sz1 = { 1.0 / sin($_) }($zp1);
    my Complex $zp2 = $angle.key + 2.0i;
    my Complex $sz2 = { 1.0 / sin($_) }($zp2);
    
    is_approx($zp0.cosec, $sz0, "Complex.cosec - $zp0");
    is_approx($zp1.cosec, $sz1, "Complex.cosec - $zp1");
    is_approx($zp2.cosec, $sz2, "Complex.cosec - $zp2");
}


{
    is(cosec(Inf), NaN, "cosec(Inf) -");
    is(cosec(-Inf), NaN, "cosec(-Inf) -");
}
        
{
    # Num tests
    is_approx(cosec((-3.92699081702367).Num), 1.41421356232158, "cosec(Num) - -3.92699081702367");
}

{
    # Rat tests
    is_approx((-0.523598775603156).Rat(1e-9).cosec, -1.99999999998317, "Rat.cosec - -0.523598775603156");
    is_approx(cosec((0.523598775603156).Rat(1e-9)), 1.99999999998317, "cosec(Rat) - 0.523598775603156");
}

{
    # Complex tests
    is_approx(cosec((0.785398163404734 + 2i).Complex), 0.194833118738127 - 0.187824499973004i, "cosec(Complex) - 0.785398163404734 + 2i");
}

{
    # Str tests
    is_approx((1.57079632680947).Str.cosec, 1, "Str.cosec - 1.57079632680947");
    is_approx(cosec((2.3561944902142).Str), 1.41421356240401, "cosec(Str) - 2.3561944902142");
}

{
    # NotComplex tests
    is_approx(NotComplex.new(3.92699081702367 + 2i).cosec, -0.194833118743389 + 0.187824499967129i, "NotComplex.cosec - 3.92699081702367 + 2i");
    is_approx(cosec(NotComplex.new(4.7123889804284 + 2i)), -0.26580222883408 - 1.12015792238299e-11i, "cosec(NotComplex) - 4.7123889804284 + 2i");
}

#?niecza skip "DifferentReal math NY working"
{
    # DifferentReal tests
    is_approx(DifferentReal.new(5.49778714383314).cosec, -1.41421356244522, "DifferentReal.cosec - 5.49778714383314");
    is_approx(cosec(DifferentReal.new(6.80678408284103)), 1.99999999978126, "cosec(DifferentReal) - 6.80678408284103");
}


# acosec tests

for @sines -> $angle
{
    next if abs(sin($angle.key())) < 1e-6;
    my $desired-result = 1.0 / sin($angle.key());

    # Num.acosec tests -- thorough
    is_approx($desired-result.Num.acosec.cosec, $desired-result, 
              "Num.acosec - {$angle.key()}");
    
    # Num.acosec(Complex) tests -- thorough
    for ($desired-result + 0i, $desired-result + .5i, $desired-result + 2i) -> $z {
        is_approx($z.acosec.cosec, $z, 
                  "Complex.acosec - $z");
    }
}
        
{
    # Num tests
    is_approx(acosec((1.99999999998317).Num), 0.523598775603156, "acosec(Num) - 0.523598775603156");
}

{
    # Rat tests
    is_approx(((1.41421356236279).Rat(1e-9)).acosec, 0.785398163404734, "Rat.acosec - 0.785398163404734");
    is_approx(acosec((1.99999999998317).Rat(1e-9)), 0.523598775603156, "acosec(Rat) - 0.523598775603156");
}

{
    # Complex tests
    is_approx(acosec((0.785398163404734 + 2i).Complex), 0.156429673425433 - 0.425586400480703i, "acosec(Complex) - 0.156429673425433 - 0.425586400480703i");
}

{
    # Str tests
    is_approx(((1.99999999998317).Str).acosec, 0.523598775603156, "Str.acosec - 0.523598775603156");
    is_approx(acosec((1.41421356236279).Str), 0.785398163404734, "acosec(Str) - 0.785398163404734");
}

{
    # NotComplex tests
    is_approx((NotComplex.new(0.523598775603156 + 2i)).acosec, 0.11106127776165 - 0.454969900935893i, "NotComplex.acosec - 0.11106127776165 - 0.454969900935893i");
    is_approx(acosec(NotComplex.new(0.785398163404734 + 2i)), 0.156429673425433 - 0.425586400480703i, "acosec(NotComplex) - 0.156429673425433 - 0.425586400480703i");
}

#?niecza skip "DifferentReal math NY working"
{
    # DifferentReal tests
    is_approx((DifferentReal.new(1.99999999998317)).acosec, 0.523598775603156, "DifferentReal.acosec - 0.523598775603156");
    is_approx(acosec(DifferentReal.new(1.41421356236279)), 0.785398163404734, "acosec(DifferentReal) - 0.785398163404734");
}

done;

# vim: ft=perl6 nomodifiable
