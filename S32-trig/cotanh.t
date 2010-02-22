# WARNING:
# This is a generated file and should not be edited directly.
# look into generate-tests.pl instead
use v6;
use Test;
plan *;

# This class, designed to help simplify the tests, is very much in a transitional
# state.  But it works as well as the previous version at the moment.  I'm checking
# it in just to clean up my local build (and save a remote copy as I take my
# the machine it lives on vacation).  Should have more updates to this over the 
# next several days.  --colomon, Sept 3rd 2009.

class AngleAndResult
{
    has $.angle_in_degrees;
    has $.result;

    our @radians-to-whatever = (1, 180 / pi, 200 / pi, 1 / (2 * pi));
    our @degrees-to-whatever = ((312689/99532) / 180, 1, 200 / 180, 1 / 360);
    our @degrees-to-whatever-num = @degrees-to-whatever.map({ .Num });

    multi method new(Int $angle_in_degrees is copy, $result is copy) {
        self.bless(*, :$angle_in_degrees, :$result);
    }
    
    method complex($imaginary_part_in_radians, $base) {
        my $z_in_radians = $.angle_in_degrees / 180.0 * pi + ($imaginary_part_in_radians)i;
		$z_in_radians * @radians-to-whatever[$base];
    }
    
    method num($base) {
		$.angle_in_degrees * @degrees-to-whatever-num[$base];
    }
    
    method rat($base) {
		$.angle_in_degrees * @degrees-to-whatever[$base];
    }
    
    method int($base) {
        $.angle_in_degrees;
    }
}

my @sines = ( 
    AngleAndResult.new(-360, 0),
    AngleAndResult.new(135 - 360, 1/2*sqrt(2)),
    AngleAndResult.new(330 - 360, -0.5),
    AngleAndResult.new(0, 0),
    AngleAndResult.new(30, 0.5),
    AngleAndResult.new(45, 1/2*sqrt(2)),
    AngleAndResult.new(90, 1),
    AngleAndResult.new(135, 1/2*sqrt(2)),
    AngleAndResult.new(180, 0),
    AngleAndResult.new(225, -1/2*sqrt(2)),
    AngleAndResult.new(270, -1),
    AngleAndResult.new(315, -1/2*sqrt(2)),
    AngleAndResult.new(360, 0),
    AngleAndResult.new(30 + 360, 0.5),
    AngleAndResult.new(225 + 360, -1/2*sqrt(2)),
    AngleAndResult.new(720, 0)
);

my @cosines = @sines.map({ AngleAndResult.new($_.angle_in_degrees - 90, $_.result) });

my @sinhes = @sines.grep({ $_.angle_in_degrees < 500 }).map({ AngleAndResult.new($_.angle_in_degrees, 
                                             (exp($_.num(Radians)) - exp(-$_.num(Radians))) / 2.0)});

my @coshes = @sines.grep({ $_.angle_in_degrees < 500 }).map({ AngleAndResult.new($_.angle_in_degrees, 
                                             (exp($_.num(Radians)) + exp(-$_.num(Radians))) / 2.0)});

my @official_bases = (Radians, Degrees, Gradians, Circles);

# cotanh tests

for @sines -> $angle
{
    	next if abs(sinh($angle.num('radians'))) < 1e-6; 	my $desired_result = cosh($angle.num('radians')) / sinh($angle.num('radians'));

    # cotanh(Num)
    is_approx(cotanh($angle.num(Radians)), $desired_result, 
              "cotanh(Num) - {$angle.num(Radians)} default");
    for @official_bases -> $base {
        is_approx(cotanh($angle.num($base), $base), $desired_result, 
                  "cotanh(Num) - {$angle.num($base)} $base");
    }
    
    # cotanh(:x(Num))
    is_approx(cotanh(:x($angle.num(Radians))), $desired_result, 
              "cotanh(:x(Num)) - {$angle.num(Radians)} default");
    for @official_bases -> $base {
        is_approx(cotanh(:x($angle.num($base)), :base($base)), $desired_result, 
                  "cotanh(:x(Num)) - {$angle.num($base)} $base");
    }

    # Num.cotanh tests
    is_approx($angle.num(Radians).cotanh, $desired_result, 
              "Num.cotanh - {$angle.num(Radians)} default");
    for @official_bases -> $base {
        is_approx($angle.num($base).cotanh($base), $desired_result, 
                  "Num.cotanh - {$angle.num($base)} $base");
    }

    # cotanh(Rat)
    is_approx(cotanh($angle.rat(Radians)), $desired_result, 
              "cotanh(Rat) - {$angle.rat(Radians)} default");
    for @official_bases -> $base {
        is_approx(cotanh($angle.rat($base), $base), $desired_result, 
                  "cotanh(Rat) - {$angle.rat($base)} $base");
    }

    # cotanh(:x(Rat))
    is_approx(cotanh(:x($angle.rat(Radians))), $desired_result, 
              "cotanh(:x(Rat)) - {$angle.rat(Radians)} default");
    for @official_bases -> $base {
        is_approx(cotanh(:x($angle.rat($base)), :base($base)), $desired_result, 
                  "cotanh(:x(Rat)) - {$angle.rat($base)} $base");
    }

    # Rat.cotanh tests
    is_approx($angle.rat(Radians).cotanh, $desired_result, 
              "Rat.cotanh - {$angle.rat(Radians)} default");
    for @official_bases -> $base {
        is_approx($angle.rat($base).cotanh($base), $desired_result, 
                  "Rat.cotanh - {$angle.rat($base)} $base");
    }

    # cotanh(Int)
    is_approx(cotanh($angle.int(Degrees), Degrees), $desired_result, 
              "cotanh(Int) - {$angle.int(Degrees)} degrees");
    is_approx($angle.int(Degrees).cotanh(Degrees), $desired_result, 
              "Int.cotanh - {$angle.int(Degrees)} degrees");

    # Complex tests
    my Complex $zp0 = $angle.complex(0.0, Radians);
    my Complex $sz0 = $desired_result + 0i;
    my Complex $zp1 = $angle.complex(1.0, Radians);
    my Complex $sz1 = { cosh($_) / sinh ($_) }($zp1);
    my Complex $zp2 = $angle.complex(2.0, Radians);
    my Complex $sz2 = { cosh($_) / sinh ($_) }($zp2);
    
    # cotanh(Complex) tests
    is_approx(cotanh($zp0), $sz0, "cotanh(Complex) - $zp0 default");
    is_approx(cotanh($zp1), $sz1, "cotanh(Complex) - $zp1 default");
    is_approx(cotanh($zp2), $sz2, "cotanh(Complex) - $zp2 default");
    
    for @official_bases -> $base {
        my Complex $z = $angle.complex(0.0, $base);
        is_approx(cotanh($z, $base), $sz0, "cotanh(Complex) - $z $base");
    
        $z = $angle.complex(1.0, $base);
        is_approx(cotanh($z, $base), $sz1, "cotanh(Complex) - $z $base");
                        
        $z = $angle.complex(2.0, $base);
        is_approx(cotanh($z, $base), $sz2, "cotanh(Complex) - $z $base");
    }
    
    # Complex.cotanh tests
    is_approx($zp0.cotanh, $sz0, "Complex.cotanh - $zp0 default");
    is_approx($zp1.cotanh, $sz1, "Complex.cotanh - $zp1 default");
    is_approx($zp2.cotanh, $sz2, "Complex.cotanh - $zp2 default");
    
    for @official_bases -> $base {
        my Complex $z = $angle.complex(0.0, $base);
        is_approx($z.cotanh($base), $sz0, "Complex.cotanh - $z $base");
    
        $z = $angle.complex(1.0, $base);
        is_approx($z.cotanh($base), $sz1, "Complex.cotanh - $z $base");
    
        $z = $angle.complex(2.0, $base);
        is_approx($z.cotanh($base), $sz2, "Complex.cotanh - $z $base");
    }
}

is(cotanh(Inf), 1, "cotanh(Inf) - default");
is(cotanh(-Inf), -1, "cotanh(-Inf) - default");
for @official_bases -> $base
{
    is(cotanh(Inf,  $base), 1, "cotanh(Inf) - $base");
    is(cotanh(-Inf, $base), -1, "cotanh(-Inf) - $base");
}
        

# acotanh tests

for @sines -> $angle
{
    	next if abs(sinh($angle.num('radians'))) < 1e-6; 	my $desired_result = cosh($angle.num('radians')) / sinh($angle.num('radians'));

    # acotanh(Num) tests
    is_approx(cotanh(acotanh($desired_result)), $desired_result, 
              "acotanh(Num) - {$angle.num(Radians)} default");
    for @official_bases -> $base {
        is_approx(cotanh(acotanh($desired_result, $base), $base), $desired_result, 
                  "acotanh(Num) - {$angle.num($base)} $base");
    }
    
    # acotanh(:x(Num))
    is_approx(cotanh(acotanh(:x($desired_result))), $desired_result, 
              "acotanh(:x(Num)) - {$angle.num(Radians)} default");
    for @official_bases -> $base {
        is_approx(cotanh(acotanh(:x($desired_result), 
                                                           :base($base)), 
                                  $base), $desired_result, 
                  "acotanh(:x(Num)) - {$angle.num($base)} $base");
    }
    
    # Num.acotanh tests
    is_approx($desired_result.Num.acotanh.cotanh, $desired_result, 
              "Num.acotanh - {$angle.num(Radians)} default");
    for @official_bases -> $base {
        is_approx($desired_result.Num.acotanh($base).cotanh($base), $desired_result,
                  "Num.acotanh - {$angle.num($base)} $base");
    }
    
    # acotanh(Complex) tests
    for ($desired_result + 0i, $desired_result + .5i, $desired_result + 2i) -> $z {
        is_approx(cotanh(acotanh($z)), $z, 
                  "acotanh(Complex) - {$angle.num(Radians)} default");
        for @official_bases -> $base {
            is_approx(cotanh(acotanh($z, $base), $base), $z, 
                      "acotanh(Complex) - {$angle.num($base)} $base");
        }
        is_approx($z.acotanh.cotanh, $z, 
                  "Complex.acotanh - {$angle.num(Radians)} default");
        for @official_bases -> $base {
            is_approx($z.acotanh($base).cotanh($base), $z, 
                      "Complex.acotanh - {$angle.num($base)} $base");
        }
    }
}

for (-4/2, -3/2, 3/2, 4/2) -> $desired_result
{
    # acotanh(Rat) tests
    is_approx(cotanh(acotanh($desired_result)), $desired_result, 
              "acotanh(Rat) - $desired_result default");
    for @official_bases -> $base {
        is_approx(cotanh(acotanh($desired_result, $base), $base), $desired_result, 
                  "acotanh(Rat) - $desired_result $base");
    }
    
    # Rat.acotanh tests
    is_approx($desired_result.acotanh.cotanh, $desired_result, 
              "Rat.acotanh - $desired_result default");
    for @official_bases -> $base {
        is_approx($desired_result.acotanh($base).cotanh($base), $desired_result,
                  "Rat.acotanh - $desired_result $base");
    }
    
    next unless $desired_result.denominator == 1;
    
    # acotanh(Int) tests
    is_approx(cotanh(acotanh($desired_result.numerator)), $desired_result, 
              "acotanh(Int) - $desired_result default");
    for @official_bases -> $base {
        is_approx(cotanh(acotanh($desired_result.numerator, $base), $base), $desired_result, 
                  "acotanh(Int) - $desired_result $base");
    }
    
    # Int.acotanh tests
    is_approx($desired_result.numerator.acotanh.cotanh, $desired_result, 
              "Int.acotanh - $desired_result default");
    for @official_bases -> $base {
        is_approx($desired_result.numerator.acotanh($base).cotanh($base), $desired_result,
                  "Int.acotanh - $desired_result $base");
    }
}
        
done_testing;

# vim: ft=perl6 nomodifiable
