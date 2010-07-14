# WARNING:
# This is a generated file and should not be edited directly.
# look into generate-tests.pl instead

use v6;
use Test;
BEGIN { @*INC.push("t/spec/packages/") };
use TrigTestSupport;


# cosh tests

my $base_list = (TrigTest::official_bases() xx *).flat;
my $iter_count = 0;
for TrigTest::coshes() -> $angle
{
    
    my $desired-result = $angle.result;

    # Num.cosh tests -- very thorough
    is_approx($angle.num(Radians).cosh, $desired-result, 
              "Num.cosh - {$angle.num(Radians)} default");
    for TrigTest::official_bases() -> $base {
        is_approx($angle.num($base).cosh($base), $desired-result, 
                  "Num.cosh - {$angle.num($base)} $base");
    }

    # Complex.cosh tests -- also very thorough
    my Complex $zp0 = $angle.complex(0.0, Radians);
    my Complex $sz0 = $desired-result + 0i;
    my Complex $zp1 = $angle.complex(1.0, Radians);
    my Complex $sz1 = { (exp($_) + exp(-$_)) / 2 }($zp1);
    my Complex $zp2 = $angle.complex(2.0, Radians);
    my Complex $sz2 = { (exp($_) + exp(-$_)) / 2 }($zp2);
    
    is_approx($zp0.cosh, $sz0, "Complex.cosh - $zp0 default");
    is_approx($zp1.cosh, $sz1, "Complex.cosh - $zp1 default");
    is_approx($zp2.cosh, $sz2, "Complex.cosh - $zp2 default");
    
    for TrigTest::official_bases() -> $base {
        my Complex $z = $angle.complex(0.0, $base);
        is_approx($z.cosh($base), $sz0, "Complex.cosh - $z $base");
    
        $z = $angle.complex(1.0, $base);
        is_approx($z.cosh($base), $sz1, "Complex.cosh - $z $base");
    
        $z = $angle.complex(2.0, $base);
        is_approx($z.cosh($base), $sz2, "Complex.cosh - $z $base");
    }
}

is(cosh(Inf), Inf, "cosh(Inf) - default");
is(cosh(-Inf), Inf, "cosh(-Inf) - default");
given $base_list.shift
{
    is(cosh(Inf,  $_), Inf, "cosh(Inf) - $_");
    is(cosh(-Inf, $_), Inf, "cosh(-Inf) - $_");
}
        
# Num tests
is_approx((-6.28318530723787).Num.cosh(:base(Radians)), 267.746761499354, "Num.cosh(:base(Radians)) - -6.28318530723787");
is_approx(cosh((-3.92699081702367).Num), 25.3868611932849, "cosh(Num) - -3.92699081702367");
is_approx(cosh((-30).Num, Degrees), 1.14023832107909, "cosh(Num, Degrees) - -30");
is_approx(cosh(:x((0).Num)), 1, "cosh(:x(Num)) - 0");
is_approx(cosh(:x((33.3333333333333).Num), :base(Gradians)), 1.14023832107909, "cosh(:x(Num), :base(Gradians)) - 33.3333333333333");

# Rat tests
is_approx((0.785398163404734).Rat(1e-9).cosh, 1.32460908925833, "Rat.cosh - 0.785398163404734");
is_approx((0.25).Rat(1e-9).cosh(Circles), 2.50917847869159, "Rat.cosh(Circles) - 0.25");
is_approx((2.3561944902142).Rat(1e-9).cosh(:base(Radians)), 5.32275214963423, "Rat.cosh(:base(Radians)) - 2.3561944902142");
is_approx(cosh((3.14159265361894).Rat(1e-9)), 11.5919532758581, "cosh(Rat) - 3.14159265361894");
is_approx(cosh((225).Rat(1e-9), Degrees), 25.3868611932849, "cosh(Rat, Degrees) - 225");
is_approx(cosh(:x((4.7123889804284).Rat(1e-9))), 55.6633808928716, "cosh(:x(Rat)) - 4.7123889804284");
is_approx(cosh(:x((350).Rat(1e-9)), :base(Gradians)), 122.077579345808, "cosh(:x(Rat), :base(Gradians)) - 350");

# Complex tests
is_approx((1 + 0.318309886183791i).Complex.cosh(:base(Circles)), -111.421967793699 + 243.459743211402i, "Complex.cosh(:base(Circles)) - 1 + 0.318309886183791i");
is_approx(cosh((6.80678408277788 + 2i).Complex), -188.09008385867 + 410.983325209867i, "cosh(Complex) - 6.80678408277788 + 2i");
is_approx(cosh((-6.28318530717959 + 2i).Complex, Radians), -111.421967793699 + -243.459743211402i, "cosh(Complex, Radians) - -6.28318530717959 + 2i");
is_approx(cosh(:x((-3.92699081698724 + 2i).Complex)), -10.5646619754469 + -23.0662917865276i, "cosh(:x(Complex)) - -3.92699081698724 + 2i");
is_approx(cosh(:x((-30 + 114.591559026165i).Complex), :base(Degrees)), -0.474506570226888 + -0.498161754088942i, "cosh(:x(Complex), :base(Degrees)) - -30 + 114.591559026165i");

# Str tests
is_approx((0).Str.cosh, 1, "Str.cosh - 0");
is_approx((33.3333333333333).Str.cosh(Gradians), 1.14023832107909, "Str.cosh(Gradians) - 33.3333333333333");
is_approx((0.125).Str.cosh(:base(Circles)), 1.32460908925833, "Str.cosh(:base(Circles)) - 0.125");
is_approx(cosh((1.57079632680947).Str), 2.50917847869159, "cosh(Str) - 1.57079632680947");
is_approx(cosh((2.3561944902142).Str, Radians), 5.32275214963423, "cosh(Str, Radians) - 2.3561944902142");
is_approx(cosh(:x((3.14159265361894).Str)), 11.5919532758581, "cosh(:x(Str)) - 3.14159265361894");
is_approx(cosh(:x((225).Str), :base(Degrees)), 25.3868611932849, "cosh(:x(Str), :base(Degrees)) - 225");

# NotComplex tests
is_approx(NotComplex.new(4.71238898038469 + 2i).cosh, -23.1641398700872 + 50.6064005308964i, "NotComplex.cosh - 4.71238898038469 + 2i");
is_approx(NotComplex.new(350 + 127.323954473516i).cosh(Gradians), -50.8021984580908 + 111.001104449219i, "NotComplex.cosh(Gradians) - 350 + 127.323954473516i");
is_approx(NotComplex.new(1 + 0.318309886183791i).cosh(:base(Circles)), -111.421967793699 + 243.459743211402i, "NotComplex.cosh(:base(Circles)) - 1 + 0.318309886183791i");
is_approx(cosh(NotComplex.new(6.80678408277788 + 2i)), -188.09008385867 + 410.983325209867i, "cosh(NotComplex) - 6.80678408277788 + 2i");
is_approx(cosh(NotComplex.new(-6.28318530717959 + 2i), Radians), -111.421967793699 + -243.459743211402i, "cosh(NotComplex, Radians) - -6.28318530717959 + 2i");
is_approx(cosh(:x(NotComplex.new(-3.92699081698724 + 2i))), -10.5646619754469 + -23.0662917865276i, "cosh(:x(NotComplex)) - -3.92699081698724 + 2i");
is_approx(cosh(:x(NotComplex.new(-30 + 114.591559026165i)), :base(Degrees)), -0.474506570226888 + -0.498161754088942i, "cosh(:x(NotComplex), :base(Degrees)) - -30 + 114.591559026165i");

# DifferentReal tests
is_approx(DifferentReal.new(0).cosh, 1, "DifferentReal.cosh - 0");
is_approx(DifferentReal.new(33.3333333333333).cosh(Gradians), 1.14023832107909, "DifferentReal.cosh(Gradians) - 33.3333333333333");
is_approx(DifferentReal.new(0.125).cosh(:base(Circles)), 1.32460908925833, "DifferentReal.cosh(:base(Circles)) - 0.125");
is_approx(cosh(DifferentReal.new(1.57079632680947)), 2.50917847869159, "cosh(DifferentReal) - 1.57079632680947");
is_approx(cosh(DifferentReal.new(2.3561944902142), Radians), 5.32275214963423, "cosh(DifferentReal, Radians) - 2.3561944902142");
is_approx(cosh(:x(DifferentReal.new(3.14159265361894))), 11.5919532758581, "cosh(:x(DifferentReal)) - 3.14159265361894");
is_approx(cosh(:x(DifferentReal.new(225)), :base(Degrees)), 25.3868611932849, "cosh(:x(DifferentReal), :base(Degrees)) - 225");

# Int tests
is_approx((270).Int.cosh(:base(Degrees)), 55.6633808928716, "Int.cosh(:base(Degrees)) - 270");
is_approx(cosh((315).Int, Degrees), 122.077579345808, "cosh(Int, Degrees) - 315");
is_approx(cosh(:x((400).Int), :base(Gradians)), 267.746761499354, "cosh(:x(Int), :base(Gradians)) - 400");

# acosh tests

for TrigTest::coshes() -> $angle
{
    
    my $desired-result = $angle.result;

    # Num.acosh tests -- thorough
    is_approx($desired-result.Num.acosh.cosh, $desired-result, 
              "Num.acosh - {$angle.num(Radians)} default");
    for TrigTest::official_bases() -> $base {
        is_approx($desired-result.Num.acosh($base).cosh($base), $desired-result,
                  "Num.acosh - {$angle.num($base)} $base");
    }
    
    # Num.acosh(Complex) tests -- thorough
    for ($desired-result + 0i, $desired-result + .5i, $desired-result + 2i) -> $z {
        is_approx(cosh(acosh($z)), $z, 
                  "acosh(Complex) - {$angle.num(Radians)} default");
        is_approx($z.acosh.cosh, $z, 
                  "Complex.acosh - {$angle.num(Radians)} default");
        for TrigTest::official_bases() -> $base {
            is_approx($z.acosh($base).cosh($base), $z, 
                      "Complex.acosh - {$angle.num($base)} $base");
        }
    }
}
        
# Num tests
is_approx((1.14023832107909).Num.acosh(:base(Radians)), 0.523598775603156, "Num.acosh(:base(Radians)) - 0.523598775603156");
is_approx(acosh((1.32460908925833).Num), 0.785398163404734, "acosh(Num) - 0.785398163404734");
is_approx(acosh((1.14023832107909).Num, Degrees), 30, "acosh(Num, Degrees) - 30");
is_approx(acosh(:x((1.32460908925833).Num)), 0.785398163404734, "acosh(:x(Num)) - 0.785398163404734");
is_approx(acosh(:x((1.14023832107909).Num), :base(Gradians)), 33.3333333333333, "acosh(:x(Num), :base(Gradians)) - 33.3333333333333");

# Rat tests
is_approx(((1.32460908925833).Rat(1e-9)).acosh, 0.785398163404734, "Rat.acosh - 0.785398163404734");
is_approx((1.14023832107909).Rat(1e-9).acosh(Circles), 0.0833333333333333, "Rat.acosh(Circles) - 0.0833333333333333");
is_approx((1.32460908925833).Rat(1e-9).acosh(:base(Radians)), 0.785398163404734, "Rat.acosh(:base(Radians)) - 0.785398163404734");
is_approx(acosh((1.14023832107909).Rat(1e-9)), 0.523598775603156, "acosh(Rat) - 0.523598775603156");
is_approx(acosh((1.32460908925833).Rat(1e-9), Degrees), 45, "acosh(Rat, Degrees) - 45");
is_approx(acosh(:x((1.14023832107909).Rat(1e-9))), 0.523598775603156, "acosh(:x(Rat)) - 0.523598775603156");
is_approx(acosh(:x((1.32460908925833).Rat(1e-9)), :base(Gradians)), 50, "acosh(:x(Rat), :base(Gradians)) - 50");

# Complex tests
is_approx((0.523598775603156 + 2i).Complex.acosh(:base(Circles)), 0.23361063365218 + 0.213204857989985i, "Complex.acosh(:base(Circles)) - 0.23361063365218 + 0.213204857989985i");
is_approx(acosh((0.785398163404734 + 2i).Complex), 1.49709293866352 + 1.22945740853541i, "acosh(Complex) - 1.49709293866352 + 1.22945740853541i");
is_approx(acosh((0.523598775603156 + 2i).Complex, Radians), 1.46781890096429 + 1.33960563114198i, "acosh(Complex, Radians) - 1.46781890096429 + 1.33960563114198i");
is_approx(acosh(:x((0.785398163404734 + 2i).Complex)), 1.49709293866352 + 1.22945740853541i, "acosh(:x(Complex)) - 1.49709293866352 + 1.22945740853541i");
is_approx(acosh(:x((0.523598775603156 + 2i).Complex), :base(Degrees)), 84.0998281147849 + 76.7537488763944i, "acosh(:x(Complex), :base(Degrees)) - 84.0998281147849 + 76.7537488763944i");

# Str tests
is_approx(((1.32460908925833).Str).acosh, 0.785398163404734, "Str.acosh - 0.785398163404734");
is_approx((1.14023832107909).Str.acosh(Gradians), 33.3333333333333, "Str.acosh(Gradians) - 33.3333333333333");
is_approx((1.32460908925833).Str.acosh(:base(Circles)), 0.125, "Str.acosh(:base(Circles)) - 0.125");
is_approx(acosh((1.14023832107909).Str), 0.523598775603156, "acosh(Str) - 0.523598775603156");
is_approx(acosh((1.32460908925833).Str, Radians), 0.785398163404734, "acosh(Str, Radians) - 0.785398163404734");
is_approx(acosh(:x((1.14023832107909).Str)), 0.523598775603156, "acosh(:x(Str)) - 0.523598775603156");
is_approx(acosh(:x((1.32460908925833).Str), :base(Degrees)), 45, "acosh(:x(Str), :base(Degrees)) - 45");

# NotComplex tests
is_approx((NotComplex.new(0.523598775603156 + 2i)).acosh, 1.46781890096429 + 1.33960563114198i, "NotComplex.acosh - 1.46781890096429 + 1.33960563114198i");
is_approx(NotComplex.new(0.785398163404734 + 2i).acosh(Gradians), 95.3078965825084 + 78.2696895557452i, "NotComplex.acosh(Gradians) - 95.3078965825084 + 78.2696895557452i");
is_approx(NotComplex.new(0.523598775603156 + 2i).acosh(:base(Circles)), 0.23361063365218 + 0.213204857989985i, "NotComplex.acosh(:base(Circles)) - 0.23361063365218 + 0.213204857989985i");
is_approx(acosh(NotComplex.new(0.785398163404734 + 2i)), 1.49709293866352 + 1.22945740853541i, "acosh(NotComplex) - 1.49709293866352 + 1.22945740853541i");
is_approx(acosh(NotComplex.new(0.523598775603156 + 2i), Radians), 1.46781890096429 + 1.33960563114198i, "acosh(NotComplex, Radians) - 1.46781890096429 + 1.33960563114198i");
is_approx(acosh(:x(NotComplex.new(0.785398163404734 + 2i))), 1.49709293866352 + 1.22945740853541i, "acosh(:x(NotComplex)) - 1.49709293866352 + 1.22945740853541i");
is_approx(acosh(:x(NotComplex.new(0.523598775603156 + 2i)), :base(Degrees)), 84.0998281147849 + 76.7537488763944i, "acosh(:x(NotComplex), :base(Degrees)) - 84.0998281147849 + 76.7537488763944i");

# DifferentReal tests
is_approx((DifferentReal.new(1.32460908925833)).acosh, 0.785398163404734, "DifferentReal.acosh - 0.785398163404734");
is_approx(DifferentReal.new(1.14023832107909).acosh(Gradians), 33.3333333333333, "DifferentReal.acosh(Gradians) - 33.3333333333333");
is_approx(DifferentReal.new(1.32460908925833).acosh(:base(Circles)), 0.125, "DifferentReal.acosh(:base(Circles)) - 0.125");
is_approx(acosh(DifferentReal.new(1.14023832107909)), 0.523598775603156, "acosh(DifferentReal) - 0.523598775603156");
is_approx(acosh(DifferentReal.new(1.32460908925833), Radians), 0.785398163404734, "acosh(DifferentReal, Radians) - 0.785398163404734");
is_approx(acosh(:x(DifferentReal.new(1.14023832107909))), 0.523598775603156, "acosh(:x(DifferentReal)) - 0.523598775603156");
is_approx(acosh(:x(DifferentReal.new(1.32460908925833)), :base(Degrees)), 45, "acosh(:x(DifferentReal), :base(Degrees)) - 45");

done_testing;

# vim: ft=perl6 nomodifiable
