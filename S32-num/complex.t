use v6;

use Test;

plan 552;

# Basic tests functions specific to complex numbers.

is-deeply Complex.new, 0+0i, 'Complex.new() gives 0+0i';

isa-ok(1 + 2i, Complex, 'postfix:<i> creates a Complex number');
isa-ok(i, Complex, 'i creates a Complex number');
ok i == 1i, 'i == 1i';
ok 1 != 1i, '!= and complex numbers';

isa-ok((3)i, Complex, '($n)i form creates a Complex number');
isa-ok(3\i, Complex, '$n\i form creates a Complex number');

is-approx((2i)i, -2, 'postfix:<i> works on an imaginary number');
is-approx((2i + 3)i, -2 + 3i, 'postfix:<i> works on a Complex number');

# RT #104660
throws-like '(2 + 3i) > (2 + 2i)', Exception, '> comparison of complex numbers dies';
throws-like "(1 + 2i) < (2 + 4i)", Exception, 'Cannot arithmetically compare Complex numbers';

is-approx(i, 1i, 'standalone i works to generate a Complex number');
is-approx(1 - i, 1 - 1i, 'standalone i works to generate a Complex number');
is-approx(2i * i, -2, 'standalone i works times a Complex number');

# checked with the open CAS system "yacas":
# In> (3+4*I) / (2-I)
# Out> Complex(2/5,11/5)
# In> (3+4*I) * (2-I)
# Out> Complex(10,5)
# etc
is-approx (3+4i)/(2-1i), 2/5 + (11/5)i, 'Complex division';
is-approx (3+4i)*(2-1i), 10+5i,         'Complex multiplication';
is-approx (6+4i)/2,      3+2i,          'dividing Complex by a Real';
is-approx 2/(3+1i),      3/5 -(1/5)i,   'dividing a Real by a Complex';
is-approx 2 * (3+7i),    6+14i,         'Real * Complex';
is-approx (3+7i) * 2,    6+14i,         'Complex * Real';

isa-ok( EVAL((1+3i).perl), Complex, 'EVAL (1+3i).perl is Complex' );
is-approx( (EVAL (1+3i).perl), 1+3i, 'EVAL (1+3i).perl is 1+3i' );
isa-ok( EVAL((1+0i).perl), Complex, 'EVAL (1+0i).perl is Complex' );
is-approx( (EVAL (1+0i).perl), 1, 'EVAL (1+0i).perl is 1' );
isa-ok( EVAL((3i).perl), Complex, 'EVAL (3i).perl is Complex' );
is-approx( (EVAL (3i).perl), 3i, 'EVAL (3i).perl is 3i' );

#?niecza skip "NYI"
{
    ok (1+0i).Real ~~ Real, "(1+0i).Real is a Real";
    is (1+0i).Real, 1, "(1+0i).Real is 1";
    isa-ok (1.2+0i).Int, Int, "(1.2+0i).Int is an Int";
    is (1.2+0i).Int, 1, "(1.2+0i).Int is 1";
    isa-ok (1.2.sin+0i).Rat, Rat, "(1.2.sin+0i).Rat is an Rat";
    is-approx (1.2.sin+0i).Rat, 1.2.sin, "(1.2.sin+0i).Rat is 1.2.sin";
    isa-ok (1.2+0i).Num, Num, "(1.2+0i).Num is an Num";
    is-approx (1.2+0i).Num, 1.2, "(1.2+0i).Num is 1.2";
    isa-ok (1.2+1i).Complex, Complex, "(1.2+1i).Complex is an Complex";
    is-approx (1.2+1i).Complex, 1.2+1i, "(1.2+1i).Complex is 1.2+1i";
}

# MUST: test .Str

my @examples = (0i, 1 + 0i, -1 + 0i, 1i, -1i, 2 + 0i, -2 + 0i, 2i, -2i,
                2 + 3i, 2 - 3i, -2 + 3i, -2 - 3i);

append @examples, cis(1.1), cis(3.1), cis(5.1), 35.unpolar(0.8), 40.unpolar(3.7);

for @examples -> $z {
    is-approx($z + 0, $z, "$z + 0 = $z");
    is-approx(0 + $z, $z, "0 + $z = $z");
    is-approx($z + 0.0.Num, $z, "$z + 0.0.Num = $z");
    is-approx(0.0.Num + $z, $z, "0.0.Num + $z = $z");
    is-approx($z + 0 / 1, $z, "$z + 0/1 = $z");
    is-approx(0 / 1 + $z, $z, "0/1 + $z = $z");
    
    is-approx($z - 0, $z, "$z - 0 = $z");
    is-approx(0 - $z, -$z, "0 - $z = -$z");
    is-approx($z - 0.0.Num, $z, "$z - 0.0.Num = $z");
    is-approx(0.0.Num - $z, -$z, "0.0.Num - $z = -$z");
    is-approx($z - 0 / 1, $z, "$z - 0/1 = $z");
    is-approx(0 / 1 - $z, -$z, "0/1 - $z = -$z");

    is-approx($z + 2, $z.re + 2 + ($z.im)i, "$z + 2");
    is-approx(2 + $z, $z.re + 2 + ($z.im)i, "2 + $z");
    is-approx($z + 2.5.Num, $z.re + 2.5.Num + ($z.im)i, "$z + 2.5.Num = $z");
    is-approx(2.5.Num + $z, $z.re + 2.5.Num + ($z.im)i, "2.5.Num + $z = $z");
    is-approx($z + 3 / 2, $z.re + 3/2 + ($z.im)i, "$z + 3/2");
    is-approx(3 / 2 + $z, $z.re + 3/2 + ($z.im)i, "3/2 + $z");

    is-approx($z - 2, $z.re - 2 + ($z.im)i, "$z - 2");
    is-approx(2 - $z, -$z.re + 2 - ($z.im)i, "2 - $z");
    is-approx($z - 2.5.Num, $z.re - 2.5.Num + ($z.im)i, "$z - 2.5.Num = $z");
    is-approx(2.5.Num - $z, -$z.re + 2.5.Num - ($z.im)i, "2.5.Num - $z = $z");
    is-approx($z - 3 / 2, $z.re - 3/2 + ($z.im)i, "$z - 3/2");
    is-approx(3 / 2 - $z, -$z.re + 3/2 - ($z.im)i, "3/2 - $z");
}

# L<S32::Numeric/Complex/=item re>
# L<S32::Numeric/Complex/=item im>

{
    is (1 + 2i).re, 1, 'Complex.re works';
    is (1 + 2i).im, 2, 'Complex.im works';
}

{
    is-approx 0i ** 2, 0, "Complex 0 ** Int works";
    is-approx 0i ** 2.5, 0, "Complex 0 ** Rat works";
    is-approx 0i ** (2 + 0i), 0, "Complex 0 ** Complex works";
    is-approx 0 ** (2 + 0i), 0, "Real 0 ** Complex works";
}

# used to be RT #68848
{
    is-approx exp(3.0 * log(1i)), -1.83697e-16-1i,
              'exp(3.0 * log(1i))';
    sub iPower($a, $b) { exp($b * log($a)) };
    is-approx iPower(1i, 3.0), -1.83697e-16-1i, 'same as wrapped as sub';
}

is-approx e.log(1i), -2i / pi, "log e base i == -2i / pi";

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
{
  is (2+3i).conj, 2-3i, 'conj 2+3i -> 2-3i';
  is (5-4i).conj, 5+4i, 'conj 5-4i -> 5+4i';
}

{
    is <2+2i> cmp <2+2i>, Same, "<2+2i> cmp <2+2i>";
    is <2-2i> cmp <2-2i>, Same, "<2-2i> cmp <2-2i>";
    is <-2-2i> cmp <-2-2i>, Same, "<-2-2i> cmp <-2-2i>";
    is <-2+2i> cmp <-2+2i>, Same, "<-2+2i> cmp <-2+2i>";
    is <12+2i> cmp <2+2i>, More, "<12+2i> cmp <2+2i>";
    is <-2+2i> cmp <2+2i>, Less, "<-2+2i> cmp <2+2i>";
    is <2-12i> cmp <2-2i>, Less, "<2-12i> cmp <2-2i>";
    is <12-2i> cmp <2-2i>, More, "<12-2i> cmp <2-2i>";
    is <2+12i> cmp <2+2i>, More, "<2+12i> cmp <2+2i>";
    is <2-12i> cmp <2-2i>, Less, "<2-12i> cmp <2-2i>";
    is <2+2i> cmp <12+2i>, Less, "<2+2i> cmp <12+2i>";
    is <2+2i> cmp <12+2i>, Less, "<2+2i> cmp <12+2i>";
    is <2+2i> cmp 2, More, "<2+2i> cmp 2";
    is <2-2i> cmp 2, Less, "<2-2i> cmp 2";
    is <2+0i> cmp 2, Same, "<2+0i> cmp 2";
    is 2 cmp <2-0i>, Same, "2 cmp <2-0i>";
    is 1 cmp <2-2i>, Less, "1 cmp <2-2i>";
    is 2 cmp <2+0i>, Same, "2 cmp <2+0i>";
    is 2 cmp <2-2i>, More, "2 cmp <2-2i>";
    is 2 cmp <2+2i>, Less, "2 cmp <2+2i>";
    is <NaN+0i> cmp <0+0i>, More, "<NaN+0i> cmp <0+0i>";
    is <0+NaNi> cmp <0+0i>, More, "<0+NaNi> cmp <0+0i>";
}

ok Num(exp i * π) == -1, 'Num(Complex) pays attention to $*TOLERANCE';
{
    my $*TOLERANCE = 1e-20;
    throws-like 'Num(exp i * π)', Exception, 'Num(Complex) pays attention to $*TOLERANCE';
}

{ # coverage; 2016-09-26
    is-deeply (42.5+72.7i).reals, (42.5e0, 72.7e0), '.reals';
    is ( 42.5+72.7i).floor,  42+72i, '.floor (+r+i)';
    is (-42.5+72.7i).floor, -43+72i, '.floor (-r+i)';
    is ( 42.5-72.7i).floor,  42-73i, '.floor (+r-i)';
    is (-42.5-72.7i).floor, -43-73i, '.floor (-r-i)';
}

{ # coverage; 2016-09-27
    is ( 42.5+72.7i).ceiling,  43+73i, '.ceiling (+r+i)';
    is (-42.5+72.7i).ceiling, -42+73i, '.ceiling (-r+i)';
    is ( 42.5-72.7i).ceiling,  43-72i, '.ceiling (+r-i)';
    is (-42.5-72.7i).ceiling, -42-72i, '.ceiling (-r-i)';

    is ( 42.5+72.7i).round,  43+73i, '.round (+r+i), .5r';
    is (-42.5+72.3i).round, -42+72i, '.round (-r+i), .5r';
    is ( 42.5-72.7i).round,  43-73i, '.round (+r-i), .5r';
    is (-42.5-72.3i).round, -42-72i, '.round (-r-i), .5r';

    is ( 42.3+72.5i).round,  42+73i, '.round (+r+i), .5i';
    is (-42.3+72.5i).round, -42+73i, '.round (-r+i), .5i';
    is ( 42.7-72.5i).round,  43-72i, '.round (+r-i), .5i';
    is (-42.7-72.5i).round, -43-72i, '.round (-r-i), .5i';

    is ( 42.5+72.5i).round,  43+73i, '.round (+r+i), .5r, .5i';
    is (-42.5+72.5i).round, -42+73i, '.round (-r+i), .5r, .5i';
    is ( 42.5-72.5i).round,  43-72i, '.round (+r-i), .5r, .5i';
    is (-42.5-72.5i).round, -42-72i, '.round (-r-i), .5r, .5i';

    is ( 42.5+72.7i).truncate,  42+72i, '.truncate (+r+i), .5r';
    is (-42.5+72.3i).truncate, -42+72i, '.truncate (-r+i), .5r';
    is ( 42.5-72.7i).truncate,  42-72i, '.truncate (+r-i), .5r';
    is (-42.5-72.3i).truncate, -42-72i, '.truncate (-r-i), .5r';

    is ( 42.3+72.5i).truncate,  42+72i, '.truncate (+r+i), .5i';
    is (-42.3+72.5i).truncate, -42+72i, '.truncate (-r+i), .5i';
    is ( 42.7-72.5i).truncate,  42-72i, '.truncate (+r-i), .5i';
    is (-42.7-72.5i).truncate, -42-72i, '.truncate (-r-i), .5i';

    is ( 42.5+72.5i).truncate,  42+72i, '.truncate (+r+i), .5r, .5i';
    is (-42.5+72.5i).truncate, -42+72i, '.truncate (-r+i), .5r, .5i';
    is ( 42.5-72.5i).truncate,  42-72i, '.truncate (+r-i), .5r, .5i';
    is (-42.5-72.5i).truncate, -42-72i, '.truncate (-r-i), .5r, .5i';

    is-deeply abs(3+4i),      5e0,     'abs(3+4i)';
    is-deeply abs(i),         1e0,     'abs(i)';
    cmp-ok    abs(1+i), '==', sqrt(2), 'abs(1+i)';

    subtest 'Real ≅ Complex' => {
        plan 6;

        cmp-ok 42,   '≅', 42+0i,         'Int, True';
        cmp-ok 42.0, '≅', 42+0i,         'Num, True';
        cmp-ok 42e0, '≅', 42+0i,         'Rat, True';
        is    (41     ≅   42+0i), False, 'Int, False';
        is    (41e0   ≅   42+0i), False, 'Num, False';
        is    (41.0   ≅   42+0i), False, 'Rat, False';
    }

    cmp-ok postfix:<i>(
            class :: does Numeric { multi method Numeric { 42 } }
           ), '==', 42i, 'i postfix with custom Numerics works';

    subtest 'Real <=> Complex' => {
        plan 6;

        is-deeply (42 <=> 42+0i), Order::Same, 'Same, zero i part';
        is-deeply (42 <=> 43+0i), Order::Less, 'Less, zero i part';
        is-deeply (42 <=> 41+0i), Order::More, 'More, zero i part';

        is-deeply (42 <=> 42+1e-15i), Order::Same, 'Same, negligible i part';
        is-deeply (42 <=> 43+1e-15i), Order::Less, 'Less, negligible i part';
        is-deeply (42 <=> 41+1e-15i), Order::More, 'More, negligible i part';
    }

}

# vim: ft=perl6
