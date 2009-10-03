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

# tan tests

for @sines -> $angle
{
    	next if abs(cos($angle.num('radians'))) < 1e-6;     my $desired_result = sin($angle.num('radians')) / cos($angle.num('radians'));

    # tan(Num)
    is_approx(tan($angle.num("radians")), $desired_result, 
              "tan(Num) - {$angle.num('radians')} default");
    for %official_base.keys -> $base {
        is_approx(tan($angle.num($base), %official_base{$base}), $desired_result, 
                  "tan(Num) - {$angle.num($base)} $base");
    }
    
    # tan(:x(Num))
    #?rakudo skip 'named args'
    is_approx(tan(:x($angle.num("radians"))), $desired_result, 
              "tan(:x(Num)) - {$angle.num('radians')} default");
    for %official_base.keys -> $base {
        #?rakudo skip 'named args'
        is_approx(tan(:x($angle.num($base)), :base(%official_base{$base})), $desired_result, 
                  "tan(:x(Num)) - {$angle.num($base)} $base");
    }

    # Num.tan tests
    is_approx($angle.num("radians").tan, $desired_result, 
              "Num.tan - {$angle.num('radians')} default");
    for %official_base.keys -> $base {
        is_approx($angle.num($base).tan(%official_base{$base}), $desired_result, 
                  "Num.tan - {$angle.num($base)} $base");
    }

    # tan(Rat)
    is_approx(tan($angle.rat("radians")), $desired_result, 
              "tan(Rat) - {$angle.rat('radians')} default");
    for %official_base.keys -> $base {
        is_approx(tan($angle.rat($base), %official_base{$base}), $desired_result, 
                  "tan(Rat) - {$angle.rat($base)} $base");
    }

    # tan(:x(Rat))
    #?rakudo skip 'named args'
    is_approx(tan(:x($angle.rat("radians"))), $desired_result, 
              "tan(:x(Rat)) - {$angle.rat('radians')} default");
    for %official_base.keys -> $base {
        #?rakudo skip 'named args'
        is_approx(tan(:x($angle.rat($base)), :base(%official_base{$base})), $desired_result, 
                  "tan(:x(Rat)) - {$angle.rat($base)} $base");
    }

    # Rat.tan tests
    is_approx($angle.rat("radians").tan, $desired_result, 
              "Rat.tan - {$angle.rat('radians')} default");
    for %official_base.keys -> $base {
        is_approx($angle.rat($base).tan(%official_base{$base}), $desired_result, 
                  "Rat.tan - {$angle.rat($base)} $base");
    }

    # tan(Int)
    is_approx(tan($angle.int("degrees"), %official_base{"degrees"}), $desired_result, 
              "tan(Int) - {$angle.int('degrees')} degrees");
    is_approx($angle.int('degrees').tan(%official_base{'degrees'}), $desired_result, 
              "Int.tan - {$angle.int('degrees')} degrees");

    # Complex tests
    my Complex $zp0 = $angle.complex(0.0, "radians");
    my Complex $sz0 = $desired_result + 0i;
    my Complex $zp1 = $angle.complex(1.0, "radians");
    my Complex $sz1 = { sin($_) / cos($_) }($zp1);
    my Complex $zp2 = $angle.complex(2.0, "radians");
    my Complex $sz2 = { sin($_) / cos($_) }($zp2);
    
    # tan(Complex) tests
    is_approx(tan($zp0), $sz0, "tan(Complex) - $zp0 default");
    is_approx(tan($zp1), $sz1, "tan(Complex) - $zp1 default");
    is_approx(tan($zp2), $sz2, "tan(Complex) - $zp2 default");
    
    for %official_base.keys -> $base {
        my Complex $z = $angle.complex(0.0, $base);
        is_approx(tan($z, %official_base{$base}), $sz0, "tan(Complex) - $z $base");
    
        $z = $angle.complex(1.0, $base);
        is_approx(tan($z, %official_base{$base}), $sz1, "tan(Complex) - $z $base");
                        
        $z = $angle.complex(2.0, $base);
        is_approx(tan($z, %official_base{$base}), $sz2, "tan(Complex) - $z $base");
    }
    
    # Complex.tan tests
    is_approx($zp0.tan, $sz0, "Complex.tan - $zp0 default");
    is_approx($zp1.tan, $sz1, "Complex.tan - $zp1 default");
    is_approx($zp2.tan, $sz2, "Complex.tan - $zp2 default");
    
    for %official_base.keys -> $base {
        my Complex $z = $angle.complex(0.0, $base);
        #?rakudo skip "Complex.tan plus base doesn't work yet"
        is_approx($z.tan(%official_base{$base}), $sz0, "Complex.tan - $z $base");
    
        $z = $angle.complex(1.0, $base);
        #?rakudo skip "Complex.tan plus base doesn't work yet"
        is_approx($z.tan(%official_base{$base}), $sz1, "Complex.tan - $z $base");
    
        $z = $angle.complex(2.0, $base);
        #?rakudo skip "Complex.tan plus base doesn't work yet"
        is_approx($z.tan(%official_base{$base}), $sz2, "Complex.tan - $z $base");
    }
}

is(tan(Inf), NaN, "tan(Inf) - default");
is(tan(-Inf), NaN, "tan(-Inf) - default");
for %official_base.keys -> $base
{
    is(tan(Inf,  %official_base{$base}), NaN, "tan(Inf) - $base");
    is(tan(-Inf, %official_base{$base}), NaN, "tan(-Inf) - $base");
}
        

# atan tests

for @sines -> $angle
{
    	next if abs(cos($angle.num('radians'))) < 1e-6;     my $desired_result = sin($angle.num('radians')) / cos($angle.num('radians'));

    # atan(Num) tests
    is_approx(tan(atan($desired_result)), $desired_result, 
              "atan(Num) - {$angle.num('radians')} default");
    for %official_base.keys -> $base {
        is_approx(tan(atan($desired_result, %official_base{$base}), %official_base{$base}), $desired_result, 
                  "atan(Num) - {$angle.num($base)} $base");
    }
    
    # atan(:x(Num))
    #?rakudo skip 'named args'
    is_approx(tan(atan(:x($desired_result))), $desired_result, 
              "atan(:x(Num)) - {$angle.num('radians')} default");
    for %official_base.keys -> $base {
        #?rakudo skip 'named args'
        is_approx(tan(atan(:x($desired_result), 
                                                           :base(%official_base{$base})), 
                                  %official_base{$base}), $desired_result, 
                  "atan(:x(Num)) - {$angle.num($base)} $base");
    }
    
    # Num.atan tests
    is_approx($desired_result.Num.atan.tan, $desired_result, 
              "atan(Num) - {$angle.num('radians')} default");
    for %official_base.keys -> $base {
        is_approx($desired_result.Num.atan(%official_base{$base}).tan(%official_base{$base}), $desired_result,
                  "atan(Num) - {$angle.num($base)} $base");
    }
    
    # atan(Complex) tests
    for ($desired_result + 0i, $desired_result + .5i, $desired_result + 2i) -> $z {
        is_approx(tan(atan($z)), $z, 
                  "atan(Complex) - {$angle.num('radians')} default");
        for %official_base.keys -> $base {
            is_approx(tan(atan($z, %official_base{$base}), %official_base{$base}), $z, 
                      "atan(Complex) - {$angle.num($base)} $base");
        }
        is_approx($z.atan.tan, $z, 
                  "Complex.atan - {$angle.num('radians')} default");
        for %official_base.keys -> $base {
            is_approx($z.atan(%official_base{$base}).tan(%official_base{$base}), $z, 
                      "Complex.atan - {$angle.num($base)} $base");
        }
    }
}

for (-2/2, -1/2, 1/2, 2/2) -> $desired_result
{
    # atan(Rat) tests
    is_approx(tan(atan($desired_result)), $desired_result, 
              "atan(Rat) - $desired_result default");
    for %official_base.keys -> $base {
        is_approx(tan(atan($desired_result, %official_base{$base}), %official_base{$base}), $desired_result, 
                  "atan(Rat) - $desired_result $base");
    }
    
    # Rat.atan tests
    is_approx($desired_result.atan.tan, $desired_result, 
              "atan(Rat) - $desired_result default");
    for %official_base.keys -> $base {
        is_approx($desired_result.atan(%official_base{$base}).tan(%official_base{$base}), $desired_result,
                  "atan(Rat) - $desired_result $base");
    }
    
    next unless $desired_result.denominator == 1;
    
    # atan(Int) tests
    is_approx(tan(atan($desired_result.numerator)), $desired_result, 
              "atan(Int) - $desired_result default");
    for %official_base.keys -> $base {
        is_approx(tan(atan($desired_result.numerator, %official_base{$base}), %official_base{$base}), $desired_result, 
                  "atan(Int) - $desired_result $base");
    }
    
    # Int.atan tests
    is_approx($desired_result.numerator.atan.tan, $desired_result, 
              "atan(Int) - $desired_result default");
    for %official_base.keys -> $base {
        is_approx($desired_result.numerator.atan(%official_base{$base}).tan(%official_base{$base}), $desired_result,
                  "atan(Int) - $desired_result $base");
    }
}
        
done_testing;

# vim: ft=perl6 nomodifiable
