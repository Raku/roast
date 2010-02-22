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

# cosech tests

for @sines -> $angle
{
    	next if abs(sinh($angle.num('radians'))) < 1e-6; 	my $desired_result = 1.0 / sinh($angle.num('radians'));

    # cosech(Num)
    is_approx(cosech($angle.num(Radians)), $desired_result, 
              "cosech(Num) - {$angle.num(Radians)} default");
    for @official_bases -> $base {
        is_approx(cosech($angle.num($base), $base), $desired_result, 
                  "cosech(Num) - {$angle.num($base)} $base");
    }
    
    # cosech(:x(Num))
    is_approx(cosech(:x($angle.num(Radians))), $desired_result, 
              "cosech(:x(Num)) - {$angle.num(Radians)} default");
    for @official_bases -> $base {
        is_approx(cosech(:x($angle.num($base)), :base($base)), $desired_result, 
                  "cosech(:x(Num)) - {$angle.num($base)} $base");
    }

    # Num.cosech tests
    is_approx($angle.num(Radians).cosech, $desired_result, 
              "Num.cosech - {$angle.num(Radians)} default");
    for @official_bases -> $base {
        is_approx($angle.num($base).cosech($base), $desired_result, 
                  "Num.cosech - {$angle.num($base)} $base");
    }

    # cosech(Rat)
    is_approx(cosech($angle.rat(Radians)), $desired_result, 
              "cosech(Rat) - {$angle.rat(Radians)} default");
    for @official_bases -> $base {
        is_approx(cosech($angle.rat($base), $base), $desired_result, 
                  "cosech(Rat) - {$angle.rat($base)} $base");
    }

    # cosech(:x(Rat))
    is_approx(cosech(:x($angle.rat(Radians))), $desired_result, 
              "cosech(:x(Rat)) - {$angle.rat(Radians)} default");
    for @official_bases -> $base {
        is_approx(cosech(:x($angle.rat($base)), :base($base)), $desired_result, 
                  "cosech(:x(Rat)) - {$angle.rat($base)} $base");
    }

    # Rat.cosech tests
    is_approx($angle.rat(Radians).cosech, $desired_result, 
              "Rat.cosech - {$angle.rat(Radians)} default");
    for @official_bases -> $base {
        is_approx($angle.rat($base).cosech($base), $desired_result, 
                  "Rat.cosech - {$angle.rat($base)} $base");
    }

    # cosech(Int)
    is_approx(cosech($angle.int(Degrees), Degrees), $desired_result, 
              "cosech(Int) - {$angle.int(Degrees)} degrees");
    is_approx($angle.int(Degrees).cosech(Degrees), $desired_result, 
              "Int.cosech - {$angle.int(Degrees)} degrees");

    # Complex tests
    my Complex $zp0 = $angle.complex(0.0, Radians);
    my Complex $sz0 = $desired_result + 0i;
    my Complex $zp1 = $angle.complex(1.0, Radians);
    my Complex $sz1 = { 1.0 / sinh($_) }($zp1);
    my Complex $zp2 = $angle.complex(2.0, Radians);
    my Complex $sz2 = { 1.0 / sinh($_) }($zp2);
    
    # cosech(Complex) tests
    is_approx(cosech($zp0), $sz0, "cosech(Complex) - $zp0 default");
    is_approx(cosech($zp1), $sz1, "cosech(Complex) - $zp1 default");
    is_approx(cosech($zp2), $sz2, "cosech(Complex) - $zp2 default");
    
    for @official_bases -> $base {
        my Complex $z = $angle.complex(0.0, $base);
        is_approx(cosech($z, $base), $sz0, "cosech(Complex) - $z $base");
    
        $z = $angle.complex(1.0, $base);
        is_approx(cosech($z, $base), $sz1, "cosech(Complex) - $z $base");
                        
        $z = $angle.complex(2.0, $base);
        is_approx(cosech($z, $base), $sz2, "cosech(Complex) - $z $base");
    }
    
    # Complex.cosech tests
    is_approx($zp0.cosech, $sz0, "Complex.cosech - $zp0 default");
    is_approx($zp1.cosech, $sz1, "Complex.cosech - $zp1 default");
    is_approx($zp2.cosech, $sz2, "Complex.cosech - $zp2 default");
    
    for @official_bases -> $base {
        my Complex $z = $angle.complex(0.0, $base);
        is_approx($z.cosech($base), $sz0, "Complex.cosech - $z $base");
    
        $z = $angle.complex(1.0, $base);
        is_approx($z.cosech($base), $sz1, "Complex.cosech - $z $base");
    
        $z = $angle.complex(2.0, $base);
        is_approx($z.cosech($base), $sz2, "Complex.cosech - $z $base");
    }
}

is(cosech(Inf), 0, "cosech(Inf) - default");
is(cosech(-Inf), "-0", "cosech(-Inf) - default");
for @official_bases -> $base
{
    is(cosech(Inf,  $base), 0, "cosech(Inf) - $base");
    is(cosech(-Inf, $base), "-0", "cosech(-Inf) - $base");
}
        

# acosech tests

for @sines -> $angle
{
    	next if abs(sinh($angle.num('radians'))) < 1e-6; 	my $desired_result = 1.0 / sinh($angle.num('radians'));

    # acosech(Num) tests
    is_approx(cosech(acosech($desired_result)), $desired_result, 
              "acosech(Num) - {$angle.num(Radians)} default");
    for @official_bases -> $base {
        is_approx(cosech(acosech($desired_result, $base), $base), $desired_result, 
                  "acosech(Num) - {$angle.num($base)} $base");
    }
    
    # acosech(:x(Num))
    is_approx(cosech(acosech(:x($desired_result))), $desired_result, 
              "acosech(:x(Num)) - {$angle.num(Radians)} default");
    for @official_bases -> $base {
        is_approx(cosech(acosech(:x($desired_result), 
                                                           :base($base)), 
                                  $base), $desired_result, 
                  "acosech(:x(Num)) - {$angle.num($base)} $base");
    }
    
    # Num.acosech tests
    is_approx($desired_result.Num.acosech.cosech, $desired_result, 
              "Num.acosech - {$angle.num(Radians)} default");
    for @official_bases -> $base {
        is_approx($desired_result.Num.acosech($base).cosech($base), $desired_result,
                  "Num.acosech - {$angle.num($base)} $base");
    }
    
    # acosech(Complex) tests
    for ($desired_result + 0i, $desired_result + .5i, $desired_result + 2i) -> $z {
        is_approx(cosech(acosech($z)), $z, 
                  "acosech(Complex) - {$angle.num(Radians)} default");
        for @official_bases -> $base {
            is_approx(cosech(acosech($z, $base), $base), $z, 
                      "acosech(Complex) - {$angle.num($base)} $base");
        }
        is_approx($z.acosech.cosech, $z, 
                  "Complex.acosech - {$angle.num(Radians)} default");
        for @official_bases -> $base {
            is_approx($z.acosech($base).cosech($base), $z, 
                      "Complex.acosech - {$angle.num($base)} $base");
        }
    }
}

for (-2/2, -1/2, 1/2, 2/2) -> $desired_result
{
    # acosech(Rat) tests
    is_approx(cosech(acosech($desired_result)), $desired_result, 
              "acosech(Rat) - $desired_result default");
    for @official_bases -> $base {
        is_approx(cosech(acosech($desired_result, $base), $base), $desired_result, 
                  "acosech(Rat) - $desired_result $base");
    }
    
    # Rat.acosech tests
    is_approx($desired_result.acosech.cosech, $desired_result, 
              "Rat.acosech - $desired_result default");
    for @official_bases -> $base {
        is_approx($desired_result.acosech($base).cosech($base), $desired_result,
                  "Rat.acosech - $desired_result $base");
    }
    
    next unless $desired_result.denominator == 1;
    
    # acosech(Int) tests
    is_approx(cosech(acosech($desired_result.numerator)), $desired_result, 
              "acosech(Int) - $desired_result default");
    for @official_bases -> $base {
        is_approx(cosech(acosech($desired_result.numerator, $base), $base), $desired_result, 
                  "acosech(Int) - $desired_result $base");
    }
    
    # Int.acosech tests
    is_approx($desired_result.numerator.acosech.cosech, $desired_result, 
              "Int.acosech - $desired_result default");
    for @official_bases -> $base {
        is_approx($desired_result.numerator.acosech($base).cosech($base), $desired_result,
                  "Int.acosech - $desired_result $base");
    }
}
        
done_testing;

# vim: ft=perl6 nomodifiable
