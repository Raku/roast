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

# sinh tests

for @sinhes -> $angle
{
    	my $desired_result = $angle.result;

    # sinh(Num)
    is_approx(sinh($angle.num(Radians)), $desired_result, 
              "sinh(Num) - {$angle.num(Radians)} default");
    for @official_bases -> $base {
        is_approx(sinh($angle.num($base), $base), $desired_result, 
                  "sinh(Num) - {$angle.num($base)} $base");
    }
    
    # sinh(:x(Num))
    is_approx(sinh(:x($angle.num(Radians))), $desired_result, 
              "sinh(:x(Num)) - {$angle.num(Radians)} default");
    for @official_bases -> $base {
        is_approx(sinh(:x($angle.num($base)), :base($base)), $desired_result, 
                  "sinh(:x(Num)) - {$angle.num($base)} $base");
    }

    # Num.sinh tests
    is_approx($angle.num(Radians).sinh, $desired_result, 
              "Num.sinh - {$angle.num(Radians)} default");
    for @official_bases -> $base {
        is_approx($angle.num($base).sinh($base), $desired_result, 
                  "Num.sinh - {$angle.num($base)} $base");
    }

    # sinh(Rat)
    is_approx(sinh($angle.rat(Radians)), $desired_result, 
              "sinh(Rat) - {$angle.rat(Radians)} default");
    for @official_bases -> $base {
        is_approx(sinh($angle.rat($base), $base), $desired_result, 
                  "sinh(Rat) - {$angle.rat($base)} $base");
    }

    # sinh(:x(Rat))
    is_approx(sinh(:x($angle.rat(Radians))), $desired_result, 
              "sinh(:x(Rat)) - {$angle.rat(Radians)} default");
    for @official_bases -> $base {
        is_approx(sinh(:x($angle.rat($base)), :base($base)), $desired_result, 
                  "sinh(:x(Rat)) - {$angle.rat($base)} $base");
    }

    # Rat.sinh tests
    is_approx($angle.rat(Radians).sinh, $desired_result, 
              "Rat.sinh - {$angle.rat(Radians)} default");
    for @official_bases -> $base {
        is_approx($angle.rat($base).sinh($base), $desired_result, 
                  "Rat.sinh - {$angle.rat($base)} $base");
    }

    # sinh(Int)
    is_approx(sinh($angle.int(Degrees), Degrees), $desired_result, 
              "sinh(Int) - {$angle.int(Degrees)} degrees");
    is_approx($angle.int(Degrees).sinh(Degrees), $desired_result, 
              "Int.sinh - {$angle.int(Degrees)} degrees");

    # Complex tests
    my Complex $zp0 = $angle.complex(0.0, Radians);
    my Complex $sz0 = $desired_result + 0i;
    my Complex $zp1 = $angle.complex(1.0, Radians);
    my Complex $sz1 = { (exp($_) - exp(-$_)) / 2 }($zp1);
    my Complex $zp2 = $angle.complex(2.0, Radians);
    my Complex $sz2 = { (exp($_) - exp(-$_)) / 2 }($zp2);
    
    # sinh(Complex) tests
    is_approx(sinh($zp0), $sz0, "sinh(Complex) - $zp0 default");
    is_approx(sinh($zp1), $sz1, "sinh(Complex) - $zp1 default");
    is_approx(sinh($zp2), $sz2, "sinh(Complex) - $zp2 default");
    
    for @official_bases -> $base {
        my Complex $z = $angle.complex(0.0, $base);
        is_approx(sinh($z, $base), $sz0, "sinh(Complex) - $z $base");
    
        $z = $angle.complex(1.0, $base);
        is_approx(sinh($z, $base), $sz1, "sinh(Complex) - $z $base");
                        
        $z = $angle.complex(2.0, $base);
        is_approx(sinh($z, $base), $sz2, "sinh(Complex) - $z $base");
    }
    
    # Complex.sinh tests
    is_approx($zp0.sinh, $sz0, "Complex.sinh - $zp0 default");
    is_approx($zp1.sinh, $sz1, "Complex.sinh - $zp1 default");
    is_approx($zp2.sinh, $sz2, "Complex.sinh - $zp2 default");
    
    for @official_bases -> $base {
        my Complex $z = $angle.complex(0.0, $base);
        is_approx($z.sinh($base), $sz0, "Complex.sinh - $z $base");
    
        $z = $angle.complex(1.0, $base);
        is_approx($z.sinh($base), $sz1, "Complex.sinh - $z $base");
    
        $z = $angle.complex(2.0, $base);
        is_approx($z.sinh($base), $sz2, "Complex.sinh - $z $base");
    }
}

is(sinh(Inf), Inf, "sinh(Inf) - default");
is(sinh(-Inf), -Inf, "sinh(-Inf) - default");
for @official_bases -> $base
{
    is(sinh(Inf,  $base), Inf, "sinh(Inf) - $base");
    is(sinh(-Inf, $base), -Inf, "sinh(-Inf) - $base");
}
        

# asinh tests

for @sinhes -> $angle
{
    	my $desired_result = $angle.result;

    # asinh(Num) tests
    is_approx(sinh(asinh($desired_result)), $desired_result, 
              "asinh(Num) - {$angle.num(Radians)} default");
    for @official_bases -> $base {
        is_approx(sinh(asinh($desired_result, $base), $base), $desired_result, 
                  "asinh(Num) - {$angle.num($base)} $base");
    }
    
    # asinh(:x(Num))
    is_approx(sinh(asinh(:x($desired_result))), $desired_result, 
              "asinh(:x(Num)) - {$angle.num(Radians)} default");
    for @official_bases -> $base {
        is_approx(sinh(asinh(:x($desired_result), 
                                                           :base($base)), 
                                  $base), $desired_result, 
                  "asinh(:x(Num)) - {$angle.num($base)} $base");
    }
    
    # Num.asinh tests
    is_approx($desired_result.Num.asinh.sinh, $desired_result, 
              "Num.asinh - {$angle.num(Radians)} default");
    for @official_bases -> $base {
        is_approx($desired_result.Num.asinh($base).sinh($base), $desired_result,
                  "Num.asinh - {$angle.num($base)} $base");
    }
    
    # asinh(Complex) tests
    for ($desired_result + 0i, $desired_result + .5i, $desired_result + 2i) -> $z {
        is_approx(sinh(asinh($z)), $z, 
                  "asinh(Complex) - {$angle.num(Radians)} default");
        for @official_bases -> $base {
            is_approx(sinh(asinh($z, $base), $base), $z, 
                      "asinh(Complex) - {$angle.num($base)} $base");
        }
        is_approx($z.asinh.sinh, $z, 
                  "Complex.asinh - {$angle.num(Radians)} default");
        for @official_bases -> $base {
            is_approx($z.asinh($base).sinh($base), $z, 
                      "Complex.asinh - {$angle.num($base)} $base");
        }
    }
}

for (-2/2, -1/2, 1/2, 2/2) -> $desired_result
{
    # asinh(Rat) tests
    is_approx(sinh(asinh($desired_result)), $desired_result, 
              "asinh(Rat) - $desired_result default");
    for @official_bases -> $base {
        is_approx(sinh(asinh($desired_result, $base), $base), $desired_result, 
                  "asinh(Rat) - $desired_result $base");
    }
    
    # Rat.asinh tests
    is_approx($desired_result.asinh.sinh, $desired_result, 
              "Rat.asinh - $desired_result default");
    for @official_bases -> $base {
        is_approx($desired_result.asinh($base).sinh($base), $desired_result,
                  "Rat.asinh - $desired_result $base");
    }
    
    next unless $desired_result.denominator == 1;
    
    # asinh(Int) tests
    is_approx(sinh(asinh($desired_result.numerator)), $desired_result, 
              "asinh(Int) - $desired_result default");
    for @official_bases -> $base {
        is_approx(sinh(asinh($desired_result.numerator, $base), $base), $desired_result, 
                  "asinh(Int) - $desired_result $base");
    }
    
    # Int.asinh tests
    is_approx($desired_result.numerator.asinh.sinh, $desired_result, 
              "Int.asinh - $desired_result default");
    for @official_bases -> $base {
        is_approx($desired_result.numerator.asinh($base).sinh($base), $desired_result,
                  "Int.asinh - $desired_result $base");
    }
}
        
done_testing;

# vim: ft=perl6 nomodifiable
