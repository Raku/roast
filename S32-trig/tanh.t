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

# tanh tests

for @sines -> $angle
{
    	next if abs(cosh($angle.num('radians'))) < 1e-6; 	my $desired_result = sinh($angle.num('radians')) / cosh($angle.num('radians'));

    # tanh(Num)
    is_approx(tanh($angle.num(Radians)), $desired_result, 
              "tanh(Num) - {$angle.num(Radians)} default");
    for @official_bases -> $base {
        is_approx(tanh($angle.num($base), $base), $desired_result, 
                  "tanh(Num) - {$angle.num($base)} $base");
    }
    
    # tanh(:x(Num))
    is_approx(tanh(:x($angle.num(Radians))), $desired_result, 
              "tanh(:x(Num)) - {$angle.num(Radians)} default");
    for @official_bases -> $base {
        is_approx(tanh(:x($angle.num($base)), :base($base)), $desired_result, 
                  "tanh(:x(Num)) - {$angle.num($base)} $base");
    }

    # Num.tanh tests
    is_approx($angle.num(Radians).tanh, $desired_result, 
              "Num.tanh - {$angle.num(Radians)} default");
    for @official_bases -> $base {
        is_approx($angle.num($base).tanh($base), $desired_result, 
                  "Num.tanh - {$angle.num($base)} $base");
    }

    # tanh(Rat)
    is_approx(tanh($angle.rat(Radians)), $desired_result, 
              "tanh(Rat) - {$angle.rat(Radians)} default");
    for @official_bases -> $base {
        is_approx(tanh($angle.rat($base), $base), $desired_result, 
                  "tanh(Rat) - {$angle.rat($base)} $base");
    }

    # tanh(:x(Rat))
    is_approx(tanh(:x($angle.rat(Radians))), $desired_result, 
              "tanh(:x(Rat)) - {$angle.rat(Radians)} default");
    for @official_bases -> $base {
        is_approx(tanh(:x($angle.rat($base)), :base($base)), $desired_result, 
                  "tanh(:x(Rat)) - {$angle.rat($base)} $base");
    }

    # Rat.tanh tests
    is_approx($angle.rat(Radians).tanh, $desired_result, 
              "Rat.tanh - {$angle.rat(Radians)} default");
    for @official_bases -> $base {
        is_approx($angle.rat($base).tanh($base), $desired_result, 
                  "Rat.tanh - {$angle.rat($base)} $base");
    }

    # tanh(Int)
    is_approx(tanh($angle.int(Degrees), Degrees), $desired_result, 
              "tanh(Int) - {$angle.int(Degrees)} degrees");
    is_approx($angle.int(Degrees).tanh(Degrees), $desired_result, 
              "Int.tanh - {$angle.int(Degrees)} degrees");

    # Complex tests
    my Complex $zp0 = $angle.complex(0.0, Radians);
    my Complex $sz0 = $desired_result + 0i;
    my Complex $zp1 = $angle.complex(1.0, Radians);
    my Complex $sz1 = { sinh($_) / cosh($_) }($zp1);
    my Complex $zp2 = $angle.complex(2.0, Radians);
    my Complex $sz2 = { sinh($_) / cosh($_) }($zp2);
    
    # tanh(Complex) tests
    is_approx(tanh($zp0), $sz0, "tanh(Complex) - $zp0 default");
    is_approx(tanh($zp1), $sz1, "tanh(Complex) - $zp1 default");
    is_approx(tanh($zp2), $sz2, "tanh(Complex) - $zp2 default");
    
    for @official_bases -> $base {
        my Complex $z = $angle.complex(0.0, $base);
        is_approx(tanh($z, $base), $sz0, "tanh(Complex) - $z $base");
    
        $z = $angle.complex(1.0, $base);
        is_approx(tanh($z, $base), $sz1, "tanh(Complex) - $z $base");
                        
        $z = $angle.complex(2.0, $base);
        is_approx(tanh($z, $base), $sz2, "tanh(Complex) - $z $base");
    }
    
    # Complex.tanh tests
    is_approx($zp0.tanh, $sz0, "Complex.tanh - $zp0 default");
    is_approx($zp1.tanh, $sz1, "Complex.tanh - $zp1 default");
    is_approx($zp2.tanh, $sz2, "Complex.tanh - $zp2 default");
    
    for @official_bases -> $base {
        my Complex $z = $angle.complex(0.0, $base);
        is_approx($z.tanh($base), $sz0, "Complex.tanh - $z $base");
    
        $z = $angle.complex(1.0, $base);
        is_approx($z.tanh($base), $sz1, "Complex.tanh - $z $base");
    
        $z = $angle.complex(2.0, $base);
        is_approx($z.tanh($base), $sz2, "Complex.tanh - $z $base");
    }
}

is(tanh(Inf), 1, "tanh(Inf) - default");
is(tanh(-Inf), -1, "tanh(-Inf) - default");
for @official_bases -> $base
{
    is(tanh(Inf,  $base), 1, "tanh(Inf) - $base");
    is(tanh(-Inf, $base), -1, "tanh(-Inf) - $base");
}
        

# atanh tests

for @sines -> $angle
{
    	next if abs(cosh($angle.num('radians'))) < 1e-6; 	my $desired_result = sinh($angle.num('radians')) / cosh($angle.num('radians'));

    # atanh(Num) tests
    is_approx(tanh(atanh($desired_result)), $desired_result, 
              "atanh(Num) - {$angle.num(Radians)} default");
    for @official_bases -> $base {
        is_approx(tanh(atanh($desired_result, $base), $base), $desired_result, 
                  "atanh(Num) - {$angle.num($base)} $base");
    }
    
    # atanh(:x(Num))
    is_approx(tanh(atanh(:x($desired_result))), $desired_result, 
              "atanh(:x(Num)) - {$angle.num(Radians)} default");
    for @official_bases -> $base {
        is_approx(tanh(atanh(:x($desired_result), 
                                                           :base($base)), 
                                  $base), $desired_result, 
                  "atanh(:x(Num)) - {$angle.num($base)} $base");
    }
    
    # Num.atanh tests
    is_approx($desired_result.Num.atanh.tanh, $desired_result, 
              "Num.atanh - {$angle.num(Radians)} default");
    for @official_bases -> $base {
        is_approx($desired_result.Num.atanh($base).tanh($base), $desired_result,
                  "Num.atanh - {$angle.num($base)} $base");
    }
    
    # atanh(Complex) tests
    for ($desired_result + 0i, $desired_result + .5i, $desired_result + 2i) -> $z {
        is_approx(tanh(atanh($z)), $z, 
                  "atanh(Complex) - {$angle.num(Radians)} default");
        for @official_bases -> $base {
            is_approx(tanh(atanh($z, $base), $base), $z, 
                      "atanh(Complex) - {$angle.num($base)} $base");
        }
        is_approx($z.atanh.tanh, $z, 
                  "Complex.atanh - {$angle.num(Radians)} default");
        for @official_bases -> $base {
            is_approx($z.atanh($base).tanh($base), $z, 
                      "Complex.atanh - {$angle.num($base)} $base");
        }
    }
}

for (-2/2, -1/2, 0/1, 1/2) -> $desired_result
{
    # atanh(Rat) tests
    is_approx(tanh(atanh($desired_result)), $desired_result, 
              "atanh(Rat) - $desired_result default");
    for @official_bases -> $base {
        is_approx(tanh(atanh($desired_result, $base), $base), $desired_result, 
                  "atanh(Rat) - $desired_result $base");
    }
    
    # Rat.atanh tests
    is_approx($desired_result.atanh.tanh, $desired_result, 
              "Rat.atanh - $desired_result default");
    for @official_bases -> $base {
        is_approx($desired_result.atanh($base).tanh($base), $desired_result,
                  "Rat.atanh - $desired_result $base");
    }
    
    next unless $desired_result.denominator == 1;
    
    # atanh(Int) tests
    is_approx(tanh(atanh($desired_result.numerator)), $desired_result, 
              "atanh(Int) - $desired_result default");
    for @official_bases -> $base {
        is_approx(tanh(atanh($desired_result.numerator, $base), $base), $desired_result, 
                  "atanh(Int) - $desired_result $base");
    }
    
    # Int.atanh tests
    is_approx($desired_result.numerator.atanh.tanh, $desired_result, 
              "Int.atanh - $desired_result default");
    for @official_bases -> $base {
        is_approx($desired_result.numerator.atanh($base).tanh($base), $desired_result,
                  "Int.atanh - $desired_result $base");
    }
}
        
done_testing;

# vim: ft=perl6 nomodifiable
