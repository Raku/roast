# WARNING:
# This is a generated file and should not be edited directly.
# look into generate-tests.pl instead

use v6;
use Test;
BEGIN { @*INC.push("t/spec/packages/") };
use TrigTestSupport;


# tanh tests

my $base_list = (TrigTest::official_bases() xx *).flat;
my $iter_count = 0;
for TrigTest::sines() -> $angle
{
    next if abs(cosh($angle.num(Radians))) < 1e-6;
    my $desired-result = sinh($angle.num(Radians)) / cosh($angle.num(Radians));

    # Num.tanh tests -- very thorough
    is_approx($angle.num(Radians).tanh, $desired-result, 
              "Num.tanh - {$angle.num(Radians)} default");
    for TrigTest::official_bases() -> $base {
        is_approx($angle.num($base).tanh($base), $desired-result, 
                  "Num.tanh - {$angle.num($base)} $base");
    }

    # Complex.tanh tests -- also very thorough
    my Complex $zp0 = $angle.complex(0.0, Radians);
    my Complex $sz0 = $desired-result + 0i;
    my Complex $zp1 = $angle.complex(1.0, Radians);
    my Complex $sz1 = { sinh($_) / cosh($_) }($zp1);
    my Complex $zp2 = $angle.complex(2.0, Radians);
    my Complex $sz2 = { sinh($_) / cosh($_) }($zp2);
    
    is_approx($zp0.tanh, $sz0, "Complex.tanh - $zp0 default");
    is_approx($zp1.tanh, $sz1, "Complex.tanh - $zp1 default");
    is_approx($zp2.tanh, $sz2, "Complex.tanh - $zp2 default");
    
    for TrigTest::official_bases() -> $base {
        my Complex $z = $angle.complex(0.0, $base);
        is_approx($z.tanh($base), $sz0, "Complex.tanh - $z $base");
    
        $z = $angle.complex(1.0, $base);
        is_approx($z.tanh($base), $sz1, "Complex.tanh - $z $base");
    
        $z = $angle.complex(2.0, $base);
        is_approx($z.tanh($base), $sz2, "Complex.tanh - $z $base");
    }
}

is(tanh(Inf), 1, "tanh(Inf) - default");
is(tanh(-Inf), -1, "tanh(-Inf) - default");
given $base_list.shift
{
    is(tanh(Inf,  $_), 1, "tanh(Inf) - $_");
    is(tanh(-Inf, $_), -1, "tanh(-Inf) - $_");
}
        
# Num tests
is_approx((-6.28318530723787).Num.tanh(:base(Radians)), -0.999993025339611, "Num.tanh(:base(Radians)) - -6.28318530723787");
is_approx(tanh((-3.92699081702367).Num), -0.999223894878698, "tanh(Num) - -3.92699081702367");
is_approx(tanh((-30).Num, Degrees), -0.480472778160188, "tanh(Num, Degrees) - -30");
is_approx(tanh(:x((0).Num)), 0, "tanh(:x(Num)) - 0");
is_approx(tanh(:x((33.3333333333333).Num), :base(Gradians)), 0.480472778160188, "tanh(:x(Num), :base(Gradians)) - 33.3333333333333");

# Rat tests
is_approx((0.785398163404734).Rat(1e-9).tanh, 0.655794202636825, "Rat.tanh - 0.785398163404734");
is_approx((0.25).Rat(1e-9).tanh(Circles), 0.917152335669589, "Rat.tanh(Circles) - 0.25");
is_approx((2.3561944902142).Rat(1e-9).tanh(:base(Radians)), 0.98219338000801, "Rat.tanh(:base(Radians)) - 2.3561944902142");
is_approx(tanh((3.14159265361894).Rat(1e-9)), 0.996272076220967, "tanh(Rat) - 3.14159265361894");
is_approx(tanh((225).Rat(1e-9), Degrees), 0.999223894878698, "tanh(Rat, Degrees) - 225");
is_approx(tanh(:x((4.7123889804284).Rat(1e-9))), 0.999838613988647, "tanh(:x(Rat)) - 4.7123889804284");
is_approx(tanh(:x((350).Rat(1e-9)), :base(Gradians)), 0.999966448999799, "tanh(:x(Rat), :base(Gradians)) - 350");

# Complex tests
is_approx((1 + 0.318309886183791i).Complex.tanh(:base(Circles)), 1.00000455895463 + -5.27848285809168e-06i, "Complex.tanh(:base(Circles)) - 1 + 0.318309886183791i");
is_approx(tanh((6.80678408277788 + 2i).Complex), 1.00000159982829 + -1.85231870546421e-06i, "tanh(Complex) - 6.80678408277788 + 2i");
is_approx(tanh((10.2101761241668 + 2i).Complex, Radians), 1.0000000017698 + -2.04911454909893e-09i, "tanh(Complex, Radians) - 10.2101761241668 + 2i");
is_approx(tanh(:x((12.5663706143592 + 2i).Complex)), 1.0000000000159 + -1.84077712754231e-11i, "tanh(:x(Complex)) - 12.5663706143592 + 2i");
is_approx(tanh(:x((-360 + 114.591559026165i).Complex), :base(Degrees)), -1.00000455895463 + -5.27848285809168e-06i, "tanh(:x(Complex), :base(Degrees)) - -360 + 114.591559026165i");

# Str tests
is_approx((-3.92699081702367).Str.tanh, -0.999223894878698, "Str.tanh - -3.92699081702367");
is_approx((-33.3333333333333).Str.tanh(Gradians), -0.480472778160188, "Str.tanh(Gradians) - -33.3333333333333");
is_approx((0).Str.tanh(:base(Circles)), 0, "Str.tanh(:base(Circles)) - 0");
is_approx(tanh((0.523598775603156).Str), 0.480472778160188, "tanh(Str) - 0.523598775603156");
is_approx(tanh((0.785398163404734).Str, Radians), 0.655794202636825, "tanh(Str, Radians) - 0.785398163404734");
is_approx(tanh(:x((1.57079632680947).Str)), 0.917152335669589, "tanh(:x(Str)) - 1.57079632680947");
is_approx(tanh(:x((135).Str), :base(Degrees)), 0.98219338000801, "tanh(:x(Str), :base(Degrees)) - 135");

# NotComplex tests
is_approx(NotComplex.new(3.14159265358979 + 2i).tanh, 1.00244025822645 + -0.00283347808179854i, "NotComplex.tanh - 3.14159265358979 + 2i");
is_approx(NotComplex.new(250 + 127.323954473516i).tanh(Gradians), 1.00050744914266 + -0.000587884565556679i, "NotComplex.tanh(Gradians) - 250 + 127.323954473516i");
is_approx(NotComplex.new(0.75 + 0.318309886183791i).tanh(:base(Circles)), 1.00010549555372 + -0.0001221600793053i, "NotComplex.tanh(:base(Circles)) - 0.75 + 0.318309886183791i");
is_approx(tanh(NotComplex.new(5.49778714378214 + 2i)), 1.00002193068325 + -2.53924635030599e-05i, "tanh(NotComplex) - 5.49778714378214 + 2i");
is_approx(tanh(NotComplex.new(6.28318530717959 + 2i), Radians), 1.00000455895463 + -5.27848285809168e-06i, "tanh(NotComplex, Radians) - 6.28318530717959 + 2i");
is_approx(tanh(:x(NotComplex.new(6.80678408277788 + 2i))), 1.00000159982829 + -1.85231870546421e-06i, "tanh(:x(NotComplex)) - 6.80678408277788 + 2i");
is_approx(tanh(:x(NotComplex.new(585 + 114.591559026165i)), :base(Degrees)), 1.0000000017698 + -2.04911454909893e-09i, "tanh(:x(NotComplex), :base(Degrees)) - 585 + 114.591559026165i");

# DifferentReal tests
is_approx(DifferentReal.new(12.5663706144757).tanh, 0.999999999975677, "DifferentReal.tanh - 12.5663706144757");
is_approx(DifferentReal.new(-400).tanh(Gradians), -0.999993025339611, "DifferentReal.tanh(Gradians) - -400");
is_approx(DifferentReal.new(-0.625).tanh(:base(Circles)), -0.999223894878698, "DifferentReal.tanh(:base(Circles)) - -0.625");
is_approx(tanh(DifferentReal.new(-0.523598775603156)), -0.480472778160188, "tanh(DifferentReal) - -0.523598775603156");
is_approx(tanh(DifferentReal.new(0), Radians), 0, "tanh(DifferentReal, Radians) - 0");
is_approx(tanh(:x(DifferentReal.new(0.523598775603156))), 0.480472778160188, "tanh(:x(DifferentReal)) - 0.523598775603156");
is_approx(tanh(:x(DifferentReal.new(45)), :base(Degrees)), 0.655794202636825, "tanh(:x(DifferentReal), :base(Degrees)) - 45");

# Int tests
is_approx((90).Int.tanh(:base(Degrees)), 0.917152335669589, "Int.tanh(:base(Degrees)) - 90");
is_approx(tanh((135).Int, Degrees), 0.98219338000801, "tanh(Int, Degrees) - 135");
is_approx(tanh(:x((200).Int), :base(Gradians)), 0.996272076220967, "tanh(:x(Int), :base(Gradians)) - 200");

# atanh tests

for TrigTest::sines() -> $angle
{
    next if abs(cosh($angle.num(Radians))) < 1e-6;
    my $desired-result = sinh($angle.num(Radians)) / cosh($angle.num(Radians));

    # Num.atanh tests -- thorough
    is_approx($desired-result.Num.atanh.tanh, $desired-result, 
              "Num.atanh - {$angle.num(Radians)} default");
    for TrigTest::official_bases() -> $base {
        is_approx($desired-result.Num.atanh($base).tanh($base), $desired-result,
                  "Num.atanh - {$angle.num($base)} $base");
    }
    
    # Num.atanh(Complex) tests -- thorough
    for ($desired-result + 0i, $desired-result + .5i, $desired-result + 2i) -> $z {
        is_approx(tanh(atanh($z)), $z, 
                  "atanh(Complex) - {$angle.num(Radians)} default");
        is_approx($z.atanh.tanh, $z, 
                  "Complex.atanh - {$angle.num(Radians)} default");
        for TrigTest::official_bases() -> $base {
            is_approx($z.atanh($base).tanh($base), $z, 
                      "Complex.atanh - {$angle.num($base)} $base");
        }
    }
}
        
# Num tests
is_approx((0.480472778160188).Num.atanh(:base(Radians)), 0.523598775603156, "Num.atanh(:base(Radians)) - 0.523598775603156");
is_approx(atanh((0.655794202636825).Num), 0.785398163404734, "atanh(Num) - 0.785398163404734");
is_approx(atanh((0.480472778160188).Num, Degrees), 30, "atanh(Num, Degrees) - 30");
is_approx(atanh(:x((0.655794202636825).Num)), 0.785398163404734, "atanh(:x(Num)) - 0.785398163404734");
is_approx(atanh(:x((0.480472778160188).Num), :base(Gradians)), 33.3333333333333, "atanh(:x(Num), :base(Gradians)) - 33.3333333333333");

# Rat tests
is_approx(((0.655794202636825).Rat(1e-9)).atanh, 0.785398163404734, "Rat.atanh - 0.785398163404734");
is_approx((0.480472778160188).Rat(1e-9).atanh(Circles), 0.0833333333333333, "Rat.atanh(Circles) - 0.0833333333333333");
is_approx((0.655794202636825).Rat(1e-9).atanh(:base(Radians)), 0.785398163404734, "Rat.atanh(:base(Radians)) - 0.785398163404734");
is_approx(atanh((0.480472778160188).Rat(1e-9)), 0.523598775603156, "atanh(Rat) - 0.523598775603156");
is_approx(atanh((0.655794202636825).Rat(1e-9), Degrees), 45, "atanh(Rat, Degrees) - 45");
is_approx(atanh(:x((0.480472778160188).Rat(1e-9))), 0.523598775603156, "atanh(:x(Rat)) - 0.523598775603156");
is_approx(atanh(:x((0.655794202636825).Rat(1e-9)), :base(Gradians)), 50, "atanh(:x(Rat), :base(Gradians)) - 50");

# Complex tests
is_approx((0.523598775603156 + 2i).Complex.atanh(:base(Circles)), 0.0160130041020726 + 0.179585639857388i, "Complex.atanh(:base(Circles)) - 0.0160130041020726 + 0.179585639857388i");
is_approx(atanh((0.785398163404734 + 2i).Complex), 0.143655432578432 + 1.15296697280152i, "atanh(Complex) - 0.143655432578432 + 1.15296697280152i");
is_approx(atanh((0.523598775603156 + 2i).Complex, Radians), 0.100612672097949 + 1.12836985373239i, "atanh(Complex, Radians) - 0.100612672097949 + 1.12836985373239i");
is_approx(atanh(:x((0.785398163404734 + 2i).Complex)), 0.143655432578432 + 1.15296697280152i, "atanh(:x(Complex)) - 0.143655432578432 + 1.15296697280152i");
is_approx(atanh(:x((0.523598775603156 + 2i).Complex), :base(Degrees)), 5.76468147674614 + 64.6508303486597i, "atanh(:x(Complex), :base(Degrees)) - 5.76468147674614 + 64.6508303486597i");

# Str tests
is_approx(((0.655794202636825).Str).atanh, 0.785398163404734, "Str.atanh - 0.785398163404734");
is_approx((0.480472778160188).Str.atanh(Gradians), 33.3333333333333, "Str.atanh(Gradians) - 33.3333333333333");
is_approx((0.655794202636825).Str.atanh(:base(Circles)), 0.125, "Str.atanh(:base(Circles)) - 0.125");
is_approx(atanh((0.480472778160188).Str), 0.523598775603156, "atanh(Str) - 0.523598775603156");
is_approx(atanh((0.655794202636825).Str, Radians), 0.785398163404734, "atanh(Str, Radians) - 0.785398163404734");
is_approx(atanh(:x((0.480472778160188).Str)), 0.523598775603156, "atanh(:x(Str)) - 0.523598775603156");
is_approx(atanh(:x((0.655794202636825).Str), :base(Degrees)), 45, "atanh(:x(Str), :base(Degrees)) - 45");

# NotComplex tests
is_approx((NotComplex.new(0.523598775603156 + 2i)).atanh, 0.100612672097949 + 1.12836985373239i, "NotComplex.atanh - 0.100612672097949 + 1.12836985373239i");
is_approx(NotComplex.new(0.785398163404734 + 2i).atanh(Gradians), 9.14538887874479 + 73.4001571772242i, "NotComplex.atanh(Gradians) - 9.14538887874479 + 73.4001571772242i");
is_approx(NotComplex.new(0.523598775603156 + 2i).atanh(:base(Circles)), 0.0160130041020726 + 0.179585639857388i, "NotComplex.atanh(:base(Circles)) - 0.0160130041020726 + 0.179585639857388i");
is_approx(atanh(NotComplex.new(0.785398163404734 + 2i)), 0.143655432578432 + 1.15296697280152i, "atanh(NotComplex) - 0.143655432578432 + 1.15296697280152i");
is_approx(atanh(NotComplex.new(0.523598775603156 + 2i), Radians), 0.100612672097949 + 1.12836985373239i, "atanh(NotComplex, Radians) - 0.100612672097949 + 1.12836985373239i");
is_approx(atanh(:x(NotComplex.new(0.785398163404734 + 2i))), 0.143655432578432 + 1.15296697280152i, "atanh(:x(NotComplex)) - 0.143655432578432 + 1.15296697280152i");
is_approx(atanh(:x(NotComplex.new(0.523598775603156 + 2i)), :base(Degrees)), 5.76468147674614 + 64.6508303486597i, "atanh(:x(NotComplex), :base(Degrees)) - 5.76468147674614 + 64.6508303486597i");

# DifferentReal tests
is_approx((DifferentReal.new(0.655794202636825)).atanh, 0.785398163404734, "DifferentReal.atanh - 0.785398163404734");
is_approx(DifferentReal.new(0.480472778160188).atanh(Gradians), 33.3333333333333, "DifferentReal.atanh(Gradians) - 33.3333333333333");
is_approx(DifferentReal.new(0.655794202636825).atanh(:base(Circles)), 0.125, "DifferentReal.atanh(:base(Circles)) - 0.125");
is_approx(atanh(DifferentReal.new(0.480472778160188)), 0.523598775603156, "atanh(DifferentReal) - 0.523598775603156");
is_approx(atanh(DifferentReal.new(0.655794202636825), Radians), 0.785398163404734, "atanh(DifferentReal, Radians) - 0.785398163404734");
is_approx(atanh(:x(DifferentReal.new(0.480472778160188))), 0.523598775603156, "atanh(:x(DifferentReal)) - 0.523598775603156");
is_approx(atanh(:x(DifferentReal.new(0.655794202636825)), :base(Degrees)), 45, "atanh(:x(DifferentReal), :base(Degrees)) - 45");

done_testing;

# vim: ft=perl6 nomodifiable
