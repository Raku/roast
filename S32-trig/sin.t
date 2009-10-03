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

# sin tests

for @sines -> $angle
{
    	my $desired_result = $angle.result;

    # sin(Num)
    is_approx(sin($angle.num("radians")), $desired_result, 
              "sin(Num) - {$angle.num('radians')} default");
    for %official_base.keys -> $base {
        is_approx(sin($angle.num($base), %official_base{$base}), $desired_result, 
                  "sin(Num) - {$angle.num($base)} $base");
    }
    
    # sin(:x(Num))
    #?rakudo skip 'named args'
    is_approx(sin(:x($angle.num("radians"))), $desired_result, 
              "sin(:x(Num)) - {$angle.num('radians')} default");
    for %official_base.keys -> $base {
        #?rakudo skip 'named args'
        is_approx(sin(:x($angle.num($base)), :base(%official_base{$base})), $desired_result, 
                  "sin(:x(Num)) - {$angle.num($base)} $base");
    }

    # Num.sin tests
    is_approx($angle.num("radians").sin, $desired_result, 
              "Num.sin - {$angle.num('radians')} default");
    for %official_base.keys -> $base {
        is_approx($angle.num($base).sin(%official_base{$base}), $desired_result, 
                  "Num.sin - {$angle.num($base)} $base");
    }

    # sin(Rat)
    is_approx(sin($angle.rat("radians")), $desired_result, 
              "sin(Rat) - {$angle.rat('radians')} default");
    for %official_base.keys -> $base {
        is_approx(sin($angle.rat($base), %official_base{$base}), $desired_result, 
                  "sin(Rat) - {$angle.rat($base)} $base");
    }

    # sin(:x(Rat))
    #?rakudo skip 'named args'
    is_approx(sin(:x($angle.rat("radians"))), $desired_result, 
              "sin(:x(Rat)) - {$angle.rat('radians')} default");
    for %official_base.keys -> $base {
        #?rakudo skip 'named args'
        is_approx(sin(:x($angle.rat($base)), :base(%official_base{$base})), $desired_result, 
                  "sin(:x(Rat)) - {$angle.rat($base)} $base");
    }

    # Rat.sin tests
    is_approx($angle.rat("radians").sin, $desired_result, 
              "Rat.sin - {$angle.rat('radians')} default");
    for %official_base.keys -> $base {
        is_approx($angle.rat($base).sin(%official_base{$base}), $desired_result, 
                  "Rat.sin - {$angle.rat($base)} $base");
    }

    # sin(Int)
    is_approx(sin($angle.int("degrees"), %official_base{"degrees"}), $desired_result, 
              "sin(Int) - {$angle.int('degrees')} degrees");
    is_approx($angle.int('degrees').sin(%official_base{'degrees'}), $desired_result, 
              "Int.sin - {$angle.int('degrees')} degrees");

    # Complex tests
    my Complex $zp0 = $angle.complex(0.0, "radians");
    my Complex $sz0 = $desired_result + 0i;
    my Complex $zp1 = $angle.complex(1.0, "radians");
    my Complex $sz1 = { (exp($_ * 1i) - exp(-$_ * 1i)) / 2i }($zp1);
    my Complex $zp2 = $angle.complex(2.0, "radians");
    my Complex $sz2 = { (exp($_ * 1i) - exp(-$_ * 1i)) / 2i }($zp2);
    
    # sin(Complex) tests
    is_approx(sin($zp0), $sz0, "sin(Complex) - $zp0 default");
    is_approx(sin($zp1), $sz1, "sin(Complex) - $zp1 default");
    is_approx(sin($zp2), $sz2, "sin(Complex) - $zp2 default");
    
    for %official_base.keys -> $base {
        my Complex $z = $angle.complex(0.0, $base);
        is_approx(sin($z, %official_base{$base}), $sz0, "sin(Complex) - $z $base");
    
        $z = $angle.complex(1.0, $base);
        is_approx(sin($z, %official_base{$base}), $sz1, "sin(Complex) - $z $base");
                        
        $z = $angle.complex(2.0, $base);
        is_approx(sin($z, %official_base{$base}), $sz2, "sin(Complex) - $z $base");
    }
    
    # Complex.sin tests
    is_approx($zp0.sin, $sz0, "Complex.sin - $zp0 default");
    is_approx($zp1.sin, $sz1, "Complex.sin - $zp1 default");
    is_approx($zp2.sin, $sz2, "Complex.sin - $zp2 default");
    
    for %official_base.keys -> $base {
        my Complex $z = $angle.complex(0.0, $base);
        #?rakudo skip "Complex.sin plus base doesn't work yet"
        is_approx($z.sin(%official_base{$base}), $sz0, "Complex.sin - $z $base");
    
        $z = $angle.complex(1.0, $base);
        #?rakudo skip "Complex.sin plus base doesn't work yet"
        is_approx($z.sin(%official_base{$base}), $sz1, "Complex.sin - $z $base");
    
        $z = $angle.complex(2.0, $base);
        #?rakudo skip "Complex.sin plus base doesn't work yet"
        is_approx($z.sin(%official_base{$base}), $sz2, "Complex.sin - $z $base");
    }
}

is(sin(Inf), NaN, "sin(Inf) - default");
is(sin(-Inf), NaN, "sin(-Inf) - default");
for %official_base.keys -> $base
{
    is(sin(Inf,  %official_base{$base}), NaN, "sin(Inf) - $base");
    is(sin(-Inf, %official_base{$base}), NaN, "sin(-Inf) - $base");
}
        

# asin tests

for @sines -> $angle
{
    	my $desired_result = $angle.result;

    # asin(Num) tests
    is_approx(sin(asin($desired_result)), $desired_result, 
              "asin(Num) - {$angle.num('radians')} default");
    for %official_base.keys -> $base {
        is_approx(sin(asin($desired_result, %official_base{$base}), %official_base{$base}), $desired_result, 
                  "asin(Num) - {$angle.num($base)} $base");
    }
    
    # asin(:x(Num))
    #?rakudo skip 'named args'
    is_approx(sin(asin(:x($desired_result))), $desired_result, 
              "asin(:x(Num)) - {$angle.num('radians')} default");
    for %official_base.keys -> $base {
        #?rakudo skip 'named args'
        is_approx(sin(asin(:x($desired_result), 
                                                           :base(%official_base{$base})), 
                                  %official_base{$base}), $desired_result, 
                  "asin(:x(Num)) - {$angle.num($base)} $base");
    }
    
    # Num.asin tests
    is_approx($desired_result.Num.asin.sin, $desired_result, 
              "asin(Num) - {$angle.num('radians')} default");
    for %official_base.keys -> $base {
        is_approx($desired_result.Num.asin(%official_base{$base}).sin(%official_base{$base}), $desired_result,
                  "asin(Num) - {$angle.num($base)} $base");
    }
    
    # asin(Complex) tests
    for ($desired_result + 0i, $desired_result + .5i, $desired_result + 2i) -> $z {
        is_approx(sin(asin($z)), $z, 
                  "asin(Complex) - {$angle.num('radians')} default");
        for %official_base.keys -> $base {
            is_approx(sin(asin($z, %official_base{$base}), %official_base{$base}), $z, 
                      "asin(Complex) - {$angle.num($base)} $base");
        }
        is_approx($z.asin.sin, $z, 
                  "Complex.asin - {$angle.num('radians')} default");
        for %official_base.keys -> $base {
            is_approx($z.asin(%official_base{$base}).sin(%official_base{$base}), $z, 
                      "Complex.asin - {$angle.num($base)} $base");
        }
    }
}

for (-2/2, -1/2, 1/2, 2/2) -> $desired_result
{
    # asin(Rat) tests
    is_approx(sin(asin($desired_result)), $desired_result, 
              "asin(Rat) - $desired_result default");
    for %official_base.keys -> $base {
        is_approx(sin(asin($desired_result, %official_base{$base}), %official_base{$base}), $desired_result, 
                  "asin(Rat) - $desired_result $base");
    }
    
    # Rat.asin tests
    is_approx($desired_result.asin.sin, $desired_result, 
              "asin(Rat) - $desired_result default");
    for %official_base.keys -> $base {
        is_approx($desired_result.asin(%official_base{$base}).sin(%official_base{$base}), $desired_result,
                  "asin(Rat) - $desired_result $base");
    }
    
    next unless $desired_result.denominator == 1;
    
    # asin(Int) tests
    is_approx(sin(asin($desired_result.numerator)), $desired_result, 
              "asin(Int) - $desired_result default");
    for %official_base.keys -> $base {
        is_approx(sin(asin($desired_result.numerator, %official_base{$base}), %official_base{$base}), $desired_result, 
                  "asin(Int) - $desired_result $base");
    }
    
    # Int.asin tests
    is_approx($desired_result.numerator.asin.sin, $desired_result, 
              "asin(Int) - $desired_result default");
    for %official_base.keys -> $base {
        is_approx($desired_result.numerator.asin(%official_base{$base}).sin(%official_base{$base}), $desired_result,
                  "asin(Int) - $desired_result $base");
    }
}
        
done_testing;

# vim: ft=perl6 nomodifiable
