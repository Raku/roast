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
    
    multi method new(Int $angle_in_degrees is copy, $result is copy) {
        self.bless(*, :$angle_in_degrees, :$result);
    }
    
    method complex($imaginary_part_in_radians, $base) {
        my $z_in_radians = $.angle_in_degrees.Num / 180.0 * pi + ($imaginary_part_in_radians)i; 
        given $base {
            when Degrees     { $z_in_radians * 180.0 / pi; }
            when Radians     { $z_in_radians; }
            when Gradians    { $z_in_radians * 200.0 / pi; }
            when Circles     { $z_in_radians / (2.0 * pi); }
        }
    }
    
    method num($base) {
        given $base {
            when Degrees     { $.angle_in_degrees.Num }
            when Radians     { $.angle_in_degrees.Num / 180.0 * pi }
            when Gradians    { $.angle_in_degrees.Num / 180.0 * 200.0 }
            when Circles     { $.angle_in_degrees.Num / 360.0 }
        }
    }
    
    method rat($base) {
        given $base {
            when Degrees     { $.angle_in_degrees / 1 }
            when Radians     { $.angle_in_degrees / 180 * (314159265 / 100000000) }
            when Gradians    { $.angle_in_degrees * (200 / 180) }
            when Circles     { $.angle_in_degrees / 360 }
        }
    }
    
    method int($base) {
        given $base {
            when Degrees     { $.angle_in_degrees }
        }
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

# tan tests

for @sines -> $angle
{
    	next if abs(cos($angle.num('radians'))) < 1e-6;     my $desired_result = sin($angle.num('radians')) / cos($angle.num('radians'));

    # tan(Num)
    is_approx(tan($angle.num(Radians)), $desired_result, 
              "tan(Num) - {$angle.num(Radians)} default");
    for @official_bases -> $base {
        is_approx(tan($angle.num($base), $base), $desired_result, 
                  "tan(Num) - {$angle.num($base)} $base");
    }
    
    # tan(:x(Num))
    is_approx(tan(:x($angle.num(Radians))), $desired_result, 
              "tan(:x(Num)) - {$angle.num(Radians)} default");
    for @official_bases -> $base {
        is_approx(tan(:x($angle.num($base)), :base($base)), $desired_result, 
                  "tan(:x(Num)) - {$angle.num($base)} $base");
    }

    # Num.tan tests
    is_approx($angle.num(Radians).tan, $desired_result, 
              "Num.tan - {$angle.num(Radians)} default");
    for @official_bases -> $base {
        is_approx($angle.num($base).tan($base), $desired_result, 
                  "Num.tan - {$angle.num($base)} $base");
    }

    # tan(Rat)
    is_approx(tan($angle.rat(Radians)), $desired_result, 
              "tan(Rat) - {$angle.rat(Radians)} default");
    for @official_bases -> $base {
        is_approx(tan($angle.rat($base), $base), $desired_result, 
                  "tan(Rat) - {$angle.rat($base)} $base");
    }

    # tan(:x(Rat))
    is_approx(tan(:x($angle.rat(Radians))), $desired_result, 
              "tan(:x(Rat)) - {$angle.rat(Radians)} default");
    for @official_bases -> $base {
        is_approx(tan(:x($angle.rat($base)), :base($base)), $desired_result, 
                  "tan(:x(Rat)) - {$angle.rat($base)} $base");
    }

    # Rat.tan tests
    is_approx($angle.rat(Radians).tan, $desired_result, 
              "Rat.tan - {$angle.rat(Radians)} default");
    for @official_bases -> $base {
        is_approx($angle.rat($base).tan($base), $desired_result, 
                  "Rat.tan - {$angle.rat($base)} $base");
    }

    # tan(Int)
    is_approx(tan($angle.int(Degrees), Degrees), $desired_result, 
              "tan(Int) - {$angle.int(Degrees)} degrees");
    is_approx($angle.int(Degrees).tan(Degrees), $desired_result, 
              "Int.tan - {$angle.int(Degrees)} degrees");

    # Complex tests
    my Complex $zp0 = $angle.complex(0.0, Radians);
    my Complex $sz0 = $desired_result + 0i;
    my Complex $zp1 = $angle.complex(1.0, Radians);
    my Complex $sz1 = { sin($_) / cos($_) }($zp1);
    my Complex $zp2 = $angle.complex(2.0, Radians);
    my Complex $sz2 = { sin($_) / cos($_) }($zp2);
    
    # tan(Complex) tests
    is_approx(tan($zp0), $sz0, "tan(Complex) - $zp0 default");
    is_approx(tan($zp1), $sz1, "tan(Complex) - $zp1 default");
    is_approx(tan($zp2), $sz2, "tan(Complex) - $zp2 default");
    
    for @official_bases -> $base {
        my Complex $z = $angle.complex(0.0, $base);
        is_approx(tan($z, $base), $sz0, "tan(Complex) - $z $base");
    
        $z = $angle.complex(1.0, $base);
        is_approx(tan($z, $base), $sz1, "tan(Complex) - $z $base");
                        
        $z = $angle.complex(2.0, $base);
        is_approx(tan($z, $base), $sz2, "tan(Complex) - $z $base");
    }
    
    # Complex.tan tests
    is_approx($zp0.tan, $sz0, "Complex.tan - $zp0 default");
    is_approx($zp1.tan, $sz1, "Complex.tan - $zp1 default");
    is_approx($zp2.tan, $sz2, "Complex.tan - $zp2 default");
    
    for @official_bases -> $base {
        my Complex $z = $angle.complex(0.0, $base);
        is_approx($z.tan($base), $sz0, "Complex.tan - $z $base");
    
        $z = $angle.complex(1.0, $base);
        is_approx($z.tan($base), $sz1, "Complex.tan - $z $base");
    
        $z = $angle.complex(2.0, $base);
        is_approx($z.tan($base), $sz2, "Complex.tan - $z $base");
    }
}

is(tan(Inf), NaN, "tan(Inf) - default");
is(tan(-Inf), NaN, "tan(-Inf) - default");
for @official_bases -> $base
{
    is(tan(Inf,  $base), NaN, "tan(Inf) - $base");
    is(tan(-Inf, $base), NaN, "tan(-Inf) - $base");
}
        

# atan tests

for @sines -> $angle
{
    	next if abs(cos($angle.num('radians'))) < 1e-6;     my $desired_result = sin($angle.num('radians')) / cos($angle.num('radians'));

    # atan(Num) tests
    is_approx(tan(atan($desired_result)), $desired_result, 
              "atan(Num) - {$angle.num(Radians)} default");
    for @official_bases -> $base {
        is_approx(tan(atan($desired_result, $base), $base), $desired_result, 
                  "atan(Num) - {$angle.num($base)} $base");
    }
    
    # atan(:x(Num))
    is_approx(tan(atan(:x($desired_result))), $desired_result, 
              "atan(:x(Num)) - {$angle.num(Radians)} default");
    for @official_bases -> $base {
        is_approx(tan(atan(:x($desired_result), 
                                                           :base($base)), 
                                  $base), $desired_result, 
                  "atan(:x(Num)) - {$angle.num($base)} $base");
    }
    
    # Num.atan tests
    is_approx($desired_result.Num.atan.tan, $desired_result, 
              "Num.atan - {$angle.num(Radians)} default");
    for @official_bases -> $base {
        is_approx($desired_result.Num.atan($base).tan($base), $desired_result,
                  "Num.atan - {$angle.num($base)} $base");
    }
    
    # atan(Complex) tests
    for ($desired_result + 0i, $desired_result + .5i, $desired_result + 2i) -> $z {
        is_approx(tan(atan($z)), $z, 
                  "atan(Complex) - {$angle.num(Radians)} default");
        for @official_bases -> $base {
            is_approx(tan(atan($z, $base), $base), $z, 
                      "atan(Complex) - {$angle.num($base)} $base");
        }
        is_approx($z.atan.tan, $z, 
                  "Complex.atan - {$angle.num(Radians)} default");
        for @official_bases -> $base {
            is_approx($z.atan($base).tan($base), $z, 
                      "Complex.atan - {$angle.num($base)} $base");
        }
    }
}

for (-2/2, -1/2, 1/2, 2/2) -> $desired_result
{
    # atan(Rat) tests
    is_approx(tan(atan($desired_result)), $desired_result, 
              "atan(Rat) - $desired_result default");
    for @official_bases -> $base {
        is_approx(tan(atan($desired_result, $base), $base), $desired_result, 
                  "atan(Rat) - $desired_result $base");
    }
    
    # Rat.atan tests
    is_approx($desired_result.atan.tan, $desired_result, 
              "Rat.atan - $desired_result default");
    for @official_bases -> $base {
        is_approx($desired_result.atan($base).tan($base), $desired_result,
                  "Rat.atan - $desired_result $base");
    }
    
    next unless $desired_result.denominator == 1;
    
    # atan(Int) tests
    is_approx(tan(atan($desired_result.numerator)), $desired_result, 
              "atan(Int) - $desired_result default");
    for @official_bases -> $base {
        is_approx(tan(atan($desired_result.numerator, $base), $base), $desired_result, 
                  "atan(Int) - $desired_result $base");
    }
    
    # Int.atan tests
    is_approx($desired_result.numerator.atan.tan, $desired_result, 
              "Int.atan - $desired_result default");
    for @official_bases -> $base {
        is_approx($desired_result.numerator.atan($base).tan($base), $desired_result,
                  "Int.atan - $desired_result $base");
    }
}
        
done_testing;

# vim: ft=perl6 nomodifiable
