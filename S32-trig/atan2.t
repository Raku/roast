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

# atan2 tests

# First, test atan2 with the default $x parameter of 1

for @sines -> $angle
{
    next if abs(cos($angle.num('radians'))) < 1e-6;     
	my $desired_result = sin($angle.num('radians')) / cos($angle.num('radians'));

    # atan2(Num) tests
    is_approx(tan(atan2($desired_result)), $desired_result, 
              "atan2(Num) - {$angle.num('radians')} default");
    
    # atan2(:y(Num))
    is_approx(tan(atan2(:y($desired_result))), $desired_result, 
              "atan2(:y(Num)) - {$angle.num('radians')} default");
    for %official_base.keys -> $base {
        is_approx(tan(atan2(:y($desired_result), :base(%official_base{$base})), 
                      %official_base{$base}), $desired_result, 
                  "atan2(:y(Num)) - {$angle.num($base)} $base");
    }
    
    # Num.atan2 tests
    is_approx($desired_result.Num.atan2.tan, $desired_result, 
              "atan2(Num) - {$angle.num('radians')} default");
}

for (-2/2, -1/2, 1/2, 2/2) -> $desired_result
{
    # atan2(Rat) tests
    is_approx(tan(atan2($desired_result)), $desired_result, 
              "atan2(Rat) - $desired_result default");
    
    # Rat.atan2 tests
    is_approx($desired_result.atan2.tan, $desired_result, 
              "atan2(Rat) - $desired_result default");
    
    next unless $desired_result.denominator == 1;
    
    # atan2(Int) tests
    is_approx(tan(atan2($desired_result.numerator)), $desired_result, 
              "atan2(Int) - $desired_result default");
    
    # Int.atan2 tests
    is_approx($desired_result.numerator.atan2.tan, $desired_result, 
              "atan2(Int) - $desired_result default");
}

# Now test the full atan2 interface

for @sines -> $angle
{
    next if abs(cos($angle.num('radians'))) < 1e-6;     
	my $desired_result = sin($angle.num('radians')) / cos($angle.num('radians'));

    # atan2(Num) tests
    is_approx(tan(atan2($desired_result, 1)), $desired_result, 
              "atan2(Num, 1) - {$angle.num('radians')} default");
    for %official_base.keys -> $base {
        is_approx(tan(atan2($desired_result, 1, %official_base{$base}), %official_base{$base}), $desired_result, 
                  "atan2(Num, 1) - {$angle.num($base)} $base");
    }
    
    # atan2(:x(Num))
    is_approx(tan(atan2(:y($desired_result), :x(1))), $desired_result, 
              "atan2(:x(Num), :y(1)) - {$angle.num('radians')} default");
    for %official_base.keys -> $base {
        is_approx(tan(atan2(:y($desired_result), :x(1), :base(%official_base{$base})), 
                                  %official_base{$base}), $desired_result, 
                  "atan2(:x(Num), :y(1)) - {$angle.num($base)} $base");
    }
    
    # # Num.atan2 tests
    # is_approx($desired_result.Num.atan2.tan, $desired_result, 
    #           "atan2(Num) - {$angle.num('radians')} default");
    # for %official_base.keys -> $base {
    #     is_approx($desired_result.Num.atan2(%official_base{$base}).tan(%official_base{$base}), $desired_result,
    #               "atan2(Num) - {$angle.num($base)} $base");
    # }
}

for (-2/2, -1/2, 1/2, 2/2) -> $desired_result
{
    # atan2(Rat) tests
    is_approx(tan(atan2($desired_result, 1)), $desired_result, 
              "atan2(Rat) - $desired_result default");
    for %official_base.keys -> $base {
        is_approx(tan(atan2($desired_result, 1, %official_base{$base}), %official_base{$base}), $desired_result, 
                  "atan2(Rat) - $desired_result $base");
    }
    
    # # Rat.atan2 tests
    # is_approx($desired_result.atan2.tan, $desired_result, 
    #           "atan2(Rat) - $desired_result default");
    # for %official_base.keys -> $base {
    #     is_approx($desired_result.atan2(%official_base{$base}).tan(%official_base{$base}), $desired_result,
    #               "atan2(Rat) - $desired_result $base");
    # }
    
    next unless $desired_result.denominator == 1;
    
    # atan2(Int) tests
    is_approx(tan(atan2($desired_result.numerator, 1)), $desired_result, 
              "atan2(Int) - $desired_result default");
    for %official_base.keys -> $base {
        is_approx(tan(atan2($desired_result.numerator, 1, %official_base{$base}), %official_base{$base}), $desired_result, 
                  "atan2(Int) - $desired_result $base");
    }
    
    # # Int.atan2 tests
    # is_approx($desired_result.numerator.atan2.tan, $desired_result, 
    #           "atan2(Int) - $desired_result default");
    # for %official_base.keys -> $base {
    #     is_approx($desired_result.numerator.atan2(%official_base{$base}).tan(%official_base{$base}), $desired_result,
    #               "atan2(Int) - $desired_result $base");
    # }
}

# check that the proper quadrant is returned

is_approx(atan2(4, 4, "degrees"), 45, "atan2(4, 4) is 45 degrees");
is_approx(atan2(-4, 4, "degrees"), -45, "atan2(-4, 4) is -45 degrees");
is_approx(atan2(4, -4, "degrees"), 135, "atan2(4, -4) is 135 degrees");
is_approx(atan2(-4, -4, "degrees"), -135, "atan2(-4, -4) is -135 degrees");

done_testing;

# vim: ft=perl6 nomodifiable
