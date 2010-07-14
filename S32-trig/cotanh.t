# WARNING:
# This is a generated file and should not be edited directly.
# look into generate-tests.pl instead

use v6;
use Test;
BEGIN { @*INC.push("t/spec/packages/") };
use TrigTestSupport;


# cotanh tests

my $base_list = (TrigTest::official_bases() xx *).flat;
my $iter_count = 0;
for TrigTest::sines() -> $angle
{
    next if abs(sinh($angle.num(Radians))) < 1e-6;
    my $desired-result = cosh($angle.num(Radians)) / sinh($angle.num(Radians));

    # Num.cotanh tests -- very thorough
    is_approx($angle.num(Radians).cotanh, $desired-result, 
              "Num.cotanh - {$angle.num(Radians)} default");
    for TrigTest::official_bases() -> $base {
        is_approx($angle.num($base).cotanh($base), $desired-result, 
                  "Num.cotanh - {$angle.num($base)} $base");
    }

    # Complex.cotanh tests -- also very thorough
    my Complex $zp0 = $angle.complex(0.0, Radians);
    my Complex $sz0 = $desired-result + 0i;
    my Complex $zp1 = $angle.complex(1.0, Radians);
    my Complex $sz1 = { cosh($_) / sinh ($_) }($zp1);
    my Complex $zp2 = $angle.complex(2.0, Radians);
    my Complex $sz2 = { cosh($_) / sinh ($_) }($zp2);
    
    is_approx($zp0.cotanh, $sz0, "Complex.cotanh - $zp0 default");
    is_approx($zp1.cotanh, $sz1, "Complex.cotanh - $zp1 default");
    is_approx($zp2.cotanh, $sz2, "Complex.cotanh - $zp2 default");
    
    for TrigTest::official_bases() -> $base {
        my Complex $z = $angle.complex(0.0, $base);
        is_approx($z.cotanh($base), $sz0, "Complex.cotanh - $z $base");
    
        $z = $angle.complex(1.0, $base);
        is_approx($z.cotanh($base), $sz1, "Complex.cotanh - $z $base");
    
        $z = $angle.complex(2.0, $base);
        is_approx($z.cotanh($base), $sz2, "Complex.cotanh - $z $base");
    }
}

is(cotanh(Inf), 1, "cotanh(Inf) - default");
is(cotanh(-Inf), -1, "cotanh(-Inf) - default");
given $base_list.shift
{
    is(cotanh(Inf,  $_), 1, "cotanh(Inf) - $_");
    is(cotanh(-Inf, $_), -1, "cotanh(-Inf) - $_");
}
        
# Num tests
is_approx((-6.28318530723787).Num.cotanh(:base(Radians)), -1.00000697470903, "Num.cotanh(:base(Radians)) - -6.28318530723787");
is_approx(cotanh((-3.92699081702367).Num), -1.0007767079283, "cotanh(Num) - -3.92699081702367");
is_approx(cotanh((-30).Num, Degrees), -2.08128336391745, "cotanh(Num, Degrees) - -30");
is_approx(cotanh(:x((0.523598775603156).Num)), 2.08128336391745, "cotanh(:x(Num)) - 0.523598775603156");
is_approx(cotanh(:x((50).Num), :base(Gradians)), 1.52486861881241, "cotanh(:x(Num), :base(Gradians)) - 50");

# Rat tests
is_approx((1.57079632680947).Rat(1e-9).cotanh, 1.09033141072462, "Rat.cotanh - 1.57079632680947");
is_approx((0.375).Rat(1e-9).cotanh(Circles), 1.01812944411399, "Rat.cotanh(Circles) - 0.375");
is_approx((3.14159265361894).Rat(1e-9).cotanh(:base(Radians)), 1.0037418731971, "Rat.cotanh(:base(Radians)) - 3.14159265361894");
is_approx(cotanh((3.92699081702367).Rat(1e-9)), 1.0007767079283, "cotanh(Rat) - 3.92699081702367");
is_approx(cotanh((270).Rat(1e-9), Degrees), 1.000161412061, "cotanh(Rat, Degrees) - 270");
is_approx(cotanh(:x((5.49778714383314).Rat(1e-9))), 1.00003355212591, "cotanh(:x(Rat)) - 5.49778714383314");
is_approx(cotanh(:x((400).Rat(1e-9)), :base(Gradians)), 1.00000697470903, "cotanh(:x(Rat), :base(Gradians)) - 400");

# Complex tests
is_approx((1.08333333333333 + 0.318309886183791i).Complex.cotanh(:base(Circles)), 0.999998400170843 + 1.85231277868836e-06i, "Complex.cotanh(:base(Circles)) - 1.08333333333333 + 0.318309886183791i");
is_approx(cotanh((10.2101761241668 + 2i).Complex), 0.999999998230198 + 2.04911454184587e-09i, "cotanh(Complex) - 10.2101761241668 + 2i");
is_approx(cotanh((12.5663706143592 + 2i).Complex, Radians), 0.999999999984101 + 1.84077712748377e-11i, "cotanh(Complex, Radians) - 12.5663706143592 + 2i");
is_approx(cotanh(:x((-6.28318530717959 + 2i).Complex)), -0.999995441038292 + 5.278434729546e-06i, "cotanh(:x(Complex)) - -6.28318530717959 + 2i");
is_approx(cotanh(:x((-225 + 114.591559026165i).Complex), :base(Degrees)), -0.999492463148825 + 0.000587288173595236i, "cotanh(:x(Complex), :base(Degrees)) - -225 + 114.591559026165i");

# Str tests
is_approx((-0.523598775603156).Str.cotanh, -2.08128336391745, "Str.cotanh - -0.523598775603156");
is_approx((33.3333333333333).Str.cotanh(Gradians), 2.08128336391745, "Str.cotanh(Gradians) - 33.3333333333333");
is_approx((0.125).Str.cotanh(:base(Circles)), 1.52486861881241, "Str.cotanh(:base(Circles)) - 0.125");
is_approx(cotanh((1.57079632680947).Str), 1.09033141072462, "cotanh(Str) - 1.57079632680947");
is_approx(cotanh((2.3561944902142).Str, Radians), 1.01812944411399, "cotanh(Str, Radians) - 2.3561944902142");
is_approx(cotanh(:x((3.14159265361894).Str)), 1.0037418731971, "cotanh(:x(Str)) - 3.14159265361894");
is_approx(cotanh(:x((225).Str), :base(Degrees)), 1.0007767079283, "cotanh(:x(Str), :base(Degrees)) - 225");

# NotComplex tests
is_approx(NotComplex.new(4.71238898038469 + 2i).cotanh, 0.99989450065605 + 0.000122134306870744i, "NotComplex.cotanh - 4.71238898038469 + 2i");
is_approx(NotComplex.new(350 + 127.323954473516i).cotanh(Gradians), 0.999978069152959 + 2.53913497751775e-05i, "NotComplex.cotanh(Gradians) - 350 + 127.323954473516i");
is_approx(NotComplex.new(1 + 0.318309886183791i).cotanh(:base(Circles)), 0.999995441038292 + 5.278434729546e-06i, "NotComplex.cotanh(:base(Circles)) - 1 + 0.318309886183791i");
is_approx(cotanh(NotComplex.new(6.80678408277788 + 2i)), 0.999998400170843 + 1.85231277868836e-06i, "cotanh(NotComplex) - 6.80678408277788 + 2i");
is_approx(cotanh(NotComplex.new(10.2101761241668 + 2i), Radians), 0.999999998230198 + 2.04911454184587e-09i, "cotanh(NotComplex, Radians) - 10.2101761241668 + 2i");
is_approx(cotanh(:x(NotComplex.new(12.5663706143592 + 2i))), 0.999999999984101 + 1.84077712748377e-11i, "cotanh(:x(NotComplex)) - 12.5663706143592 + 2i");
is_approx(cotanh(:x(NotComplex.new(-360 + 114.591559026165i)), :base(Degrees)), -0.999995441038292 + 5.278434729546e-06i, "cotanh(:x(NotComplex), :base(Degrees)) - -360 + 114.591559026165i");

# DifferentReal tests
is_approx(DifferentReal.new(-3.92699081702367).cotanh, -1.0007767079283, "DifferentReal.cotanh - -3.92699081702367");
is_approx(DifferentReal.new(-33.3333333333333).cotanh(Gradians), -2.08128336391745, "DifferentReal.cotanh(Gradians) - -33.3333333333333");
is_approx(DifferentReal.new(0.0833333333333333).cotanh(:base(Circles)), 2.08128336391745, "DifferentReal.cotanh(:base(Circles)) - 0.0833333333333333");
is_approx(cotanh(DifferentReal.new(0.785398163404734)), 1.52486861881241, "cotanh(DifferentReal) - 0.785398163404734");
is_approx(cotanh(DifferentReal.new(1.57079632680947), Radians), 1.09033141072462, "cotanh(DifferentReal, Radians) - 1.57079632680947");
is_approx(cotanh(:x(DifferentReal.new(2.3561944902142))), 1.01812944411399, "cotanh(:x(DifferentReal)) - 2.3561944902142");
is_approx(cotanh(:x(DifferentReal.new(180)), :base(Degrees)), 1.0037418731971, "cotanh(:x(DifferentReal), :base(Degrees)) - 180");

# Int tests
is_approx((225).Int.cotanh(:base(Degrees)), 1.0007767079283, "Int.cotanh(:base(Degrees)) - 225");
is_approx(cotanh((270).Int, Degrees), 1.000161412061, "cotanh(Int, Degrees) - 270");
is_approx(cotanh(:x((350).Int), :base(Gradians)), 1.00003355212591, "cotanh(:x(Int), :base(Gradians)) - 350");

# acotanh tests

for TrigTest::sines() -> $angle
{
    next if abs(sinh($angle.num(Radians))) < 1e-6;
    my $desired-result = cosh($angle.num(Radians)) / sinh($angle.num(Radians));

    # Num.acotanh tests -- thorough
    is_approx($desired-result.Num.acotanh.cotanh, $desired-result, 
              "Num.acotanh - {$angle.num(Radians)} default");
    for TrigTest::official_bases() -> $base {
        is_approx($desired-result.Num.acotanh($base).cotanh($base), $desired-result,
                  "Num.acotanh - {$angle.num($base)} $base");
    }
    
    # Num.acotanh(Complex) tests -- thorough
    for ($desired-result + 0i, $desired-result + .5i, $desired-result + 2i) -> $z {
        is_approx(cotanh(acotanh($z)), $z, 
                  "acotanh(Complex) - {$angle.num(Radians)} default");
        is_approx($z.acotanh.cotanh, $z, 
                  "Complex.acotanh - {$angle.num(Radians)} default");
        for TrigTest::official_bases() -> $base {
            is_approx($z.acotanh($base).cotanh($base), $z, 
                      "Complex.acotanh - {$angle.num($base)} $base");
        }
    }
}
        
# Num tests
is_approx((2.08128336391745).Num.acotanh(:base(Radians)), 0.523598775603156, "Num.acotanh(:base(Radians)) - 0.523598775603156");
is_approx(acotanh((1.52486861881241).Num), 0.785398163404734, "acotanh(Num) - 0.785398163404734");
is_approx(acotanh((2.08128336391745).Num, Degrees), 30, "acotanh(Num, Degrees) - 30");
is_approx(acotanh(:x((1.52486861881241).Num)), 0.785398163404734, "acotanh(:x(Num)) - 0.785398163404734");
is_approx(acotanh(:x((2.08128336391745).Num), :base(Gradians)), 33.3333333333333, "acotanh(:x(Num), :base(Gradians)) - 33.3333333333333");

# Rat tests
is_approx(((1.52486861881241).Rat(1e-9)).acotanh, 0.785398163404734, "Rat.acotanh - 0.785398163404734");
is_approx((2.08128336391745).Rat(1e-9).acotanh(Circles), 0.0833333333333333, "Rat.acotanh(Circles) - 0.0833333333333333");
is_approx((1.52486861881241).Rat(1e-9).acotanh(:base(Radians)), 0.785398163404734, "Rat.acotanh(:base(Radians)) - 0.785398163404734");
is_approx(acotanh((2.08128336391745).Rat(1e-9)), 0.523598775603156, "acotanh(Rat) - 0.523598775603156");
is_approx(acotanh((1.52486861881241).Rat(1e-9), Degrees), 45, "acotanh(Rat, Degrees) - 45");
is_approx(acotanh(:x((2.08128336391745).Rat(1e-9))), 0.523598775603156, "acotanh(:x(Rat)) - 0.523598775603156");
is_approx(acotanh(:x((1.52486861881241).Rat(1e-9)), :base(Gradians)), 50, "acotanh(:x(Rat), :base(Gradians)) - 50");

# Complex tests
is_approx((0.523598775603156 + 2i).Complex.acotanh(:base(Circles)), 0.0160130041020726 + -0.0704143601426119i, "Complex.acotanh(:base(Circles)) - 0.0160130041020726 + -0.0704143601426119i");
is_approx(acotanh((0.785398163404734 + 2i).Complex), 0.143655432578432 + -0.417829353993379i, "acotanh(Complex) - 0.143655432578432 + -0.417829353993379i");
is_approx(acotanh((0.523598775603156 + 2i).Complex, Radians), 0.100612672097949 + -0.442426473062511i, "acotanh(Complex, Radians) - 0.100612672097949 + -0.442426473062511i");
is_approx(acotanh(:x((0.785398163404734 + 2i).Complex)), 0.143655432578432 + -0.417829353993379i, "acotanh(:x(Complex)) - 0.143655432578432 + -0.417829353993379i");
is_approx(acotanh(:x((0.523598775603156 + 2i).Complex), :base(Degrees)), 5.76468147674613 + -25.3491696513403i, "acotanh(:x(Complex), :base(Degrees)) - 5.76468147674613 + -25.3491696513403i");

# Str tests
is_approx(((1.52486861881241).Str).acotanh, 0.785398163404734, "Str.acotanh - 0.785398163404734");
is_approx((2.08128336391745).Str.acotanh(Gradians), 33.3333333333333, "Str.acotanh(Gradians) - 33.3333333333333");
is_approx((1.52486861881241).Str.acotanh(:base(Circles)), 0.125, "Str.acotanh(:base(Circles)) - 0.125");
is_approx(acotanh((2.08128336391745).Str), 0.523598775603156, "acotanh(Str) - 0.523598775603156");
is_approx(acotanh((1.52486861881241).Str, Radians), 0.785398163404734, "acotanh(Str, Radians) - 0.785398163404734");
is_approx(acotanh(:x((2.08128336391745).Str)), 0.523598775603156, "acotanh(:x(Str)) - 0.523598775603156");
is_approx(acotanh(:x((1.52486861881241).Str), :base(Degrees)), 45, "acotanh(:x(Str), :base(Degrees)) - 45");

# NotComplex tests
is_approx((NotComplex.new(0.523598775603156 + 2i)).acotanh, 0.100612672097949 + -0.442426473062511i, "NotComplex.acotanh - 0.100612672097949 + -0.442426473062511i");
is_approx(NotComplex.new(0.785398163404734 + 2i).acotanh(Gradians), 9.14538887874479 + -26.5998428227758i, "NotComplex.acotanh(Gradians) - 9.14538887874479 + -26.5998428227758i");
is_approx(NotComplex.new(0.523598775603156 + 2i).acotanh(:base(Circles)), 0.0160130041020726 + -0.0704143601426119i, "NotComplex.acotanh(:base(Circles)) - 0.0160130041020726 + -0.0704143601426119i");
is_approx(acotanh(NotComplex.new(0.785398163404734 + 2i)), 0.143655432578432 + -0.417829353993379i, "acotanh(NotComplex) - 0.143655432578432 + -0.417829353993379i");
is_approx(acotanh(NotComplex.new(0.523598775603156 + 2i), Radians), 0.100612672097949 + -0.442426473062511i, "acotanh(NotComplex, Radians) - 0.100612672097949 + -0.442426473062511i");
is_approx(acotanh(:x(NotComplex.new(0.785398163404734 + 2i))), 0.143655432578432 + -0.417829353993379i, "acotanh(:x(NotComplex)) - 0.143655432578432 + -0.417829353993379i");
is_approx(acotanh(:x(NotComplex.new(0.523598775603156 + 2i)), :base(Degrees)), 5.76468147674613 + -25.3491696513403i, "acotanh(:x(NotComplex), :base(Degrees)) - 5.76468147674613 + -25.3491696513403i");

# DifferentReal tests
is_approx((DifferentReal.new(1.52486861881241)).acotanh, 0.785398163404734, "DifferentReal.acotanh - 0.785398163404734");
is_approx(DifferentReal.new(2.08128336391745).acotanh(Gradians), 33.3333333333333, "DifferentReal.acotanh(Gradians) - 33.3333333333333");
is_approx(DifferentReal.new(1.52486861881241).acotanh(:base(Circles)), 0.125, "DifferentReal.acotanh(:base(Circles)) - 0.125");
is_approx(acotanh(DifferentReal.new(2.08128336391745)), 0.523598775603156, "acotanh(DifferentReal) - 0.523598775603156");
is_approx(acotanh(DifferentReal.new(1.52486861881241), Radians), 0.785398163404734, "acotanh(DifferentReal, Radians) - 0.785398163404734");
is_approx(acotanh(:x(DifferentReal.new(2.08128336391745))), 0.523598775603156, "acotanh(:x(DifferentReal)) - 0.523598775603156");
is_approx(acotanh(:x(DifferentReal.new(1.52486861881241)), :base(Degrees)), 45, "acotanh(:x(DifferentReal), :base(Degrees)) - 45");

done_testing;

# vim: ft=perl6 nomodifiable
