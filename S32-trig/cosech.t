# WARNING:
# This is a generated file and should not be edited directly.
# look into generate-tests.pl instead

use v6;
use Test;
BEGIN { @*INC.push("t/spec/packages/") };
use TrigTestSupport;


# cosech tests

my $base_list = (TrigTest::official_bases() xx *).flat;
my $iter_count = 0;
for TrigTest::sines() -> $angle
{
    next if abs(sinh($angle.num(Radians))) < 1e-6;
    my $desired-result = 1.0 / sinh($angle.num(Radians));

    # Num.cosech tests -- very thorough
    is_approx($angle.num(Radians).cosech, $desired-result, 
              "Num.cosech - {$angle.num(Radians)} default");
    for TrigTest::official_bases() -> $base {
        is_approx($angle.num($base).cosech($base), $desired-result, 
                  "Num.cosech - {$angle.num($base)} $base");
    }

    # Complex.cosech tests -- also very thorough
    my Complex $zp0 = $angle.complex(0.0, Radians);
    my Complex $sz0 = $desired-result + 0i;
    my Complex $zp1 = $angle.complex(1.0, Radians);
    my Complex $sz1 = { 1.0 / sinh($_) }($zp1);
    my Complex $zp2 = $angle.complex(2.0, Radians);
    my Complex $sz2 = { 1.0 / sinh($_) }($zp2);
    
    is_approx($zp0.cosech, $sz0, "Complex.cosech - $zp0 default");
    is_approx($zp1.cosech, $sz1, "Complex.cosech - $zp1 default");
    is_approx($zp2.cosech, $sz2, "Complex.cosech - $zp2 default");
    
    for TrigTest::official_bases() -> $base {
        my Complex $z = $angle.complex(0.0, $base);
        is_approx($z.cosech($base), $sz0, "Complex.cosech - $z $base");
    
        $z = $angle.complex(1.0, $base);
        is_approx($z.cosech($base), $sz1, "Complex.cosech - $z $base");
    
        $z = $angle.complex(2.0, $base);
        is_approx($z.cosech($base), $sz2, "Complex.cosech - $z $base");
    }
}

is(cosech(Inf), 0, "cosech(Inf) - default");
is(cosech(-Inf), "-0", "cosech(-Inf) - default");
given $base_list.shift
{
    is(cosech(Inf,  $_), 0, "cosech(Inf) - $_");
    is(cosech(-Inf, $_), "-0", "cosech(-Inf) - $_");
}
        
# Num tests
is_approx((-6.28318530723787).Num.cosech(:base(Radians)), -0.00373489848806797, "Num.cosech(:base(Radians)) - -6.28318530723787");
is_approx(cosech((-3.92699081702367).Num), -0.0394210493494572, "cosech(Num) - -3.92699081702367");
is_approx(cosech((-30).Num, Degrees), -1.8253055746695, "cosech(Num, Degrees) - -30");
is_approx(cosech(:x((0.523598775603156).Num)), 1.8253055746695, "cosech(:x(Num)) - 0.523598775603156");
is_approx(cosech(:x((50).Num), :base(Gradians)), 1.15118387090806, "cosech(:x(Num), :base(Gradians)) - 50");

# Rat tests
is_approx((1.57079632680947).Rat(1e-9).cosech, 0.434537208087792, "Rat.cosech - 1.57079632680947");
is_approx((0.375).Rat(1e-9).cosech(Circles), 0.191278762469516, "Rat.cosech(Circles) - 0.375");
is_approx((3.14159265361894).Rat(1e-9).cosech(:base(Radians)), 0.086589537527514, "Rat.cosech(:base(Radians)) - 3.14159265361894");
is_approx(cosech((3.92699081702367).Rat(1e-9)), 0.0394210493494572, "cosech(Rat) - 3.92699081702367");
is_approx(cosech((270).Rat(1e-9), Degrees), 0.0179680320529917, "cosech(Rat, Degrees) - 270");
is_approx(cosech(:x((5.49778714383314).Rat(1e-9))), 0.00819178720191627, "cosech(:x(Rat)) - 5.49778714383314");
is_approx(cosech(:x((400).Rat(1e-9)), :base(Gradians)), 0.00373489848806797, "cosech(:x(Rat), :base(Gradians)) - 400");

# Complex tests
is_approx((1.08333333333333 + 0.318309886183791i).Complex.cosech(:base(Circles)), -0.000920717929196107 + -0.00201181030212346i, "Complex.cosech(:base(Circles)) - 1.08333333333333 + 0.318309886183791i");
is_approx(cosech((10.2101761241668 + 2i).Complex), -3.06234024500267e-05 + -6.6913355283183e-05i, "cosech(Complex) - 10.2101761241668 + 2i");
is_approx(cosech((12.5663706143592 + 2i).Complex, Radians), -2.90249297856666e-06 + -6.34206286115907e-06i, "cosech(Complex, Radians) - 12.5663706143592 + 2i");
is_approx(cosech(:x((-6.28318530717959 + 2i).Complex)), 0.00155424826436473 + -0.00339611810181237i, "cosech(:x(Complex)) - -6.28318530717959 + 2i");
is_approx(cosech(:x((-225 + 114.591559026165i).Complex), :base(Degrees)), 0.0163838933661525 + -0.0358272658449737i, "cosech(:x(Complex), :base(Degrees)) - -225 + 114.591559026165i");

# Str tests
is_approx((-0.523598775603156).Str.cosech, -1.8253055746695, "Str.cosech - -0.523598775603156");
is_approx((33.3333333333333).Str.cosech(Gradians), 1.8253055746695, "Str.cosech(Gradians) - 33.3333333333333");
is_approx((0.125).Str.cosech(:base(Circles)), 1.15118387090806, "Str.cosech(:base(Circles)) - 0.125");
is_approx(cosech((1.57079632680947).Str), 0.434537208087792, "cosech(Str) - 1.57079632680947");
is_approx(cosech((2.3561944902142).Str, Radians), 0.191278762469516, "cosech(Str, Radians) - 2.3561944902142");
is_approx(cosech(:x((3.14159265361894).Str)), 0.086589537527514, "cosech(:x(Str)) - 3.14159265361894");
is_approx(cosech(:x((225).Str), :base(Degrees)), 0.0394210493494572, "cosech(:x(Str), :base(Degrees)) - 225");

# NotComplex tests
is_approx(NotComplex.new(4.71238898038469 + 2i).cosech, -0.00747534423267824 + -0.0163365616325251i, "NotComplex.cosech - 4.71238898038469 + 2i");
is_approx(NotComplex.new(350 + 127.323954473516i).cosech(Gradians), -0.00340879719539436 + -0.00744860766594804i, "NotComplex.cosech(Gradians) - 350 + 127.323954473516i");
is_approx(NotComplex.new(1 + 0.318309886183791i).cosech(:base(Circles)), -0.00155424826436473 + -0.00339611810181237i, "NotComplex.cosech(:base(Circles)) - 1 + 0.318309886183791i");
is_approx(cosech(NotComplex.new(6.80678408277788 + 2i)), -0.000920717929196107 + -0.00201181030212346i, "cosech(NotComplex) - 6.80678408277788 + 2i");
is_approx(cosech(NotComplex.new(10.2101761241668 + 2i), Radians), -3.06234024500267e-05 + -6.6913355283183e-05i, "cosech(NotComplex, Radians) - 10.2101761241668 + 2i");
is_approx(cosech(:x(NotComplex.new(12.5663706143592 + 2i))), -2.90249297856666e-06 + -6.34206286115907e-06i, "cosech(:x(NotComplex)) - 12.5663706143592 + 2i");
is_approx(cosech(:x(NotComplex.new(-360 + 114.591559026165i)), :base(Degrees)), 0.00155424826436473 + -0.00339611810181237i, "cosech(:x(NotComplex), :base(Degrees)) - -360 + 114.591559026165i");

# DifferentReal tests
is_approx(DifferentReal.new(-3.92699081702367).cosech, -0.0394210493494572, "DifferentReal.cosech - -3.92699081702367");
is_approx(DifferentReal.new(-33.3333333333333).cosech(Gradians), -1.8253055746695, "DifferentReal.cosech(Gradians) - -33.3333333333333");
is_approx(DifferentReal.new(0.0833333333333333).cosech(:base(Circles)), 1.8253055746695, "DifferentReal.cosech(:base(Circles)) - 0.0833333333333333");
is_approx(cosech(DifferentReal.new(0.785398163404734)), 1.15118387090806, "cosech(DifferentReal) - 0.785398163404734");
is_approx(cosech(DifferentReal.new(1.57079632680947), Radians), 0.434537208087792, "cosech(DifferentReal, Radians) - 1.57079632680947");
is_approx(cosech(:x(DifferentReal.new(2.3561944902142))), 0.191278762469516, "cosech(:x(DifferentReal)) - 2.3561944902142");
is_approx(cosech(:x(DifferentReal.new(180)), :base(Degrees)), 0.086589537527514, "cosech(:x(DifferentReal), :base(Degrees)) - 180");

# Int tests
is_approx((225).Int.cosech(:base(Degrees)), 0.0394210493494572, "Int.cosech(:base(Degrees)) - 225");
is_approx(cosech((270).Int, Degrees), 0.0179680320529917, "cosech(Int, Degrees) - 270");
is_approx(cosech(:x((350).Int), :base(Gradians)), 0.00819178720191627, "cosech(:x(Int), :base(Gradians)) - 350");

# acosech tests

for TrigTest::sines() -> $angle
{
    next if abs(sinh($angle.num(Radians))) < 1e-6;
    my $desired-result = 1.0 / sinh($angle.num(Radians));

    # Num.acosech tests -- thorough
    is_approx($desired-result.Num.acosech.cosech, $desired-result, 
              "Num.acosech - {$angle.num(Radians)} default");
    for TrigTest::official_bases() -> $base {
        is_approx($desired-result.Num.acosech($base).cosech($base), $desired-result,
                  "Num.acosech - {$angle.num($base)} $base");
    }
    
    # Num.acosech(Complex) tests -- thorough
    for ($desired-result + 0i, $desired-result + .5i, $desired-result + 2i) -> $z {
        is_approx(cosech(acosech($z)), $z, 
                  "acosech(Complex) - {$angle.num(Radians)} default");
        is_approx($z.acosech.cosech, $z, 
                  "Complex.acosech - {$angle.num(Radians)} default");
        for TrigTest::official_bases() -> $base {
            is_approx($z.acosech($base).cosech($base), $z, 
                      "Complex.acosech - {$angle.num($base)} $base");
        }
    }
}
        
# Num tests
is_approx((1.8253055746695).Num.acosech(:base(Radians)), 0.523598775603156, "Num.acosech(:base(Radians)) - 0.523598775603156");
is_approx(acosech((1.15118387090806).Num), 0.785398163404734, "acosech(Num) - 0.785398163404734");
is_approx(acosech((1.8253055746695).Num, Degrees), 30, "acosech(Num, Degrees) - 30");
is_approx(acosech(:x((1.15118387090806).Num)), 0.785398163404734, "acosech(:x(Num)) - 0.785398163404734");
is_approx(acosech(:x((1.8253055746695).Num), :base(Gradians)), 33.3333333333333, "acosech(:x(Num), :base(Gradians)) - 33.3333333333333");

# Rat tests
is_approx(((1.15118387090806).Rat(1e-9)).acosech, 0.785398163404734, "Rat.acosech - 0.785398163404734");
is_approx((1.8253055746695).Rat(1e-9).acosech(Circles), 0.0833333333333333, "Rat.acosech(Circles) - 0.0833333333333333");
is_approx((1.15118387090806).Rat(1e-9).acosech(:base(Radians)), 0.785398163404734, "Rat.acosech(:base(Radians)) - 0.785398163404734");
is_approx(acosech((1.8253055746695).Rat(1e-9)), 0.523598775603156, "acosech(Rat) - 0.523598775603156");
is_approx(acosech((1.15118387090806).Rat(1e-9), Degrees), 45, "acosech(Rat, Degrees) - 45");
is_approx(acosech(:x((1.8253055746695).Rat(1e-9))), 0.523598775603156, "acosech(:x(Rat)) - 0.523598775603156");
is_approx(acosech(:x((1.15118387090806).Rat(1e-9)), :base(Gradians)), 50, "acosech(:x(Rat), :base(Gradians)) - 50");

# Complex tests
is_approx((0.523598775603156 + 2i).Complex.acosech(:base(Circles)), 0.0219340274537799 + -0.0767068658616915i, "Complex.acosech(:base(Circles)) - 0.0219340274537799 + -0.0767068658616915i");
is_approx(acosech((0.785398163404734 + 2i).Complex), 0.186914543518615 + -0.439776333846415i, "acosech(Complex) - 0.186914543518615 + -0.439776333846415i");
is_approx(acosech((0.523598775603156 + 2i).Complex, Radians), 0.137815559024863 + -0.481963452541975i, "acosech(Complex, Radians) - 0.137815559024863 + -0.481963452541975i");
is_approx(acosech(:x((0.785398163404734 + 2i).Complex)), 0.186914543518615 + -0.439776333846415i, "acosech(:x(Complex)) - 0.186914543518615 + -0.439776333846415i");
is_approx(acosech(:x((0.523598775603156 + 2i).Complex), :base(Degrees)), 7.89624988336075 + -27.6144717102089i, "acosech(:x(Complex), :base(Degrees)) - 7.89624988336075 + -27.6144717102089i");

# Str tests
is_approx(((1.15118387090806).Str).acosech, 0.785398163404734, "Str.acosech - 0.785398163404734");
is_approx((1.8253055746695).Str.acosech(Gradians), 33.3333333333333, "Str.acosech(Gradians) - 33.3333333333333");
is_approx((1.15118387090806).Str.acosech(:base(Circles)), 0.125, "Str.acosech(:base(Circles)) - 0.125");
is_approx(acosech((1.8253055746695).Str), 0.523598775603156, "acosech(Str) - 0.523598775603156");
is_approx(acosech((1.15118387090806).Str, Radians), 0.785398163404734, "acosech(Str, Radians) - 0.785398163404734");
is_approx(acosech(:x((1.8253055746695).Str)), 0.523598775603156, "acosech(:x(Str)) - 0.523598775603156");
is_approx(acosech(:x((1.15118387090806).Str), :base(Degrees)), 45, "acosech(:x(Str), :base(Degrees)) - 45");

# NotComplex tests
is_approx((NotComplex.new(0.523598775603156 + 2i)).acosech, 0.137815559024863 + -0.481963452541975i, "NotComplex.acosech - 0.137815559024863 + -0.481963452541975i");
is_approx(NotComplex.new(0.785398163404734 + 2i).acosech(Gradians), 11.8993494147011 + -27.9970309545954i, "NotComplex.acosech(Gradians) - 11.8993494147011 + -27.9970309545954i");
is_approx(NotComplex.new(0.523598775603156 + 2i).acosech(:base(Circles)), 0.0219340274537799 + -0.0767068658616915i, "NotComplex.acosech(:base(Circles)) - 0.0219340274537799 + -0.0767068658616915i");
is_approx(acosech(NotComplex.new(0.785398163404734 + 2i)), 0.186914543518615 + -0.439776333846415i, "acosech(NotComplex) - 0.186914543518615 + -0.439776333846415i");
is_approx(acosech(NotComplex.new(0.523598775603156 + 2i), Radians), 0.137815559024863 + -0.481963452541975i, "acosech(NotComplex, Radians) - 0.137815559024863 + -0.481963452541975i");
is_approx(acosech(:x(NotComplex.new(0.785398163404734 + 2i))), 0.186914543518615 + -0.439776333846415i, "acosech(:x(NotComplex)) - 0.186914543518615 + -0.439776333846415i");
is_approx(acosech(:x(NotComplex.new(0.523598775603156 + 2i)), :base(Degrees)), 7.89624988336075 + -27.6144717102089i, "acosech(:x(NotComplex), :base(Degrees)) - 7.89624988336075 + -27.6144717102089i");

# DifferentReal tests
is_approx((DifferentReal.new(1.15118387090806)).acosech, 0.785398163404734, "DifferentReal.acosech - 0.785398163404734");
is_approx(DifferentReal.new(1.8253055746695).acosech(Gradians), 33.3333333333333, "DifferentReal.acosech(Gradians) - 33.3333333333333");
is_approx(DifferentReal.new(1.15118387090806).acosech(:base(Circles)), 0.125, "DifferentReal.acosech(:base(Circles)) - 0.125");
is_approx(acosech(DifferentReal.new(1.8253055746695)), 0.523598775603156, "acosech(DifferentReal) - 0.523598775603156");
is_approx(acosech(DifferentReal.new(1.15118387090806), Radians), 0.785398163404734, "acosech(DifferentReal, Radians) - 0.785398163404734");
is_approx(acosech(:x(DifferentReal.new(1.8253055746695))), 0.523598775603156, "acosech(:x(DifferentReal)) - 0.523598775603156");
is_approx(acosech(:x(DifferentReal.new(1.15118387090806)), :base(Degrees)), 45, "acosech(:x(DifferentReal), :base(Degrees)) - 45");

done_testing;

# vim: ft=perl6 nomodifiable
