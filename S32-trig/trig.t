use v6;
use Test;
plan *;

=begin description

Basic tests for trigonometric functions.

=end description

# See also: L<"http://theory.cs.iitm.ernet.in/~arvindn/pi/"> :)
my $PI = 3.14159265358979323846264338327950288419716939937510;

# -- pi
is_approx(pi, $PI, "pi()");
is_approx(pi + 3, $PI + 3, "'pi() + 3' may drop its parentheses before +3");

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
            when "radians"     { $.angle_in_degrees / 180 * (355 / 113) }
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

# -- atan
# The basic form of atan (one argument) returns a value in ]-pi, pi[.
# Quadrants I, III
is_approx(atan(1)           / $PI * 180, 45, 'atan Q I & III - default');
is_approx(atan(1/3*sqrt(3)) / $PI * 180, 30, 'atan Q I & III - default');
is_approx(atan(sqrt(3))     / $PI * 180, 60, 'atan Q I & III - default');

is_approx(atan(1, 'degrees'), 45, 'atan Q I & III - degrees');
is_approx(atan(1/3*sqrt(3), 'degrees'), 30, 'atan Q I & III - degrees');
is_approx(atan(sqrt(3), 'degrees'), 60, 'atan Q I & III - degrees');

is_approx(atan(1, 'gradians'), 50, 'atan Q I & III - gradians');
is_approx(atan(1/3*sqrt(3), 'gradians'), 100/3, 'atan Q I & III - gradians');
is_approx(atan(sqrt(3), 'gradians'), 200/3, 'atan Q I & III - gradians');

is_approx(atan(1, 'radians')           / $PI * 180, 45, 'atan Q I & III - radians');
is_approx(atan(1/3*sqrt(3), 'radians') / $PI * 180, 30, 'atan Q I & III - radians');
is_approx(atan(sqrt(3), 'radians')     / $PI * 180, 60, 'atan Q I & III - radians');

is_approx(atan(1, 1), 1/8, 'atan Q I & III - revolutions');
is_approx(atan(1/3*sqrt(3), 1), 3/36, 'atan Q I & III - revolutions');
is_approx(atan(sqrt(3), 1), 1/6, 'atan Q I & III - revolutions');


# Quadrants II, IV
is_approx(atan(-1)           / $PI * 180, -45, 'atan Q II & IV - default');
is_approx(atan(-1/3*sqrt(3)) / $PI * 180, -30, 'atan Q II & IV - default');
is_approx(atan(-sqrt(3))     / $PI * 180, -60, 'atan Q II & IV - default');

is_approx(atan(-1, 'degrees'), -45, 'atan Q I & III - degrees');
is_approx(atan(-1/3*sqrt(3), 'degrees'), -30, 'atan Q I & III - degrees');
is_approx(atan(-sqrt(3), 'degrees'), -60, 'atan Q I & III - degrees');

is_approx(atan(-1, 'gradians'), -50, 'atan Q I & III - gradians');
is_approx(atan(-1/3*sqrt(3), 'gradians'), -100/3, 'atan Q I & III - gradians');
is_approx(atan(-sqrt(3), 'gradians'), -200/3, 'atan Q I & III - gradians');

is_approx(atan(-1, 'radians')           / $PI * 180, -45, 'atan Q II & IV - radians');
is_approx(atan(-1/3*sqrt(3), 'radians') / $PI * 180, -30, 'atan Q II & IV - radians');
is_approx(atan(-sqrt(3), 'radians')     / $PI * 180, -60, 'atan Q II & IV - radians');

is_approx(atan(-1, 1), -1/8, 'atan Q II & IV - revolutions');
is_approx(atan(-1/3*sqrt(3), 1), -3/36, 'atan Q II & IV - revolutions');
is_approx(atan(-sqrt(3), 1), -1/6, 'atan Q II & IV - revolutions');


is_approx(atan(Inf),   $PI / 2, 'arctan approaches pi/2 as x -> Inf (default)');
is_approx(atan(-Inf), -$PI / 2, 'arctan approaches -pi/2 as x-> -Inf (default)');

is_approx(atan(Inf, 'degrees'),   90, 'arctan approaches 90 as x -> Inf (degrees)');
is_approx(atan(-Inf, 'degrees'), -90, 'arctan approaches -90 as x-> -Inf (degrees)');

is_approx(atan(Inf, 'gradians'),   100, 'arctan approaches 100 as x -> Inf (gradians)');
is_approx(atan(-Inf, 'gradians'), -100, 'arctan approaches -100 as x-> -Inf (gradians)');

is_approx(atan(Inf, 'radians'),   $PI / 2, 'arctan approaches pi/2 as x -> Inf (radians)');
is_approx(atan(-Inf, 'radians'), -$PI / 2, 'arctan approaches -pi/2 as x-> -Inf (radians)');

is_approx(atan(Inf, 1),   1/4, 'arctan approaches 1/4 as x -> Inf (revolutions)');
is_approx(atan(-Inf, 1), -1/4, 'arctan approaches -1/4 as x-> -Inf (revolutions)' );


# S29: C<atan2> computes the arctangent of $y/$x, and
# **takes the quadrant into account**. The second argument is
# assumed to be 1 if it is not present.
# Quadrant I
is_approx(atan2(1, 1)           / $PI * 180, 45, 'atan2 - default (Q I)');
is_approx(atan2(1)              / $PI * 180, 45, 'atan2 - default (Q I)');
is_approx(atan2(1, sqrt(3))     / $PI * 180, 30, 'atan2 - default (Q I)');
is_approx(atan2(1, 1/3*sqrt(3)) / $PI * 180, 60, 'atan2 - default (Q I)');

is_approx(atan2(1, 1, 'degrees')          , 45, 'atan2 - degrees (Q I)');
is_approx(atan2(1, sqrt(3), 'degrees')    , 30, 'atan2 - degrees (Q I)');
is_approx(atan2(1, 1/3*sqrt(3), 'degrees'), 60, 'atan2 - degrees (Q I)');

is_approx(atan2(1, 1, 'gradians')          , 50, 'atan2 - gradians (Q I)');
is_approx(atan2(1, sqrt(3), 'gradians')    , 100/3, 'atan2 - gradians (Q I)');
is_approx(atan2(1, 1/3*sqrt(3), 'gradians'), 200/3, 'atan2 - gradians (Q I)');

is_approx(atan2(1, 1, 'radians')           / $PI * 180, 45, 'atan2 - radians (Q I)');
is_approx(atan2(1, sqrt(3), 'radians')     / $PI * 180, 30, 'atan2 - radians (Q I)');
is_approx(atan2(1, 1/3*sqrt(3), 'radians') / $PI * 180, 60, 'atan2 - radians (Q I)');

is_approx(atan2(1, 1, 1)          ,  1/8, 'atan2 - revolutions (Q I)');
is_approx(atan2(1, sqrt(3), 1)    , 3/36, 'atan2 - revolutions (Q I)');
is_approx(atan2(1, 1/3*sqrt(3), 1),  1/6, 'atan2 - revolutions (Q I)');


# Quadrant II
is_approx(atan2(1, -1)           / $PI * 180, 135, 'atan2 - default (Q II)');
is_approx(atan2(1, -1/3*sqrt(3)) / $PI * 180, 120, 'atan2 - default (Q II)');
is_approx(atan2(1, -sqrt(3))     / $PI * 180, 150, 'atan2 - default (Q II)');

is_approx(atan2(1, -1, 'degrees')          , 135, 'atan2 - degrees (Q II)');
is_approx(atan2(1, -1/3*sqrt(3), 'degrees'), 120, 'atan2 - degrees (Q II)');
is_approx(atan2(1, -sqrt(3), 'degrees')    , 150, 'atan2 - degrees (Q II)');

is_approx(atan2(1, -1, 'gradians')          , 150, 'atan2 - gradians (Q II)');
is_approx(atan2(1, -1/3*sqrt(3), 'gradians'), 133+1/3, 'atan2 - gradians (Q II)');
is_approx(atan2(1, -sqrt(3), 'gradians')    , 166+2/3, 'atan2 - gradians (Q II)');

is_approx(atan2(1, -1, 'radians')           / $PI * 180, 135, 'atan2 - radians (Q II)');
is_approx(atan2(1, -1/3*sqrt(3), 'radians') / $PI * 180, 120, 'atan2 - radians (Q II)');
is_approx(atan2(1, -sqrt(3), 'radians')     / $PI * 180, 150, 'atan2 - radians (Q II)');

is_approx(atan2(1, -1, 1)          ,  3/8, 'atan2 - revolutions (Q II)');
is_approx(atan2(1, -1/3*sqrt(3), 1),  1/3, 'atan2 - revolutions (Q II)');
is_approx(atan2(1, -sqrt(3), 1)    , 5/12, 'atan2 - revolutions (Q II)');


# Quadrant III
is_approx(atan2(-1, -1)           / $PI * 180 + 360, 225, 'atan2 - default (Q III)');
is_approx(atan2(-1, -sqrt(3))     / $PI * 180 + 360, 210, 'atan2 - default (Q III)');
is_approx(atan2(-1, -1/3*sqrt(3)) / $PI * 180 + 360, 240, 'atan2 - default (Q III)');

is_approx(atan2(-1, -1, 'degrees') + 360          , 225, 'atan2 - degrees (Q III)');
is_approx(atan2(-1, -sqrt(3), 'degrees') + 360    , 210, 'atan2 - degrees (Q III)');
is_approx(atan2(-1, -1/3*sqrt(3), 'degrees') + 360, 240, 'atan2 - degrees (Q III)');

is_approx(atan2(-1, -1, 'gradians') + 400          , 250, 'atan2 - gradians (Q III)');
is_approx(atan2(-1, -sqrt(3), 'gradians') + 400    , 233+1/3, 'atan2 - gradians (Q III)');
is_approx(atan2(-1, -1/3*sqrt(3), 'gradians') + 400, 266+2/3, 'atan2 - gradians (Q III)');

is_approx(atan2(-1, -1, 'radians')           / $PI * 180 + 360, 225, 'atan2 - radians (Q III)');
is_approx(atan2(-1, -sqrt(3), 'radians')     / $PI * 180 + 360, 210, 'atan2 - radians (Q III)');
is_approx(atan2(-1, -1/3*sqrt(3), 'radians') / $PI * 180 + 360, 240, 'atan2 - radians (Q III)');

is_approx(atan2(-1, -1, 1) + 1          , 225/360, 'atan2 - revolutions (Q III)');
is_approx(atan2(-1, -sqrt(3), 1) + 1    , 210/360, 'atan2 - revolutions (Q III)');
is_approx(atan2(-1, -1/3*sqrt(3), 1) + 1, 240/360, 'atan2 - revolutions (Q III)');


# Quadrant IV
is_approx(atan2(-1, 1)           / $PI * 180 + 360, 315, 'atan2 - default (Q IV)');
is_approx(atan2(-1)              / $PI * 180 + 360, 315, 'atan2 - default (Q IV)');
is_approx(atan2(-1, sqrt(3))     / $PI * 180 + 360, 330, 'atan2 - default (Q IV)');
is_approx(atan2(-1, 1/3*sqrt(3)) / $PI * 180 + 360, 300, 'atan2 - default (Q IV)');

is_approx(atan2(-1, 1, 'degrees') + 360          , 315, 'atan2 - degrees (Q IV)');
is_approx(atan2(-1, sqrt(3), 'degrees') + 360    , 330, 'atan2 - degrees (Q IV)');
is_approx(atan2(-1, 1/3*sqrt(3), 'degrees') + 360, 300, 'atan2 - degrees (Q IV)');

is_approx(atan2(-1, 1, 'gradians') + 400          , 350, 'atan2 - gradians (Q IV)');
is_approx(atan2(-1, sqrt(3), 'gradians') + 400    , 366+2/3, 'atan2 - gradians (Q IV)');
is_approx(atan2(-1, 1/3*sqrt(3), 'gradians') + 400, 333+1/3, 'atan2 - gradians (Q IV)');

is_approx(atan2(-1, 1, 'radians')           / $PI * 180 + 360, 315, 'atan2 - radians (Q IV)');
is_approx(atan2(-1, sqrt(3), 'radians')     / $PI * 180 + 360, 330, 'atan2 - radians (Q IV)');
is_approx(atan2(-1, 1/3*sqrt(3), 'radians') / $PI * 180 + 360, 300, 'atan2 - radians (Q IV)');

is_approx(atan2(-1, 1, 1) + 1          , 315/360, 'atan2 - revolutions (Q IV)');
is_approx(atan2(-1, sqrt(3), 1) + 1    , 330/360, 'atan2 - revolutions (Q IV)');
is_approx(atan2(-1, 1/3*sqrt(3), 1) + 1, 300/360, 'atan2 - revolutions (Q IV)');


# -- sin, cos, tan
	    
my %official_base = (
    "radians" => "radians",
    "gradians" => "gradians", 
    "degrees" => "degrees",
    "revolutions" => 1
);

# SHOULD BE IN COMPLEX.PM!
# but that doesn't work for some reason...

# For some reason, the default values mechanism is giving trouble here.
# So write this function out twice for now.

multi sub sin(Complex $a)
{
    $a.sin;
}

multi sub sin(Complex $a, $base)
{
    # Doing it this way allows us to bypass the default value mechanism
    ($a.re!to-radians($base) + $a.im!to-radians($base) * 1i).sin;
}

multi sub cos(Complex $a)
{
    $a.cos;
}

multi sub cos(Complex $a, $base)
{
    # Doing it this way allows us to bypass the default value mechanism
    ($a.re!to-radians($base) + $a.im!to-radians($base) * 1i).cos;
}

# END SHOULD BE IN COMPLEX.PM!

# sin
		
for @sines -> $angle
{
    my $sine = $angle.result;
    
    # sin(Num)
	is_approx(sin($angle.num("radians")), $sine, 
	          "sin(Num) - {$angle.num('radians')} default");
	for %official_base.keys -> $base {
	    is_approx(sin($angle.num($base), %official_base{$base}), $sine, 
	              "sin(Num) - {$angle.num($base)} $base");
	}
	              
    # Num.sin tests
    is_approx($angle.num("radians").sin, $sine, 
              "Num.sin - {$angle.num('radians')} default");
	for %official_base.keys -> $base {
	    is_approx($angle.num($base).sin(%official_base{$base}), $sine, 
	              "Num.sin - {$angle.num($base)} $base");
	}
	
	# sin(Rat)
	is_approx(sin($angle.rat("radians")), $sine, 
	          "sin(Rat) - {$angle.rat('radians')} default");
	for %official_base.keys -> $base {
	    is_approx(sin($angle.rat($base), %official_base{$base}), $sine, 
	              "sin(Rat) - {$angle.rat($base)} $base");
	}
	              
    # Rat.sin tests
    is_approx($angle.rat("radians").sin, $sine, 
              "Rat.sin - {$angle.rat('radians')} default");
	for %official_base.keys -> $base {
	    is_approx($angle.rat($base).sin(%official_base{$base}), $sine, 
	              "Rat.sin - {$angle.rat($base)} $base");
	}

    # sin(Int)
    is_approx(sin($angle.int("degrees"), %official_base{"degrees"}), $sine, 
              "sin(Int) - {$angle.int('degrees')} degrees");
    is_approx($angle.int('degrees').sin(%official_base{'degrees'}), $sine, 
              "Int.sin - {$angle.int('degrees')} degrees");

    # Complex tests
    my Complex $zp0 = $angle.complex(0.0, "radians");
    my Complex $sz0 = $sine + 0i;
    my Complex $zp1 = $angle.complex(1.0, "radians");
    my Complex $sz1 = (exp($zp1 * 1i) - exp(-$zp1 * 1i)) / 2i;
    my Complex $zp2 = $angle.complex(2.0, "radians");
    my Complex $sz2 = (exp($zp2 * 1i) - exp(-$zp2 * 1i)) / 2i;
    
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

is(sin(Inf), NaN, "sin - default");
is(sin(-Inf), NaN, "sin - default");
for %official_base.keys -> $base
{
    is(sin(Inf,  %official_base{$base}), NaN, "sin - $base");
    is(sin(-Inf, %official_base{$base}), NaN, "sin - $base");
}

# cos
		
for @cosines -> $angle
{
    my $cosine = $angle.result;
    
    # cos(Num)
	is_approx(cos($angle.num("radians")), $cosine, 
	          "cos(Num) - {$angle.num('radians')} default");
	for %official_base.keys -> $base {
	    is_approx(cos($angle.num($base), %official_base{$base}), $cosine, 
	              "cos(Num) - {$angle.num($base)} $base");
	}
	              
    # Num.cos tests
    is_approx($angle.num("radians").cos, $cosine, 
              "Num.cos - {$angle.num('radians')} default");
	for %official_base.keys -> $base {
	    is_approx($angle.num($base).cos(%official_base{$base}), $cosine, 
	              "Num.cos - {$angle.num($base)} $base");
	}
	
	# cos(Rat)
	is_approx(cos($angle.rat("radians")), $cosine, 
	          "cos(Rat) - {$angle.rat('radians')} default");
	for %official_base.keys -> $base {
	    is_approx(cos($angle.rat($base), %official_base{$base}), $cosine, 
	              "cos(Rat) - {$angle.rat($base)} $base");
	}
	              
    # Rat.cos tests
    is_approx($angle.rat("radians").cos, $cosine, 
              "Rat.cos - {$angle.rat('radians')} default");
	for %official_base.keys -> $base {
	    is_approx($angle.rat($base).cos(%official_base{$base}), $cosine, 
	              "Rat.cos - {$angle.rat($base)} $base");
	}

    # cos(Int)
    is_approx(cos($angle.int("degrees"), %official_base{"degrees"}), $cosine, 
              "cos(Int) - {$angle.int('degrees')} degrees");
    is_approx($angle.int('degrees').cos(%official_base{'degrees'}), $cosine, 
              "Int.cos - {$angle.int('degrees')} degrees");

    # Complex tests
    my Complex $zp0 = $angle.complex(0.0, "radians");
    my Complex $sz0 = $cosine + 0i;
    my Complex $zp1 = $angle.complex(1.0, "radians");
    my Complex $sz1 = (exp($zp1 * 1i) + exp(-$zp1 * 1i)) / 2.0;
    my Complex $zp2 = $angle.complex(2.0, "radians");
    my Complex $sz2 = (exp($zp2 * 1i) + exp(-$zp2 * 1i)) / 2.0;
    
    # cos(Complex) tests
    is_approx(cos($zp0), $sz0, "cos(Complex) - $zp0 default");
    is_approx(cos($zp1), $sz1, "cos(Complex) - $zp1 default");
    is_approx(cos($zp2), $sz2, "cos(Complex) - $zp2 default");
    
    for %official_base.keys -> $base {
        my Complex $z = $angle.complex(0.0, $base);
        is_approx(cos($z, %official_base{$base}), $sz0, "cos(Complex) - $z $base");
        
        $z = $angle.complex(1.0, $base);
        is_approx(cos($z, %official_base{$base}), $sz1, "cos(Complex) - $z $base");
        
        $z = $angle.complex(2.0, $base);
        is_approx(cos($z, %official_base{$base}), $sz2, "cos(Complex) - $z $base");
    }
    
    # Complex.cos tests
    is_approx($zp0.cos, $sz0, "Complex.cos - $zp0 default");
    is_approx($zp1.cos, $sz1, "Complex.cos - $zp1 default");
    is_approx($zp2.cos, $sz2, "Complex.cos - $zp2 default");
              
	for %official_base.keys -> $base {
        my Complex $z = $angle.complex(0.0, $base);
        #?rakudo skip "Complex.cos plus base doesn't work yet"
        is_approx($z.cos(%official_base{$base}), $sz0, "Complex.cos - $z $base");
        
        $z = $angle.complex(1.0, $base);
        #?rakudo skip "Complex.cos plus base doesn't work yet"
        is_approx($z.cos(%official_base{$base}), $sz1, "Complex.cos - $z $base");
        
        $z = $angle.complex(2.0, $base);
        #?rakudo skip "Complex.cos plus base doesn't work yet"
        is_approx($z.cos(%official_base{$base}), $sz2, "Complex.cos - $z $base");
    }
}

is(cos(Inf), NaN, "cos - default");
is(cos(-Inf), NaN, "cos - default");
for %official_base.keys -> $base
{
    is(cos(Inf,  %official_base{$base}), NaN, "cos - $base");
    is(cos(-Inf, %official_base{$base}), NaN, "cos - $base");
}

# tan
for @sines -> $angle
{
    next if abs(cos($angle.num("radians"))) < 1e-10; 
    my $tan = sin($angle.num("radians")) / cos($angle.num("radians"));
    
    # tan(Num)
	is_approx(tan($angle.num("radians")), $tan, 
	          "tan(Num) - {$angle.num('radians')} default");
	for %official_base.keys -> $base {
	    is_approx(tan($angle.num($base), %official_base{$base}), $tan, 
	              "tan(Num) - {$angle.num($base)} $base");
	}
	              
    # Num.tan tests
    is_approx($angle.num("radians").tan, $tan, 
              "Num.tan - {$angle.num('radians')} default");
	for %official_base.keys -> $base {
	    is_approx($angle.num($base).tan(%official_base{$base}), $tan, 
	              "Num.tan - {$angle.num($base)} $base");
	}
	
	# tan(Rat)
	is_approx(tan($angle.rat("radians")), $tan, 
	          "tan(Rat) - {$angle.rat('radians')} default");
	for %official_base.keys -> $base {
	    is_approx(tan($angle.rat($base), %official_base{$base}), $tan, 
	              "tan(Rat) - {$angle.rat($base)} $base");
	}
	              
    # Rat.tan tests
    is_approx($angle.rat("radians").tan, $tan, 
              "Rat.tan - {$angle.rat('radians')} default");
	for %official_base.keys -> $base {
	    is_approx($angle.rat($base).tan(%official_base{$base}), $tan, 
	              "Rat.tan - {$angle.rat($base)} $base");
	}

    # tan(Int)
    is_approx(tan($angle.int("degrees"), %official_base{"degrees"}), $tan, 
              "tan(Int) - {$angle.int('degrees')} degrees");
    is_approx($angle.int('degrees').tan(%official_base{'degrees'}), $tan, 
              "Int.tan - {$angle.int('degrees')} degrees");
}

is(tan(Inf), NaN, "tan - default");
is(tan(-Inf), NaN, "tan - default");
for %official_base.keys -> $base
{
    is(tan(Inf,  %official_base{$base}), NaN, "tan - $base");
    is(tan(-Inf, %official_base{$base}), NaN, "tan - $base");
}


# cotan
for @sines -> $angle
{
    next if abs(sin($angle.num("radians"))) < 1e-10; 
    my $cotan = cos($angle.num("radians")) / sin($angle.num("radians"));
    
    # cotan(Num)
	is_approx(cotan($angle.num("radians")), $cotan, 
	          "cotan(Num) - {$angle.num('radians')} default");
	for %official_base.keys -> $base {
	    is_approx(cotan($angle.num($base), %official_base{$base}), $cotan, 
	              "cotan(Num) - {$angle.num($base)} $base");
	}
	              
    # Num.cotan tests
    is_approx($angle.num("radians").cotan, $cotan, 
              "Num.cotan - {$angle.num('radians')} default");
	for %official_base.keys -> $base {
	    is_approx($angle.num($base).cotan(%official_base{$base}), $cotan, 
	              "Num.cotan - {$angle.num($base)} $base");
	}
	
	# cotan(Rat)
	is_approx(cotan($angle.rat("radians")), $cotan, 
	          "cotan(Rat) - {$angle.rat('radians')} default");
	for %official_base.keys -> $base {
	    is_approx(cotan($angle.rat($base), %official_base{$base}), $cotan, 
	              "cotan(Rat) - {$angle.rat($base)} $base");
	}
	              
    # Rat.cotan tests
    is_approx($angle.rat("radians").cotan, $cotan, 
              "Rat.cotan - {$angle.rat('radians')} default");
	for %official_base.keys -> $base {
	    is_approx($angle.rat($base).cotan(%official_base{$base}), $cotan, 
	              "Rat.cotan - {$angle.rat($base)} $base");
	}

    # cotan(Int)
    is_approx(cotan($angle.int("degrees"), %official_base{"degrees"}), $cotan, 
              "cotan(Int) - {$angle.int('degrees')} degrees");
    is_approx($angle.int('degrees').cotan(%official_base{'degrees'}), $cotan, 
              "Int.cotan - {$angle.int('degrees')} degrees");
}

is(cotan(Inf), NaN, "cotan - default");
is(cotan(-Inf), NaN, "cotan - default");
for %official_base.keys -> $base
{
    is(cotan(Inf,  %official_base{$base}), NaN, "cotan - $base");
    is(cotan(-Inf, %official_base{$base}), NaN, "cotan - $base");
}


# sec
for @cosines -> $angle
{
    next if $angle.result == 0.0;
    my $sec = 1.0 / $angle.result;
    
    # sec(Num)
	is_approx(sec($angle.num("radians")), $sec, 
	          "sec(Num) - {$angle.num('radians')} default");
	for %official_base.keys -> $base {
	    is_approx(sec($angle.num($base), %official_base{$base}), $sec, 
	              "sec(Num) - {$angle.num($base)} $base");
	}
	              
    # Num.sec tests
    is_approx($angle.num("radians").sec, $sec, 
              "Num.sec - {$angle.num('radians')} default");
	for %official_base.keys -> $base {
	    is_approx($angle.num($base).sec(%official_base{$base}), $sec, 
	              "Num.sec - {$angle.num($base)} $base");
	}
	
	# sec(Rat)
	is_approx(sec($angle.rat("radians")), $sec, 
	          "sec(Rat) - {$angle.rat('radians')} default");
	for %official_base.keys -> $base {
	    is_approx(sec($angle.rat($base), %official_base{$base}), $sec, 
	              "sec(Rat) - {$angle.rat($base)} $base");
	}
	              
    # Rat.sec tests
    is_approx($angle.rat("radians").sec, $sec, 
              "Rat.sec - {$angle.rat('radians')} default");
	for %official_base.keys -> $base {
	    is_approx($angle.rat($base).sec(%official_base{$base}), $sec, 
	              "Rat.sec - {$angle.rat($base)} $base");
	}

    # sec(Int)
    is_approx(sec($angle.int("degrees"), %official_base{"degrees"}), $sec, 
              "sec(Int) - {$angle.int('degrees')} degrees");
    is_approx($angle.int('degrees').sec(%official_base{'degrees'}), $sec, 
              "Int.sec - {$angle.int('degrees')} degrees");
}

is(sec(Inf), NaN, "sec - default");
is(sec(-Inf), NaN, "sec - default");
for %official_base.keys -> $base
{
    is(sec(Inf,  %official_base{$base}), NaN, "sec - $base");
    is(sec(-Inf, %official_base{$base}), NaN, "sec - $base");
}


# cosec
for @sines -> $angle
{
    next if $angle.result == 0.0;
    my $cosec = 1.0 / $angle.result;
    
    # cosec(Num)
	is_approx(cosec($angle.num("radians")), $cosec, 
	          "cosec(Num) - {$angle.num('radians')} default");
	for %official_base.keys -> $base {
	    is_approx(cosec($angle.num($base), %official_base{$base}), $cosec, 
	              "cosec(Num) - {$angle.num($base)} $base");
	}
	              
    # Num.cosec tests
    is_approx($angle.num("radians").cosec, $cosec, 
              "Num.cosec - {$angle.num('radians')} default");
	for %official_base.keys -> $base {
	    is_approx($angle.num($base).cosec(%official_base{$base}), $cosec, 
	              "Num.cosec - {$angle.num($base)} $base");
	}
	
	# cosec(Rat)
	is_approx(cosec($angle.rat("radians")), $cosec, 
	          "cosec(Rat) - {$angle.rat('radians')} default");
	for %official_base.keys -> $base {
	    is_approx(cosec($angle.rat($base), %official_base{$base}), $cosec, 
	              "cosec(Rat) - {$angle.rat($base)} $base");
	}
	              
    # Rat.cosec tests
    is_approx($angle.rat("radians").cosec, $cosec, 
              "Rat.cosec - {$angle.rat('radians')} default");
	for %official_base.keys -> $base {
	    is_approx($angle.rat($base).cosec(%official_base{$base}), $cosec, 
	              "Rat.cosec - {$angle.rat($base)} $base");
	}

    # cosec(Int)
    is_approx(cosec($angle.int("degrees"), %official_base{"degrees"}), $cosec, 
              "cosec(Int) - {$angle.int('degrees')} degrees");
    is_approx($angle.int('degrees').cosec(%official_base{'degrees'}), $cosec, 
              "Int.cosec - {$angle.int('degrees')} degrees");
}

is(cosec(Inf), NaN, "cosec - default");
is(cosec(-Inf), NaN, "cosec - default");
for %official_base.keys -> $base
{
    is(cosec(Inf,  %official_base{$base}), NaN, "cosec - $base");
    is(cosec(-Inf, %official_base{$base}), NaN, "cosec - $base");
}


# asin
is_approx(asin(0),            0, 'asin - default');
#?pugs 2 todo 'feature'
is_approx(asin(1/2*sqrt(2)),  1/4*$PI, 'asin - default');
is_approx(asin(1),            2/4*$PI, 'asin - default');

is_approx(asin(0, 'degrees'),            0, 'asin - degrees');
is_approx(asin(1/2*sqrt(2), 'degrees'), 45, 'asin - degrees');
is_approx(asin(1, 'degrees'),           90, 'asin - degrees');

is_approx(asin(0, 'gradians'),             0, 'asin - gradians');
is_approx(asin(1/2*sqrt(2), 'gradians'),  50, 'asin - gradians');
is_approx(asin(1, 'gradians'),           100, 'asin - gradians');

is_approx(asin(0, 'radians'),           0/4*$PI, 'asin - radians');
is_approx(asin(1/2*sqrt(2), 'radians'), 1/4*$PI, 'asin - radians');
is_approx(asin(1, 'radians'),           2/4*$PI, 'asin - radians');

is_approx(asin(0, 1),           0/8, 'asin - revolutions');
is_approx(asin(1/2*sqrt(2), 1), 1/8, 'asin - revolutions');
is_approx(asin(1, 1),           2/8, 'asin - revolutions');


# acos
#?pugs 2 todo 'feature'
is_approx(acos(0),           2/4*$PI, 'acos - default');
is_approx(acos(1/2*sqrt(2)), 1/4*$PI, 'acos - default');
is_approx(acos(1),           0/4*$PI, 'acos - default');

is_approx(acos(0, 'degrees'),           90, 'acos - degrees');
is_approx(acos(1/2*sqrt(2), 'degrees'), 45, 'acos - degrees');
is_approx(acos(1, 'degrees'),            0, 'acos - degrees');

is_approx(acos(0, 'gradians'),           100, 'acos - gradians');
is_approx(acos(1/2*sqrt(2), 'gradians'),  50, 'acos - gradians');
is_approx(acos(1, 'gradians'),             0, 'acos - gradians');

is_approx(acos(0, 'radians'),            2/4*$PI, 'acos - radians');
is_approx(acos(1/2*sqrt(2), 'radians'), 1/4*$PI, 'acos - radians');
is_approx(acos(1, 'radians'),            0/4*$PI, 'acos - radians');

is_approx(acos(0, 1),           2/8, 'acos - revolutions');
is_approx(acos(1/2*sqrt(2), 1), 1/8, 'acos - revolutions');
is_approx(acos(1, 1),           0/8, 'acos - revolutions');


# asec
is_approx(asec(-1.5707963267949), 2.26090341816943, 'asec - default');
is_approx(asec(1.5707963267949), 0.880689235420358, 'asec - default');

is_approx(asec(-1.5707963267949, 'degrees'), 129.54022374781, 'asec - degrees');
is_approx(asec(1.5707963267949, 'degrees'), 50.4597762521899, 'asec - degrees');

is_approx(asec(-1.5707963267949, 'gradians'), 143.933581942011, 'asec - gradians');
is_approx(asec(1.5707963267949, 'gradians'), 56.0664180579888, 'asec - gradians');

is_approx(asec(-1.5707963267949, 'radians'), 2.26090341816943, 'asec - radians');
is_approx(asec(1.5707963267949, 'radians'), 0.880689235420358, 'asec - radians');

is_approx(asec(-1.5707963267949, 1), 0.359833954855028, 'asec - revolutions');
is_approx(asec(1.5707963267949, 1), 0.140166045144972, 'asec - revolutions');


# cosh
my @coshes = ( 
    AngleAndResult.new(0, 1),
    AngleAndResult.new(45, (exp(pi / 4.0) + exp(-pi / 4.0)) / 2.0),
    AngleAndResult.new(90, (exp(pi / 2.0) + exp(-pi / 2.0)) / 2.0),
    AngleAndResult.new(180, (exp(pi) + exp(-pi)) / 2.0)
);

for @coshes -> $angle
{
    my $cosh = $angle.result;
    
    # cosh(Num)
	is_approx(cosh($angle.num("radians")), $cosh, 
	          "cosh(Num) - {$angle.num('radians')} default");
	for %official_base.keys -> $base {
	    is_approx(cosh($angle.num($base), %official_base{$base}), $cosh, 
	              "cosh(Num) - {$angle.num($base)} $base");
	}
	
	# MUST: Add all the other forms
}

is(cosh(Inf), Inf);
is(cosh(-Inf), Inf);


# sinh
my @sinhes = ( 
    AngleAndResult.new(0, 0.0),
    AngleAndResult.new(45, (exp(pi / 4.0) - exp(-pi / 4.0)) / 2.0),
    AngleAndResult.new(90, (exp(pi / 2.0) - exp(-pi / 2.0)) / 2.0),
    AngleAndResult.new(180, (exp(pi) - exp(-pi)) / 2.0)
);

for @sinhes -> $angle
{
    my $sinh = $angle.result;
    
    # sinh(Num)
	is_approx(sinh($angle.num("radians")), $sinh, 
	          "sinh(Num) - {$angle.num('radians')} default");
	for %official_base.keys -> $base {
	    is_approx(sinh($angle.num($base), %official_base{$base}), $sinh, 
	              "sinh(Num) - {$angle.num($base)} $base");
	}
	
	# MUST: Add all the other forms
}

# sech
for @coshes -> $angle
{
    my $sech = 1.0 / $angle.result;
    
    # sech(Num)
	is_approx(sech($angle.num("radians")), $sech, 
	          "sech(Num) - {$angle.num('radians')} default");
	for %official_base.keys -> $base {
	    is_approx(sech($angle.num($base), %official_base{$base}), $sech, 
	              "sech(Num) - {$angle.num($base)} $base");
	}
	
	# MUST: Add all the other forms
}


# tanh
my @tanhes = ( 
    AngleAndResult.new(0, 0.0),
    AngleAndResult.new(45, (exp(pi / 2.0) - 1.0) / (exp(pi / 2.0) + 1.0)),
    AngleAndResult.new(90, (exp(pi) - 1.0) / (exp(pi) + 1.0)),
    AngleAndResult.new(180, (exp(2.0 * pi) - 1.0) / (exp(2.0 * pi) + 1.0)),
);

for @tanhes -> $angle
{
    my $tanh = $angle.result;
    
    # tanh(Num)
	is_approx(tanh($angle.num("radians")), $tanh, 
	          "tanh(Num) - {$angle.num('radians')} default");
	for %official_base.keys -> $base {
	    is_approx(tanh($angle.num($base), %official_base{$base}), $tanh, 
	              "tanh(Num) - {$angle.num($base)} $base");
	}
	
	# MUST: Add all the other forms
}


# cosech
for @sinhes -> $angle
{
    next if $angle.result == 0.0;
    my $cosech = 1.0 / $angle.result;
    
    # cosech(Num)
	is_approx(cosech($angle.num("radians")), $cosech, 
	          "cosech(Num) - {$angle.num('radians')} default");
	for %official_base.keys -> $base {
	    is_approx(cosech($angle.num($base), %official_base{$base}), $cosech, 
	              "cosech(Num) - {$angle.num($base)} $base");
	}
	
	# MUST: Add all the other forms
}


# cotanh
for @tanhes -> $angle
{
    next if $angle.result == 0.0;
    my $cotanh = 1.0 / $angle.result;
    
    # cotanh(Num)
	is_approx(cotanh($angle.num("radians")), $cotanh, 
	          "cotanh(Num) - {$angle.num('radians')} default");
	for %official_base.keys -> $base {
	    is_approx(cotanh($angle.num($base), %official_base{$base}), $cotanh, 
	              "cotanh(Num) - {$angle.num($base)} $base");
	}
	
	# MUST: Add all the other forms
}


# acosh
is_approx(acosh(1.5707963267949), 1.02322747854755, 'acosh - default');
is_approx(acosh(3.14159265358979), 1.81152627246085, 'acosh - default');

is_approx(acosh(1.5707963267949, 'degrees'), 58.6266160025878, 'acosh - degrees');
is_approx(acosh(3.14159265358979, 'degrees'), 103.792809889073, 'acosh - degrees');

is_approx(acosh(1.5707963267949, 'gradians'), 65.1406844473198, 'acosh - gradians');
is_approx(acosh(3.14159265358979, 'gradians'), 115.325344321192, 'acosh - gradians');

is_approx(acosh(1.5707963267949, 'radians'), 1.02322747854755, 'acosh - radians');
is_approx(acosh(3.14159265358979, 'radians'), 1.81152627246085, 'acosh - radians');

is_approx(acosh(1.5707963267949, 1), 0.162851711118299, 'acosh - revolutions');
is_approx(acosh(3.14159265358979, 1), 0.28831336080298, 'acosh - revolutions');


# asinh
is_approx(asinh(1.5707963267949), 1.23340311751122, 'asinh - default');
is_approx(asinh(3.14159265358979), 1.86229574331085, 'asinh - default');

is_approx(asinh(1.5707963267949, 'degrees'), 70.6687930716712, 'asinh - degrees');
is_approx(asinh(3.14159265358979, 'degrees'), 106.70168629689, 'asinh - degrees');

is_approx(asinh(1.5707963267949, 'gradians'), 78.5208811907457, 'asinh - gradians');
is_approx(asinh(3.14159265358979, 'gradians'), 118.557429218767, 'asinh - gradians');

is_approx(asinh(1.5707963267949, 'radians'), 1.23340311751122, 'asinh - radians');
is_approx(asinh(3.14159265358979, 'radians'), 1.86229574331085, 'asinh - radians');

is_approx(asinh(1.5707963267949, 1), 0.196302202976864, 'asinh - revolutions');
is_approx(asinh(3.14159265358979, 1), 0.296393573046917, 'asinh - revolutions');


# asech
is_approx(asech(0.5), 1.31695789692482, 'asech - default');
is_approx(asech(1), 0, 'asech - default');

is_approx(asech(0.5, 'degrees'), 75.4561292902169, 'asech - degrees');
is_approx(asech(1, 'degrees'), 0, 'asech - degrees');

is_approx(asech(0.5, 'gradians'), 83.8401436557965, 'asech - gradians');
is_approx(asech(1, 'gradians'), 0, 'asech - gradians');

is_approx(asech(0.5, 'radians'), 1.31695789692482, 'asech - radians');
is_approx(asech(1, 'radians'), 0, 'asech - radians');

is_approx(asech(0.5, 1), 0.209600359139491, 'asech - revolutions');
is_approx(asech(1, 1), 0, 'asech - revolutions');


# atanh
is_approx(atanh(0), 0, 'atanh - default');
is_approx(atanh(0.5), 0.549306144334055, 'atanh - default');

is_approx(atanh(0, 'degrees'), 0, 'atanh - degrees');
is_approx(atanh(0.5, 'degrees'), 31.4729237309454, 'atanh - degrees');

is_approx(atanh(0, 'gradians'), 0, 'atanh - gradians');
is_approx(atanh(0.5, 'gradians'), 34.969915256606, 'atanh - gradians');

is_approx(atanh(0, 'radians'), 0, 'atanh - radians');
is_approx(atanh(0.5, 'radians'), 0.549306144334055, 'atanh - radians');

is_approx(atanh(0, 1), 0, 'atanh - revolutions');
is_approx(atanh(0.5, 1), 0.087424788141515, 'atanh - revolutions');


# cosec
for @sines -> $angle
{
    next if $angle.result == 0.0;
    my $cosec = 1.0 / $angle.result;
    
    # cosec(Num)
	is_approx(cosec($angle.num("radians")), $cosec, 
	          "cosec(Num) - {$angle.num('radians')} default");
	for %official_base.keys -> $base {
	    is_approx(cosec($angle.num($base), %official_base{$base}), $cosec, 
	              "cosec(Num) - {$angle.num($base)} $base");
	}
	
	# MUST: Add all the other forms
}


# acosec
is_approx(acosec(-1.5707963267949), -0.690107091374538, 'acosec - default');
is_approx(acosec(1.5707963267949), 0.690107091374538, 'acosec - default');

is_approx(acosec(-1.5707963267949, 'degrees'), -39.5402237478101, 'acosec - degrees');
is_approx(acosec(1.5707963267949, 'degrees'), 39.5402237478101, 'acosec - degrees');

is_approx(acosec(-1.5707963267949, 'gradians'), -43.9335819420112, 'acosec - gradians');
is_approx(acosec(1.5707963267949, 'gradians'), 43.9335819420112, 'acosec - gradians');

is_approx(acosec(-1.5707963267949, 'radians'), -0.690107091374538, 'acosec - radians');
is_approx(acosec(1.5707963267949, 'radians'), 0.690107091374538, 'acosec - radians');

is_approx(acosec(-1.5707963267949, 1), -0.109833954855028, 'acosec - revolutions');
is_approx(acosec(1.5707963267949, 1), 0.109833954855028, 'acosec - revolutions');


# acotan
is_approx(acotan(-1.5707963267949), -0.566911504941008, 'acotan - default');
is_approx(acotan(1.5707963267949), 0.566911504941008, 'acotan - default');

is_approx(acotan(-1.5707963267949, 'degrees'), -32.4816365905297, 'acotan - degrees');
is_approx(acotan(1.5707963267949, 'degrees'), 32.4816365905297, 'acotan - degrees');

is_approx(acotan(-1.5707963267949, 'gradians'), -36.0907073228108, 'acotan - gradians');
is_approx(acotan(1.5707963267949, 'gradians'), 36.0907073228108, 'acotan - gradians');

is_approx(acotan(-1.5707963267949, 'radians'), -0.566911504941008, 'acotan - radians');
is_approx(acotan(1.5707963267949, 'radians'), 0.566911504941008, 'acotan - radians');

is_approx(acotan(-1.5707963267949, 1), -0.0902267683070269, 'acotan - revolutions');
is_approx(acotan(1.5707963267949, 1), 0.0902267683070269, 'acotan - revolutions');


# acosech
is_approx(acosech(1.5707963267949), 0.599971479517856, 'acosech - default');
is_approx(acosech(3.14159265358979), 0.313165880450869, 'acosech - default');

is_approx(acosech(1.5707963267949, 'degrees'), 34.3758336045928, 'acosech - degrees');
is_approx(acosech(3.14159265358979, 'degrees'), 17.9430832373333, 'acosech - degrees');

is_approx(acosech(1.5707963267949, 'gradians'), 38.1953706717698, 'acosech - gradians');
is_approx(acosech(3.14159265358979, 'gradians'), 19.9367591525925, 'acosech - gradians');

is_approx(acosech(1.5707963267949, 'radians'), 0.599971479517856, 'acosech - radians');
is_approx(acosech(3.14159265358979, 'radians'), 0.313165880450869, 'acosech - radians');

is_approx(acosech(1.5707963267949, 1), 0.0954884266794246, 'acosech - revolutions');
is_approx(acosech(3.14159265358979, 1), 0.0498418978814813, 'acosech - revolutions');


# acotanh
is_approx(acotanh(-1.5707963267949), -0.752469267141925, 'acotanh - default');
is_approx(acotanh(1.5707963267949), 0.752469267141925, 'acotanh - default');

is_approx(acotanh(-1.5707963267949, 'degrees'), -43.1133132205344, 'acotanh - degrees');
is_approx(acotanh(1.5707963267949, 'degrees'), 43.1133132205344, 'acotanh - degrees');

is_approx(acotanh(-1.5707963267949, 'gradians'), -47.9036813561493, 'acotanh - gradians');
is_approx(acotanh(1.5707963267949, 'gradians'), 47.9036813561493, 'acotanh - gradians');

is_approx(acotanh(-1.5707963267949, 'radians'), -0.752469267141925, 'acotanh - radians');
is_approx(acotanh(1.5707963267949, 'radians'), 0.752469267141925, 'acotanh - radians');

is_approx(acotanh(-1.5707963267949, 1), -0.119759203390373, 'acotanh - revolutions');
is_approx(acotanh(1.5707963267949, 1), 0.119759203390373, 'acotanh - revolutions');


#?rakudo skip 'named args'
{

# -- atan
# The basic form of atan (one argument) returns a value in ]-pi, pi[.
# Quadrants I, III
is_approx(atan(:x(1))           / $PI * 180, 45);
is_approx(atan(:x(1/3*sqrt(3))) / $PI * 180, 30);
is_approx(atan(:x(sqrt(3)))     / $PI * 180, 60);

# Quadrants II, IV
is_approx(atan(:x(-1))           / $PI * 180, -45);
is_approx(atan(:x(-1/3*sqrt(3))) / $PI * 180, -30);
is_approx(atan(:x(-sqrt(3)))     / $PI * 180, -60);

# S29: C<atan2> computes the arctangent of $y/$x, and
# **takes the quadrant into account**. The second argument is
# assumed to be 1 if it is not present.
# Quadrant I
is_approx(atan2(:x(1), 1)           / $PI * 180, 45);
is_approx(atan2(:x(1))              / $PI * 180, 45);
is_approx(atan2(:x(1), sqrt(3))     / $PI * 180, 30);
is_approx(atan2(:x(1), 1/3*sqrt(3)) / $PI * 180, 60);

# Quadrant II
is_approx(atan2(:x(1), -1)           / $PI * 180, 135);
is_approx(atan2(:x(1), -1/3*sqrt(3)) / $PI * 180, 120);
is_approx(atan2(:x(1), -sqrt(3))     / $PI * 180, 150);

# Quadrant III
is_approx(atan2(x => -1, -1)           / $PI * 180 + 360, 225);
is_approx(atan2(x => -1, -sqrt(3))     / $PI * 180 + 360, 210);
is_approx(atan2(x => -1, -1/3*sqrt(3)) / $PI * 180 + 360, 240);

# Quadrant IV
is_approx(atan2(x => -1, 1)           / $PI * 180 + 360, 315);
is_approx(atan2(x => -1)              / $PI * 180 + 360, 315);
is_approx(atan2(x => -1, sqrt(3))     / $PI * 180 + 360, 330);
is_approx(atan2(x => -1, 1/3*sqrt(3)) / $PI * 180 + 360, 300);

# -- sin, cos, tan
# sin
is_approx(sin(:x(0/4*$PI)), 0);
is_approx(sin(:x(1/4*$PI)), 1/2*sqrt(2));
is_approx(sin(:x(2/4*$PI)), 1);
is_approx(sin(:x(3/4*$PI)), 1/2*sqrt(2));
is_approx(sin(:x(4/4*$PI)), 0);
is_approx(sin(:x(5/4*$PI)), -1/2*sqrt(2));
is_approx(sin(:x(6/4*$PI)), -1);
is_approx(sin(:x(7/4*$PI)), -1/2*sqrt(2));
is_approx(sin(:x(8/4*$PI)), 0);

# cos
is_approx(cos(:x(0/4*$PI)), 1);
is_approx(cos(:x(1/4*$PI)), 1/2*sqrt(2));
is_approx(cos(:x(2/4*$PI)), 0);
is_approx(cos(:x(3/4*$PI)), -1/2*sqrt(2));
is_approx(cos(:x(4/4*$PI)), -1);
is_approx(cos(:x(5/4*$PI)), -1/2*sqrt(2));
is_approx(cos(:x(6/4*$PI)), 0);
is_approx(cos(:x(7/4*$PI)), 1/2*sqrt(2));
is_approx(cos(:x(8/4*$PI)), 1);

# tan
is_approx(tan(:x(0/4*$PI)),  0);
is_approx(tan(:x(1/4*$PI)),  1);
is_approx(tan(:x(3/4*$PI)), -1);
is_approx(tan(:x(4/4*$PI)),  0);
is_approx(tan(:x(5/4*$PI)),  1);
is_approx(tan(:x(7/4*$PI)), -1);
is_approx(tan(:x(8/4*$PI)),  0);

# sec
is_approx(sec(:x(0)),    1);
is_approx(sec(:x($PI)), -1);


# asin
is_approx(asin(:x(0)),            0);
#?pugs 2 todo 'feature'
is_approx(asin(:x(1/2*sqrt(2))),  1/4*$PI);
is_approx(asin(:x(1)),            2/4*$PI);

# acos
#?pugs 2 todo 'feature'
is_approx(acos(:x(0)),            2/4*$PI);
is_approx(acos(:x(1/2*sqrt(2))),  1/4*$PI);
is_approx(acos(:x(1)),            0/4*$PI);


# cosh
is_approx( cosh(:x(0)), 1);
is_approx( cosh(:x(1)), 0.5*(exp(1) + exp(-1)) );

# sinh
is_approx( sinh(:x(0)), 0);
is_approx( sinh(:x(1)), 0.5*(exp(1) - exp(-1)) );

# asinh
is_approx( asinh(:x(0)), 0 );

# acosh
is_approx( acosh(:x(1)), 0 );

# tanh
is_approx( tanh(:x(0)), 0);
is_approx( tanh(:x(1)), sinh(1)/cosh(1) );

# atanh
is_approx( atanh(:x(0)), 0 );

# sech
is_approx( sech(:x(0)), 1 );

# cosech
is_approx( cosech(:x(2)), 1/sinh(2) );

# cotanh
is_approx( cotanh(:x(1)), 1/tanh(1) );

# asech
is_approx( asech(:x(1)), 0 );
# -- atan
# The basic form of atan (one argument) returns a value in ]-pi, pi[.
# Quadrants I, III
is_approx(atan(:x(1))           / $PI * 180, 45);
is_approx(atan(:x(1/3*sqrt(3))) / $PI * 180, 30);
is_approx(atan(:x(sqrt(3)))     / $PI * 180, 60);

# Quadrants II, IV
is_approx(atan(:x(-1))           / $PI * 180, -45);
is_approx(atan(:x(-1/3*sqrt(3))) / $PI * 180, -30);
is_approx(atan(:x(-sqrt(3)))     / $PI * 180, -60);

# S29: C<atan2> computes the arctangent of $y/$x, and
# **takes the quadrant into account**. The second argument is
# assumed to be 1 if it is not present.
# Quadrant I
is_approx(atan2(x => 1, 1)           / $PI * 180, 45);
is_approx(atan2(:x(1))              / $PI * 180, 45);
is_approx(atan2(x => 1, sqrt(3))     / $PI * 180, 30);
is_approx(atan2(x => 1, 1/3*sqrt(3)) / $PI * 180, 60);

# Quadrant II
is_approx(atan2(x => 1, -1)           / $PI * 180, 135);
is_approx(atan2(x => 1, -1/3*sqrt(3)) / $PI * 180, 120);
is_approx(atan2(x => 1, -sqrt(3))     / $PI * 180, 150);

# Quadrant III
is_approx(atan2(x => -1, -1)           / $PI * 180 + 360, 225);
is_approx(atan2(x => -1, -sqrt(3))     / $PI * 180 + 360, 210);
is_approx(atan2(x => -1, -1/3*sqrt(3)) / $PI * 180 + 360, 240);

# Quadrant IV
is_approx(atan2(x => -1, 1)           / $PI * 180 + 360, 315);
is_approx(atan2(x => -1)              / $PI * 180 + 360, 315);
is_approx(atan2(x => -1, sqrt(3))     / $PI * 180 + 360, 330);
is_approx(atan2(x => -1, 1/3*sqrt(3)) / $PI * 180 + 360, 300);

# -- sin, cos, tan
# sin
is_approx(sin(:x(0/4*$PI)), 0);
is_approx(sin(:x(1/4*$PI)), 1/2*sqrt(2));
is_approx(sin(:x(2/4*$PI)), 1);
is_approx(sin(:x(3/4*$PI)), 1/2*sqrt(2));
is_approx(sin(:x(4/4*$PI)), 0);
is_approx(sin(:x(5/4*$PI)), -1/2*sqrt(2));
is_approx(sin(:x(6/4*$PI)), -1);
is_approx(sin(:x(7/4*$PI)), -1/2*sqrt(2));
is_approx(sin(:x(8/4*$PI)), 0);

# cos
is_approx(cos(:x(0/4*$PI)), 1);
is_approx(cos(:x(1/4*$PI)), 1/2*sqrt(2));
is_approx(cos(:x(2/4*$PI)), 0);
is_approx(cos(:x(3/4*$PI)), -1/2*sqrt(2));
is_approx(cos(:x(4/4*$PI)), -1);
is_approx(cos(:x(5/4*$PI)), -1/2*sqrt(2));
is_approx(cos(:x(6/4*$PI)), 0);
is_approx(cos(:x(7/4*$PI)), 1/2*sqrt(2));
is_approx(cos(:x(8/4*$PI)), 1);

# tan
is_approx(tan(:x(0/4*$PI)),  0);
is_approx(tan(:x(1/4*$PI)),  1);
is_approx(tan(:x(3/4*$PI)), -1);
is_approx(tan(:x(4/4*$PI)),  0);
is_approx(tan(:x(5/4*$PI)),  1);
is_approx(tan(:x(7/4*$PI)), -1);
is_approx(tan(:x(8/4*$PI)),  0);

# sec
is_approx(sec(:x(0)),    1);
is_approx(sec(:x($PI)), -1);


# asin
is_approx(asin(:x(0)),            0);
#?pugs 2 todo 'feature'
is_approx(asin(:x(1/2*sqrt(2))),  1/4*$PI);
is_approx(asin(:x(1)),            2/4*$PI);

# acos
#?pugs 2 todo 'feature'
is_approx(acos(:x(0)),            2/4*$PI);
is_approx(acos(:x(1/2*sqrt(2))),  1/4*$PI);
is_approx(acos(:x(1)),            0/4*$PI);


# cosh
is_approx( cosh(:x(0)), 1);
is_approx( cosh(:x(1)), 0.5*(exp(1) + exp(-1)) );

# sinh
is_approx( sinh(:x(0)), 0);
is_approx( sinh(:x(1)), 0.5*(exp(1) - exp(-1)) );

# asinh
is_approx( asinh(:x(0)), 0 );

# acosh
is_approx( acosh(:x(1)), 0 );

# tanh
is_approx( tanh(:x(0)), 0);
is_approx( tanh(:x(1)), sinh(1)/cosh(1) );

# atanh
is_approx( atanh(:x(0)), 0 );

# sech
is_approx( sech(:x(0)), 1 );

# cosech
is_approx( cosech(:x(2)), 1/sinh(2) );

# cotanh
is_approx( cotanh(:x(1)), 1/tanh(1) );

# asech
is_approx( asech(:x(1)), 0 );
}

done_testing;

# vim: ft=perl6
