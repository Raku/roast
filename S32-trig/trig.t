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
# sin
my %sines = ( -360 => 0,
              135 - 360 => 1/2*sqrt(2),
              330 - 360 => -0.5,
              0 => 0,
              30 => 0.5,
			  45 => 1/2*sqrt(2),
			  90 => 1,
			  135 => 1/2*sqrt(2),
			  180 => 0,
			  225 => -1/2*sqrt(2),
			  270 => -1,
			  315 => -1/2*sqrt(2),
			  360 => 0,
              30 + 360 => 0.5,
			  225 + 360 => -1/2*sqrt(2),
              720 => 0
		    );
		
for %sines.kv -> $angle, $sine
{
	is_approx(sin( $angle/180*$PI), $sine, "sin - default");
	is_approx(sin( $angle/180*$PI, 'radians'), $sine, "sin - radians");
	is_approx(sin( $angle, 'degrees'), $sine, "sin - degrees");
	is_approx(sin( $angle/180*200, 'gradians'), $sine, "sin - gradians");
	is_approx(sin( $angle/360, 1), $sine, "sin - revolutions");
	
    # is_approx(sin($angle/180*$PI + 0i), $sine, "sin Complex - default");  
}

is(sin(Inf), NaN, "sin - default");
is(sin(-Inf), NaN, "sin - default");
for <degrees radians gradians revolutions> -> $base
{
    is(sin(Inf,  $base), NaN, "sin - $base");
    is(sin(-Inf, $base), NaN, "sin - $base");
}

# cos	
my %cosines;
for %sines.kv -> $angle, $sine
{
    %cosines{$angle - 90} = $sine;
}

for %cosines.kv -> $angle, $cosine
{
	is_approx(cos( $angle/180*$PI), $cosine, "cos - default");
	is_approx(cos( $angle/180*$PI, 'radians'), $cosine, "cos - radians");
	is_approx(cos( $angle, 'degrees'), $cosine, "cos - degrees");
	is_approx(cos( $angle/180*200, 'gradians'), $cosine, "cos - gradians");
	is_approx(cos( $angle/360, 1), $cosine, "cos - revolutions");
	
    # is_approx(cos($angle/180*$PI + 0i), $cosine, "cos Complex - default");  
}

is(cos(Inf), NaN, "cos - default");
is(cos(-Inf), NaN, "cos - default");
for <degrees radians gradians revolutions> -> $base
{
    is(cos(Inf,  $base), NaN, "cos - $base");
    is(cos(-Inf, $base), NaN, "cos - $base");
}

# tan
is_approx(tan(0/4*$PI),  0, "tan - default");
is_approx(tan(1/4*$PI),  1, "tan - default");
is_approx(tan(3/4*$PI), -1, "tan - default");
is_approx(tan(4/4*$PI),  0, "tan - default");
is_approx(tan(5/4*$PI),  1, "tan - default");
is_approx(tan(7/4*$PI), -1, "tan - default");
is_approx(tan(8/4*$PI),  0, "tan - default");
is(tan(Inf), NaN, "tan - default");
is(tan(-Inf), NaN, "tan - default");

is_approx(tan(  0, 'degrees'),  0, "tan - degrees");
is_approx(tan( 45, 'degrees'),  1, "tan - degrees");
is_approx(tan(135, 'degrees'), -1, "tan - degrees");
is_approx(tan(180, 'degrees'),  0, "tan - degrees");
is_approx(tan(225, 'degrees'),  1, "tan - degrees");
is_approx(tan(315, 'degrees'), -1, "tan - degrees");
is_approx(tan(360, 'degrees'),  0, "tan - degrees");
is(tan(Inf, 'degrees'), NaN, "tan - degrees");
is(tan(-Inf, 'degrees'), NaN, "tan - degrees");

is_approx(tan(  0, 'gradians'),  0, "tan - gradians");
is_approx(tan( 50, 'gradians'),  1, "tan - gradians");
is_approx(tan(150, 'gradians'), -1, "tan - gradians");
is_approx(tan(200, 'gradians'),  0, "tan - gradians");
is_approx(tan(250, 'gradians'),  1, "tan - gradians");
is_approx(tan(350, 'gradians'), -1, "tan - gradians");
is_approx(tan(400, 'gradians'),  0, "tan - gradians");
is(tan(Inf, 'gradians'), NaN, "tan - gradians");
is(tan(-Inf, 'gradians'), NaN, "tan - gradians");

is_approx(tan(0/4*$PI, 'radians'),  0, "tan - radians");
is_approx(tan(1/4*$PI, 'radians'),  1, "tan - radians");
is_approx(tan(3/4*$PI, 'radians'), -1, "tan - radians");
is_approx(tan(4/4*$PI, 'radians'),  0, "tan - radians");
is_approx(tan(5/4*$PI, 'radians'),  1, "tan - radians");
is_approx(tan(7/4*$PI, 'radians'), -1, "tan - radians");
is_approx(tan(8/4*$PI, 'radians'),  0, "tan - radians");
is(tan(Inf, 'radians'), NaN, "tan - radians");
is(tan(-Inf, 'radians'), NaN, "tan - radians");

is_approx(tan(0/8, 1),  0, "tan - revolutions");
is_approx(tan(1/8, 1),  1, "tan - revolutions");
is_approx(tan(3/8, 1), -1, "tan - revolutions");
is_approx(tan(4/8, 1),  0, "tan - revolutions");
is_approx(tan(5/8, 1),  1, "tan - revolutions");
is_approx(tan(7/8, 1), -1, "tan - revolutions");
is_approx(tan(8/8, 1),  0, "tan - revolutions");
is(tan(Inf, 1), NaN, "tan - revolutions");
is(tan(-Inf, 1), NaN, "tan - revolutions");


# sec
is_approx(sec(0),    1, 'sec - default');
is_approx(sec($PI), -1, 'sec - default');
is(sec(Inf), NaN, 'sec - default');
is(sec(-Inf), NaN, 'sec - default');

is_approx(sec(0, 'degrees'),    1, 'sec - degrees');
is_approx(sec(180, 'degrees'), -1, 'sec - degrees');
is(sec(Inf, 'degrees'), NaN, 'sec - degrees');
is(sec(-Inf, 'degrees'), NaN, 'sec - degrees');

is_approx(sec(0, 'gradians'),    1, 'sec - gradians');
is_approx(sec(200, 'gradians'), -1, 'sec - gradians');
is(sec(Inf, 'gradians'), NaN, 'sec - gradians');
is(sec(-Inf, 'gradians'), NaN, 'sec - gradians');

is_approx(sec(0, 'radians'),    1, 'sec - radians');
is_approx(sec($PI, 'radians'), -1, 'sec - radians');
is(sec(Inf, 'radians'), NaN, 'sec - radians');
is(sec(-Inf, 'radians'), NaN, 'sec - radians');

is_approx(sec(0, 1),    1, 'sec - revolutions');
is_approx(sec(4/8, 1), -1, 'sec - revolutions');
is(sec(Inf, 1), NaN, 'sec - revolutions');
is(sec(-Inf, 1), NaN, 'sec - revolutions');


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
is_approx(cosh(0), 1, 'cosh - default');
is_approx(cosh(1), 1.54308063481524, 'cosh - default');

is_approx(cosh(0, 'degrees'), 57.2957795130823, 'cosh - degrees');
is_approx(cosh(1, 'degrees'), 88.4120078232813, 'cosh - degrees');

is_approx(cosh(0, 'gradians'), 63.6619772367581, 'cosh - gradians');
is_approx(cosh(1, 'gradians'), 98.2355642480903, 'cosh - gradians');

is_approx(cosh(0, 'radians'), 1, 'cosh - radians');
is_approx(cosh(1, 'radians'), 1.54308063481524, 'cosh - radians');

is_approx(cosh(0, 1), 0.159154943091895, 'cosh - revolutions');
is_approx(cosh(1, 1), 0.245588910620226, 'cosh - revolutions');

is(cosh(Inf), Inf);
is(cosh(-Inf), Inf);


# sinh
is_approx(sinh(0), 0, 'sinh - default');
is_approx(sinh(1), 1.1752011936438, 'sinh - default');

is_approx(sinh(0, 'degrees'), 0, 'sinh - degrees');
is_approx(sinh(1, 'degrees'), 67.3340684745264, 'sinh - degrees');

is_approx(sinh(0, 'gradians'), 0, 'sinh - gradians');
is_approx(sinh(1, 'gradians'), 74.8156316383627, 'sinh - gradians');

is_approx(sinh(0, 'radians'), 0, 'sinh - radians');
is_approx(sinh(1, 'radians'), 1.1752011936438, 'sinh - radians');

is_approx(sinh(0, 1), 0, 'sinh - revolutions');
is_approx(sinh(1, 1), 0.187039079095907, 'sinh - revolutions');


# sech
is_approx(sech(0), 1, 'sech - default');
is_approx(sech(1), 0.648054273663885, 'sech - default');

is_approx(sech(0, 'degrees'), 57.2957795130823, 'sech - degrees');
is_approx(sech(1, 'degrees'), 37.1307747763567, 'sech - degrees');

is_approx(sech(0, 'gradians'), 63.6619772367581, 'sech - gradians');
is_approx(sech(1, 'gradians'), 41.2564164181741, 'sech - gradians');

is_approx(sech(0, 'radians'), 1, 'sech - radians');
is_approx(sech(1, 'radians'), 0.648054273663885, 'sech - radians');

is_approx(sech(0, 1), 0.159154943091895, 'sech - revolutions');
is_approx(sech(1, 1), 0.103141041045435, 'sech - revolutions');


# tanh
is_approx(tanh(0), 0, 'tanh - default');
is_approx(tanh(1), 0.761594155955765, 'tanh - default');

is_approx(tanh(0, 'degrees'), 0, 'tanh - degrees');
is_approx(tanh(1, 'degrees'), 43.6361308380935, 'tanh - degrees');

is_approx(tanh(0, 'gradians'), 0, 'tanh - gradians');
is_approx(tanh(1, 'gradians'), 48.4845898201039, 'tanh - gradians');

is_approx(tanh(0, 'radians'), 0, 'tanh - radians');
is_approx(tanh(1, 'radians'), 0.761594155955765, 'tanh - radians');

is_approx(tanh(0, 1), 0, 'tanh - revolutions');
is_approx(tanh(1, 1), 0.12121147455026, 'tanh - revolutions');


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
is_approx(cosec(-1.5707963267949), -1, 'cosec - default');
is_approx(cosec(1.5707963267949), 1, 'cosec - default');

is_approx(cosec(-1.5707963267949, 'degrees'), -57.2957795130823, 'cosec - degrees');
is_approx(cosec(1.5707963267949, 'degrees'), 57.2957795130823, 'cosec - degrees');

is_approx(cosec(-1.5707963267949, 'gradians'), -63.6619772367581, 'cosec - gradians');
is_approx(cosec(1.5707963267949, 'gradians'), 63.6619772367581, 'cosec - gradians');

is_approx(cosec(-1.5707963267949, 'radians'), -1, 'cosec - radians');
is_approx(cosec(1.5707963267949, 'radians'), 1, 'cosec - radians');

is_approx(cosec(-1.5707963267949, 1), -0.159154943091895, 'cosec - revolutions');
is_approx(cosec(1.5707963267949, 1), 0.159154943091895, 'cosec - revolutions');


# cotan
is_approx(cotan(-0.785398163397448), -1, 'cotan - default');
is_approx(cotan(0.785398163397448), 1, 'cotan - default');

is_approx(cotan(-0.785398163397448, 'degrees'), -57.2957795130824, 'cotan - degrees');
is_approx(cotan(0.785398163397448, 'degrees'), 57.2957795130824, 'cotan - degrees');

is_approx(cotan(-0.785398163397448, 'gradians'), -63.6619772367582, 'cotan - gradians');
is_approx(cotan(0.785398163397448, 'gradians'), 63.6619772367582, 'cotan - gradians');

is_approx(cotan(-0.785398163397448, 'radians'), -1, 'cotan - radians');
is_approx(cotan(0.785398163397448, 'radians'), 1, 'cotan - radians');

is_approx(cotan(-0.785398163397448, 1), -0.159154943091895, 'cotan - revolutions');
is_approx(cotan(0.785398163397448, 1), 0.159154943091895, 'cotan - revolutions');


# cosech
is_approx(cosech(-1.5707963267949), -0.434537208094694, 'cosech - default');
is_approx(cosech(1.5707963267949), 0.434537208094694, 'cosech - default');

is_approx(cosech(-1.5707963267949, 'degrees'), -24.897148065224, 'cosech - degrees');
is_approx(cosech(1.5707963267949, 'degrees'), 24.897148065224, 'cosech - degrees');

is_approx(cosech(-1.5707963267949, 'gradians'), -27.6634978502489, 'cosech - gradians');
is_approx(cosech(1.5707963267949, 'gradians'), 27.6634978502489, 'cosech - gradians');

is_approx(cosech(-1.5707963267949, 'radians'), -0.434537208094694, 'cosech - radians');
is_approx(cosech(1.5707963267949, 'radians'), 0.434537208094694, 'cosech - radians');

is_approx(cosech(-1.5707963267949, 1), -0.0691587446256221, 'cosech - revolutions');
is_approx(cosech(1.5707963267949, 1), 0.0691587446256221, 'cosech - revolutions');


# cotanh
is_approx(cotanh(-1.5707963267949), -1.09033141072737, 'cotanh - default');
is_approx(cotanh(1.5707963267949), 1.09033141072737, 'cotanh - default');

is_approx(cotanh(-1.5707963267949, 'degrees'), -62.4713881052233, 'cotanh - degrees');
is_approx(cotanh(1.5707963267949, 'degrees'), 62.4713881052233, 'cotanh - degrees');

is_approx(cotanh(-1.5707963267949, 'gradians'), -69.4126534502481, 'cotanh - gradians');
is_approx(cotanh(1.5707963267949, 'gradians'), 69.4126534502481, 'cotanh - gradians');

is_approx(cotanh(-1.5707963267949, 'radians'), -1.09033141072737, 'cotanh - radians');
is_approx(cotanh(1.5707963267949, 'radians'), 1.09033141072737, 'cotanh - radians');

is_approx(cotanh(-1.5707963267949, 1), -0.17353163362562, 'cotanh - revolutions');
is_approx(cotanh(1.5707963267949, 1), 0.17353163362562, 'cotanh - revolutions');


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
