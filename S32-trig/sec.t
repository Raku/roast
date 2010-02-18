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

# sec tests

for @cosines -> $angle
{
    	next if abs(cos($angle.num('radians'))) < 1e-6;     my $desired_result = 1.0 / cos($angle.num('radians'));

    # sec(Num)
    is_approx(sec($angle.num(Radians)), $desired_result, 
              "sec(Num) - {$angle.num(Radians)} default");
    for @official_bases -> $base {
        is_approx(sec($angle.num($base), $base), $desired_result, 
                  "sec(Num) - {$angle.num($base)} $base");
    }
    
    # sec(:x(Num))
    is_approx(sec(:x($angle.num(Radians))), $desired_result, 
              "sec(:x(Num)) - {$angle.num(Radians)} default");
    for @official_bases -> $base {
        is_approx(sec(:x($angle.num($base)), :base($base)), $desired_result, 
                  "sec(:x(Num)) - {$angle.num($base)} $base");
    }

    # Num.sec tests
    is_approx($angle.num(Radians).sec, $desired_result, 
              "Num.sec - {$angle.num(Radians)} default");
    for @official_bases -> $base {
        is_approx($angle.num($base).sec($base), $desired_result, 
                  "Num.sec - {$angle.num($base)} $base");
    }

    # sec(Rat)
    is_approx(sec($angle.rat(Radians)), $desired_result, 
              "sec(Rat) - {$angle.rat(Radians)} default");
    for @official_bases -> $base {
        is_approx(sec($angle.rat($base), $base), $desired_result, 
                  "sec(Rat) - {$angle.rat($base)} $base");
    }

    # sec(:x(Rat))
    is_approx(sec(:x($angle.rat(Radians))), $desired_result, 
              "sec(:x(Rat)) - {$angle.rat(Radians)} default");
    for @official_bases -> $base {
        is_approx(sec(:x($angle.rat($base)), :base($base)), $desired_result, 
                  "sec(:x(Rat)) - {$angle.rat($base)} $base");
    }

    # Rat.sec tests
    is_approx($angle.rat(Radians).sec, $desired_result, 
              "Rat.sec - {$angle.rat(Radians)} default");
    for @official_bases -> $base {
        is_approx($angle.rat($base).sec($base), $desired_result, 
                  "Rat.sec - {$angle.rat($base)} $base");
    }

    # sec(Int)
    is_approx(sec($angle.int(Degrees), Degrees), $desired_result, 
              "sec(Int) - {$angle.int(Degrees)} degrees");
    is_approx($angle.int(Degrees).sec(Degrees), $desired_result, 
              "Int.sec - {$angle.int(Degrees)} degrees");

    # Complex tests
    my Complex $zp0 = $angle.complex(0.0, Radians);
    my Complex $sz0 = $desired_result + 0i;
    my Complex $zp1 = $angle.complex(1.0, Radians);
    my Complex $sz1 = { 1.0 / cos($_) }($zp1);
    my Complex $zp2 = $angle.complex(2.0, Radians);
    my Complex $sz2 = { 1.0 / cos($_) }($zp2);
    
    # sec(Complex) tests
    is_approx(sec($zp0), $sz0, "sec(Complex) - $zp0 default");
    is_approx(sec($zp1), $sz1, "sec(Complex) - $zp1 default");
    is_approx(sec($zp2), $sz2, "sec(Complex) - $zp2 default");
    
    for @official_bases -> $base {
        my Complex $z = $angle.complex(0.0, $base);
        is_approx(sec($z, $base), $sz0, "sec(Complex) - $z $base");
    
        $z = $angle.complex(1.0, $base);
        is_approx(sec($z, $base), $sz1, "sec(Complex) - $z $base");
                        
        $z = $angle.complex(2.0, $base);
        is_approx(sec($z, $base), $sz2, "sec(Complex) - $z $base");
    }
    
    # Complex.sec tests
    is_approx($zp0.sec, $sz0, "Complex.sec - $zp0 default");
    is_approx($zp1.sec, $sz1, "Complex.sec - $zp1 default");
    is_approx($zp2.sec, $sz2, "Complex.sec - $zp2 default");
    
    for @official_bases -> $base {
        my Complex $z = $angle.complex(0.0, $base);
        is_approx($z.sec($base), $sz0, "Complex.sec - $z $base");
    
        $z = $angle.complex(1.0, $base);
        is_approx($z.sec($base), $sz1, "Complex.sec - $z $base");
    
        $z = $angle.complex(2.0, $base);
        is_approx($z.sec($base), $sz2, "Complex.sec - $z $base");
    }
}

is(sec(Inf), NaN, "sec(Inf) - default");
is(sec(-Inf), NaN, "sec(-Inf) - default");
for @official_bases -> $base
{
    is(sec(Inf,  $base), NaN, "sec(Inf) - $base");
    is(sec(-Inf, $base), NaN, "sec(-Inf) - $base");
}
        

# asec tests

for @cosines -> $angle
{
    	next if abs(cos($angle.num('radians'))) < 1e-6;     my $desired_result = 1.0 / cos($angle.num('radians'));

    # asec(Num) tests
    is_approx(sec(asec($desired_result)), $desired_result, 
              "asec(Num) - {$angle.num(Radians)} default");
    for @official_bases -> $base {
        is_approx(sec(asec($desired_result, $base), $base), $desired_result, 
                  "asec(Num) - {$angle.num($base)} $base");
    }
    
    # asec(:x(Num))
    is_approx(sec(asec(:x($desired_result))), $desired_result, 
              "asec(:x(Num)) - {$angle.num(Radians)} default");
    for @official_bases -> $base {
        is_approx(sec(asec(:x($desired_result), 
                                                           :base($base)), 
                                  $base), $desired_result, 
                  "asec(:x(Num)) - {$angle.num($base)} $base");
    }
    
    # Num.asec tests
    is_approx($desired_result.Num.asec.sec, $desired_result, 
              "Num.asec - {$angle.num(Radians)} default");
    for @official_bases -> $base {
        is_approx($desired_result.Num.asec($base).sec($base), $desired_result,
                  "Num.asec - {$angle.num($base)} $base");
    }
    
    # asec(Complex) tests
    for ($desired_result + 0i, $desired_result + .5i, $desired_result + 2i) -> $z {
        is_approx(sec(asec($z)), $z, 
                  "asec(Complex) - {$angle.num(Radians)} default");
        for @official_bases -> $base {
            is_approx(sec(asec($z, $base), $base), $z, 
                      "asec(Complex) - {$angle.num($base)} $base");
        }
        is_approx($z.asec.sec, $z, 
                  "Complex.asec - {$angle.num(Radians)} default");
        for @official_bases -> $base {
            is_approx($z.asec($base).sec($base), $z, 
                      "Complex.asec - {$angle.num($base)} $base");
        }
    }
}

for (-3/2, -2/2, 2/2, 3/2) -> $desired_result
{
    # asec(Rat) tests
    is_approx(sec(asec($desired_result)), $desired_result, 
              "asec(Rat) - $desired_result default");
    for @official_bases -> $base {
        is_approx(sec(asec($desired_result, $base), $base), $desired_result, 
                  "asec(Rat) - $desired_result $base");
    }
    
    # Rat.asec tests
    is_approx($desired_result.asec.sec, $desired_result, 
              "Rat.asec - $desired_result default");
    for @official_bases -> $base {
        is_approx($desired_result.asec($base).sec($base), $desired_result,
                  "Rat.asec - $desired_result $base");
    }
    
    next unless $desired_result.denominator == 1;
    
    # asec(Int) tests
    is_approx(sec(asec($desired_result.numerator)), $desired_result, 
              "asec(Int) - $desired_result default");
    for @official_bases -> $base {
        is_approx(sec(asec($desired_result.numerator, $base), $base), $desired_result, 
                  "asec(Int) - $desired_result $base");
    }
    
    # Int.asec tests
    is_approx($desired_result.numerator.asec.sec, $desired_result, 
              "Int.asec - $desired_result default");
    for @official_bases -> $base {
        is_approx($desired_result.numerator.asec($base).sec($base), $desired_result,
                  "Int.asec - $desired_result $base");
    }
}
        
done_testing;

# vim: ft=perl6 nomodifiable
