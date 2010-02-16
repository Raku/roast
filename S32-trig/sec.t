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

# sec tests

for @cosines -> $angle
{
    	next if abs(cos($angle.num('radians'))) < 1e-6;     my $desired_result = 1.0 / cos($angle.num('radians'));

    # sec(Num)
    is_approx(sec($angle.num("radians")), $desired_result, 
              "sec(Num) - {$angle.num('radians')} default");
    for %official_base.keys -> $base {
        is_approx(sec($angle.num($base), %official_base{$base}), $desired_result, 
                  "sec(Num) - {$angle.num($base)} $base");
    }
    
    # sec(:x(Num))
    is_approx(sec(:x($angle.num("radians"))), $desired_result, 
              "sec(:x(Num)) - {$angle.num('radians')} default");
    for %official_base.keys -> $base {
        is_approx(sec(:x($angle.num($base)), :base(%official_base{$base})), $desired_result, 
                  "sec(:x(Num)) - {$angle.num($base)} $base");
    }

    # Num.sec tests
    is_approx($angle.num("radians").sec, $desired_result, 
              "Num.sec - {$angle.num('radians')} default");
    for %official_base.keys -> $base {
        is_approx($angle.num($base).sec(%official_base{$base}), $desired_result, 
                  "Num.sec - {$angle.num($base)} $base");
    }

    # sec(Rat)
    is_approx(sec($angle.rat("radians")), $desired_result, 
              "sec(Rat) - {$angle.rat('radians')} default");
    for %official_base.keys -> $base {
        is_approx(sec($angle.rat($base), %official_base{$base}), $desired_result, 
                  "sec(Rat) - {$angle.rat($base)} $base");
    }

    # sec(:x(Rat))
    is_approx(sec(:x($angle.rat("radians"))), $desired_result, 
              "sec(:x(Rat)) - {$angle.rat('radians')} default");
    for %official_base.keys -> $base {
        is_approx(sec(:x($angle.rat($base)), :base(%official_base{$base})), $desired_result, 
                  "sec(:x(Rat)) - {$angle.rat($base)} $base");
    }

    # Rat.sec tests
    is_approx($angle.rat("radians").sec, $desired_result, 
              "Rat.sec - {$angle.rat('radians')} default");
    for %official_base.keys -> $base {
        is_approx($angle.rat($base).sec(%official_base{$base}), $desired_result, 
                  "Rat.sec - {$angle.rat($base)} $base");
    }

    # sec(Int)
    is_approx(sec($angle.int("degrees"), %official_base{"degrees"}), $desired_result, 
              "sec(Int) - {$angle.int('degrees')} degrees");
    is_approx($angle.int('degrees').sec(%official_base{'degrees'}), $desired_result, 
              "Int.sec - {$angle.int('degrees')} degrees");

    # Complex tests
    my Complex $zp0 = $angle.complex(0.0, "radians");
    my Complex $sz0 = $desired_result + 0i;
    my Complex $zp1 = $angle.complex(1.0, "radians");
    my Complex $sz1 = { 1.0 / cos($_) }($zp1);
    my Complex $zp2 = $angle.complex(2.0, "radians");
    my Complex $sz2 = { 1.0 / cos($_) }($zp2);
    
    # sec(Complex) tests
    is_approx(sec($zp0), $sz0, "sec(Complex) - $zp0 default");
    is_approx(sec($zp1), $sz1, "sec(Complex) - $zp1 default");
    is_approx(sec($zp2), $sz2, "sec(Complex) - $zp2 default");
    
    for %official_base.keys -> $base {
        my Complex $z = $angle.complex(0.0, $base);
        is_approx(sec($z, %official_base{$base}), $sz0, "sec(Complex) - $z $base");
    
        $z = $angle.complex(1.0, $base);
        is_approx(sec($z, %official_base{$base}), $sz1, "sec(Complex) - $z $base");
                        
        $z = $angle.complex(2.0, $base);
        is_approx(sec($z, %official_base{$base}), $sz2, "sec(Complex) - $z $base");
    }
    
    # Complex.sec tests
    is_approx($zp0.sec, $sz0, "Complex.sec - $zp0 default");
    is_approx($zp1.sec, $sz1, "Complex.sec - $zp1 default");
    is_approx($zp2.sec, $sz2, "Complex.sec - $zp2 default");
    
    for %official_base.keys -> $base {
        my Complex $z = $angle.complex(0.0, $base);
        is_approx($z.sec(%official_base{$base}), $sz0, "Complex.sec - $z $base");
    
        $z = $angle.complex(1.0, $base);
        is_approx($z.sec(%official_base{$base}), $sz1, "Complex.sec - $z $base");
    
        $z = $angle.complex(2.0, $base);
        is_approx($z.sec(%official_base{$base}), $sz2, "Complex.sec - $z $base");
    }
}

is(sec(Inf), NaN, "sec(Inf) - default");
is(sec(-Inf), NaN, "sec(-Inf) - default");
for %official_base.keys -> $base
{
    is(sec(Inf,  %official_base{$base}), NaN, "sec(Inf) - $base");
    is(sec(-Inf, %official_base{$base}), NaN, "sec(-Inf) - $base");
}
        

# asec tests

for @cosines -> $angle
{
    	next if abs(cos($angle.num('radians'))) < 1e-6;     my $desired_result = 1.0 / cos($angle.num('radians'));

    # asec(Num) tests
    is_approx(sec(asec($desired_result)), $desired_result, 
              "asec(Num) - {$angle.num('radians')} default");
    for %official_base.keys -> $base {
        is_approx(sec(asec($desired_result, %official_base{$base}), %official_base{$base}), $desired_result, 
                  "asec(Num) - {$angle.num($base)} $base");
    }
    
    # asec(:x(Num))
    is_approx(sec(asec(:x($desired_result))), $desired_result, 
              "asec(:x(Num)) - {$angle.num('radians')} default");
    for %official_base.keys -> $base {
        is_approx(sec(asec(:x($desired_result), 
                                                           :base(%official_base{$base})), 
                                  %official_base{$base}), $desired_result, 
                  "asec(:x(Num)) - {$angle.num($base)} $base");
    }
    
    # Num.asec tests
    is_approx($desired_result.Num.asec.sec, $desired_result, 
              "Num.asec - {$angle.num('radians')} default");
    for %official_base.keys -> $base {
        is_approx($desired_result.Num.asec(%official_base{$base}).sec(%official_base{$base}), $desired_result,
                  "Num.asec - {$angle.num($base)} $base");
    }
    
    # asec(Complex) tests
    for ($desired_result + 0i, $desired_result + .5i, $desired_result + 2i) -> $z {
        is_approx(sec(asec($z)), $z, 
                  "asec(Complex) - {$angle.num('radians')} default");
        for %official_base.keys -> $base {
            is_approx(sec(asec($z, %official_base{$base}), %official_base{$base}), $z, 
                      "asec(Complex) - {$angle.num($base)} $base");
        }
        is_approx($z.asec.sec, $z, 
                  "Complex.asec - {$angle.num('radians')} default");
        for %official_base.keys -> $base {
            is_approx($z.asec(%official_base{$base}).sec(%official_base{$base}), $z, 
                      "Complex.asec - {$angle.num($base)} $base");
        }
    }
}

for (-3/2, -2/2, 2/2, 3/2) -> $desired_result
{
    # asec(Rat) tests
    is_approx(sec(asec($desired_result)), $desired_result, 
              "asec(Rat) - $desired_result default");
    for %official_base.keys -> $base {
        is_approx(sec(asec($desired_result, %official_base{$base}), %official_base{$base}), $desired_result, 
                  "asec(Rat) - $desired_result $base");
    }
    
    # Rat.asec tests
    is_approx($desired_result.asec.sec, $desired_result, 
              "Rat.asec - $desired_result default");
    for %official_base.keys -> $base {
        is_approx($desired_result.asec(%official_base{$base}).sec(%official_base{$base}), $desired_result,
                  "Rat.asec - $desired_result $base");
    }
    
    next unless $desired_result.denominator == 1;
    
    # asec(Int) tests
    is_approx(sec(asec($desired_result.numerator)), $desired_result, 
              "asec(Int) - $desired_result default");
    for %official_base.keys -> $base {
        is_approx(sec(asec($desired_result.numerator, %official_base{$base}), %official_base{$base}), $desired_result, 
                  "asec(Int) - $desired_result $base");
    }
    
    # Int.asec tests
    is_approx($desired_result.numerator.asec.sec, $desired_result, 
              "Int.asec - $desired_result default");
    for %official_base.keys -> $base {
        is_approx($desired_result.numerator.asec(%official_base{$base}).sec(%official_base{$base}), $desired_result,
                  "Int.asec - $desired_result $base");
    }
}
        
done_testing;

# vim: ft=perl6 nomodifiable
