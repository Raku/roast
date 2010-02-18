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

# cosec tests

for @sines -> $angle
{
    	next if abs(sin($angle.num('radians'))) < 1e-6; 	my $desired_result = 1.0 / sin($angle.num('radians'));

    # cosec(Num)
    is_approx(cosec($angle.num(Radians)), $desired_result, 
              "cosec(Num) - {$angle.num(Radians)} default");
    for @official_bases -> $base {
        is_approx(cosec($angle.num($base), $base), $desired_result, 
                  "cosec(Num) - {$angle.num($base)} $base");
    }
    
    # cosec(:x(Num))
    is_approx(cosec(:x($angle.num(Radians))), $desired_result, 
              "cosec(:x(Num)) - {$angle.num(Radians)} default");
    for @official_bases -> $base {
        is_approx(cosec(:x($angle.num($base)), :base($base)), $desired_result, 
                  "cosec(:x(Num)) - {$angle.num($base)} $base");
    }

    # Num.cosec tests
    is_approx($angle.num(Radians).cosec, $desired_result, 
              "Num.cosec - {$angle.num(Radians)} default");
    for @official_bases -> $base {
        is_approx($angle.num($base).cosec($base), $desired_result, 
                  "Num.cosec - {$angle.num($base)} $base");
    }

    # cosec(Rat)
    is_approx(cosec($angle.rat(Radians)), $desired_result, 
              "cosec(Rat) - {$angle.rat(Radians)} default");
    for @official_bases -> $base {
        is_approx(cosec($angle.rat($base), $base), $desired_result, 
                  "cosec(Rat) - {$angle.rat($base)} $base");
    }

    # cosec(:x(Rat))
    is_approx(cosec(:x($angle.rat(Radians))), $desired_result, 
              "cosec(:x(Rat)) - {$angle.rat(Radians)} default");
    for @official_bases -> $base {
        is_approx(cosec(:x($angle.rat($base)), :base($base)), $desired_result, 
                  "cosec(:x(Rat)) - {$angle.rat($base)} $base");
    }

    # Rat.cosec tests
    is_approx($angle.rat(Radians).cosec, $desired_result, 
              "Rat.cosec - {$angle.rat(Radians)} default");
    for @official_bases -> $base {
        is_approx($angle.rat($base).cosec($base), $desired_result, 
                  "Rat.cosec - {$angle.rat($base)} $base");
    }

    # cosec(Int)
    is_approx(cosec($angle.int(Degrees), Degrees), $desired_result, 
              "cosec(Int) - {$angle.int(Degrees)} degrees");
    is_approx($angle.int(Degrees).cosec(Degrees), $desired_result, 
              "Int.cosec - {$angle.int(Degrees)} degrees");

    # Complex tests
    my Complex $zp0 = $angle.complex(0.0, Radians);
    my Complex $sz0 = $desired_result + 0i;
    my Complex $zp1 = $angle.complex(1.0, Radians);
    my Complex $sz1 = { 1.0 / sin($_) }($zp1);
    my Complex $zp2 = $angle.complex(2.0, Radians);
    my Complex $sz2 = { 1.0 / sin($_) }($zp2);
    
    # cosec(Complex) tests
    is_approx(cosec($zp0), $sz0, "cosec(Complex) - $zp0 default");
    is_approx(cosec($zp1), $sz1, "cosec(Complex) - $zp1 default");
    is_approx(cosec($zp2), $sz2, "cosec(Complex) - $zp2 default");
    
    for @official_bases -> $base {
        my Complex $z = $angle.complex(0.0, $base);
        is_approx(cosec($z, $base), $sz0, "cosec(Complex) - $z $base");
    
        $z = $angle.complex(1.0, $base);
        is_approx(cosec($z, $base), $sz1, "cosec(Complex) - $z $base");
                        
        $z = $angle.complex(2.0, $base);
        is_approx(cosec($z, $base), $sz2, "cosec(Complex) - $z $base");
    }
    
    # Complex.cosec tests
    is_approx($zp0.cosec, $sz0, "Complex.cosec - $zp0 default");
    is_approx($zp1.cosec, $sz1, "Complex.cosec - $zp1 default");
    is_approx($zp2.cosec, $sz2, "Complex.cosec - $zp2 default");
    
    for @official_bases -> $base {
        my Complex $z = $angle.complex(0.0, $base);
        is_approx($z.cosec($base), $sz0, "Complex.cosec - $z $base");
    
        $z = $angle.complex(1.0, $base);
        is_approx($z.cosec($base), $sz1, "Complex.cosec - $z $base");
    
        $z = $angle.complex(2.0, $base);
        is_approx($z.cosec($base), $sz2, "Complex.cosec - $z $base");
    }
}

is(cosec(Inf), NaN, "cosec(Inf) - default");
is(cosec(-Inf), NaN, "cosec(-Inf) - default");
for @official_bases -> $base
{
    is(cosec(Inf,  $base), NaN, "cosec(Inf) - $base");
    is(cosec(-Inf, $base), NaN, "cosec(-Inf) - $base");
}
        

# acosec tests

for @sines -> $angle
{
    	next if abs(sin($angle.num('radians'))) < 1e-6; 	my $desired_result = 1.0 / sin($angle.num('radians'));

    # acosec(Num) tests
    is_approx(cosec(acosec($desired_result)), $desired_result, 
              "acosec(Num) - {$angle.num(Radians)} default");
    for @official_bases -> $base {
        is_approx(cosec(acosec($desired_result, $base), $base), $desired_result, 
                  "acosec(Num) - {$angle.num($base)} $base");
    }
    
    # acosec(:x(Num))
    is_approx(cosec(acosec(:x($desired_result))), $desired_result, 
              "acosec(:x(Num)) - {$angle.num(Radians)} default");
    for @official_bases -> $base {
        is_approx(cosec(acosec(:x($desired_result), 
                                                           :base($base)), 
                                  $base), $desired_result, 
                  "acosec(:x(Num)) - {$angle.num($base)} $base");
    }
    
    # Num.acosec tests
    is_approx($desired_result.Num.acosec.cosec, $desired_result, 
              "Num.acosec - {$angle.num(Radians)} default");
    for @official_bases -> $base {
        is_approx($desired_result.Num.acosec($base).cosec($base), $desired_result,
                  "Num.acosec - {$angle.num($base)} $base");
    }
    
    # acosec(Complex) tests
    for ($desired_result + 0i, $desired_result + .5i, $desired_result + 2i) -> $z {
        is_approx(cosec(acosec($z)), $z, 
                  "acosec(Complex) - {$angle.num(Radians)} default");
        for @official_bases -> $base {
            is_approx(cosec(acosec($z, $base), $base), $z, 
                      "acosec(Complex) - {$angle.num($base)} $base");
        }
        is_approx($z.acosec.cosec, $z, 
                  "Complex.acosec - {$angle.num(Radians)} default");
        for @official_bases -> $base {
            is_approx($z.acosec($base).cosec($base), $z, 
                      "Complex.acosec - {$angle.num($base)} $base");
        }
    }
}

for (-3/2, -2/2, 2/2, 3/2) -> $desired_result
{
    # acosec(Rat) tests
    is_approx(cosec(acosec($desired_result)), $desired_result, 
              "acosec(Rat) - $desired_result default");
    for @official_bases -> $base {
        is_approx(cosec(acosec($desired_result, $base), $base), $desired_result, 
                  "acosec(Rat) - $desired_result $base");
    }
    
    # Rat.acosec tests
    is_approx($desired_result.acosec.cosec, $desired_result, 
              "Rat.acosec - $desired_result default");
    for @official_bases -> $base {
        is_approx($desired_result.acosec($base).cosec($base), $desired_result,
                  "Rat.acosec - $desired_result $base");
    }
    
    next unless $desired_result.denominator == 1;
    
    # acosec(Int) tests
    is_approx(cosec(acosec($desired_result.numerator)), $desired_result, 
              "acosec(Int) - $desired_result default");
    for @official_bases -> $base {
        is_approx(cosec(acosec($desired_result.numerator, $base), $base), $desired_result, 
                  "acosec(Int) - $desired_result $base");
    }
    
    # Int.acosec tests
    is_approx($desired_result.numerator.acosec.cosec, $desired_result, 
              "Int.acosec - $desired_result default");
    for @official_bases -> $base {
        is_approx($desired_result.numerator.acosec($base).cosec($base), $desired_result,
                  "Int.acosec - $desired_result $base");
    }
}
        
done_testing;

# vim: ft=perl6 nomodifiable
