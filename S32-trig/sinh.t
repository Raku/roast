# WARNING:
# This is a generated file and should not be edited directly.
# look into generate-tests.pl instead

use v6;
use Test;
BEGIN { @*INC.push("t/spec/packages/") };
use TrigTestSupport;


# sinh tests

my $base_list = (TrigTest::official_bases() xx *).flat;
my $iter_count = 0;
for TrigTest::sinhes() -> $angle
{
    
    my $desired-result = $angle.result;

    # Num.sinh tests -- very thorough
    is_approx($angle.num(Radians).sinh, $desired-result, 
              "Num.sinh - {$angle.num(Radians)} default");
    for TrigTest::official_bases() -> $base {
        is_approx($angle.num($base).sinh($base), $desired-result, 
                  "Num.sinh - {$angle.num($base)} $base");
    }

    # Complex.sinh tests -- also very thorough
    my Complex $zp0 = $angle.complex(0.0, Radians);
    my Complex $sz0 = $desired-result + 0i;
    my Complex $zp1 = $angle.complex(1.0, Radians);
    my Complex $sz1 = { (exp($_) - exp(-$_)) / 2 }($zp1);
    my Complex $zp2 = $angle.complex(2.0, Radians);
    my Complex $sz2 = { (exp($_) - exp(-$_)) / 2 }($zp2);
    
    is_approx($zp0.sinh, $sz0, "Complex.sinh - $zp0 default");
    is_approx($zp1.sinh, $sz1, "Complex.sinh - $zp1 default");
    is_approx($zp2.sinh, $sz2, "Complex.sinh - $zp2 default");
    
    for TrigTest::official_bases() -> $base {
        my Complex $z = $angle.complex(0.0, $base);
        is_approx($z.sinh($base), $sz0, "Complex.sinh - $z $base");
    
        $z = $angle.complex(1.0, $base);
        is_approx($z.sinh($base), $sz1, "Complex.sinh - $z $base");
    
        $z = $angle.complex(2.0, $base);
        is_approx($z.sinh($base), $sz2, "Complex.sinh - $z $base");
    }
}

is(sinh(Inf), Inf, "sinh(Inf) - default");
is(sinh(-Inf), -Inf, "sinh(-Inf) - default");
given $base_list.shift
{
    is(sinh(Inf,  $_), Inf, "sinh(Inf) - $_");
    is(sinh(-Inf, $_), -Inf, "sinh(-Inf) - $_");
}
        
# Num tests
is_approx((-6.28318530723787).Num.sinh(:base(Radians)), -267.744894056623, "Num.sinh(:base(Radians)) - -6.28318530723787");
is_approx(sinh((-3.92699081702367).Num), -25.367158320299, "sinh(Num) - -3.92699081702367");
is_approx(sinh((-30).Num, Degrees), -0.547853473893578, "sinh(Num, Degrees) - -30");
is_approx(sinh(:x((0).Num)), 0, "sinh(:x(Num)) - 0");
is_approx(sinh(:x((33.3333333333333).Num), :base(Gradians)), 0.547853473893578, "sinh(:x(Num), :base(Gradians)) - 33.3333333333333");

# Rat tests
is_approx((0.785398163404734).Rat(1e-9).sinh, 0.86867096149566, "Rat.sinh - 0.785398163404734");
is_approx((0.25).Rat(1e-9).sinh(Circles), 2.30129890234386, "Rat.sinh(Circles) - 0.25");
is_approx((2.3561944902142).Rat(1e-9).sinh(:base(Radians)), 5.22797192479415, "Rat.sinh(:base(Radians)) - 2.3561944902142");
is_approx(sinh((3.14159265361894).Rat(1e-9)), 11.5487393575956, "sinh(Rat) - 3.14159265361894");
is_approx(sinh((225).Rat(1e-9), Degrees), 25.367158320299, "sinh(Rat, Degrees) - 225");
is_approx(sinh(:x((4.7123889804284).Rat(1e-9))), 55.6543976018509, "sinh(:x(Rat)) - 4.7123889804284");
is_approx(sinh(:x((350).Rat(1e-9)), :base(Gradians)), 122.073483520919, "sinh(:x(Rat), :base(Gradians)) - 350");

# Complex tests
is_approx((1 + 0.318309886183791i).Complex.sinh(:base(Circles)), -111.421190663313 + 243.461441272272i, "Complex.sinh(:base(Circles)) - 1 + 0.318309886183791i");
is_approx(sinh((6.80678408277788 + 2i).Complex), -188.089623498406 + 410.984331115396i, "sinh(Complex) - 6.80678408277788 + 2i");
is_approx(sinh((-6.28318530717959 + 2i).Complex, Radians), 111.421190663313 + 243.461441272272i, "sinh(Complex, Radians) - -6.28318530717959 + 2i");
is_approx(sinh(:x((-3.92699081698724 + 2i).Complex)), 10.5564626871829 + 23.0842075582347i, "sinh(:x(Complex)) - -3.92699081698724 + 2i");
is_approx(sinh(:x((-30 + 114.591559026165i).Complex), :base(Degrees)), 0.227987490052175 + 1.03681577132525i, "sinh(:x(Complex), :base(Degrees)) - -30 + 114.591559026165i");

# Str tests
is_approx((0).Str.sinh, 0, "Str.sinh - 0");
is_approx((33.3333333333333).Str.sinh(Gradians), 0.547853473893578, "Str.sinh(Gradians) - 33.3333333333333");
is_approx((0.125).Str.sinh(:base(Circles)), 0.86867096149566, "Str.sinh(:base(Circles)) - 0.125");
is_approx(sinh((1.57079632680947).Str), 2.30129890234386, "sinh(Str) - 1.57079632680947");
is_approx(sinh((2.3561944902142).Str, Radians), 5.22797192479415, "sinh(Str, Radians) - 2.3561944902142");
is_approx(sinh(:x((3.14159265361894).Str)), 11.5487393575956, "sinh(:x(Str)) - 3.14159265361894");
is_approx(sinh(:x((225).Str), :base(Degrees)), 25.367158320299, "sinh(:x(Str), :base(Degrees)) - 225");

# NotComplex tests
is_approx(NotComplex.new(4.71238898038469 + 2i).sinh, -23.1604015019471 + 50.614569014306i, "NotComplex.sinh - 4.71238898038469 + 2i");
is_approx(NotComplex.new(350 + 127.323954473516i).sinh(Gradians), -50.8004939935201 + 111.004828772251i, "NotComplex.sinh(Gradians) - 350 + 127.323954473516i");
is_approx(NotComplex.new(1 + 0.318309886183791i).sinh(:base(Circles)), -111.421190663313 + 243.461441272272i, "NotComplex.sinh(:base(Circles)) - 1 + 0.318309886183791i");
is_approx(sinh(NotComplex.new(6.80678408277788 + 2i)), -188.089623498406 + 410.984331115396i, "sinh(NotComplex) - 6.80678408277788 + 2i");
is_approx(sinh(NotComplex.new(-6.28318530717959 + 2i), Radians), 111.421190663313 + 243.461441272272i, "sinh(NotComplex, Radians) - -6.28318530717959 + 2i");
is_approx(sinh(:x(NotComplex.new(-3.92699081698724 + 2i))), 10.5564626871829 + 23.0842075582347i, "sinh(:x(NotComplex)) - -3.92699081698724 + 2i");
is_approx(sinh(:x(NotComplex.new(-30 + 114.591559026165i)), :base(Degrees)), 0.227987490052175 + 1.03681577132525i, "sinh(:x(NotComplex), :base(Degrees)) - -30 + 114.591559026165i");

# DifferentReal tests
is_approx(DifferentReal.new(0).sinh, 0, "DifferentReal.sinh - 0");
is_approx(DifferentReal.new(33.3333333333333).sinh(Gradians), 0.547853473893578, "DifferentReal.sinh(Gradians) - 33.3333333333333");
is_approx(DifferentReal.new(0.125).sinh(:base(Circles)), 0.86867096149566, "DifferentReal.sinh(:base(Circles)) - 0.125");
is_approx(sinh(DifferentReal.new(1.57079632680947)), 2.30129890234386, "sinh(DifferentReal) - 1.57079632680947");
is_approx(sinh(DifferentReal.new(2.3561944902142), Radians), 5.22797192479415, "sinh(DifferentReal, Radians) - 2.3561944902142");
is_approx(sinh(:x(DifferentReal.new(3.14159265361894))), 11.5487393575956, "sinh(:x(DifferentReal)) - 3.14159265361894");
is_approx(sinh(:x(DifferentReal.new(225)), :base(Degrees)), 25.367158320299, "sinh(:x(DifferentReal), :base(Degrees)) - 225");

# Int tests
is_approx((270).Int.sinh(:base(Degrees)), 55.6543976018509, "Int.sinh(:base(Degrees)) - 270");
is_approx(sinh((315).Int, Degrees), 122.073483520919, "sinh(Int, Degrees) - 315");
is_approx(sinh(:x((400).Int), :base(Gradians)), 267.744894056623, "sinh(:x(Int), :base(Gradians)) - 400");

# asinh tests

for TrigTest::sinhes() -> $angle
{
    
    my $desired-result = $angle.result;

    # Num.asinh tests -- thorough
    is_approx($desired-result.Num.asinh.sinh, $desired-result, 
              "Num.asinh - {$angle.num(Radians)} default");
    for TrigTest::official_bases() -> $base {
        is_approx($desired-result.Num.asinh($base).sinh($base), $desired-result,
                  "Num.asinh - {$angle.num($base)} $base");
    }
    
    # Num.asinh(Complex) tests -- thorough
    for ($desired-result + 0i, $desired-result + .5i, $desired-result + 2i) -> $z {
        is_approx(sinh(asinh($z)), $z, 
                  "asinh(Complex) - {$angle.num(Radians)} default");
        is_approx($z.asinh.sinh, $z, 
                  "Complex.asinh - {$angle.num(Radians)} default");
        for TrigTest::official_bases() -> $base {
            is_approx($z.asinh($base).sinh($base), $z, 
                      "Complex.asinh - {$angle.num($base)} $base");
        }
    }
}
        
# Num tests
is_approx((0.547853473893578).Num.asinh(:base(Radians)), 0.523598775603156, "Num.asinh(:base(Radians)) - 0.523598775603156");
is_approx(asinh((0.86867096149566).Num), 0.785398163404734, "asinh(Num) - 0.785398163404734");
is_approx(asinh((0.547853473893578).Num, Degrees), 30, "asinh(Num, Degrees) - 30");
is_approx(asinh(:x((0.86867096149566).Num)), 0.785398163404734, "asinh(:x(Num)) - 0.785398163404734");
is_approx(asinh(:x((0.547853473893578).Num), :base(Gradians)), 33.3333333333333, "asinh(:x(Num), :base(Gradians)) - 33.3333333333333");

# Rat tests
is_approx(((0.86867096149566).Rat(1e-9)).asinh, 0.785398163404734, "Rat.asinh - 0.785398163404734");
is_approx((0.547853473893578).Rat(1e-9).asinh(Circles), 0.0833333333333333, "Rat.asinh(Circles) - 0.0833333333333333");
is_approx((0.86867096149566).Rat(1e-9).asinh(:base(Radians)), 0.785398163404734, "Rat.asinh(:base(Radians)) - 0.785398163404734");
is_approx(asinh((0.547853473893578).Rat(1e-9)), 0.523598775603156, "asinh(Rat) - 0.523598775603156");
is_approx(asinh((0.86867096149566).Rat(1e-9), Degrees), 45, "asinh(Rat, Degrees) - 45");
is_approx(asinh(:x((0.547853473893578).Rat(1e-9))), 0.523598775603156, "asinh(:x(Rat)) - 0.523598775603156");
is_approx(asinh(:x((0.86867096149566).Rat(1e-9)), :base(Gradians)), 50, "asinh(:x(Rat), :base(Gradians)) - 50");

# Complex tests
is_approx((0.523598775603156 + 2i).Complex.asinh(:base(Circles)), 0.217378232794649 + 0.203866513229826i, "Complex.asinh(:base(Circles)) - 0.217378232794649 + 0.203866513229826i");
is_approx(asinh((0.785398163404734 + 2i).Complex), 1.41841325789332 + 1.15495109689711i, "asinh(Complex) - 1.41841325789332 + 1.15495109689711i");
is_approx(asinh((0.523598775603156 + 2i).Complex, Radians), 1.365827718396 + 1.28093108055158i, "asinh(Complex, Radians) - 1.365827718396 + 1.28093108055158i");
is_approx(asinh(:x((0.785398163404734 + 2i).Complex)), 1.41841325789332 + 1.15495109689711i, "asinh(:x(Complex)) - 1.41841325789332 + 1.15495109689711i");
is_approx(asinh(:x((0.523598775603156 + 2i).Complex), :base(Degrees)), 78.2561638060736 + 73.3919447627375i, "asinh(:x(Complex), :base(Degrees)) - 78.2561638060736 + 73.3919447627375i");

# Str tests
is_approx(((0.86867096149566).Str).asinh, 0.785398163404734, "Str.asinh - 0.785398163404734");
is_approx((0.547853473893578).Str.asinh(Gradians), 33.3333333333333, "Str.asinh(Gradians) - 33.3333333333333");
is_approx((0.86867096149566).Str.asinh(:base(Circles)), 0.125, "Str.asinh(:base(Circles)) - 0.125");
is_approx(asinh((0.547853473893578).Str), 0.523598775603156, "asinh(Str) - 0.523598775603156");
is_approx(asinh((0.86867096149566).Str, Radians), 0.785398163404734, "asinh(Str, Radians) - 0.785398163404734");
is_approx(asinh(:x((0.547853473893578).Str)), 0.523598775603156, "asinh(:x(Str)) - 0.523598775603156");
is_approx(asinh(:x((0.86867096149566).Str), :base(Degrees)), 45, "asinh(:x(Str), :base(Degrees)) - 45");

# NotComplex tests
is_approx((NotComplex.new(0.523598775603156 + 2i)).asinh, 1.365827718396 + 1.28093108055158i, "NotComplex.asinh - 1.365827718396 + 1.28093108055158i");
is_approx(NotComplex.new(0.785398163404734 + 2i).asinh(Gradians), 90.2989925363205 + 73.5264704402324i, "NotComplex.asinh(Gradians) - 90.2989925363205 + 73.5264704402324i");
is_approx(NotComplex.new(0.523598775603156 + 2i).asinh(:base(Circles)), 0.217378232794649 + 0.203866513229826i, "NotComplex.asinh(:base(Circles)) - 0.217378232794649 + 0.203866513229826i");
is_approx(asinh(NotComplex.new(0.785398163404734 + 2i)), 1.41841325789332 + 1.15495109689711i, "asinh(NotComplex) - 1.41841325789332 + 1.15495109689711i");
is_approx(asinh(NotComplex.new(0.523598775603156 + 2i), Radians), 1.365827718396 + 1.28093108055158i, "asinh(NotComplex, Radians) - 1.365827718396 + 1.28093108055158i");
is_approx(asinh(:x(NotComplex.new(0.785398163404734 + 2i))), 1.41841325789332 + 1.15495109689711i, "asinh(:x(NotComplex)) - 1.41841325789332 + 1.15495109689711i");
is_approx(asinh(:x(NotComplex.new(0.523598775603156 + 2i)), :base(Degrees)), 78.2561638060736 + 73.3919447627375i, "asinh(:x(NotComplex), :base(Degrees)) - 78.2561638060736 + 73.3919447627375i");

# DifferentReal tests
is_approx((DifferentReal.new(0.86867096149566)).asinh, 0.785398163404734, "DifferentReal.asinh - 0.785398163404734");
is_approx(DifferentReal.new(0.547853473893578).asinh(Gradians), 33.3333333333333, "DifferentReal.asinh(Gradians) - 33.3333333333333");
is_approx(DifferentReal.new(0.86867096149566).asinh(:base(Circles)), 0.125, "DifferentReal.asinh(:base(Circles)) - 0.125");
is_approx(asinh(DifferentReal.new(0.547853473893578)), 0.523598775603156, "asinh(DifferentReal) - 0.523598775603156");
is_approx(asinh(DifferentReal.new(0.86867096149566), Radians), 0.785398163404734, "asinh(DifferentReal, Radians) - 0.785398163404734");
is_approx(asinh(:x(DifferentReal.new(0.547853473893578))), 0.523598775603156, "asinh(:x(DifferentReal)) - 0.523598775603156");
is_approx(asinh(:x(DifferentReal.new(0.86867096149566)), :base(Degrees)), 45, "asinh(:x(DifferentReal), :base(Degrees)) - 45");

done_testing;

# vim: ft=perl6 nomodifiable
