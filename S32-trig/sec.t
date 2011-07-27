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



# sec tests

my $iter_count = 0;
for @cosines -> $angle
{
    next if abs(cos($angle.key())) < 1e-6;
    my $desired-result = 1.0 / cos($angle.key());

    # Num.sec tests -- very thorough
    is_approx($angle.key().sec, $desired-result, 
              "Num.sec - {$angle.key()}");

    # Complex.sec tests -- also very thorough
    my Complex $zp0 = $angle.key + 0.0i;
    my Complex $sz0 = $desired-result + 0i;
    my Complex $zp1 = $angle.key + 1.0i;
    my Complex $sz1 = { 1.0 / cos($_) }($zp1);
    my Complex $zp2 = $angle.key + 2.0i;
    my Complex $sz2 = { 1.0 / cos($_) }($zp2);
    
    is_approx($zp0.sec, $sz0, "Complex.sec - $zp0");
    is_approx($zp1.sec, $sz1, "Complex.sec - $zp1");
    is_approx($zp2.sec, $sz2, "Complex.sec - $zp2");
}

{
    is(sec(Inf), NaN, "sec(Inf) -");
    is(sec(-Inf), NaN, "sec(-Inf) -");
}
        
{
    # Num tests
    is_approx(sec((-5.49778714383314).Num), 1.41421356230097, "sec(Num) - -5.49778714383314");
    is_approx(sec(:x((-2.09439510241262).Num)), -1.9999999999327, "sec(:x(Num)) - -2.09439510241262");
}

{
    # Rat tests
    is_approx((-1.04719755120631).Rat(1e-9).sec, 2.00000000003365, "Rat.sec - -1.04719755120631");
    is_approx(sec((-0.785398163404734).Rat(1e-9)), 1.4142135623834, "sec(Rat) - -0.785398163404734");
    is_approx(sec(:x((0).Rat(1e-9))), 1, "sec(:x(Rat)) - 0");
}

{
    # Complex tests
    is_approx(sec((0.785398163404734 + 2i).Complex), 0.194833118735496 + 0.187824499975941i, "sec(Complex) - 0.785398163404734 + 2i");
    is_approx(sec(:x((2.3561944902142 + 2i).Complex)), -0.194833118740758 + 0.187824499970067i, "sec(:x(Complex)) - 2.3561944902142 + 2i");
}

{
    # Str tests
    is_approx((3.14159265361894).Str.sec, -1, "Str.sec - 3.14159265361894");
    is_approx(sec((3.92699081702367).Str), -1.41421356242461, "sec(Str) - 3.92699081702367");
    is_approx(sec(:x((5.23598775603156).Str)), 1.99999999983174, "sec(:x(Str)) - 5.23598775603156");
}

{
    # NotComplex tests
    is_approx(NotComplex.new(8.63937979745208 + 2i).sec, -0.194833118751283 + 0.187824499958317i, "NotComplex.sec - 8.63937979745208 + 2i");
    is_approx(sec(NotComplex.new(-5.49778714383314 + 2i)), 0.19483311874602 + 0.187824499964192i, "sec(NotComplex) - -5.49778714383314 + 2i");
    is_approx(sec(:x(NotComplex.new(-2.09439510241262 + 2i))), -0.140337325261927 - 0.234327511876613i, "sec(:x(NotComplex)) - -2.09439510241262 + 2i");
}

{
    # DifferentReal tests
    is_approx(DifferentReal.new(-1.04719755120631).sec, 2.00000000003365, "DifferentReal.sec - -1.04719755120631");
    is_approx(sec(DifferentReal.new(-0.785398163404734)), 1.4142135623834, "sec(DifferentReal) - -0.785398163404734");
    is_approx(sec(:x(DifferentReal.new(0))), 1, "sec(:x(DifferentReal)) - 0");
}


# asec tests

for @cosines -> $angle
{
    next if abs(cos($angle.key())) < 1e-6;
    my $desired-result = 1.0 / cos($angle.key());

    # Num.asec tests -- thorough
    is_approx($desired-result.Num.asec.sec, $desired-result, 
              "Num.asec - {$angle.key()}");
    
    # Num.asec(Complex) tests -- thorough
    for ($desired-result + 0i, $desired-result + .5i, $desired-result + 2i) -> $z {
        is_approx(sec(asec($z)), $z, 
                  "asec(Complex) - {$angle.key()}");
        is_approx($z.asec.sec, $z, 
                  "Complex.asec - {$angle.key()}");
    }
}
        
{
    # Num tests
    is_approx(asec((1.4142135623834).Num), 0.785398163404734, "asec(Num) - 0.785398163404734");
    is_approx(asec(:x((1.4142135623834).Num)), 0.785398163404734, "asec(:x(Num)) - 0.785398163404734");
}

{
    # Rat tests
    is_approx(((1.4142135623834).Rat(1e-9)).asec, 0.785398163404734, "Rat.asec - 0.785398163404734");
    is_approx(asec((1.4142135623834).Rat(1e-9)), 0.785398163404734, "asec(Rat) - 0.785398163404734");
    is_approx(asec(:x((1.4142135623834).Rat(1e-9))), 0.785398163404734, "asec(:x(Rat)) - 0.785398163404734");
}

{
    # Complex tests
    is_approx(asec((0.785398163404734 + 2i).Complex), 1.41436665336946 + 0.425586400480703i, "asec(Complex) - 1.41436665336946 + 0.425586400480703i");
    is_approx(asec(:x((0.785398163404734 + 2i).Complex)), 1.41436665336946 + 0.425586400480703i, "asec(:x(Complex)) - 1.41436665336946 + 0.425586400480703i");
}

{
    # Str tests
    is_approx(((1.4142135623834).Str).asec, 0.785398163404734, "Str.asec - 0.785398163404734");
    is_approx(asec((1.4142135623834).Str), 0.785398163404734, "asec(Str) - 0.785398163404734");
    is_approx(asec(:x((1.4142135623834).Str)), 0.785398163404734, "asec(:x(Str)) - 0.785398163404734");
}

{
    # NotComplex tests
    is_approx((NotComplex.new(0.785398163404734 + 2i)).asec, 1.41436665336946 + 0.425586400480703i, "NotComplex.asec - 1.41436665336946 + 0.425586400480703i");
    is_approx(asec(NotComplex.new(0.785398163404734 + 2i)), 1.41436665336946 + 0.425586400480703i, "asec(NotComplex) - 1.41436665336946 + 0.425586400480703i");
    is_approx(asec(:x(NotComplex.new(0.785398163404734 + 2i))), 1.41436665336946 + 0.425586400480703i, "asec(:x(NotComplex)) - 1.41436665336946 + 0.425586400480703i");
}

{
    # DifferentReal tests
    is_approx((DifferentReal.new(1.4142135623834)).asec, 0.785398163404734, "DifferentReal.asec - 0.785398163404734");
    is_approx(asec(DifferentReal.new(1.4142135623834)), 0.785398163404734, "asec(DifferentReal) - 0.785398163404734");
    is_approx(asec(:x(DifferentReal.new(1.4142135623834))), 0.785398163404734, "asec(:x(DifferentReal)) - 0.785398163404734");
}

done;

# vim: ft=perl6 nomodifiable
