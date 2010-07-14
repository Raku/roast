# WARNING:
# This is a generated file and should not be edited directly.
# look into generate-tests.pl instead

use v6;
use Test;
BEGIN { @*INC.push("t/spec/packages/") };
use TrigTestSupport;


# cos tests

my $base_list = (TrigTest::official_bases() xx *).flat;
my $iter_count = 0;
for TrigTest::cosines() -> $angle
{
    
    my $desired-result = $angle.result;

    # Num.cos tests -- very thorough
    is_approx($angle.num(Radians).cos, $desired-result, 
              "Num.cos - {$angle.num(Radians)} default");
    for TrigTest::official_bases() -> $base {
        is_approx($angle.num($base).cos($base), $desired-result, 
                  "Num.cos - {$angle.num($base)} $base");
    }

    # Complex.cos tests -- also very thorough
    my Complex $zp0 = $angle.complex(0.0, Radians);
    my Complex $sz0 = $desired-result + 0i;
    my Complex $zp1 = $angle.complex(1.0, Radians);
    my Complex $sz1 = { (exp($_ * 1i) + exp(-$_ * 1i)) / 2 }($zp1);
    my Complex $zp2 = $angle.complex(2.0, Radians);
    my Complex $sz2 = { (exp($_ * 1i) + exp(-$_ * 1i)) / 2 }($zp2);
    
    is_approx($zp0.cos, $sz0, "Complex.cos - $zp0 default");
    is_approx($zp1.cos, $sz1, "Complex.cos - $zp1 default");
    is_approx($zp2.cos, $sz2, "Complex.cos - $zp2 default");
    
    for TrigTest::official_bases() -> $base {
        my Complex $z = $angle.complex(0.0, $base);
        is_approx($z.cos($base), $sz0, "Complex.cos - $z $base");
    
        $z = $angle.complex(1.0, $base);
        is_approx($z.cos($base), $sz1, "Complex.cos - $z $base");
    
        $z = $angle.complex(2.0, $base);
        is_approx($z.cos($base), $sz2, "Complex.cos - $z $base");
    }
}

is(cos(Inf), NaN, "cos(Inf) - default");
is(cos(-Inf), NaN, "cos(-Inf) - default");
given $base_list.shift
{
    is(cos(Inf,  $_), NaN, "cos(Inf) - $_");
    is(cos(-Inf, $_), NaN, "cos(-Inf) - $_");
}
        
# Num tests
is_approx((-7.85398163404734).Num.cos(:base(Radians)), 0, "Num.cos(:base(Radians)) - -7.85398163404734");
is_approx(cos((-5.49778714383314).Num), 0.707106781186548, "cos(Num) - -5.49778714383314");
is_approx(cos((-120).Num, Degrees), -0.5, "cos(Num, Degrees) - -120");
is_approx(cos(:x((-1.57079632680947).Num)), 0, "cos(:x(Num)) - -1.57079632680947");
is_approx(cos(:x((-66.6666666666667).Num), :base(Gradians)), 0.5, "cos(:x(Num), :base(Gradians)) - -66.6666666666667");

# Rat tests
is_approx((-0.785398163404734).Rat(1e-9).cos, 0.707106781186548, "Rat.cos - -0.785398163404734");
is_approx((0).Rat(1e-9).cos(Circles), 1, "Rat.cos(Circles) - 0");
is_approx((0.785398163404734).Rat(1e-9).cos(:base(Radians)), 0.707106781186548, "Rat.cos(:base(Radians)) - 0.785398163404734");
is_approx(cos((1.57079632680947).Rat(1e-9)), 0, "cos(Rat) - 1.57079632680947");
is_approx(cos((135).Rat(1e-9), Degrees), -0.707106781186548, "cos(Rat, Degrees) - 135");
is_approx(cos(:x((3.14159265361894).Rat(1e-9))), -1, "cos(:x(Rat)) - 3.14159265361894");
is_approx(cos(:x((250).Rat(1e-9)), :base(Gradians)), -0.707106781186548, "cos(:x(Rat), :base(Gradians)) - 250");

# Complex tests
is_approx((0.75 + 0.318309886183791i).Complex.cos(:base(Circles)), 1.64464647771967e-10 + 3.62686040784702i, "Complex.cos(:base(Circles)) - 0.75 + 0.318309886183791i");
is_approx(cos((5.23598775598299 + 2i).Complex), 1.88109784570007 + 3.14095324908742i, "cos(Complex) - 5.23598775598299 + 2i");
is_approx(cos((8.63937979737193 + 2i).Complex, Radians), -2.66027408552925 + -2.5645775886001i, "cos(Complex, Radians) - 8.63937979737193 + 2i");
is_approx(cos(:x((10.9955742875643 + 2i).Complex)), 3.83749730967581e-10 + 3.62686040784702i, "cos(:x(Complex)) - 10.9955742875643 + 2i");
is_approx(cos(:x((-450 + 114.591559026165i).Complex), :base(Degrees)), -2.74108860120286e-10 + 3.62686040784702i, "cos(:x(Complex), :base(Degrees)) - -450 + 114.591559026165i");

# Str tests
is_approx((-5.49778714383314).Str.cos, 0.707106781186548, "Str.cos - -5.49778714383314");
is_approx((-133.333333333333).Str.cos(Gradians), -0.5, "Str.cos(Gradians) - -133.333333333333");
is_approx((-0.25).Str.cos(:base(Circles)), 0, "Str.cos(:base(Circles)) - -0.25");
is_approx(cos((-1.04719755120631).Str), 0.5, "cos(Str) - -1.04719755120631");
is_approx(cos((-0.785398163404734).Str, Radians), 0.707106781186548, "cos(Str, Radians) - -0.785398163404734");
is_approx(cos(:x((0).Str)), 1, "cos(:x(Str)) - 0");
is_approx(cos(:x((45).Str), :base(Degrees)), 0.707106781186548, "cos(:x(Str), :base(Degrees)) - 45");

# NotComplex tests
is_approx(NotComplex.new(1.5707963267949 + 2i).cos, -5.48221061741595e-11 + -3.62686040784702i, "NotComplex.cos - 1.5707963267949 + 2i");
is_approx(NotComplex.new(150 + 127.323954473516i).cos(Gradians), -2.66027408537419 + -2.56457758874958i, "NotComplex.cos(Gradians) - 150 + 127.323954473516i");
is_approx(NotComplex.new(0.5 + 0.318309886183791i).cos(:base(Circles)), -3.76219569108363 + 1.05700044699469e-10i, "NotComplex.cos(:base(Circles)) - 0.5 + 0.318309886183791i");
is_approx(cos(NotComplex.new(3.92699081698724 + 2i)), -2.66027408521913 + 2.56457758889906i, "cos(NotComplex) - 3.92699081698724 + 2i");
is_approx(cos(NotComplex.new(4.71238898038469 + 2i), Radians), 1.64464647771967e-10 + 3.62686040784702i, "cos(NotComplex, Radians) - 4.71238898038469 + 2i");
is_approx(cos(:x(NotComplex.new(5.23598775598299 + 2i))), 1.88109784570007 + 3.14095324908742i, "cos(:x(NotComplex)) - 5.23598775598299 + 2i");
is_approx(cos(:x(NotComplex.new(495 + 114.591559026165i)), :base(Degrees)), -2.66027408552925 + -2.5645775886001i, "cos(:x(NotComplex), :base(Degrees)) - 495 + 114.591559026165i");

# DifferentReal tests
is_approx(DifferentReal.new(10.9955742876663).cos, 0, "DifferentReal.cos - 10.9955742876663");
is_approx(DifferentReal.new(-500).cos(Gradians), 0, "DifferentReal.cos(Gradians) - -500");
is_approx(DifferentReal.new(-0.875).cos(:base(Circles)), 0.707106781186548, "DifferentReal.cos(:base(Circles)) - -0.875");
is_approx(cos(DifferentReal.new(-2.09439510241262)), -0.5, "cos(DifferentReal) - -2.09439510241262");
is_approx(cos(DifferentReal.new(-1.57079632680947), Radians), 0, "cos(DifferentReal, Radians) - -1.57079632680947");
is_approx(cos(:x(DifferentReal.new(-1.04719755120631))), 0.5, "cos(:x(DifferentReal)) - -1.04719755120631");
is_approx(cos(:x(DifferentReal.new(-45)), :base(Degrees)), 0.707106781186548, "cos(:x(DifferentReal), :base(Degrees)) - -45");

# Int tests
is_approx((0).Int.cos(:base(Degrees)), 1, "Int.cos(:base(Degrees)) - 0");
is_approx(cos((45).Int, Degrees), 0.707106781186548, "cos(Int, Degrees) - 45");
is_approx(cos(:x((100).Int), :base(Gradians)), 0, "cos(:x(Int), :base(Gradians)) - 100");

# acos tests

for TrigTest::cosines() -> $angle
{
    
    my $desired-result = $angle.result;

    # Num.acos tests -- thorough
    is_approx($desired-result.Num.acos.cos, $desired-result, 
              "Num.acos - {$angle.num(Radians)} default");
    for TrigTest::official_bases() -> $base {
        is_approx($desired-result.Num.acos($base).cos($base), $desired-result,
                  "Num.acos - {$angle.num($base)} $base");
    }
    
    # Num.acos(Complex) tests -- thorough
    for ($desired-result + 0i, $desired-result + .5i, $desired-result + 2i) -> $z {
        is_approx(cos(acos($z)), $z, 
                  "acos(Complex) - {$angle.num(Radians)} default");
        is_approx($z.acos.cos, $z, 
                  "Complex.acos - {$angle.num(Radians)} default");
        for TrigTest::official_bases() -> $base {
            is_approx($z.acos($base).cos($base), $z, 
                      "Complex.acos - {$angle.num($base)} $base");
        }
    }
}
        
# Num tests
is_approx((0.707106781186548).Num.acos(:base(Radians)), 0.785398163404734, "Num.acos(:base(Radians)) - 0.785398163404734");
is_approx(acos((0.707106781186548).Num), 0.785398163404734, "acos(Num) - 0.785398163404734");
is_approx(acos((0.707106781186548).Num, Degrees), 45, "acos(Num, Degrees) - 45");
is_approx(acos(:x((0.707106781186548).Num)), 0.785398163404734, "acos(:x(Num)) - 0.785398163404734");
is_approx(acos(:x((0.707106781186548).Num), :base(Gradians)), 50, "acos(:x(Num), :base(Gradians)) - 50");

# Rat tests
is_approx(((0.707106781186548).Rat(1e-9)).acos, 0.785398163404734, "Rat.acos - 0.785398163404734");
is_approx((0.707106781186548).Rat(1e-9).acos(Circles), 0.125, "Rat.acos(Circles) - 0.125");
is_approx((0.707106781186548).Rat(1e-9).acos(:base(Radians)), 0.785398163404734, "Rat.acos(:base(Radians)) - 0.785398163404734");
is_approx(acos((0.707106781186548).Rat(1e-9)), 0.785398163404734, "acos(Rat) - 0.785398163404734");
is_approx(acos((0.707106781186548).Rat(1e-9), Degrees), 45, "acos(Rat, Degrees) - 45");
is_approx(acos(:x((0.707106781186548).Rat(1e-9))), 0.785398163404734, "acos(:x(Rat)) - 0.785398163404734");
is_approx(acos(:x((0.707106781186548).Rat(1e-9)), :base(Gradians)), 50, "acos(:x(Rat), :base(Gradians)) - 50");

# Complex tests
is_approx((0.785398163404734 + 2i).Complex.acos(:base(Circles)), 0.195674223889363 + -0.238269741456271i, "Complex.acos(:base(Circles)) - 0.195674223889363 + -0.238269741456271i");
is_approx(acos((0.785398163404734 + 2i).Complex), 1.22945740853542 + -1.49709293866352i, "acos(Complex) - 1.22945740853542 + -1.49709293866352i");
is_approx(acos((0.785398163404734 + 2i).Complex, Radians), 1.22945740853542 + -1.49709293866352i, "acos(Complex, Radians) - 1.22945740853542 + -1.49709293866352i");
is_approx(acos(:x((0.785398163404734 + 2i).Complex)), 1.22945740853542 + -1.49709293866352i, "acos(:x(Complex)) - 1.22945740853542 + -1.49709293866352i");
is_approx(acos(:x((0.785398163404734 + 2i).Complex), :base(Degrees)), 70.4427206001707 + -85.7771069242577i, "acos(:x(Complex), :base(Degrees)) - 70.4427206001707 + -85.7771069242577i");

# Str tests
is_approx(((0.707106781186548).Str).acos, 0.785398163404734, "Str.acos - 0.785398163404734");
is_approx((0.707106781186548).Str.acos(Gradians), 50, "Str.acos(Gradians) - 50");
is_approx((0.707106781186548).Str.acos(:base(Circles)), 0.125, "Str.acos(:base(Circles)) - 0.125");
is_approx(acos((0.707106781186548).Str), 0.785398163404734, "acos(Str) - 0.785398163404734");
is_approx(acos((0.707106781186548).Str, Radians), 0.785398163404734, "acos(Str, Radians) - 0.785398163404734");
is_approx(acos(:x((0.707106781186548).Str)), 0.785398163404734, "acos(:x(Str)) - 0.785398163404734");
is_approx(acos(:x((0.707106781186548).Str), :base(Degrees)), 45, "acos(:x(Str), :base(Degrees)) - 45");

# NotComplex tests
is_approx((NotComplex.new(0.785398163404734 + 2i)).acos, 1.22945740853542 + -1.49709293866352i, "NotComplex.acos - 1.22945740853542 + -1.49709293866352i");
is_approx(NotComplex.new(0.785398163404734 + 2i).acos(Gradians), 78.2696895557452 + -95.3078965825085i, "NotComplex.acos(Gradians) - 78.2696895557452 + -95.3078965825085i");
is_approx(NotComplex.new(0.785398163404734 + 2i).acos(:base(Circles)), 0.195674223889363 + -0.238269741456271i, "NotComplex.acos(:base(Circles)) - 0.195674223889363 + -0.238269741456271i");
is_approx(acos(NotComplex.new(0.785398163404734 + 2i)), 1.22945740853542 + -1.49709293866352i, "acos(NotComplex) - 1.22945740853542 + -1.49709293866352i");
is_approx(acos(NotComplex.new(0.785398163404734 + 2i), Radians), 1.22945740853542 + -1.49709293866352i, "acos(NotComplex, Radians) - 1.22945740853542 + -1.49709293866352i");
is_approx(acos(:x(NotComplex.new(0.785398163404734 + 2i))), 1.22945740853542 + -1.49709293866352i, "acos(:x(NotComplex)) - 1.22945740853542 + -1.49709293866352i");
is_approx(acos(:x(NotComplex.new(0.785398163404734 + 2i)), :base(Degrees)), 70.4427206001707 + -85.7771069242577i, "acos(:x(NotComplex), :base(Degrees)) - 70.4427206001707 + -85.7771069242577i");

# DifferentReal tests
is_approx((DifferentReal.new(0.707106781186548)).acos, 0.785398163404734, "DifferentReal.acos - 0.785398163404734");
is_approx(DifferentReal.new(0.707106781186548).acos(Gradians), 50, "DifferentReal.acos(Gradians) - 50");
is_approx(DifferentReal.new(0.707106781186548).acos(:base(Circles)), 0.125, "DifferentReal.acos(:base(Circles)) - 0.125");
is_approx(acos(DifferentReal.new(0.707106781186548)), 0.785398163404734, "acos(DifferentReal) - 0.785398163404734");
is_approx(acos(DifferentReal.new(0.707106781186548), Radians), 0.785398163404734, "acos(DifferentReal, Radians) - 0.785398163404734");
is_approx(acos(:x(DifferentReal.new(0.707106781186548))), 0.785398163404734, "acos(:x(DifferentReal)) - 0.785398163404734");
is_approx(acos(:x(DifferentReal.new(0.707106781186548)), :base(Degrees)), 45, "acos(:x(DifferentReal), :base(Degrees)) - 45");

done_testing;

# vim: ft=perl6 nomodifiable
