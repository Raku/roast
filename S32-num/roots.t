use v6;
use Test;

plan 55;

# L<S32::Numeric/Numeric/"=item roots">

sub approx($a, $b){
    my ($x,$y);
    my $eps = 1e-3;
    # coerce both to Complex
    $x = $a + 0i;
    $y = $b + 0i;
    my $re = abs($x.re - $y.re);
    my $im = abs($x.im - $y.im);
    # both real and imag part must be with $eps of expected
    return ( $re < $eps && $im < $eps );
}

sub has_approx($n, @list) {
    for @list -> $i {
        if approx($i, $n) {
            return 1;
        }
    }
    return Mu;
}

{
    my @l = roots(0, 1);
    ok(@l.elems == 1, 'roots(0, 1) returns 1 element');
    ok(has_approx(0, @l), 'roots(0, 1) contains 0');
}
{
    my @l = roots(0, 0);
    ok(@l.elems == 1, 'roots(0, 0) returns 1 element');
    ok(@l[0] ~~ 'NaN', 'roots(0,0) returns NaN');
}
{
    my @l = roots(0, -1);
    ok(@l.elems == 1, 'roots(0, -1) returns 1 element');
    ok(@l[0] ~~ 'NaN', 'roots(0,-1) returns NaN');
}
{
    my @l = roots(100, -1);
    ok(@l.elems == 1, 'roots(100, -1) returns 1 element');
    ok(@l[0] ~~ 'NaN', 'roots(100,-1) returns NaN');
}
{
    my @m = roots(1, 0);
    ok(@m.elems == 1, 'roots(1, 0) returns 1 element');
    ok(@m[0] ~~ 'NaN', 'roots(1,0) returns NaN');
}
{
    my @m = roots(Inf, 0);
    ok(@m.elems == 1, 'roots(Inf, 0) returns 1 element');
    ok(@m[0] ~~ 'NaN', 'roots(Inf,0) returns NaN');
}
{
    my @m = roots(-Inf, 0);
    ok(@m.elems == 1, 'roots(-Inf, 0) returns 1 element');
    ok(@m[0] ~~ 'NaN', 'roots(-Inf,0) returns NaN');
}
{
    my @m = roots(NaN, 0);
    ok(@m.elems == 1, 'roots(NaN, 0) returns 1 element');
    ok(@m[0] ~~ 'NaN', 'roots(NaN,0) returns NaN');
}
{
    my @l = roots(4, 2);
    ok(@l.elems == 2, 'roots(4, 2) returns 2 elements');
    ok(has_approx(2, @l), 'roots(4, 2) contains 2');
    ok(has_approx(-2, @l), 'roots(4, 2) contains -2');
}
{
    my @l = roots(-1, 2);
    ok(@l.elems == 2, 'roots(-1, 2) returns 2 elements');
    ok(has_approx(1i, @l), 'roots(-1, 2) contains 1i');
    ok(has_approx(-1i, @l), 'roots(-1, 2) contains -1i');
}

#?pugs todo 'feature'
{
    my @l = 16.roots(4);
    ok(@l.elems == 4, '16.roots(4) returns 4 elements');
    ok(has_approx(2, @l), '16.roots(4) contains 2');
    ok(has_approx(-2, @l), '16.roots(4) contains -2');
    ok(has_approx(2i, @l), '16.roots(4) contains 2i');
    ok(has_approx(-2i, @l), '16.roots(4) contains -2i');
}
{
    my @l = (-1).roots(2);
    ok(@l.elems == 2, '(-1).roots(2) returns 2 elements');
    ok(has_approx(1i, @l), '(-1).roots(2) contains i');
    ok(has_approx(-1i, @l), '(-1).roots(2) contains -i');
}
{
    my @l = 0e0.roots(2);
    ok(@l.elems == 2, '0e0.roots(2) returns 2 elements');
    ok(has_approx(0, @l), '0e0.roots(2) contains 0');
}
{
    my @l = roots(NaN, 1);
    ok(@l.elems == 1, 'roots(NaN, 1) returns 1 element');
    #?rakudo todo 'NaN handling'
    ok(@l[0] ~~ NaN, 'roots(NaN,1) returns NaN');
}
{
    my @l = roots(Inf, 1);
    ok(@l.elems == 1, 'roots(Inf, 1) returns 1 element');
    ok(@l[0] ~~ Inf, 'roots(Inf,1) returns Inf');
}

my $pi = 312689/99532;

{
    my @l = roots(1i,2);
    ok(@l.elems == 2, 'roots(1i,2) returns 2 elements');
    ok(has_approx(exp(5i*$pi/4), @l), 'exp(5i*$pi/4) is a square root of i');
    ok(has_approx(exp(1i*$pi/4), @l), 'exp(1i*$pi/4) is a square root of i');
}
{
    my @l = roots(1+1i,2);
    ok(@l.elems == 2, 'roots(1+1i,2) returns 2 elements');
    ok(has_approx(exp(log(2)/4 + 1i*$pi/8), @l),'exp(log(2)/4 + 1i*$pi/8) is a square root of 1+1i');
    ok(has_approx(exp(log(2)/4 + 9i*$pi/8), @l),'exp(log(2)/4 + 9i*$pi/8) is a square root of 1+1i');
}
{
    my @l = 8.roots(3);
    ok(@l.elems == 3, '8.roots(3) returns 3 elements');
    ok(has_approx(2,@l), '2 is a cube root of 8');
    ok(has_approx(exp(1/3*(log(8) + 2i*$pi)),@l), 'exp(1/3*(log(8) + 2i*$pi)) is a cube root of 8');
    ok(has_approx(exp(1/3*(log(8) + 4i*$pi)),@l), 'exp(1/3*(log(8) + 4i*$pi)) is a cube root of 8');
}
{
    my @l = (-8).Num.roots(3);
    ok(@l.elems == 3, '(-8).roots(3) returns 3 elements');
    ok(has_approx(-2,@l), '2 is a cube root of -8');
    ok(has_approx(exp(1/3*(log(8) + 3i*$pi)),@l), 'exp(1/3*(log(8) + 3i*$pi)) is a cube root of -8');
    ok(has_approx(exp(1/3*(log(8) + 5i*$pi)),@l), 'exp(1/3*(log(8) + 5i*$pi)) is a cube root of -8');
}
{
    my @l = 8.5.roots(4);
    ok(@l.elems == 4, '8.5.roots(4) returns 4 elements');
    my $quartic = 8.5 ** .25;
    ok(has_approx($quartic, @l), '8.5 ** 1/4 is a quartic root of 8.5');
    ok(has_approx(-$quartic, @l), '-(8.5 ** 1/4) is a quartic root of 8.5');
    ok(has_approx($quartic\i, @l), '(8.5 ** 1/4)i is a quartic root of 8.5');
    ok(has_approx(-$quartic\i, @l), '-(8.5 ** 1/4)i is a quartic root of 8.5');
}

# vim: ft=perl6
