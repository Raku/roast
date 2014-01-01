use v6;

use Test;

plan 488;

# Basic tests functions specific to complex numbers.

isa_ok(1 + 2i, Complex, 'postfix:<i> creates a Complex number');
#?pugs   2 skip 'i'
isa_ok(i, Complex, 'i creates a Complex number');
ok i == 1i, 'i == 1i';
ok 1 != 1i, '!= and complex numbers';

isa_ok((3)i, Complex, '($n)i form creates a Complex number');
#?pugs skip 'parsefail'
isa_ok(3\i, Complex, '$n\i form creates a Complex number');

#?pugs todo
is_approx((2i)i, -2, 'postfix:<i> works on an imaginary number');
#?pugs todo
is_approx((2i + 3)i, -2 + 3i, 'postfix:<i> works on a Complex number');

#?pugs todo
eval_dies_ok '(2 + 3i) > (2 + 2i)', '> comparison of complex numbers dies';

#?pugs   3 skip 'i'
is_approx(i, 1i, 'standalone i works to generate a Complex number');
is_approx(1 - i, 1 - 1i, 'standalone i works to generate a Complex number');
is_approx(2i * i, -2, 'standalone i works times a Complex number');

# checked with the open CAS system "yacas":
# In> (3+4*I) / (2-I)
# Out> Complex(2/5,11/5)
# In> (3+4*I) * (2-I)
# Out> Complex(10,5)
# etc
is_approx (3+4i)/(2-1i), 2/5 + (11/5)i, 'Complex division';
is_approx (3+4i)*(2-1i), 10+5i,         'Complex multiplication';
is_approx (6+4i)/2,      3+2i,          'dividing Complex by a Real';
is_approx 2/(3+1i),      3/5 -(1/5)i,   'dividing a Real by a Complex';
is_approx 2 * (3+7i),    6+14i,         'Real * Complex';
is_approx (3+7i) * 2,    6+14i,         'Complex * Real';

isa_ok( EVAL((1+3i).perl), Complex, 'EVAL (1+3i).perl is Complex' );
is_approx( (EVAL (1+3i).perl), 1+3i, 'EVAL (1+3i).perl is 1+3i' );
isa_ok( EVAL((1+0i).perl), Complex, 'EVAL (1+0i).perl is Complex' );
is_approx( (EVAL (1+0i).perl), 1, 'EVAL (1+0i).perl is 1' );
isa_ok( EVAL((3i).perl), Complex, 'EVAL (3i).perl is Complex' );
is_approx( (EVAL (3i).perl), 3i, 'EVAL (3i).perl is 3i' );

#?niecza skip "NYI"
{
    #?pugs 2 skip '.Real'
    ok (1+0i).Real ~~ Real, "(1+0i).Real is a Real";
    is (1+0i).Real, 1, "(1+0i).Real is 1";
    isa_ok (1.2+0i).Int, Int, "(1.2+0i).Int is an Int";
    is (1.2+0i).Int, 1, "(1.2+0i).Int is 1";
    isa_ok (1.2.sin+0i).Rat, Rat, "(1.2.sin+0i).Rat is an Rat";
    is_approx (1.2.sin+0i).Rat, 1.2.sin, "(1.2.sin+0i).Rat is 1.2.sin";
    isa_ok (1.2+0i).Num, Num, "(1.2+0i).Num is an Num";
    is_approx (1.2+0i).Num, 1.2, "(1.2+0i).Num is 1.2";
    #?pugs 2 skip '.Complex'
    isa_ok (1.2+1i).Complex, Complex, "(1.2+1i).Complex is an Complex";
    is_approx (1.2+1i).Complex, 1.2+1i, "(1.2+1i).Complex is 1.2+1i";
}

# MUST: test .Str

#?pugs skip 'cis, unpolar'
#?DOES 120
{
  # placeholder to hold the skip.
}

# reset for pugs
#?DOES 1

my @examples = (0i, 1 + 0i, -1 + 0i, 1i, -1i, 2 + 0i, -2 + 0i, 2i, -2i,
                2 + 3i, 2 - 3i, -2 + 3i, -2 - 3i);

#?pugs emit #
push @examples, (cis(1.1), cis(3.1), cis(5.1), 35.unpolar(0.8), 40.unpolar(3.7));

for @examples -> $z {
    is_approx($z + 0, $z, "$z + 0 = $z");
    is_approx(0 + $z, $z, "0 + $z = $z");
    is_approx($z + 0.0.Num, $z, "$z + 0.0.Num = $z");
    is_approx(0.0.Num + $z, $z, "0.0.Num + $z = $z");
    is_approx($z + 0 / 1, $z, "$z + 0/1 = $z");
    is_approx(0 / 1 + $z, $z, "0/1 + $z = $z");
    
    is_approx($z - 0, $z, "$z - 0 = $z");
    is_approx(0 - $z, -$z, "0 - $z = -$z");
    is_approx($z - 0.0.Num, $z, "$z - 0.0.Num = $z");
    is_approx(0.0.Num - $z, -$z, "0.0.Num - $z = -$z");
    is_approx($z - 0 / 1, $z, "$z - 0/1 = $z");
    is_approx(0 / 1 - $z, -$z, "0/1 - $z = -$z");

    #?pugs 6 skip '.re,.im'
    is_approx($z + 2, $z.re + 2 + ($z.im)i, "$z + 2");
    is_approx(2 + $z, $z.re + 2 + ($z.im)i, "2 + $z");
    is_approx($z + 2.5.Num, $z.re + 2.5.Num + ($z.im)i, "$z + 2.5.Num = $z");
    is_approx(2.5.Num + $z, $z.re + 2.5.Num + ($z.im)i, "2.5.Num + $z = $z");
    is_approx($z + 3 / 2, $z.re + 3/2 + ($z.im)i, "$z + 3/2");
    is_approx(3 / 2 + $z, $z.re + 3/2 + ($z.im)i, "3/2 + $z");

    #?pugs 6 skip '.re,.im'
    is_approx($z - 2, $z.re - 2 + ($z.im)i, "$z - 2");
    is_approx(2 - $z, -$z.re + 2 - ($z.im)i, "2 - $z");
    is_approx($z - 2.5.Num, $z.re - 2.5.Num + ($z.im)i, "$z - 2.5.Num = $z");
    is_approx(2.5.Num - $z, -$z.re + 2.5.Num - ($z.im)i, "2.5.Num - $z = $z");
    is_approx($z - 3 / 2, $z.re - 3/2 + ($z.im)i, "$z - 3/2");
    is_approx(3 / 2 - $z, -$z.re + 3/2 - ($z.im)i, "3/2 - $z");
}

# L<S32::Numeric/Complex/=item re>
# L<S32::Numeric/Complex/=item im>

#?pugs skip 'NYI'
#?DOES 2
{
    is (1 + 2i).re, 1, 'Complex.re works';
    is (1 + 2i).im, 2, 'Complex.im works';
}

{
    is_approx 0i ** 2, 0, "Complex 0 ** Int works";
    #?pugs todo
    is_approx 0i ** 2.5, 0, "Complex 0 ** Rat works";
    is_approx 0i ** (2 + 0i), 0, "Complex 0 ** Complex works";
    is_approx 0 ** (2 + 0i), 0, "Real 0 ** Complex works";
}

# used to be RT #68848
{
    is_approx exp(3.0 * log(1i)), -1.83697e-16-1i,
              'exp(3.0 * log(1i))';
    sub iPower($a, $b) { exp($b * log($a)) };
    is_approx iPower(1i, 3.0), -1.83697e-16-1i, 'same as wrapped as sub';
}

#?pugs   skip 'e'
is_approx e.log(1i), -2i / pi, "log e base i == -2i / pi";

# Complex math with strings, to make sure type coercion is working correctly
{
    is 3i + "1", 1 + 3i, '3i + "1"';
    is "1" + 3i, 1 + 3i, '"1" + 3i';
    is 3i - "1", 3i - 1, '3i - "1"';
    is "1" - 3i, 1 - 3i, '"1" - 3i';
    is 3i * "1", 3i * 1, '3i * "1"';
    is "1" * 3i, 1 * 3i, '"1" * 3i';
    is 3i / "1", 3i / 1, '3i / "1"';
    is "1" / 3i, 1 / 3i, '"1" / 3i';
    is 3i ** "1", 3i ** 1, '3i ** "1"';
    is "1" ** 3i, 1 ** 3i, '"1" ** 3i';
    
}

# Conjugation
#?pugs skip '.conj'
#?DOES 2
{
  is (2+3i).conj, 2-3i, 'conj 2+3i -> 2-3i';
  is (5-4i).conj, 5+4i, 'conj 5-4i -> 5+4i';
}

#?pugs todo
eval_dies_ok "(1 + 2i) < (2 + 4i)", 'Cannot arithmetically compare Complex numbers';

done;

# vim: ft=perl6
