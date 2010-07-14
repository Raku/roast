# WARNING:
# This is a generated file and should not be edited directly.
# look into generate-tests.pl instead

use v6;
use Test;
BEGIN { @*INC.push("t/spec/packages/") };
use TrigTestSupport;


# cosec tests

my $base_list = (TrigTest::official_bases() xx *).flat;
my $iter_count = 0;
for TrigTest::sines() -> $angle
{
    next if abs(sin($angle.num(Radians))) < 1e-6;
    my $desired-result = 1.0 / sin($angle.num(Radians));

    # Num.cosec tests -- very thorough
    is_approx($angle.num(Radians).cosec, $desired-result, 
              "Num.cosec - {$angle.num(Radians)} default");
    for TrigTest::official_bases() -> $base {
        is_approx($angle.num($base).cosec($base), $desired-result, 
                  "Num.cosec - {$angle.num($base)} $base");
    }

    # Complex.cosec tests -- also very thorough
    my Complex $zp0 = $angle.complex(0.0, Radians);
    my Complex $sz0 = $desired-result + 0i;
    my Complex $zp1 = $angle.complex(1.0, Radians);
    my Complex $sz1 = { 1.0 / sin($_) }($zp1);
    my Complex $zp2 = $angle.complex(2.0, Radians);
    my Complex $sz2 = { 1.0 / sin($_) }($zp2);
    
    is_approx($zp0.cosec, $sz0, "Complex.cosec - $zp0 default");
    is_approx($zp1.cosec, $sz1, "Complex.cosec - $zp1 default");
    is_approx($zp2.cosec, $sz2, "Complex.cosec - $zp2 default");
    
    for TrigTest::official_bases() -> $base {
        my Complex $z = $angle.complex(0.0, $base);
        is_approx($z.cosec($base), $sz0, "Complex.cosec - $z $base");
    
        $z = $angle.complex(1.0, $base);
        is_approx($z.cosec($base), $sz1, "Complex.cosec - $z $base");
    
        $z = $angle.complex(2.0, $base);
        is_approx($z.cosec($base), $sz2, "Complex.cosec - $z $base");
    }
}

is(cosec(Inf), NaN, "cosec(Inf) - default");
is(cosec(-Inf), NaN, "cosec(-Inf) - default");
given $base_list.shift
{
    is(cosec(Inf,  $_), NaN, "cosec(Inf) - $_");
    is(cosec(-Inf, $_), NaN, "cosec(-Inf) - $_");
}
        
# Num tests
is_approx((-3.92699081702367).Num.cosec(:base(Radians)), 1.41421356232158, "Num.cosec(:base(Radians)) - -3.92699081702367");
is_approx(cosec((-0.523598775603156).Num), -1.99999999998317, "cosec(Num) - -0.523598775603156");
is_approx(cosec((30).Num, Degrees), 1.99999999998317, "cosec(Num, Degrees) - 30");
is_approx(cosec(:x((0.785398163404734).Num)), 1.41421356236279, "cosec(:x(Num)) - 0.785398163404734");
is_approx(cosec(:x((100).Num), :base(Gradians)), 1, "cosec(:x(Num), :base(Gradians)) - 100");

# Rat tests
is_approx((2.3561944902142).Rat(1e-9).cosec, 1.41421356240401, "Rat.cosec - 2.3561944902142");
is_approx((0.625).Rat(1e-9).cosec(Circles), -1.41421356232158, "Rat.cosec(Circles) - 0.625");
is_approx((4.7123889804284).Rat(1e-9).cosec(:base(Radians)), -1, "Rat.cosec(:base(Radians)) - 4.7123889804284");
is_approx(cosec((5.49778714383314).Rat(1e-9)), -1.41421356244522, "cosec(Rat) - 5.49778714383314");
is_approx(cosec((390).Rat(1e-9), Degrees), 1.99999999978126, "cosec(Rat, Degrees) - 390");
is_approx(cosec(:x((10.2101761242615).Rat(1e-9))), -1.41421356223915, "cosec(:x(Rat)) - 10.2101761242615");
is_approx(cosec(:x((-250).Rat(1e-9)), :base(Gradians)), 1.41421356232158, "cosec(:x(Rat), :base(Gradians)) - -250");

# Complex tests
is_approx((-0.0833333333333333 + 0.318309886183791i).Complex.cosec(:base(Circles)), -0.140337325258517 + -0.234327511878805i, "Complex.cosec(:base(Circles)) - -0.0833333333333333 + 0.318309886183791i");
is_approx(cosec((0.523598775598299 + 2i).Complex), 0.140337325258517 + -0.234327511878805i, "cosec(Complex) - 0.523598775598299 + 2i");
is_approx(cosec((0.785398163397448 + 2i).Complex, Radians), 0.194833118738127 + -0.187824499973004i, "cosec(Complex, Radians) - 0.785398163397448 + 2i");
is_approx(cosec(:x((1.5707963267949 + 2i).Complex)), 0.26580222883408 + 3.73389767251692e-12i, "cosec(:x(Complex)) - 1.5707963267949 + 2i");
is_approx(cosec(:x((135 + 114.591559026165i).Complex), :base(Degrees)), 0.194833118732865 + 0.187824499978879i, "cosec(:x(Complex), :base(Degrees)) - 135 + 114.591559026165i");

# Str tests
is_approx((3.92699081702367).Str.cosec, -1.41421356232158, "Str.cosec - 3.92699081702367");
is_approx((300).Str.cosec(Gradians), -1, "Str.cosec(Gradians) - 300");
is_approx((0.875).Str.cosec(:base(Circles)), -1.41421356244522, "Str.cosec(:base(Circles)) - 0.875");
is_approx(cosec((6.80678408284103).Str), 1.99999999978126, "cosec(Str) - 6.80678408284103");
is_approx(cosec((10.2101761242615).Str, Radians), -1.41421356223915, "cosec(Str, Radians) - 10.2101761242615");
is_approx(cosec(:x((-3.92699081702367).Str)), 1.41421356232158, "cosec(:x(Str)) - -3.92699081702367");
is_approx(cosec(:x((-30).Str), :base(Degrees)), -1.99999999998317, "cosec(:x(Str), :base(Degrees)) - -30");

# NotComplex tests
is_approx(NotComplex.new(0.523598775598299 + 2i).cosec, 0.140337325258517 + -0.234327511878805i, "NotComplex.cosec - 0.523598775598299 + 2i");
is_approx(NotComplex.new(50 + 127.323954473516i).cosec(Gradians), 0.194833118738127 + -0.187824499973004i, "NotComplex.cosec(Gradians) - 50 + 127.323954473516i");
is_approx(NotComplex.new(0.25 + 0.318309886183791i).cosec(:base(Circles)), 0.26580222883408 + 3.73389767251692e-12i, "NotComplex.cosec(:base(Circles)) - 0.25 + 0.318309886183791i");
is_approx(cosec(NotComplex.new(2.35619449019234 + 2i)), 0.194833118732865 + 0.187824499978879i, "cosec(NotComplex) - 2.35619449019234 + 2i");
is_approx(cosec(NotComplex.new(3.92699081698724 + 2i), Radians), -0.194833118743389 + 0.187824499967129i, "cosec(NotComplex, Radians) - 3.92699081698724 + 2i");
is_approx(cosec(:x(NotComplex.new(4.71238898038469 + 2i))), -0.26580222883408 + -1.12015792238299e-11i, "cosec(:x(NotComplex)) - 4.71238898038469 + 2i");
is_approx(cosec(:x(NotComplex.new(315 + 114.591559026165i)), :base(Degrees)), -0.194833118727602 + -0.187824499984753i, "cosec(:x(NotComplex), :base(Degrees)) - 315 + 114.591559026165i");

# DifferentReal tests
is_approx(DifferentReal.new(6.80678408284103).cosec, 1.99999999978126, "DifferentReal.cosec - 6.80678408284103");
is_approx(DifferentReal.new(650).cosec(Gradians), -1.41421356223915, "DifferentReal.cosec(Gradians) - 650");
is_approx(DifferentReal.new(-0.625).cosec(:base(Circles)), 1.41421356232158, "DifferentReal.cosec(:base(Circles)) - -0.625");
is_approx(cosec(DifferentReal.new(-0.523598775603156)), -1.99999999998317, "cosec(DifferentReal) - -0.523598775603156");
is_approx(cosec(DifferentReal.new(0.523598775603156), Radians), 1.99999999998317, "cosec(DifferentReal, Radians) - 0.523598775603156");
is_approx(cosec(:x(DifferentReal.new(0.785398163404734))), 1.41421356236279, "cosec(:x(DifferentReal)) - 0.785398163404734");
is_approx(cosec(:x(DifferentReal.new(90)), :base(Degrees)), 1, "cosec(:x(DifferentReal), :base(Degrees)) - 90");

# Int tests
is_approx((135).Int.cosec(:base(Degrees)), 1.41421356240401, "Int.cosec(:base(Degrees)) - 135");
is_approx(cosec((225).Int, Degrees), -1.41421356232158, "cosec(Int, Degrees) - 225");
is_approx(cosec(:x((300).Int), :base(Gradians)), -1, "cosec(:x(Int), :base(Gradians)) - 300");

# acosec tests

for TrigTest::sines() -> $angle
{
    next if abs(sin($angle.num(Radians))) < 1e-6;
    my $desired-result = 1.0 / sin($angle.num(Radians));

    # Num.acosec tests -- thorough
    is_approx($desired-result.Num.acosec.cosec, $desired-result, 
              "Num.acosec - {$angle.num(Radians)} default");
    for TrigTest::official_bases() -> $base {
        is_approx($desired-result.Num.acosec($base).cosec($base), $desired-result,
                  "Num.acosec - {$angle.num($base)} $base");
    }
    
    # Num.acosec(Complex) tests -- thorough
    for ($desired-result + 0i, $desired-result + .5i, $desired-result + 2i) -> $z {
        is_approx(cosec(acosec($z)), $z, 
                  "acosec(Complex) - {$angle.num(Radians)} default");
        is_approx($z.acosec.cosec, $z, 
                  "Complex.acosec - {$angle.num(Radians)} default");
        for TrigTest::official_bases() -> $base {
            is_approx($z.acosec($base).cosec($base), $z, 
                      "Complex.acosec - {$angle.num($base)} $base");
        }
    }
}
        
# Num tests
is_approx((1.99999999998317).Num.acosec(:base(Radians)), 0.523598775603156, "Num.acosec(:base(Radians)) - 0.523598775603156");
is_approx(acosec((1.41421356236279).Num), 0.785398163404734, "acosec(Num) - 0.785398163404734");
is_approx(acosec((1.99999999998317).Num, Degrees), 30, "acosec(Num, Degrees) - 30");
is_approx(acosec(:x((1.41421356236279).Num)), 0.785398163404734, "acosec(:x(Num)) - 0.785398163404734");
is_approx(acosec(:x((1.99999999998317).Num), :base(Gradians)), 33.3333333333333, "acosec(:x(Num), :base(Gradians)) - 33.3333333333333");

# Rat tests
is_approx(((1.41421356236279).Rat(1e-9)).acosec, 0.785398163404734, "Rat.acosec - 0.785398163404734");
is_approx((1.99999999998317).Rat(1e-9).acosec(Circles), 0.0833333333333333, "Rat.acosec(Circles) - 0.0833333333333333");
is_approx((1.41421356236279).Rat(1e-9).acosec(:base(Radians)), 0.785398163404734, "Rat.acosec(:base(Radians)) - 0.785398163404734");
is_approx(acosec((1.99999999998317).Rat(1e-9)), 0.523598775603156, "acosec(Rat) - 0.523598775603156");
is_approx(acosec((1.41421356236279).Rat(1e-9), Degrees), 45, "acosec(Rat, Degrees) - 45");
is_approx(acosec(:x((1.99999999998317).Rat(1e-9))), 0.523598775603156, "acosec(:x(Rat)) - 0.523598775603156");
is_approx(acosec(:x((1.41421356236279).Rat(1e-9)), :base(Gradians)), 50, "acosec(:x(Rat), :base(Gradians)) - 50");

# Complex tests
is_approx((0.523598775603156 + 2i).Complex.acosec(:base(Circles)), 0.0176759513418686 + -0.0724107086919773i, "Complex.acosec(:base(Circles)) - 0.0176759513418686 + -0.0724107086919773i");
is_approx(acosec((0.785398163404734 + 2i).Complex), 0.156429673425433 + -0.425586400480703i, "acosec(Complex) - 0.156429673425433 + -0.425586400480703i");
is_approx(acosec((0.523598775603156 + 2i).Complex, Radians), 0.11106127776165 + -0.454969900935893i, "acosec(Complex, Radians) - 0.11106127776165 + -0.454969900935893i");
is_approx(acosec(:x((0.785398163404734 + 2i).Complex)), 0.156429673425433 + -0.425586400480703i, "acosec(:x(Complex)) - 0.156429673425433 + -0.425586400480703i");
is_approx(acosec(:x((0.523598775603156 + 2i).Complex), :base(Degrees)), 6.36334248307269 + -26.0678551291118i, "acosec(:x(Complex), :base(Degrees)) - 6.36334248307269 + -26.0678551291118i");

# Str tests
is_approx(((1.41421356236279).Str).acosec, 0.785398163404734, "Str.acosec - 0.785398163404734");
is_approx((1.99999999998317).Str.acosec(Gradians), 33.3333333333333, "Str.acosec(Gradians) - 33.3333333333333");
is_approx((1.41421356236279).Str.acosec(:base(Circles)), 0.125, "Str.acosec(:base(Circles)) - 0.125");
is_approx(acosec((1.99999999998317).Str), 0.523598775603156, "acosec(Str) - 0.523598775603156");
is_approx(acosec((1.41421356236279).Str, Radians), 0.785398163404734, "acosec(Str, Radians) - 0.785398163404734");
is_approx(acosec(:x((1.99999999998317).Str)), 0.523598775603156, "acosec(:x(Str)) - 0.523598775603156");
is_approx(acosec(:x((1.41421356236279).Str), :base(Degrees)), 45, "acosec(:x(Str), :base(Degrees)) - 45");

# NotComplex tests
is_approx((NotComplex.new(0.523598775603156 + 2i)).acosec, 0.11106127776165 + -0.454969900935893i, "NotComplex.acosec - 0.11106127776165 + -0.454969900935893i");
is_approx(NotComplex.new(0.785398163404734 + 2i).acosec(Gradians), 9.95862230876341 + -27.0936717396764i, "NotComplex.acosec(Gradians) - 9.95862230876341 + -27.0936717396764i");
is_approx(NotComplex.new(0.523598775603156 + 2i).acosec(:base(Circles)), 0.0176759513418686 + -0.0724107086919773i, "NotComplex.acosec(:base(Circles)) - 0.0176759513418686 + -0.0724107086919773i");
is_approx(acosec(NotComplex.new(0.785398163404734 + 2i)), 0.156429673425433 + -0.425586400480703i, "acosec(NotComplex) - 0.156429673425433 + -0.425586400480703i");
is_approx(acosec(NotComplex.new(0.523598775603156 + 2i), Radians), 0.11106127776165 + -0.454969900935893i, "acosec(NotComplex, Radians) - 0.11106127776165 + -0.454969900935893i");
is_approx(acosec(:x(NotComplex.new(0.785398163404734 + 2i))), 0.156429673425433 + -0.425586400480703i, "acosec(:x(NotComplex)) - 0.156429673425433 + -0.425586400480703i");
is_approx(acosec(:x(NotComplex.new(0.523598775603156 + 2i)), :base(Degrees)), 6.36334248307269 + -26.0678551291118i, "acosec(:x(NotComplex), :base(Degrees)) - 6.36334248307269 + -26.0678551291118i");

# DifferentReal tests
is_approx((DifferentReal.new(1.41421356236279)).acosec, 0.785398163404734, "DifferentReal.acosec - 0.785398163404734");
is_approx(DifferentReal.new(1.99999999998317).acosec(Gradians), 33.3333333333333, "DifferentReal.acosec(Gradians) - 33.3333333333333");
is_approx(DifferentReal.new(1.41421356236279).acosec(:base(Circles)), 0.125, "DifferentReal.acosec(:base(Circles)) - 0.125");
is_approx(acosec(DifferentReal.new(1.99999999998317)), 0.523598775603156, "acosec(DifferentReal) - 0.523598775603156");
is_approx(acosec(DifferentReal.new(1.41421356236279), Radians), 0.785398163404734, "acosec(DifferentReal, Radians) - 0.785398163404734");
is_approx(acosec(:x(DifferentReal.new(1.99999999998317))), 0.523598775603156, "acosec(:x(DifferentReal)) - 0.523598775603156");
is_approx(acosec(:x(DifferentReal.new(1.41421356236279)), :base(Degrees)), 45, "acosec(:x(DifferentReal), :base(Degrees)) - 45");

done_testing;

# vim: ft=perl6 nomodifiable
