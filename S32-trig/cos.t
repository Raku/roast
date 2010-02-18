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

    INIT {
        our @radians-to-whatever = (1, 180 / pi, 200 / pi, 1 / (2 * pi));
        our @degrees-to-whatever = ((312689/99532) / 180, 1, 200 / 180, 1 / 360);
        our @degrees-to-whatever-num = @degrees-to-whatever.map({ .Num });
    }

    multi method new(Int $angle_in_degrees is copy, $result is copy) {
        self.bless(*, :$angle_in_degrees, :$result);
    }
    
    method complex($imaginary_part_in_radians, $base) {
        my $z_in_radians = $.angle_in_degrees / 180.0 * pi + ($imaginary_part_in_radians)i;
		$z_in_radians * pir::get_global__Ps('@radians-to-whatever')[$base];
    }
    
    method num($base) {
		$.angle_in_degrees * pir::get_global__Ps('@degrees-to-whatever-num')[$base];
    }
    
    method rat($base) {
		$.angle_in_degrees * pir::get_global__Ps('@degrees-to-whatever')[$base];
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

# cos tests

for @cosines -> $angle
{
    	my $desired_result = $angle.result;

    # cos(Num)
    is_approx(cos($angle.num(Radians)), $desired_result, 
              "cos(Num) - {$angle.num(Radians)} default");
    for @official_bases -> $base {
        is_approx(cos($angle.num($base), $base), $desired_result, 
                  "cos(Num) - {$angle.num($base)} $base");
    }
    
    # cos(:x(Num))
    is_approx(cos(:x($angle.num(Radians))), $desired_result, 
              "cos(:x(Num)) - {$angle.num(Radians)} default");
    for @official_bases -> $base {
        is_approx(cos(:x($angle.num($base)), :base($base)), $desired_result, 
                  "cos(:x(Num)) - {$angle.num($base)} $base");
    }

    # Num.cos tests
    is_approx($angle.num(Radians).cos, $desired_result, 
              "Num.cos - {$angle.num(Radians)} default");
    for @official_bases -> $base {
        is_approx($angle.num($base).cos($base), $desired_result, 
                  "Num.cos - {$angle.num($base)} $base");
    }

    # cos(Rat)
    is_approx(cos($angle.rat(Radians)), $desired_result, 
              "cos(Rat) - {$angle.rat(Radians)} default");
    for @official_bases -> $base {
        is_approx(cos($angle.rat($base), $base), $desired_result, 
                  "cos(Rat) - {$angle.rat($base)} $base");
    }

    # cos(:x(Rat))
    is_approx(cos(:x($angle.rat(Radians))), $desired_result, 
              "cos(:x(Rat)) - {$angle.rat(Radians)} default");
    for @official_bases -> $base {
        is_approx(cos(:x($angle.rat($base)), :base($base)), $desired_result, 
                  "cos(:x(Rat)) - {$angle.rat($base)} $base");
    }

    # Rat.cos tests
    is_approx($angle.rat(Radians).cos, $desired_result, 
              "Rat.cos - {$angle.rat(Radians)} default");
    for @official_bases -> $base {
        is_approx($angle.rat($base).cos($base), $desired_result, 
                  "Rat.cos - {$angle.rat($base)} $base");
    }

    # cos(Int)
    is_approx(cos($angle.int(Degrees), Degrees), $desired_result, 
              "cos(Int) - {$angle.int(Degrees)} degrees");
    is_approx($angle.int(Degrees).cos(Degrees), $desired_result, 
              "Int.cos - {$angle.int(Degrees)} degrees");

    # Complex tests
    my Complex $zp0 = $angle.complex(0.0, Radians);
    my Complex $sz0 = $desired_result + 0i;
    my Complex $zp1 = $angle.complex(1.0, Radians);
    my Complex $sz1 = { (exp($_ * 1i) + exp(-$_ * 1i)) / 2 }($zp1);
    my Complex $zp2 = $angle.complex(2.0, Radians);
    my Complex $sz2 = { (exp($_ * 1i) + exp(-$_ * 1i)) / 2 }($zp2);
    
    # cos(Complex) tests
    is_approx(cos($zp0), $sz0, "cos(Complex) - $zp0 default");
    is_approx(cos($zp1), $sz1, "cos(Complex) - $zp1 default");
    is_approx(cos($zp2), $sz2, "cos(Complex) - $zp2 default");
    
    for @official_bases -> $base {
        my Complex $z = $angle.complex(0.0, $base);
        is_approx(cos($z, $base), $sz0, "cos(Complex) - $z $base");
    
        $z = $angle.complex(1.0, $base);
        is_approx(cos($z, $base), $sz1, "cos(Complex) - $z $base");
                        
        $z = $angle.complex(2.0, $base);
        is_approx(cos($z, $base), $sz2, "cos(Complex) - $z $base");
    }
    
    # Complex.cos tests
    is_approx($zp0.cos, $sz0, "Complex.cos - $zp0 default");
    is_approx($zp1.cos, $sz1, "Complex.cos - $zp1 default");
    is_approx($zp2.cos, $sz2, "Complex.cos - $zp2 default");
    
    for @official_bases -> $base {
        my Complex $z = $angle.complex(0.0, $base);
        is_approx($z.cos($base), $sz0, "Complex.cos - $z $base");
    
        $z = $angle.complex(1.0, $base);
        is_approx($z.cos($base), $sz1, "Complex.cos - $z $base");
    
        $z = $angle.complex(2.0, $base);
        is_approx($z.cos($base), $sz2, "Complex.cos - $z $base");
    }
}

is(cos(Inf), NaN, "cos(Inf) - default");
is(cos(-Inf), NaN, "cos(-Inf) - default");
for @official_bases -> $base
{
    is(cos(Inf,  $base), NaN, "cos(Inf) - $base");
    is(cos(-Inf, $base), NaN, "cos(-Inf) - $base");
}
        

# acos tests

for @cosines -> $angle
{
    	my $desired_result = $angle.result;

    # acos(Num) tests
    is_approx(cos(acos($desired_result)), $desired_result, 
              "acos(Num) - {$angle.num(Radians)} default");
    for @official_bases -> $base {
        is_approx(cos(acos($desired_result, $base), $base), $desired_result, 
                  "acos(Num) - {$angle.num($base)} $base");
    }
    
    # acos(:x(Num))
    is_approx(cos(acos(:x($desired_result))), $desired_result, 
              "acos(:x(Num)) - {$angle.num(Radians)} default");
    for @official_bases -> $base {
        is_approx(cos(acos(:x($desired_result), 
                                                           :base($base)), 
                                  $base), $desired_result, 
                  "acos(:x(Num)) - {$angle.num($base)} $base");
    }
    
    # Num.acos tests
    is_approx($desired_result.Num.acos.cos, $desired_result, 
              "Num.acos - {$angle.num(Radians)} default");
    for @official_bases -> $base {
        is_approx($desired_result.Num.acos($base).cos($base), $desired_result,
                  "Num.acos - {$angle.num($base)} $base");
    }
    
    # acos(Complex) tests
    for ($desired_result + 0i, $desired_result + .5i, $desired_result + 2i) -> $z {
        is_approx(cos(acos($z)), $z, 
                  "acos(Complex) - {$angle.num(Radians)} default");
        for @official_bases -> $base {
            is_approx(cos(acos($z, $base), $base), $z, 
                      "acos(Complex) - {$angle.num($base)} $base");
        }
        is_approx($z.acos.cos, $z, 
                  "Complex.acos - {$angle.num(Radians)} default");
        for @official_bases -> $base {
            is_approx($z.acos($base).cos($base), $z, 
                      "Complex.acos - {$angle.num($base)} $base");
        }
    }
}

for (-2/2, -1/2, 1/2, 2/2) -> $desired_result
{
    # acos(Rat) tests
    is_approx(cos(acos($desired_result)), $desired_result, 
              "acos(Rat) - $desired_result default");
    for @official_bases -> $base {
        is_approx(cos(acos($desired_result, $base), $base), $desired_result, 
                  "acos(Rat) - $desired_result $base");
    }
    
    # Rat.acos tests
    is_approx($desired_result.acos.cos, $desired_result, 
              "Rat.acos - $desired_result default");
    for @official_bases -> $base {
        is_approx($desired_result.acos($base).cos($base), $desired_result,
                  "Rat.acos - $desired_result $base");
    }
    
    next unless $desired_result.denominator == 1;
    
    # acos(Int) tests
    is_approx(cos(acos($desired_result.numerator)), $desired_result, 
              "acos(Int) - $desired_result default");
    for @official_bases -> $base {
        is_approx(cos(acos($desired_result.numerator, $base), $base), $desired_result, 
                  "acos(Int) - $desired_result $base");
    }
    
    # Int.acos tests
    is_approx($desired_result.numerator.acos.cos, $desired_result, 
              "Int.acos - $desired_result default");
    for @official_bases -> $base {
        is_approx($desired_result.numerator.acos($base).cos($base), $desired_result,
                  "Int.acos - $desired_result $base");
    }
}
        
done_testing;

# vim: ft=perl6 nomodifiable
