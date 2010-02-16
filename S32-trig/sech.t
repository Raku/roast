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

# sech tests

for @cosines -> $angle
{
    	next if abs(cosh($angle.num('radians'))) < 1e-6; 	my $desired_result = 1.0 / cosh($angle.num('radians'));

    # sech(Num)
    is_approx(sech($angle.num("radians")), $desired_result, 
              "sech(Num) - {$angle.num('radians')} default");
    for %official_base.keys -> $base {
        is_approx(sech($angle.num($base), %official_base{$base}), $desired_result, 
                  "sech(Num) - {$angle.num($base)} $base");
    }
    
    # sech(:x(Num))
    is_approx(sech(:x($angle.num("radians"))), $desired_result, 
              "sech(:x(Num)) - {$angle.num('radians')} default");
    for %official_base.keys -> $base {
        is_approx(sech(:x($angle.num($base)), :base(%official_base{$base})), $desired_result, 
                  "sech(:x(Num)) - {$angle.num($base)} $base");
    }

    # Num.sech tests
    is_approx($angle.num("radians").sech, $desired_result, 
              "Num.sech - {$angle.num('radians')} default");
    for %official_base.keys -> $base {
        is_approx($angle.num($base).sech(%official_base{$base}), $desired_result, 
                  "Num.sech - {$angle.num($base)} $base");
    }

    # sech(Rat)
    is_approx(sech($angle.rat("radians")), $desired_result, 
              "sech(Rat) - {$angle.rat('radians')} default");
    for %official_base.keys -> $base {
        is_approx(sech($angle.rat($base), %official_base{$base}), $desired_result, 
                  "sech(Rat) - {$angle.rat($base)} $base");
    }

    # sech(:x(Rat))
    is_approx(sech(:x($angle.rat("radians"))), $desired_result, 
              "sech(:x(Rat)) - {$angle.rat('radians')} default");
    for %official_base.keys -> $base {
        is_approx(sech(:x($angle.rat($base)), :base(%official_base{$base})), $desired_result, 
                  "sech(:x(Rat)) - {$angle.rat($base)} $base");
    }

    # Rat.sech tests
    is_approx($angle.rat("radians").sech, $desired_result, 
              "Rat.sech - {$angle.rat('radians')} default");
    for %official_base.keys -> $base {
        is_approx($angle.rat($base).sech(%official_base{$base}), $desired_result, 
                  "Rat.sech - {$angle.rat($base)} $base");
    }

    # sech(Int)
    is_approx(sech($angle.int("degrees"), %official_base{"degrees"}), $desired_result, 
              "sech(Int) - {$angle.int('degrees')} degrees");
    is_approx($angle.int('degrees').sech(%official_base{'degrees'}), $desired_result, 
              "Int.sech - {$angle.int('degrees')} degrees");

    # Complex tests
    my Complex $zp0 = $angle.complex(0.0, "radians");
    my Complex $sz0 = $desired_result + 0i;
    my Complex $zp1 = $angle.complex(1.0, "radians");
    my Complex $sz1 = { 1.0 / cosh($_) }($zp1);
    my Complex $zp2 = $angle.complex(2.0, "radians");
    my Complex $sz2 = { 1.0 / cosh($_) }($zp2);
    
    # sech(Complex) tests
    is_approx(sech($zp0), $sz0, "sech(Complex) - $zp0 default");
    is_approx(sech($zp1), $sz1, "sech(Complex) - $zp1 default");
    is_approx(sech($zp2), $sz2, "sech(Complex) - $zp2 default");
    
    for %official_base.keys -> $base {
        my Complex $z = $angle.complex(0.0, $base);
        is_approx(sech($z, %official_base{$base}), $sz0, "sech(Complex) - $z $base");
    
        $z = $angle.complex(1.0, $base);
        is_approx(sech($z, %official_base{$base}), $sz1, "sech(Complex) - $z $base");
                        
        $z = $angle.complex(2.0, $base);
        is_approx(sech($z, %official_base{$base}), $sz2, "sech(Complex) - $z $base");
    }
    
    # Complex.sech tests
    is_approx($zp0.sech, $sz0, "Complex.sech - $zp0 default");
    is_approx($zp1.sech, $sz1, "Complex.sech - $zp1 default");
    is_approx($zp2.sech, $sz2, "Complex.sech - $zp2 default");
    
    for %official_base.keys -> $base {
        my Complex $z = $angle.complex(0.0, $base);
        is_approx($z.sech(%official_base{$base}), $sz0, "Complex.sech - $z $base");
    
        $z = $angle.complex(1.0, $base);
        is_approx($z.sech(%official_base{$base}), $sz1, "Complex.sech - $z $base");
    
        $z = $angle.complex(2.0, $base);
        is_approx($z.sech(%official_base{$base}), $sz2, "Complex.sech - $z $base");
    }
}

is(sech(Inf), 0, "sech(Inf) - default");
is(sech(-Inf), 0, "sech(-Inf) - default");
for %official_base.keys -> $base
{
    is(sech(Inf,  %official_base{$base}), 0, "sech(Inf) - $base");
    is(sech(-Inf, %official_base{$base}), 0, "sech(-Inf) - $base");
}
        

# asech tests

for @cosines -> $angle
{
    	next if abs(cosh($angle.num('radians'))) < 1e-6; 	my $desired_result = 1.0 / cosh($angle.num('radians'));

    # asech(Num) tests
    is_approx(sech(asech($desired_result)), $desired_result, 
              "asech(Num) - {$angle.num('radians')} default");
    for %official_base.keys -> $base {
        is_approx(sech(asech($desired_result, %official_base{$base}), %official_base{$base}), $desired_result, 
                  "asech(Num) - {$angle.num($base)} $base");
    }
    
    # asech(:x(Num))
    is_approx(sech(asech(:x($desired_result))), $desired_result, 
              "asech(:x(Num)) - {$angle.num('radians')} default");
    for %official_base.keys -> $base {
        is_approx(sech(asech(:x($desired_result), 
                                                           :base(%official_base{$base})), 
                                  %official_base{$base}), $desired_result, 
                  "asech(:x(Num)) - {$angle.num($base)} $base");
    }
    
    # Num.asech tests
    is_approx($desired_result.Num.asech.sech, $desired_result, 
              "Num.asech - {$angle.num('radians')} default");
    for %official_base.keys -> $base {
        is_approx($desired_result.Num.asech(%official_base{$base}).sech(%official_base{$base}), $desired_result,
                  "Num.asech - {$angle.num($base)} $base");
    }
    
    # asech(Complex) tests
    for ($desired_result + 0i, $desired_result + .5i, $desired_result + 2i) -> $z {
        is_approx(sech(asech($z)), $z, 
                  "asech(Complex) - {$angle.num('radians')} default");
        for %official_base.keys -> $base {
            is_approx(sech(asech($z, %official_base{$base}), %official_base{$base}), $z, 
                      "asech(Complex) - {$angle.num($base)} $base");
        }
        is_approx($z.asech.sech, $z, 
                  "Complex.asech - {$angle.num('radians')} default");
        for %official_base.keys -> $base {
            is_approx($z.asech(%official_base{$base}).sech(%official_base{$base}), $z, 
                      "Complex.asech - {$angle.num($base)} $base");
        }
    }
}

for (1/4, 1/2, 3/4, 2/2) -> $desired_result
{
    # asech(Rat) tests
    is_approx(sech(asech($desired_result)), $desired_result, 
              "asech(Rat) - $desired_result default");
    for %official_base.keys -> $base {
        is_approx(sech(asech($desired_result, %official_base{$base}), %official_base{$base}), $desired_result, 
                  "asech(Rat) - $desired_result $base");
    }
    
    # Rat.asech tests
    is_approx($desired_result.asech.sech, $desired_result, 
              "Rat.asech - $desired_result default");
    for %official_base.keys -> $base {
        is_approx($desired_result.asech(%official_base{$base}).sech(%official_base{$base}), $desired_result,
                  "Rat.asech - $desired_result $base");
    }
    
    next unless $desired_result.denominator == 1;
    
    # asech(Int) tests
    is_approx(sech(asech($desired_result.numerator)), $desired_result, 
              "asech(Int) - $desired_result default");
    for %official_base.keys -> $base {
        is_approx(sech(asech($desired_result.numerator, %official_base{$base}), %official_base{$base}), $desired_result, 
                  "asech(Int) - $desired_result $base");
    }
    
    # Int.asech tests
    is_approx($desired_result.numerator.asech.sech, $desired_result, 
              "Int.asech - $desired_result default");
    for %official_base.keys -> $base {
        is_approx($desired_result.numerator.asech(%official_base{$base}).sech(%official_base{$base}), $desired_result,
                  "Int.asech - $desired_result $base");
    }
}
        
done_testing;

# vim: ft=perl6 nomodifiable
