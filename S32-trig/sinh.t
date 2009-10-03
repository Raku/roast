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
    
    multi method new(Int $angle_in_degrees is copy, Num $result is copy) {
        self.bless(*, :$angle_in_degrees, :$result);
    }
    
    method complex($imaginary_part_in_radians, $base) {
        my $z_in_radians = $.angle_in_degrees.Num / 180.0 * pi + ($imaginary_part_in_radians)i; 
        given $base {
            when "degrees"     { $z_in_radians * 180.0 / pi; }
            when "radians"     { $z_in_radians; }
            when "gradians"    { $z_in_radians * 200.0 / pi; }
            when "revolutions" { $z_in_radians / (2.0 * pi); }
        }
    }
    
    method num($base) {
        given $base {
            when "degrees"     { $.angle_in_degrees.Num }
            when "radians"     { $.angle_in_degrees.Num / 180.0 * pi }
            when "gradians"    { $.angle_in_degrees.Num / 180.0 * 200.0 }
            when "revolutions" { $.angle_in_degrees.Num / 360.0 }
        }
    }
    
    method rat($base) {
        given $base {
            when "degrees"     { $.angle_in_degrees / 1 }
            when "radians"     { $.angle_in_degrees / 180 * (314159265 / 100000000) }
            when "gradians"    { $.angle_in_degrees * (200 / 180) }
            when "revolutions" { $.angle_in_degrees / 360 }
        }
    }
    
    method int($base) {
        given $base {
            when "degrees"     { $.angle_in_degrees }
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
                                             (exp($_.num('radians')) - exp(-$_.num('radians'))) / 2.0)});

my @coshes = @sines.grep({ $_.angle_in_degrees < 500 }).map({ AngleAndResult.new($_.angle_in_degrees, 
                                             (exp($_.num('radians')) + exp(-$_.num('radians'))) / 2.0)});


my %official_base = (
    "radians" => "radians",
    "gradians" => "gradians", 
    "degrees" => "degrees",
    "revolutions" => 1
);

# sinh tests

for @sinhes -> $angle
{
    	my $desired_result = $angle.result;

    # sinh(Num)
    is_approx(sinh($angle.num("radians")), $desired_result, 
              "sinh(Num) - {$angle.num('radians')} default");
    for %official_base.keys -> $base {
        is_approx(sinh($angle.num($base), %official_base{$base}), $desired_result, 
                  "sinh(Num) - {$angle.num($base)} $base");
    }
    
    # sinh(:x(Num))
    #?rakudo skip 'named args'
    is_approx(sinh(:x($angle.num("radians"))), $desired_result, 
              "sinh(:x(Num)) - {$angle.num('radians')} default");
    for %official_base.keys -> $base {
        #?rakudo skip 'named args'
        is_approx(sinh(:x($angle.num($base)), :base(%official_base{$base})), $desired_result, 
                  "sinh(:x(Num)) - {$angle.num($base)} $base");
    }

    # Num.sinh tests
    is_approx($angle.num("radians").sinh, $desired_result, 
              "Num.sinh - {$angle.num('radians')} default");
    for %official_base.keys -> $base {
        is_approx($angle.num($base).sinh(%official_base{$base}), $desired_result, 
                  "Num.sinh - {$angle.num($base)} $base");
    }

    # sinh(Rat)
    is_approx(sinh($angle.rat("radians")), $desired_result, 
              "sinh(Rat) - {$angle.rat('radians')} default");
    for %official_base.keys -> $base {
        is_approx(sinh($angle.rat($base), %official_base{$base}), $desired_result, 
                  "sinh(Rat) - {$angle.rat($base)} $base");
    }

    # sinh(:x(Rat))
    #?rakudo skip 'named args'
    is_approx(sinh(:x($angle.rat("radians"))), $desired_result, 
              "sinh(:x(Rat)) - {$angle.rat('radians')} default");
    for %official_base.keys -> $base {
        #?rakudo skip 'named args'
        is_approx(sinh(:x($angle.rat($base)), :base(%official_base{$base})), $desired_result, 
                  "sinh(:x(Rat)) - {$angle.rat($base)} $base");
    }

    # Rat.sinh tests
    is_approx($angle.rat("radians").sinh, $desired_result, 
              "Rat.sinh - {$angle.rat('radians')} default");
    for %official_base.keys -> $base {
        is_approx($angle.rat($base).sinh(%official_base{$base}), $desired_result, 
                  "Rat.sinh - {$angle.rat($base)} $base");
    }

    # sinh(Int)
    is_approx(sinh($angle.int("degrees"), %official_base{"degrees"}), $desired_result, 
              "sinh(Int) - {$angle.int('degrees')} degrees");
    is_approx($angle.int('degrees').sinh(%official_base{'degrees'}), $desired_result, 
              "Int.sinh - {$angle.int('degrees')} degrees");

    # Complex tests
    my Complex $zp0 = $angle.complex(0.0, "radians");
    my Complex $sz0 = $desired_result + 0i;
    my Complex $zp1 = $angle.complex(1.0, "radians");
    my Complex $sz1 = { (exp($_) - exp(-$_)) / 2 }($zp1);
    my Complex $zp2 = $angle.complex(2.0, "radians");
    my Complex $sz2 = { (exp($_) - exp(-$_)) / 2 }($zp2);
    
    # sinh(Complex) tests
    is_approx(sinh($zp0), $sz0, "sinh(Complex) - $zp0 default");
    is_approx(sinh($zp1), $sz1, "sinh(Complex) - $zp1 default");
    is_approx(sinh($zp2), $sz2, "sinh(Complex) - $zp2 default");
    
    for %official_base.keys -> $base {
        my Complex $z = $angle.complex(0.0, $base);
        is_approx(sinh($z, %official_base{$base}), $sz0, "sinh(Complex) - $z $base");
    
        $z = $angle.complex(1.0, $base);
        is_approx(sinh($z, %official_base{$base}), $sz1, "sinh(Complex) - $z $base");
                        
        $z = $angle.complex(2.0, $base);
        is_approx(sinh($z, %official_base{$base}), $sz2, "sinh(Complex) - $z $base");
    }
    
    # Complex.sinh tests
    is_approx($zp0.sinh, $sz0, "Complex.sinh - $zp0 default");
    is_approx($zp1.sinh, $sz1, "Complex.sinh - $zp1 default");
    is_approx($zp2.sinh, $sz2, "Complex.sinh - $zp2 default");
    
    for %official_base.keys -> $base {
        my Complex $z = $angle.complex(0.0, $base);
        #?rakudo skip "Complex.sinh plus base doesn't work yet"
        is_approx($z.sinh(%official_base{$base}), $sz0, "Complex.sinh - $z $base");
    
        $z = $angle.complex(1.0, $base);
        #?rakudo skip "Complex.sinh plus base doesn't work yet"
        is_approx($z.sinh(%official_base{$base}), $sz1, "Complex.sinh - $z $base");
    
        $z = $angle.complex(2.0, $base);
        #?rakudo skip "Complex.sinh plus base doesn't work yet"
        is_approx($z.sinh(%official_base{$base}), $sz2, "Complex.sinh - $z $base");
    }
}

is(sinh(Inf), Inf, "sinh(Inf) - default");
is(sinh(-Inf), -Inf, "sinh(-Inf) - default");
for %official_base.keys -> $base
{
    is(sinh(Inf,  %official_base{$base}), Inf, "sinh(Inf) - $base");
    is(sinh(-Inf, %official_base{$base}), -Inf, "sinh(-Inf) - $base");
}
        

# asinh tests

for @sinhes -> $angle
{
    	my $desired_result = $angle.result;

    # asinh(Num) tests
    is_approx(sinh(asinh($desired_result)), $desired_result, 
              "asinh(Num) - {$angle.num('radians')} default");
    for %official_base.keys -> $base {
        is_approx(sinh(asinh($desired_result, %official_base{$base}), %official_base{$base}), $desired_result, 
                  "asinh(Num) - {$angle.num($base)} $base");
    }
    
    # asinh(:x(Num))
    #?rakudo skip 'named args'
    is_approx(sinh(asinh(:x($desired_result))), $desired_result, 
              "asinh(:x(Num)) - {$angle.num('radians')} default");
    for %official_base.keys -> $base {
        #?rakudo skip 'named args'
        is_approx(sinh(asinh(:x($desired_result), 
                                                           :base(%official_base{$base})), 
                                  %official_base{$base}), $desired_result, 
                  "asinh(:x(Num)) - {$angle.num($base)} $base");
    }
    
    # Num.asinh tests
    is_approx($desired_result.Num.asinh.sinh, $desired_result, 
              "asinh(Num) - {$angle.num('radians')} default");
    for %official_base.keys -> $base {
        is_approx($desired_result.Num.asinh(%official_base{$base}).sinh(%official_base{$base}), $desired_result,
                  "asinh(Num) - {$angle.num($base)} $base");
    }
    
    # asinh(Complex) tests
    for ($desired_result + 0i, $desired_result + .5i, $desired_result + 2i) -> $z {
        is_approx(sinh(asinh($z)), $z, 
                  "asinh(Complex) - {$angle.num('radians')} default");
        for %official_base.keys -> $base {
            is_approx(sinh(asinh($z, %official_base{$base}), %official_base{$base}), $z, 
                      "asinh(Complex) - {$angle.num($base)} $base");
        }
        is_approx($z.asinh.sinh, $z, 
                  "Complex.asinh - {$angle.num('radians')} default");
        for %official_base.keys -> $base {
            is_approx($z.asinh(%official_base{$base}).sinh(%official_base{$base}), $z, 
                      "Complex.asinh - {$angle.num($base)} $base");
        }
    }
}

for (-2/2, -1/2, 1/2, 2/2) -> $desired_result
{
    # asinh(Rat) tests
    is_approx(sinh(asinh($desired_result)), $desired_result, 
              "asinh(Rat) - $desired_result default");
    for %official_base.keys -> $base {
        is_approx(sinh(asinh($desired_result, %official_base{$base}), %official_base{$base}), $desired_result, 
                  "asinh(Rat) - $desired_result $base");
    }
    
    # Rat.asinh tests
    is_approx($desired_result.asinh.sinh, $desired_result, 
              "asinh(Rat) - $desired_result default");
    for %official_base.keys -> $base {
        is_approx($desired_result.asinh(%official_base{$base}).sinh(%official_base{$base}), $desired_result,
                  "asinh(Rat) - $desired_result $base");
    }
    
    next unless $desired_result.denominator == 1;
    
    # asinh(Int) tests
    is_approx(sinh(asinh($desired_result.numerator)), $desired_result, 
              "asinh(Int) - $desired_result default");
    for %official_base.keys -> $base {
        is_approx(sinh(asinh($desired_result.numerator, %official_base{$base}), %official_base{$base}), $desired_result, 
                  "asinh(Int) - $desired_result $base");
    }
    
    # Int.asinh tests
    is_approx($desired_result.numerator.asinh.sinh, $desired_result, 
              "asinh(Int) - $desired_result default");
    for %official_base.keys -> $base {
        is_approx($desired_result.numerator.asinh(%official_base{$base}).sinh(%official_base{$base}), $desired_result,
                  "asinh(Int) - $desired_result $base");
    }
}
        
done_testing;

# vim: ft=perl6 nomodifiable
