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

# cosh tests

for @coshes -> $angle
{
    	my $desired_result = $angle.result;

    # cosh(Num)
    is_approx(cosh($angle.num(Radians)), $desired_result, 
              "cosh(Num) - {$angle.num(Radians)} default");
    for @official_bases -> $base {
        is_approx(cosh($angle.num($base), $base), $desired_result, 
                  "cosh(Num) - {$angle.num($base)} $base");
    }
    
    # cosh(:x(Num))
    is_approx(cosh(:x($angle.num(Radians))), $desired_result, 
              "cosh(:x(Num)) - {$angle.num(Radians)} default");
    for @official_bases -> $base {
        is_approx(cosh(:x($angle.num($base)), :base($base)), $desired_result, 
                  "cosh(:x(Num)) - {$angle.num($base)} $base");
    }

    # Num.cosh tests
    is_approx($angle.num(Radians).cosh, $desired_result, 
              "Num.cosh - {$angle.num(Radians)} default");
    for @official_bases -> $base {
        is_approx($angle.num($base).cosh($base), $desired_result, 
                  "Num.cosh - {$angle.num($base)} $base");
    }

    # cosh(Rat)
    is_approx(cosh($angle.rat(Radians)), $desired_result, 
              "cosh(Rat) - {$angle.rat(Radians)} default");
    for @official_bases -> $base {
        is_approx(cosh($angle.rat($base), $base), $desired_result, 
                  "cosh(Rat) - {$angle.rat($base)} $base");
    }

    # cosh(:x(Rat))
    is_approx(cosh(:x($angle.rat(Radians))), $desired_result, 
              "cosh(:x(Rat)) - {$angle.rat(Radians)} default");
    for @official_bases -> $base {
        is_approx(cosh(:x($angle.rat($base)), :base($base)), $desired_result, 
                  "cosh(:x(Rat)) - {$angle.rat($base)} $base");
    }

    # Rat.cosh tests
    is_approx($angle.rat(Radians).cosh, $desired_result, 
              "Rat.cosh - {$angle.rat(Radians)} default");
    for @official_bases -> $base {
        is_approx($angle.rat($base).cosh($base), $desired_result, 
                  "Rat.cosh - {$angle.rat($base)} $base");
    }

    # cosh(Int)
    is_approx(cosh($angle.int(Degrees), Degrees), $desired_result, 
              "cosh(Int) - {$angle.int(Degrees)} degrees");
    is_approx($angle.int(Degrees).cosh(Degrees), $desired_result, 
              "Int.cosh - {$angle.int(Degrees)} degrees");

    # Complex tests
    my Complex $zp0 = $angle.complex(0.0, Radians);
    my Complex $sz0 = $desired_result + 0i;
    my Complex $zp1 = $angle.complex(1.0, Radians);
    my Complex $sz1 = { (exp($_) + exp(-$_)) / 2 }($zp1);
    my Complex $zp2 = $angle.complex(2.0, Radians);
    my Complex $sz2 = { (exp($_) + exp(-$_)) / 2 }($zp2);
    
    # cosh(Complex) tests
    is_approx(cosh($zp0), $sz0, "cosh(Complex) - $zp0 default");
    is_approx(cosh($zp1), $sz1, "cosh(Complex) - $zp1 default");
    is_approx(cosh($zp2), $sz2, "cosh(Complex) - $zp2 default");
    
    for @official_bases -> $base {
        my Complex $z = $angle.complex(0.0, $base);
        is_approx(cosh($z, $base), $sz0, "cosh(Complex) - $z $base");
    
        $z = $angle.complex(1.0, $base);
        is_approx(cosh($z, $base), $sz1, "cosh(Complex) - $z $base");
                        
        $z = $angle.complex(2.0, $base);
        is_approx(cosh($z, $base), $sz2, "cosh(Complex) - $z $base");
    }
    
    # Complex.cosh tests
    is_approx($zp0.cosh, $sz0, "Complex.cosh - $zp0 default");
    is_approx($zp1.cosh, $sz1, "Complex.cosh - $zp1 default");
    is_approx($zp2.cosh, $sz2, "Complex.cosh - $zp2 default");
    
    for @official_bases -> $base {
        my Complex $z = $angle.complex(0.0, $base);
        is_approx($z.cosh($base), $sz0, "Complex.cosh - $z $base");
    
        $z = $angle.complex(1.0, $base);
        is_approx($z.cosh($base), $sz1, "Complex.cosh - $z $base");
    
        $z = $angle.complex(2.0, $base);
        is_approx($z.cosh($base), $sz2, "Complex.cosh - $z $base");
    }
}

is(cosh(Inf), Inf, "cosh(Inf) - default");
is(cosh(-Inf), Inf, "cosh(-Inf) - default");
for @official_bases -> $base
{
    is(cosh(Inf,  $base), Inf, "cosh(Inf) - $base");
    is(cosh(-Inf, $base), Inf, "cosh(-Inf) - $base");
}
        

# acosh tests

for @coshes -> $angle
{
    	my $desired_result = $angle.result;

    # acosh(Num) tests
    is_approx(cosh(acosh($desired_result)), $desired_result, 
              "acosh(Num) - {$angle.num(Radians)} default");
    for @official_bases -> $base {
        is_approx(cosh(acosh($desired_result, $base), $base), $desired_result, 
                  "acosh(Num) - {$angle.num($base)} $base");
    }
    
    # acosh(:x(Num))
    is_approx(cosh(acosh(:x($desired_result))), $desired_result, 
              "acosh(:x(Num)) - {$angle.num(Radians)} default");
    for @official_bases -> $base {
        is_approx(cosh(acosh(:x($desired_result), 
                                                           :base($base)), 
                                  $base), $desired_result, 
                  "acosh(:x(Num)) - {$angle.num($base)} $base");
    }
    
    # Num.acosh tests
    is_approx($desired_result.Num.acosh.cosh, $desired_result, 
              "Num.acosh - {$angle.num(Radians)} default");
    for @official_bases -> $base {
        is_approx($desired_result.Num.acosh($base).cosh($base), $desired_result,
                  "Num.acosh - {$angle.num($base)} $base");
    }
    
    # acosh(Complex) tests
    for ($desired_result + 0i, $desired_result + .5i, $desired_result + 2i) -> $z {
        is_approx(cosh(acosh($z)), $z, 
                  "acosh(Complex) - {$angle.num(Radians)} default");
        for @official_bases -> $base {
            is_approx(cosh(acosh($z, $base), $base), $z, 
                      "acosh(Complex) - {$angle.num($base)} $base");
        }
        is_approx($z.acosh.cosh, $z, 
                  "Complex.acosh - {$angle.num(Radians)} default");
        for @official_bases -> $base {
            is_approx($z.acosh($base).cosh($base), $z, 
                      "Complex.acosh - {$angle.num($base)} $base");
        }
    }
}

for (2/2, 3/2, 4/2, 5/2) -> $desired_result
{
    # acosh(Rat) tests
    is_approx(cosh(acosh($desired_result)), $desired_result, 
              "acosh(Rat) - $desired_result default");
    for @official_bases -> $base {
        is_approx(cosh(acosh($desired_result, $base), $base), $desired_result, 
                  "acosh(Rat) - $desired_result $base");
    }
    
    # Rat.acosh tests
    is_approx($desired_result.acosh.cosh, $desired_result, 
              "Rat.acosh - $desired_result default");
    for @official_bases -> $base {
        is_approx($desired_result.acosh($base).cosh($base), $desired_result,
                  "Rat.acosh - $desired_result $base");
    }
    
    next unless $desired_result.denominator == 1;
    
    # acosh(Int) tests
    is_approx(cosh(acosh($desired_result.numerator)), $desired_result, 
              "acosh(Int) - $desired_result default");
    for @official_bases -> $base {
        is_approx(cosh(acosh($desired_result.numerator, $base), $base), $desired_result, 
                  "acosh(Int) - $desired_result $base");
    }
    
    # Int.acosh tests
    is_approx($desired_result.numerator.acosh.cosh, $desired_result, 
              "Int.acosh - $desired_result default");
    for @official_bases -> $base {
        is_approx($desired_result.numerator.acosh($base).cosh($base), $desired_result,
                  "Int.acosh - $desired_result $base");
    }
}
        
done_testing;

# vim: ft=perl6 nomodifiable
