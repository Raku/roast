use v6;

use Test;

plan *;

# Basic tests functions specific to complex numbers.

isa_ok(1 + 2i, Complex, 'postfix:<i> creates a Complex number');

is_approx((2i)i, -2, 'postfix:<i> works on an imaginary number');
is_approx((2i + 3)i, -2 + 3i, 'postfix:<i> works on a Complex number');

# checked with the open CAS system "yacas":
# In> (3+4*I) / (2-I)
# Out> Complex(2/5,11/5)
# In> (3+4*I) * (2-I)
# Out> Complex(10,5)
# etc
is_approx (3+4i)/(2-1i), 2/5 + (11/5)i, 'Complex division';
is_approx (3+4i)*(2-1i), 10+5i,         'Complex division';
is_approx (6+4i)/2,      3+2i,          'dividing Complex by a Real';
is_approx 2/(3+1i),      3/5 -(1/5)i,   'dividing a Real by a Complex';
is_approx 2 * (3+7i),    6+14i,         'Real * Complex';
is_approx (3+7i) * 2,    6+14i,         'Complex * Real';

isa_ok( eval((1+3i).perl), Complex, 'eval (1+3i).perl is Complex' );
is_approx( (eval (1+3i).perl), 1+3i, 'eval (1+3i).perl is 1+3i' );
isa_ok( eval((1+0i).perl), Complex, 'eval (1+0i).perl is Complex' );
is_approx( (eval (1+0i).perl), 1, 'eval (1+0i).perl is 1' );
isa_ok( eval((3i).perl), Complex, 'eval (3i).perl is Complex' );
is_approx( (eval (3i).perl), 3i, 'eval (3i).perl is 3i' );

# MUST: test .Str

my @examples = (0i, 1 + 0i, -1 + 0i, 1i, -1i, 2 + 0i, -2 + 0i, 2i, -2i,
                2 + 3i, 2 - 3i, -2 + 3i, -2 - 3i,
                cis(1.1), cis(3.1), cis(5.1), 35.unpolar(0.8), 40.unpolar(3.7));

for @examples -> $z {
    is_approx($z + 0, $z, "$z + 0 = $z");
    is_approx(0 + $z, $z, "0 + $z = $z");
    is_approx($z + 0.0, $z, "$z + 0.0 = $z");
    is_approx(0.0 + $z, $z, "0.0 + $z = $z");
    is_approx($z + 0 / 1, $z, "$z + 0/1 = $z");
    is_approx(0 / 1 + $z, $z, "0/1 + $z = $z");
    
    is_approx($z - 0, $z, "$z - 0 = $z");
    is_approx(0 - $z, -$z, "0 - $z = -$z");
    is_approx($z - 0.0, $z, "$z - 0.0 = $z");
    is_approx(0.0 - $z, -$z, "0.0 - $z = -$z");
    is_approx($z - 0 / 1, $z, "$z - 0/1 = $z");
    is_approx(0 / 1 - $z, -$z, "0/1 - $z = -$z");
    
    is_approx($z + 2, $z.re + 2 + ($z.im)i, "$z + 2");
    is_approx(2 + $z, $z.re + 2 + ($z.im)i, "2 + $z");
    is_approx($z + 2.5, $z.re + 2.5 + ($z.im)i, "$z + 2.5 = $z");
    is_approx(2.5 + $z, $z.re + 2.5 + ($z.im)i, "2.5 + $z = $z");
    is_approx($z + 3 / 2, $z.re + 3/2 + ($z.im)i, "$z + 3/2");
    is_approx(3 / 2 + $z, $z.re + 3/2 + ($z.im)i, "3/2 + $z");

    is_approx($z - 2, $z.re - 2 + ($z.im)i, "$z - 2");
    is_approx(2 - $z, -$z.re + 2 - ($z.im)i, "2 - $z");
    is_approx($z - 2.5, $z.re - 2.5 + ($z.im)i, "$z - 2.5 = $z");
    is_approx(2.5 - $z, -$z.re + 2.5 - ($z.im)i, "2.5 - $z = $z");
    is_approx($z - 3 / 2, $z.re - 3/2 + ($z.im)i, "$z - 3/2");
    is_approx(3 / 2 - $z, -$z.re + 3/2 - ($z.im)i, "3/2 - $z");
}

# L<S32::Numeric/Complex/=item re>
# L<S32::Numeric/Complex/=item im>

{
    is (1 + 2i).re, 1, 'Complex.re works';
    is (1 + 2i).im, 2, 'Complex.im works';
}

# L<S32::Numeric/Num/=item cis>
my $pi = 3.141592653589793238;

{
    is_approx(cis(0),        1 + 0i,       "cis(0)     == 1");
    is_approx(cis($pi),      -1 + 0i,      "cis(pi)    == -1");
    is_approx(cis($pi / 2),  1i,           "cis(pi/2)  == i");
    is_approx(cis(3*$pi / 2),-1i,          "cis(3pi/2) == -i");
}

#?rakudo skip 'named args'
{
    is_approx(cis(:angle(0)),        1 + 0i,       "cis(:angle(0))     == 1");
    is_approx(cis(:angle($pi)),      -1 + 0i,      "cis(:angle(pi))    == -1");
    is_approx(cis(:angle($pi / 2)),  1i,           "cis(:angle(pi/2))  == i");
    is_approx(cis(:angle(3*$pi / 2)),-1i,          "cis(:angle(3pi/2)) == -i");
}

# Test that 1.unpolar == cis
# L<S32::Numeric/Num/=item cis>
# L<S32::Numeric/Num/=item unpolar>

{
    for 1..20 -> $i {
        my $angle = 2 * $pi * $i / 20;
        is_approx(cis($i), 1.unpolar($i), "cis(x) == 1.unpolar(x) No $i");
    }
}

# L<S32::Numeric/Num/=item abs>
# L<S32::Numeric/Num/=item unpolar>
#
# Test that unpolar() doesn't change the absolute value

{
    my $counter = 1;
    for 1..10 -> $abs {
        for 1..10 -> $a {
            my $angle = 2 * $pi * $a / 10;
            is_approx(abs($abs.unpolar($angle)), $abs,
                    "unpolar doesn't change the absolute value (No $counter)");
            $counter++;
        }
    }
}

# L<S32::Numeric/Num/=item unpolar>
#?rakudo skip 'named args'
{
    # Basic tests for unpolar()
    my $s = 2 * sqrt(2);

    is_approx(unpolar(:mag(4), 0),         4,     "unpolar(:mag(4), 0)    == 4");
    is_approx(unpolar(:mag(4), $pi/4),     $s + ($s)i ,"unpolar(:mag(4), pi/4) == 2+2i");
    is_approx(unpolar(:mag(4), $pi/2),     4i,    "unpolar(:mag(4), pi/2) == 4i");
    is_approx(unpolar(:mag(4), 3*$pi/4),   -$s + ($s)i,"unpolar(:mag(4), pi/4) == -2+2i");
    is_approx(unpolar(:mag(4), $pi),       -4,    "unpolar(:mag(4), pi)   == -4");
}

{
    # Basic tests for unpolar()
    my $s = 2 * sqrt(2);

    is_approx(4.unpolar(0),         4,     "4.unpolar(0)    == 4");
    is_approx(4.unpolar($pi/4),     $s + ($s)i ,"4.unpolar(pi/4) == 2+2i");
    is_approx(4.unpolar($pi/2),     4i,    "4.unpolar(pi/2) == 4i");
    is_approx(4.unpolar(3*$pi/4),   -$s + ($s)i,"4.unpolar(pi/4) == -2+2i");
    is_approx(4.unpolar($pi),       -4,    "4.unpolar(pi)   == -4");
}

done_testing;

# vim: ft=perl6
