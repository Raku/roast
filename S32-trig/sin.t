# WARNING:
# This is a generated file and should not be edited directly.
# look into generate-tests.pl instead

use v6;
use Test;
BEGIN { @*INC.push("t/spec/packages/") };
use TrigTestSupport;


# sin tests

my $base_list = (TrigTest::official_bases() xx *).flat;
my $iter_count = 0;
for TrigTest::sines() -> $angle
{
    
    my $desired-result = $angle.result;

    # Num.sin tests -- very thorough
    is_approx($angle.num(Radians).sin, $desired-result, 
              "Num.sin - {$angle.num(Radians)} default");
    for TrigTest::official_bases() -> $base {
        is_approx($angle.num($base).sin($base), $desired-result, 
                  "Num.sin - {$angle.num($base)} $base");
    }

    # Complex.sin tests -- also very thorough
    my Complex $zp0 = $angle.complex(0.0, Radians);
    my Complex $sz0 = $desired-result + 0i;
    my Complex $zp1 = $angle.complex(1.0, Radians);
    my Complex $sz1 = { (exp($_ * 1i) - exp(-$_ * 1i)) / 2i }($zp1);
    my Complex $zp2 = $angle.complex(2.0, Radians);
    my Complex $sz2 = { (exp($_ * 1i) - exp(-$_ * 1i)) / 2i }($zp2);
    
    is_approx($zp0.sin, $sz0, "Complex.sin - $zp0 default");
    is_approx($zp1.sin, $sz1, "Complex.sin - $zp1 default");
    is_approx($zp2.sin, $sz2, "Complex.sin - $zp2 default");
    
    for TrigTest::official_bases() -> $base {
        my Complex $z = $angle.complex(0.0, $base);
        is_approx($z.sin($base), $sz0, "Complex.sin - $z $base");
    
        $z = $angle.complex(1.0, $base);
        is_approx($z.sin($base), $sz1, "Complex.sin - $z $base");
    
        $z = $angle.complex(2.0, $base);
        is_approx($z.sin($base), $sz2, "Complex.sin - $z $base");
    }
}

is(sin(Inf), NaN, "sin(Inf) - default");
is(sin(-Inf), NaN, "sin(-Inf) - default");
given $base_list.shift
{
    is(sin(Inf,  $_), NaN, "sin(Inf) - $_");
    is(sin(-Inf, $_), NaN, "sin(-Inf) - $_");
}
        
# Num tests
is_approx((-6.28318530723787).Num.sin(:base(Radians)), 0, "Num.sin(:base(Radians)) - -6.28318530723787");
is_approx(sin((-3.92699081702367).Num), 0.707106781186548, "sin(Num) - -3.92699081702367");
is_approx(sin((-30).Num, Degrees), -0.5, "sin(Num, Degrees) - -30");
is_approx(sin(:x((0).Num)), 0, "sin(:x(Num)) - 0");
is_approx(sin(:x((33.3333333333333).Num), :base(Gradians)), 0.5, "sin(:x(Num), :base(Gradians)) - 33.3333333333333");

# Rat tests
is_approx((0.785398163404734).Rat(1e-9).sin, 0.707106781186548, "Rat.sin - 0.785398163404734");
is_approx((0.25).Rat(1e-9).sin(Circles), 1, "Rat.sin(Circles) - 0.25");
is_approx((2.3561944902142).Rat(1e-9).sin(:base(Radians)), 0.707106781186548, "Rat.sin(:base(Radians)) - 2.3561944902142");
is_approx(sin((3.14159265361894).Rat(1e-9)), 0, "sin(Rat) - 3.14159265361894");
is_approx(sin((225).Rat(1e-9), Degrees), -0.707106781186548, "sin(Rat, Degrees) - 225");
is_approx(sin(:x((4.7123889804284).Rat(1e-9))), -1, "sin(:x(Rat)) - 4.7123889804284");
is_approx(sin(:x((350).Rat(1e-9)), :base(Gradians)), -0.707106781186548, "sin(:x(Rat), :base(Gradians)) - 350");

# Complex tests
is_approx((1 + 0.318309886183791i).Complex.sin(:base(Circles)), 2.19288424696638e-10 + 3.62686040784702i, "Complex.sin(:base(Circles)) - 1 + 0.318309886183791i");
is_approx(sin((6.80678408277788 + 2i).Complex), 1.88109784574755 + 3.140953249061i, "sin(Complex) - 6.80678408277788 + 2i");
is_approx(sin((10.2101761241668 + 2i).Complex, Radians), -2.66027408556802 + -2.56457758856273i, "sin(Complex, Radians) - 10.2101761241668 + 2i");
is_approx(sin(:x((12.5663706143592 + 2i).Complex)), 4.38576849393276e-10 + 3.62686040784702i, "sin(:x(Complex)) - 12.5663706143592 + 2i");
is_approx(sin(:x((-360 + 114.591559026165i).Complex), :base(Degrees)), -2.19288424696638e-10 + 3.62686040784702i, "sin(:x(Complex), :base(Degrees)) - -360 + 114.591559026165i");

# Str tests
is_approx((-3.92699081702367).Str.sin, 0.707106781186548, "Str.sin - -3.92699081702367");
is_approx((-33.3333333333333).Str.sin(Gradians), -0.5, "Str.sin(Gradians) - -33.3333333333333");
is_approx((0).Str.sin(:base(Circles)), 0, "Str.sin(:base(Circles)) - 0");
is_approx(sin((0.523598775603156).Str), 0.5, "sin(Str) - 0.523598775603156");
is_approx(sin((0.785398163404734).Str, Radians), 0.707106781186548, "sin(Str, Radians) - 0.785398163404734");
is_approx(sin(:x((1.57079632680947).Str)), 1, "sin(:x(Str)) - 1.57079632680947");
is_approx(sin(:x((135).Str), :base(Degrees)), 0.707106781186548, "sin(:x(Str), :base(Degrees)) - 135");

# NotComplex tests
is_approx(NotComplex.new(3.14159265358979 + 2i).sin, -1.09644212348319e-10 + -3.62686040784702i, "NotComplex.sin - 3.14159265358979 + 2i");
is_approx(NotComplex.new(250 + 127.323954473516i).sin(Gradians), -2.66027408541296 + -2.56457758871221i, "NotComplex.sin(Gradians) - 250 + 127.323954473516i");
is_approx(NotComplex.new(0.75 + 0.318309886183791i).sin(:base(Circles)), -3.76219569108363 + 1.58548456399631e-10i, "NotComplex.sin(:base(Circles)) - 0.75 + 0.318309886183791i");
is_approx(sin(NotComplex.new(5.49778714378214 + 2i)), -2.66027408518037 + 2.56457758893643i, "sin(NotComplex) - 5.49778714378214 + 2i");
is_approx(sin(NotComplex.new(6.28318530717959 + 2i), Radians), 2.19288424696638e-10 + 3.62686040784702i, "sin(NotComplex, Radians) - 6.28318530717959 + 2i");
is_approx(sin(:x(NotComplex.new(6.80678408277788 + 2i))), 1.88109784574755 + 3.140953249061i, "sin(:x(NotComplex)) - 6.80678408277788 + 2i");
is_approx(sin(:x(NotComplex.new(585 + 114.591559026165i)), :base(Degrees)), -2.66027408556802 + -2.56457758856273i, "sin(:x(NotComplex), :base(Degrees)) - 585 + 114.591559026165i");

# DifferentReal tests
is_approx(DifferentReal.new(12.5663706144757).sin, 0, "DifferentReal.sin - 12.5663706144757");
is_approx(DifferentReal.new(-400).sin(Gradians), 0, "DifferentReal.sin(Gradians) - -400");
is_approx(DifferentReal.new(-0.625).sin(:base(Circles)), 0.707106781186548, "DifferentReal.sin(:base(Circles)) - -0.625");
is_approx(sin(DifferentReal.new(-0.523598775603156)), -0.5, "sin(DifferentReal) - -0.523598775603156");
is_approx(sin(DifferentReal.new(0), Radians), 0, "sin(DifferentReal, Radians) - 0");
is_approx(sin(:x(DifferentReal.new(0.523598775603156))), 0.5, "sin(:x(DifferentReal)) - 0.523598775603156");
is_approx(sin(:x(DifferentReal.new(45)), :base(Degrees)), 0.707106781186548, "sin(:x(DifferentReal), :base(Degrees)) - 45");

# Int tests
is_approx((90).Int.sin(:base(Degrees)), 1, "Int.sin(:base(Degrees)) - 90");
is_approx(sin((135).Int, Degrees), 0.707106781186548, "sin(Int, Degrees) - 135");
is_approx(sin(:x((200).Int), :base(Gradians)), 0, "sin(:x(Int), :base(Gradians)) - 200");

# asin tests

for TrigTest::sines() -> $angle
{
    
    my $desired-result = $angle.result;

    # Num.asin tests -- thorough
    is_approx($desired-result.Num.asin.sin, $desired-result, 
              "Num.asin - {$angle.num(Radians)} default");
    for TrigTest::official_bases() -> $base {
        is_approx($desired-result.Num.asin($base).sin($base), $desired-result,
                  "Num.asin - {$angle.num($base)} $base");
    }
    
    # Num.asin(Complex) tests -- thorough
    for ($desired-result + 0i, $desired-result + .5i, $desired-result + 2i) -> $z {
        is_approx(sin(asin($z)), $z, 
                  "asin(Complex) - {$angle.num(Radians)} default");
        is_approx($z.asin.sin, $z, 
                  "Complex.asin - {$angle.num(Radians)} default");
        for TrigTest::official_bases() -> $base {
            is_approx($z.asin($base).sin($base), $z, 
                      "Complex.asin - {$angle.num($base)} $base");
        }
    }
}
        
# Num tests
is_approx((0.5).Num.asin(:base(Radians)), 0.523598775603156, "Num.asin(:base(Radians)) - 0.523598775603156");
is_approx(asin((0.707106781186548).Num), 0.785398163404734, "asin(Num) - 0.785398163404734");
is_approx(asin((0.5).Num, Degrees), 30, "asin(Num, Degrees) - 30");
is_approx(asin(:x((0.707106781186548).Num)), 0.785398163404734, "asin(:x(Num)) - 0.785398163404734");
is_approx(asin(:x((0.5).Num), :base(Gradians)), 33.3333333333333, "asin(:x(Num), :base(Gradians)) - 33.3333333333333");

# Rat tests
is_approx(((0.707106781186548).Rat(1e-9)).asin, 0.785398163404734, "Rat.asin - 0.785398163404734");
is_approx((0.5).Rat(1e-9).asin(Circles), 0.0833333333333333, "Rat.asin(Circles) - 0.0833333333333333");
is_approx((0.707106781186548).Rat(1e-9).asin(:base(Radians)), 0.785398163404734, "Rat.asin(:base(Radians)) - 0.785398163404734");
is_approx(asin((0.5).Rat(1e-9)), 0.523598775603156, "asin(Rat) - 0.523598775603156");
is_approx(asin((0.707106781186548).Rat(1e-9), Degrees), 45, "asin(Rat, Degrees) - 45");
is_approx(asin(:x((0.5).Rat(1e-9))), 0.523598775603156, "asin(:x(Rat)) - 0.523598775603156");
is_approx(asin(:x((0.707106781186548).Rat(1e-9)), :base(Gradians)), 50, "asin(:x(Rat), :base(Gradians)) - 50");

# Complex tests
is_approx((0.523598775603156 + 2i).Complex.asin(:base(Circles)), 0.0367951420100155 + 0.23361063365218i, "Complex.asin(:base(Circles)) - 0.0367951420100155 + 0.23361063365218i");
is_approx(asin((0.785398163404734 + 2i).Complex), 0.341338918259481 + 1.49709293866352i, "asin(Complex) - 0.341338918259481 + 1.49709293866352i");
is_approx(asin((0.523598775603156 + 2i).Complex, Radians), 0.231190695652916 + 1.46781890096429i, "asin(Complex, Radians) - 0.231190695652916 + 1.46781890096429i");
is_approx(asin(:x((0.785398163404734 + 2i).Complex)), 0.341338918259481 + 1.49709293866352i, "asin(:x(Complex)) - 0.341338918259481 + 1.49709293866352i");
is_approx(asin(:x((0.523598775603156 + 2i).Complex), :base(Degrees)), 13.2462511236056 + 84.0998281147849i, "asin(:x(Complex), :base(Degrees)) - 13.2462511236056 + 84.0998281147849i");

# Str tests
is_approx(((0.707106781186548).Str).asin, 0.785398163404734, "Str.asin - 0.785398163404734");
is_approx((0.5).Str.asin(Gradians), 33.3333333333333, "Str.asin(Gradians) - 33.3333333333333");
is_approx((0.707106781186548).Str.asin(:base(Circles)), 0.125, "Str.asin(:base(Circles)) - 0.125");
is_approx(asin((0.5).Str), 0.523598775603156, "asin(Str) - 0.523598775603156");
is_approx(asin((0.707106781186548).Str, Radians), 0.785398163404734, "asin(Str, Radians) - 0.785398163404734");
is_approx(asin(:x((0.5).Str)), 0.523598775603156, "asin(:x(Str)) - 0.523598775603156");
is_approx(asin(:x((0.707106781186548).Str), :base(Degrees)), 45, "asin(:x(Str), :base(Degrees)) - 45");

# NotComplex tests
is_approx((NotComplex.new(0.523598775603156 + 2i)).asin, 0.231190695652916 + 1.46781890096429i, "NotComplex.asin - 0.231190695652916 + 1.46781890096429i");
is_approx(NotComplex.new(0.785398163404734 + 2i).asin(Gradians), 21.7303104442548 + 95.3078965825085i, "NotComplex.asin(Gradians) - 21.7303104442548 + 95.3078965825085i");
is_approx(NotComplex.new(0.523598775603156 + 2i).asin(:base(Circles)), 0.0367951420100155 + 0.23361063365218i, "NotComplex.asin(:base(Circles)) - 0.0367951420100155 + 0.23361063365218i");
is_approx(asin(NotComplex.new(0.785398163404734 + 2i)), 0.341338918259481 + 1.49709293866352i, "asin(NotComplex) - 0.341338918259481 + 1.49709293866352i");
is_approx(asin(NotComplex.new(0.523598775603156 + 2i), Radians), 0.231190695652916 + 1.46781890096429i, "asin(NotComplex, Radians) - 0.231190695652916 + 1.46781890096429i");
is_approx(asin(:x(NotComplex.new(0.785398163404734 + 2i))), 0.341338918259481 + 1.49709293866352i, "asin(:x(NotComplex)) - 0.341338918259481 + 1.49709293866352i");
is_approx(asin(:x(NotComplex.new(0.523598775603156 + 2i)), :base(Degrees)), 13.2462511236056 + 84.0998281147849i, "asin(:x(NotComplex), :base(Degrees)) - 13.2462511236056 + 84.0998281147849i");

# DifferentReal tests
is_approx((DifferentReal.new(0.707106781186548)).asin, 0.785398163404734, "DifferentReal.asin - 0.785398163404734");
is_approx(DifferentReal.new(0.5).asin(Gradians), 33.3333333333333, "DifferentReal.asin(Gradians) - 33.3333333333333");
is_approx(DifferentReal.new(0.707106781186548).asin(:base(Circles)), 0.125, "DifferentReal.asin(:base(Circles)) - 0.125");
is_approx(asin(DifferentReal.new(0.5)), 0.523598775603156, "asin(DifferentReal) - 0.523598775603156");
is_approx(asin(DifferentReal.new(0.707106781186548), Radians), 0.785398163404734, "asin(DifferentReal, Radians) - 0.785398163404734");
is_approx(asin(:x(DifferentReal.new(0.5))), 0.523598775603156, "asin(:x(DifferentReal)) - 0.523598775603156");
is_approx(asin(:x(DifferentReal.new(0.707106781186548)), :base(Degrees)), 45, "asin(:x(DifferentReal), :base(Degrees)) - 45");

done_testing;

# vim: ft=perl6 nomodifiable
