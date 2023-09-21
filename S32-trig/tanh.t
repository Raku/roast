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



# tanh tests

for @sines -> $angle
{
    next if abs(cosh($angle.key())) < 1e-6;
    my $desired-result = sinh($angle.key()) / cosh($angle.key());

    # Num.tanh tests -- very thorough
    is-approx($angle.key().tanh, $desired-result, 
              "Num.tanh - {$angle.key()}");

    # Complex.tanh tests -- also very thorough
    my Complex $zp0 = $angle.key + 0.0i;
    my Complex $sz0 = $desired-result + 0i;
    my Complex $zp1 = $angle.key + 1.0i;
    my Complex $sz1 = { sinh($_) / cosh($_) }($zp1);
    my Complex $zp2 = $angle.key + 2.0i;
    my Complex $sz2 = { sinh($_) / cosh($_) }($zp2);
    
    is-approx($zp0.tanh, $sz0, "Complex.tanh - $zp0");
    is-approx($zp1.tanh, $sz1, "Complex.tanh - $zp1");
    is-approx($zp2.tanh, $sz2, "Complex.tanh - $zp2");
}

#?niecza skip "Inf results wrong"
{
    is(tanh(Inf), 1, "tanh(Inf) -");
    is(tanh(-Inf), -1, "tanh(-Inf) -");
}
        
{
    # Num tests
    is-approx(tanh((-6.283185).Num), -0.999993025339611, "tanh(Num) - -6.283185");
}

{
    # Rat tests
    is-approx((-3.9269908).Rat(1e-9).tanh, -0.999223894878698, "Rat.tanh - -3.9269908");
    is-approx(tanh((-0.5235988).Rat(1e-9)), -0.480472778160188, "tanh(Rat) - -0.5235988");
}

{
    # Complex tests
    is-approx(tanh((0+2i).Complex), 0-2.18503986326152i, "tanh(Complex) - 0+2i");
}

{
    # Str tests
    is-approx((0.5235988).Str.tanh, 0.480472778160188, "Str.tanh - 0.5235988");
    is-approx(tanh((0.7853982).Str), 0.655794202636825, "tanh(Str) - 0.7853982");
}

{
    # NotComplex tests
    is-approx(NotComplex.new(1.57079632680947+2i).tanh, 1.05580658455051-0.0691882492979498i, "NotComplex.tanh - 1.57079632680947+2i");
    is-approx(tanh(NotComplex.new(2.3561944902142+2i)), 1.01171902215521-0.0137576097040009i, "tanh(NotComplex) - 2.3561944902142+2i");
}

{
    # DifferentReal tests
    is-approx(DifferentReal.new(3.141593).tanh, 0.996272076220967, "DifferentReal.tanh - 3.141593");
    is-approx(tanh(DifferentReal.new(3.9269908)), 0.999223894878698, "tanh(DifferentReal) - 3.9269908");
}

{
    # FatRat tests
    is-approx((4.7123890).FatRat.tanh, 0.999838613988647, "FatRat.tanh - 4.7123890");
    is-approx(tanh((5.4977871).FatRat), 0.999966448999799, "tanh(FatRat) - 5.4977871");
}


# atanh tests

for @sines -> $angle
{
    next if abs(cosh($angle.key())) < 1e-6;
    my $desired-result = sinh($angle.key()) / cosh($angle.key());

    # Num.atanh tests -- thorough
    is-approx($desired-result.Num.atanh.tanh, $desired-result, 
              "Num.atanh - {$angle.key()}");
    
    # Num.atanh(Complex) tests -- thorough
    for ($desired-result + 0i, $desired-result + .5i, $desired-result + 2i) -> $z {
        is-approx($z.atanh.tanh, $z, 
                  "Complex.atanh - $z");
    }
}
        
{
    # Num tests
    is-approx(atanh((0.480472778160188).Num), 0.5235988, "atanh(Num) - 0.5235988");
}

{
    # Rat tests
    is-approx(((0.655794202636825).Rat(1e-9)).atanh, 0.7853982, "Rat.atanh - 0.7853982");
    is-approx(atanh((0.480472778160188).Rat(1e-9)), 0.5235988, "atanh(Rat) - 0.5235988");
}

{
    # Complex tests
    is-approx(atanh((0.785398163404734+2i).Complex), 0.143655432578432+1.15296697280152i, "atanh(Complex) - 0.143655432578432+1.15296697280152i");
}

{
    # Str tests
    is-approx(((0.480472778160188).Str).atanh, 0.5235988, "Str.atanh - 0.5235988");
    is-approx(atanh((0.655794202636825).Str), 0.7853982, "atanh(Str) - 0.7853982");
}

{
    # NotComplex tests
    is-approx((NotComplex.new(0.523598775603156+2i)).atanh, 0.100612672097949+1.12836985373239i, "NotComplex.atanh - 0.100612672097949+1.12836985373239i");
    is-approx(atanh(NotComplex.new(0.785398163404734+2i)), 0.143655432578432+1.15296697280152i, "atanh(NotComplex) - 0.143655432578432+1.15296697280152i");
}

{
    # DifferentReal tests
    is-approx((DifferentReal.new(0.480472778160188)).atanh, 0.5235988, "DifferentReal.atanh - 0.5235988");
    is-approx(atanh(DifferentReal.new(0.655794202636825)), 0.7853982, "atanh(DifferentReal) - 0.7853982");
}

{
    # FatRat tests
    is-approx(((0.480472778160188).FatRat).atanh, 0.5235988, "FatRat.atanh - 0.5235988");
    is-approx(atanh((0.655794202636825).FatRat), 0.7853982, "atanh(FatRat) - 0.7853982");
}

done-testing;

# vim: ft=perl6 nomodifiable
