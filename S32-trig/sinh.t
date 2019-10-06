use v6;
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



# sinh tests

for @sinhes -> $angle
{
    
    my $desired-result = $angle.value;

    # Num.sinh tests -- very thorough
    is-approx($angle.key().sinh, $desired-result, 
              "Num.sinh - {$angle.key()}");

    # Complex.sinh tests -- also very thorough
    my Complex $zp0 = $angle.key + 0.0i;
    my Complex $sz0 = $desired-result + 0i;
    my Complex $zp1 = $angle.key + 1.0i;
    my Complex $sz1 = { (exp($_) - exp(-$_)) / 2 }($zp1);
    my Complex $zp2 = $angle.key + 2.0i;
    my Complex $sz2 = { (exp($_) - exp(-$_)) / 2 }($zp2);
    
    is-approx($zp0.sinh, $sz0, "Complex.sinh - $zp0");
    is-approx($zp1.sinh, $sz1, "Complex.sinh - $zp1");
    is-approx($zp2.sinh, $sz2, "Complex.sinh - $zp2");
}

{
    is(sinh(Inf), Inf, "sinh(Inf) -");
    is(sinh(-Inf), -Inf, "sinh(-Inf) -");
}
        
{
    # Num tests
    is-approx(sinh((-6.283185).Num), -267.744894056623, "sinh(Num) - -6.283185");
}

{
    # Rat tests
    is-approx((-3.9269908).Rat(1e-9).sinh, -25.367158320299, "Rat.sinh - -3.9269908");
    is-approx(sinh((-0.5235988).Rat(1e-9)), -0.547853473893578, "sinh(Rat) - -0.5235988");
}

{
    # Complex tests
    is-approx(sinh((0+2i).Complex), -0+0.909297426825682i, "sinh(Complex) - 0+2i");
}

{
    # Str tests
    is-approx((0.5235988).Str.sinh, 0.547853473893578, "Str.sinh - 0.5235988");
    is-approx(sinh((0.7853982).Str), 0.86867096149566, "sinh(Str) - 0.7853982");
}

{
    # NotComplex tests
    is-approx(NotComplex.new(1.57079632680947+2i).sinh, -0.957678258159807+2.28158953412064i, "NotComplex.sinh - 1.57079632680947+2i");
    is-approx(sinh(NotComplex.new(2.3561944902142+2i)), -2.17560397806036+4.83996483329327i, "sinh(NotComplex) - 2.3561944902142+2i");
}

{
    # DifferentReal tests
    is-approx(DifferentReal.new(3.141593).sinh, 11.5487393575956, "DifferentReal.sinh - 3.141593");
    is-approx(sinh(DifferentReal.new(3.9269908)), 25.367158320299, "sinh(DifferentReal) - 3.9269908");
}

{
    # FatRat tests
    is-approx((4.7123890).FatRat.sinh, 55.6543976018509, "FatRat.sinh - 4.7123890");
    is-approx(sinh((5.4977871).FatRat), 122.073483520919, "sinh(FatRat) - 5.4977871");
}


# asinh tests

for @sinhes -> $angle
{
    
    my $desired-result = $angle.value;

    # Num.asinh tests -- thorough
    is-approx($desired-result.Num.asinh.sinh, $desired-result, 
              "Num.asinh - {$angle.key()}");
    
    # Num.asinh(Complex) tests -- thorough
    for ($desired-result + 0i, $desired-result + .5i, $desired-result + 2i) -> $z {
        is-approx($z.asinh.sinh, $z, 
                  "Complex.asinh - $z");
    }
}
        
{
    # Num tests
    is-approx(asinh((0.547853473893578).Num), 0.5235988, "asinh(Num) - 0.5235988");
}

{
    # Rat tests
    is-approx(((0.86867096149566).Rat(1e-9)).asinh, 0.7853982, "Rat.asinh - 0.7853982");
    is-approx(asinh((0.547853473893578).Rat(1e-9)), 0.5235988, "asinh(Rat) - 0.5235988");
}

{
    # Complex tests
    is-approx(asinh((0.785398163404734+2i).Complex), 1.41841325789332+1.15495109689711i, "asinh(Complex) - 1.41841325789332+1.15495109689711i");
}

{
    # Str tests
    is-approx(((0.547853473893578).Str).asinh, 0.5235988, "Str.asinh - 0.5235988");
    is-approx(asinh((0.86867096149566).Str), 0.7853982, "asinh(Str) - 0.7853982");
}

{
    # NotComplex tests
    is-approx((NotComplex.new(0.523598775603156+2i)).asinh, 1.365827718396+1.28093108055158i, "NotComplex.asinh - 1.365827718396+1.28093108055158i");
    is-approx(asinh(NotComplex.new(0.785398163404734+2i)), 1.41841325789332+1.15495109689711i, "asinh(NotComplex) - 1.41841325789332+1.15495109689711i");
}

{
    # DifferentReal tests
    is-approx((DifferentReal.new(0.547853473893578)).asinh, 0.5235988, "DifferentReal.asinh - 0.5235988");
    is-approx(asinh(DifferentReal.new(0.86867096149566)), 0.7853982, "asinh(DifferentReal) - 0.7853982");
}

{
    # FatRat tests
    is-approx(((0.547853473893578).FatRat).asinh, 0.5235988, "FatRat.asinh - 0.5235988");
    is-approx(asinh((0.86867096149566).FatRat), 0.7853982, "asinh(FatRat) - 0.7853982");
}

{
    ok (1, * * 10 ... * > 1e40).map({-.asinh == asinh(-$_)}).all, "asinh(x) equals -asinh(-x) for huge values";
}

done-testing;

# vim: ft=perl6 nomodifiable
