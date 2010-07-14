# WARNING:
# This is a generated file and should not be edited directly.
# look into generate-tests.pl instead

use v6;
use Test;
BEGIN { @*INC.push("t/spec/packages/") };
use TrigTestSupport;


# sech tests

my $base_list = (TrigTest::official_bases() xx *).flat;
my $iter_count = 0;
for TrigTest::cosines() -> $angle
{
    next if abs(cosh($angle.num(Radians))) < 1e-6;
    my $desired-result = 1.0 / cosh($angle.num(Radians));

    # Num.sech tests -- very thorough
    is_approx($angle.num(Radians).sech, $desired-result, 
              "Num.sech - {$angle.num(Radians)} default");
    for TrigTest::official_bases() -> $base {
        is_approx($angle.num($base).sech($base), $desired-result, 
                  "Num.sech - {$angle.num($base)} $base");
    }

    # Complex.sech tests -- also very thorough
    my Complex $zp0 = $angle.complex(0.0, Radians);
    my Complex $sz0 = $desired-result + 0i;
    my Complex $zp1 = $angle.complex(1.0, Radians);
    my Complex $sz1 = { 1.0 / cosh($_) }($zp1);
    my Complex $zp2 = $angle.complex(2.0, Radians);
    my Complex $sz2 = { 1.0 / cosh($_) }($zp2);
    
    is_approx($zp0.sech, $sz0, "Complex.sech - $zp0 default");
    is_approx($zp1.sech, $sz1, "Complex.sech - $zp1 default");
    is_approx($zp2.sech, $sz2, "Complex.sech - $zp2 default");
    
    for TrigTest::official_bases() -> $base {
        my Complex $z = $angle.complex(0.0, $base);
        is_approx($z.sech($base), $sz0, "Complex.sech - $z $base");
    
        $z = $angle.complex(1.0, $base);
        is_approx($z.sech($base), $sz1, "Complex.sech - $z $base");
    
        $z = $angle.complex(2.0, $base);
        is_approx($z.sech($base), $sz2, "Complex.sech - $z $base");
    }
}

is(sech(Inf), 0, "sech(Inf) - default");
is(sech(-Inf), 0, "sech(-Inf) - default");
given $base_list.shift
{
    is(sech(Inf,  $_), 0, "sech(Inf) - $_");
    is(sech(-Inf, $_), 0, "sech(-Inf) - $_");
}
        
# Num tests
is_approx((-7.85398163404734).Num.sech(:base(Radians)), 0.000776406290791195, "Num.sech(:base(Radians)) - -7.85398163404734");
is_approx(sech((-5.49778714383314).Num), 0.00819151235926221, "sech(Num) - -5.49778714383314");
is_approx(sech((-120).Num, Degrees), 0.242610328725292, "sech(Num, Degrees) - -120");
is_approx(sech(:x((-1.57079632680947).Num)), 0.39853681533306, "sech(:x(Num)) - -1.57079632680947");
is_approx(sech(:x((-66.6666666666667).Num), :base(Gradians)), 0.624887966291348, "sech(:x(Num), :base(Gradians)) - -66.6666666666667");

# Rat tests
is_approx((-0.785398163404734).Rat(1e-9).sech, 0.754939708710524, "Rat.sech - -0.785398163404734");
is_approx((0).Rat(1e-9).sech(Circles), 1, "Rat.sech(Circles) - 0");
is_approx((0.785398163404734).Rat(1e-9).sech(:base(Radians)), 0.754939708710524, "Rat.sech(:base(Radians)) - 0.785398163404734");
is_approx(sech((1.57079632680947).Rat(1e-9)), 0.39853681533306, "sech(Rat) - 1.57079632680947");
is_approx(sech((135).Rat(1e-9), Degrees), 0.187872734233684, "sech(Rat, Degrees) - 135");
is_approx(sech(:x((3.14159265361894).Rat(1e-9))), 0.0862667383315497, "sech(:x(Rat)) - 3.14159265361894");
is_approx(sech(:x((250).Rat(1e-9)), :base(Gradians)), 0.03939045447117, "sech(:x(Rat), :base(Gradians)) - 250");

# Complex tests
is_approx((0.75 + 0.318309886183791i).Complex.sech(:base(Circles)), -0.00747812852392195 + -0.0163373718784962i, "Complex.sech(:base(Circles)) - 0.75 + 0.318309886183791i");
is_approx(sech((5.23598775598299 + 2i).Complex), -0.00442939468455126 + -0.00967785580479825i, "sech(Complex) - 5.23598775598299 + 2i");
is_approx(sech((8.63937979737193 + 2i).Complex, Radians), -0.000147313195924476 + -0.000321885185311518i, "sech(Complex, Radians) - 8.63937979737193 + 2i");
is_approx(sech(:x((10.9955742875643 + 2i).Complex)), -1.39623768314672e-05 + -3.05083499454631e-05i, "sech(:x(Complex)) - 10.9955742875643 + 2i");
is_approx(sech(:x((-450 + 114.591559026165i).Complex), :base(Degrees)), -0.000323099182825132 + 0.000705984381473971i, "sech(:x(Complex), :base(Degrees)) - -450 + 114.591559026165i");

# Str tests
is_approx((-5.49778714383314).Str.sech, 0.00819151235926221, "Str.sech - -5.49778714383314");
is_approx((-133.333333333333).Str.sech(Gradians), 0.242610328725292, "Str.sech(Gradians) - -133.333333333333");
is_approx((-0.25).Str.sech(:base(Circles)), 0.39853681533306, "Str.sech(:base(Circles)) - -0.25");
is_approx(sech((-1.04719755120631).Str), 0.624887966291348, "sech(Str) - -1.04719755120631");
is_approx(sech((-0.785398163404734).Str, Radians), 0.754939708710524, "sech(Str, Radians) - -0.785398163404734");
is_approx(sech(:x((0).Str)), 1, "sech(:x(Str)) - 0");
is_approx(sech(:x((45).Str), :base(Degrees)), 0.754939708710524, "sech(:x(Str), :base(Degrees)) - 45");

# NotComplex tests
is_approx(NotComplex.new(1.5707963267949 + 2i).sech, -0.190922860876021 + -0.382612165180853i, "NotComplex.sech - 1.5707963267949 + 2i");
is_approx(NotComplex.new(150 + 127.323954473516i).sech(Gradians), -0.0805328866721174 + -0.172834180073469i, "NotComplex.sech(Gradians) - 150 + 127.323954473516i");
is_approx(NotComplex.new(0.5 + 0.318309886183791i).sech(:base(Circles)), -0.0361218942926504 + -0.0786335422219264i, "NotComplex.sech(:base(Circles)) - 0.5 + 0.318309886183791i");
is_approx(sech(NotComplex.new(3.92699081698724 + 2i)), -0.016413269655411 + -0.035835814522277i, "sech(NotComplex) - 3.92699081698724 + 2i");
is_approx(sech(NotComplex.new(4.71238898038469 + 2i), Radians), -0.00747812852392195 + -0.0163373718784962i, "sech(NotComplex, Radians) - 4.71238898038469 + 2i");
is_approx(sech(:x(NotComplex.new(5.23598775598299 + 2i))), -0.00442939468455126 + -0.00967785580479825i, "sech(:x(NotComplex)) - 5.23598775598299 + 2i");
is_approx(sech(:x(NotComplex.new(495 + 114.591559026165i)), :base(Degrees)), -0.000147313195924476 + -0.000321885185311518i, "sech(:x(NotComplex), :base(Degrees)) - 495 + 114.591559026165i");

# DifferentReal tests
is_approx(DifferentReal.new(10.9955742876663).sech, 3.3551563035587e-05, "DifferentReal.sech - 10.9955742876663");
is_approx(DifferentReal.new(-500).sech(Gradians), 0.000776406290791195, "DifferentReal.sech(Gradians) - -500");
is_approx(DifferentReal.new(-0.875).sech(:base(Circles)), 0.00819151235926221, "DifferentReal.sech(:base(Circles)) - -0.875");
is_approx(sech(DifferentReal.new(-2.09439510241262)), 0.242610328725292, "sech(DifferentReal) - -2.09439510241262");
is_approx(sech(DifferentReal.new(-1.57079632680947), Radians), 0.39853681533306, "sech(DifferentReal, Radians) - -1.57079632680947");
is_approx(sech(:x(DifferentReal.new(-1.04719755120631))), 0.624887966291348, "sech(:x(DifferentReal)) - -1.04719755120631");
is_approx(sech(:x(DifferentReal.new(-45)), :base(Degrees)), 0.754939708710524, "sech(:x(DifferentReal), :base(Degrees)) - -45");

# Int tests
is_approx((0).Int.sech(:base(Degrees)), 1, "Int.sech(:base(Degrees)) - 0");
is_approx(sech((45).Int, Degrees), 0.754939708710524, "sech(Int, Degrees) - 45");
is_approx(sech(:x((100).Int), :base(Gradians)), 0.39853681533306, "sech(:x(Int), :base(Gradians)) - 100");

# asech tests

for TrigTest::cosines() -> $angle
{
    next if abs(cosh($angle.num(Radians))) < 1e-6;
    my $desired-result = 1.0 / cosh($angle.num(Radians));

    # Num.asech tests -- thorough
    is_approx($desired-result.Num.asech.sech, $desired-result, 
              "Num.asech - {$angle.num(Radians)} default");
    for TrigTest::official_bases() -> $base {
        is_approx($desired-result.Num.asech($base).sech($base), $desired-result,
                  "Num.asech - {$angle.num($base)} $base");
    }
    
    # Num.asech(Complex) tests -- thorough
    for ($desired-result + 0i, $desired-result + .5i, $desired-result + 2i) -> $z {
        is_approx(sech(asech($z)), $z, 
                  "asech(Complex) - {$angle.num(Radians)} default");
        is_approx($z.asech.sech, $z, 
                  "Complex.asech - {$angle.num(Radians)} default");
        for TrigTest::official_bases() -> $base {
            is_approx($z.asech($base).sech($base), $z, 
                      "Complex.asech - {$angle.num($base)} $base");
        }
    }
}
        
# Num tests
is_approx((0.754939708710524).Num.asech(:base(Radians)), 0.785398163404734, "Num.asech(:base(Radians)) - 0.785398163404734");
is_approx(asech((0.754939708710524).Num), 0.785398163404734, "asech(Num) - 0.785398163404734");
is_approx(asech((0.754939708710524).Num, Degrees), 45, "asech(Num, Degrees) - 45");
is_approx(asech(:x((0.754939708710524).Num)), 0.785398163404734, "asech(:x(Num)) - 0.785398163404734");
is_approx(asech(:x((0.754939708710524).Num), :base(Gradians)), 50, "asech(:x(Num), :base(Gradians)) - 50");

# Rat tests
is_approx(((0.754939708710524).Rat(1e-9)).asech, 0.785398163404734, "Rat.asech - 0.785398163404734");
is_approx((0.754939708710524).Rat(1e-9).asech(Circles), 0.125, "Rat.asech(Circles) - 0.125");
is_approx((0.754939708710524).Rat(1e-9).asech(:base(Radians)), 0.785398163404734, "Rat.asech(:base(Radians)) - 0.785398163404734");
is_approx(asech((0.754939708710524).Rat(1e-9)), 0.785398163404734, "asech(Rat) - 0.785398163404734");
is_approx(asech((0.754939708710524).Rat(1e-9), Degrees), 45, "asech(Rat, Degrees) - 45");
is_approx(asech(:x((0.754939708710524).Rat(1e-9))), 0.785398163404734, "asech(:x(Rat)) - 0.785398163404734");
is_approx(asech(:x((0.754939708710524).Rat(1e-9)), :base(Gradians)), 50, "asech(:x(Rat), :base(Gradians)) - 50");

# Complex tests
is_approx((0.785398163404734 + 2i).Complex.asech(:base(Circles)), 0.0677341793491909 + -0.225103444228091i, "Complex.asech(:base(Circles)) - 0.0677341793491909 + -0.225103444228091i");
is_approx(asech((0.785398163404734 + 2i).Complex), 0.425586400480703 + -1.41436665336946i, "asech(Complex) - 0.425586400480703 + -1.41436665336946i");
is_approx(asech((0.785398163404734 + 2i).Complex, Radians), 0.425586400480703 + -1.41436665336946i, "asech(Complex, Radians) - 0.425586400480703 + -1.41436665336946i");
is_approx(asech(:x((0.785398163404734 + 2i).Complex)), 0.425586400480703 + -1.41436665336946i, "asech(:x(Complex)) - 0.425586400480703 + -1.41436665336946i");
is_approx(asech(:x((0.785398163404734 + 2i).Complex), :base(Degrees)), 24.3843045657087 + -81.0372399221129i, "asech(:x(Complex), :base(Degrees)) - 24.3843045657087 + -81.0372399221129i");

# Str tests
is_approx(((0.754939708710524).Str).asech, 0.785398163404734, "Str.asech - 0.785398163404734");
is_approx((0.754939708710524).Str.asech(Gradians), 50, "Str.asech(Gradians) - 50");
is_approx((0.754939708710524).Str.asech(:base(Circles)), 0.125, "Str.asech(:base(Circles)) - 0.125");
is_approx(asech((0.754939708710524).Str), 0.785398163404734, "asech(Str) - 0.785398163404734");
is_approx(asech((0.754939708710524).Str, Radians), 0.785398163404734, "asech(Str, Radians) - 0.785398163404734");
is_approx(asech(:x((0.754939708710524).Str)), 0.785398163404734, "asech(:x(Str)) - 0.785398163404734");
is_approx(asech(:x((0.754939708710524).Str), :base(Degrees)), 45, "asech(:x(Str), :base(Degrees)) - 45");

# NotComplex tests
is_approx((NotComplex.new(0.785398163404734 + 2i)).asech, 0.425586400480703 + -1.41436665336946i, "NotComplex.asech - 0.425586400480703 + -1.41436665336946i");
is_approx(NotComplex.new(0.785398163404734 + 2i).asech(Gradians), 27.0936717396764 + -90.0413776912366i, "NotComplex.asech(Gradians) - 27.0936717396764 + -90.0413776912366i");
is_approx(NotComplex.new(0.785398163404734 + 2i).asech(:base(Circles)), 0.0677341793491909 + -0.225103444228091i, "NotComplex.asech(:base(Circles)) - 0.0677341793491909 + -0.225103444228091i");
is_approx(asech(NotComplex.new(0.785398163404734 + 2i)), 0.425586400480703 + -1.41436665336946i, "asech(NotComplex) - 0.425586400480703 + -1.41436665336946i");
is_approx(asech(NotComplex.new(0.785398163404734 + 2i), Radians), 0.425586400480703 + -1.41436665336946i, "asech(NotComplex, Radians) - 0.425586400480703 + -1.41436665336946i");
is_approx(asech(:x(NotComplex.new(0.785398163404734 + 2i))), 0.425586400480703 + -1.41436665336946i, "asech(:x(NotComplex)) - 0.425586400480703 + -1.41436665336946i");
is_approx(asech(:x(NotComplex.new(0.785398163404734 + 2i)), :base(Degrees)), 24.3843045657087 + -81.0372399221129i, "asech(:x(NotComplex), :base(Degrees)) - 24.3843045657087 + -81.0372399221129i");

# DifferentReal tests
is_approx((DifferentReal.new(0.754939708710524)).asech, 0.785398163404734, "DifferentReal.asech - 0.785398163404734");
is_approx(DifferentReal.new(0.754939708710524).asech(Gradians), 50, "DifferentReal.asech(Gradians) - 50");
is_approx(DifferentReal.new(0.754939708710524).asech(:base(Circles)), 0.125, "DifferentReal.asech(:base(Circles)) - 0.125");
is_approx(asech(DifferentReal.new(0.754939708710524)), 0.785398163404734, "asech(DifferentReal) - 0.785398163404734");
is_approx(asech(DifferentReal.new(0.754939708710524), Radians), 0.785398163404734, "asech(DifferentReal, Radians) - 0.785398163404734");
is_approx(asech(:x(DifferentReal.new(0.754939708710524))), 0.785398163404734, "asech(:x(DifferentReal)) - 0.785398163404734");
is_approx(asech(:x(DifferentReal.new(0.754939708710524)), :base(Degrees)), 45, "asech(:x(DifferentReal), :base(Degrees)) - 45");

done_testing;

# vim: ft=perl6 nomodifiable
