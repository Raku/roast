# WARNING:
# This is a generated file and should not be edited directly.
# look into generate-tests.pl instead

use v6;
use Test;
BEGIN { @*INC.push("t/spec/packages/") };
use TrigTestSupport;


# atan2 tests

# First, test atan2 with x = 1

for TrigTest::sines() -> $angle
{
    next if abs(cos($angle.num(Radians))) < 1e-6;     
	my $desired-result = sin($angle.num(Radians)) / cos($angle.num(Radians));

    # Num.atan2 tests
    is_approx($desired-result.Num.atan2.tan, $desired-result, 
              "Num.atan2() - {$angle.num(Radians)} default");
    is_approx($desired-result.Num.atan2(1.Num).tan, $desired-result, 
              "Num.atan2(1.Num) - {$angle.num(Radians)} default");
    for TrigTest::official_bases() -> $base {
        is_approx($desired-result.Num.atan2(:base($base)).tan($base), $desired-result, 
                  "Num.atan2() - {$angle.num($base)} $base");
        is_approx($desired-result.Num.atan2(1.Num, $base).tan($base), $desired-result, 
                  "Num.atan2(1.Num) - {$angle.num($base)} $base");
    }
}

# check that the proper quadrant is returned

is_approx(atan2(4, 4, Degrees), 45, "atan2(4, 4) is 45 degrees");
is_approx(atan2(-4, 4, Degrees), -45, "atan2(-4, 4) is -45 degrees");
is_approx(atan2(4, -4, Degrees), 135, "atan2(4, -4) is 135 degrees");
is_approx(atan2(-4, -4, Degrees), -135, "atan2(-4, -4) is -135 degrees");

# Num tests
is_approx((0.1).Num.atan2(:base(Radians)), 0.099668652491162, "Num.atan2(:base(Radians))");
is_approx(atan2((0.1).Num), 0.099668652491162, "atan2(Num)");
#?rakudo todo 'Cannot tell difference between TrigBase and Int'
is_approx(atan2((10).Num, Degrees), 84.2894068625004, "atan2(Num, Degrees)");
is_approx(atan2(:y((0.1).Num)), 0.099668652491162, "atan2(:y(Num))");
is_approx(atan2(:y((-1).Num), :base(Gradians)), -50, "atan2(:y(Num), :base(Gradians))");

# Num vs Num tests
is_approx((-10).Num.atan2((10).Num), -0.785398163397448, "Num.atan2(Num)");
is_approx((0.1).Num.atan2((100).Num, Circles), 0.000159154890040279, "Num.atan2(Num, Circles)");
is_approx((-0.1).Num.atan2((0.1).Num, :base(Radians)), -0.785398163397448, "Num.atan2(Num, :base(Radians))");
is_approx(atan2((-10).Num, (-100).Num), -3.04192400109863, "atan2(Num, Num)");
is_approx(atan2((100).Num, (-1).Num, Degrees), 90.5729386976835, "atan2(Num, Num, Degrees)");
is_approx(atan2(:y((-100).Num), :x((10).Num)), -1.47112767430373, "atan2(:y(Num), :x(Num))");
is_approx(atan2(:y((0.1).Num), :x((-1).Num), :base(Gradians)), 193.654896513889, "atan2(:y(Num), :x(Num), :base(Gradians))");

# Num vs Rat tests
is_approx((10).Num.atan2((-10).Rat(1e-9)), 2.35619449019234, "Num.atan2(Rat)");
is_approx((-100).Num.atan2((-10).Rat(1e-9), Circles), -0.265862758715277, "Num.atan2(Rat, Circles)");
is_approx((-1).Num.atan2((1).Rat(1e-9), :base(Radians)), -0.785398163397448, "Num.atan2(Rat, :base(Radians))");
is_approx(atan2((10).Num, (-1).Rat(1e-9)), 1.67046497928606, "atan2(Num, Rat)");
is_approx(atan2((-1).Num, (-0.1).Rat(1e-9), Degrees), -95.7105931374996, "atan2(Num, Rat, Degrees)");
is_approx(atan2(:y((-0.1).Num), :x((-1).Rat(1e-9))), -3.04192400109863, "atan2(:y(Num), :x(Rat))");
is_approx(atan2(:y((-10).Num), :x((0.1).Rat(1e-9)), :base(Gradians)), -99.3634014470183, "atan2(:y(Num), :x(Rat), :base(Gradians))");

# Num vs Int tests
is_approx((-10).Num.atan2((1).Int), -1.47112767430373, "Num.atan2(Int)");
is_approx((0.1).Num.atan2((10).Int, Circles), 0.00159149638245413, "Num.atan2(Int, Circles)");
is_approx((10).Num.atan2((-100).Int, :base(Radians)), 3.04192400109863, "Num.atan2(Int, :base(Radians))");
is_approx(atan2((-1).Num, (-10).Int), -3.04192400109863, "atan2(Num, Int)");
is_approx(atan2((100).Num, (-100).Int, Degrees), 135, "atan2(Num, Int, Degrees)");
is_approx(atan2(:y((-100).Num), :x((1).Int)), -1.56079666010823, "atan2(:y(Num), :x(Int))");
is_approx(atan2(:y((-100).Num), :x((100).Int), :base(Gradians)), -50, "atan2(:y(Num), :x(Int), :base(Gradians))");

# Num vs Str tests
is_approx((1).Num.atan2((0.1).Str), 1.47112767430373, "Num.atan2(Str)");
is_approx((-1).Num.atan2((-0.1).Str, Circles), -0.265862758715277, "Num.atan2(Str, Circles)");
is_approx((100).Num.atan2((-0.1).Str, :base(Radians)), 1.57179632646156, "Num.atan2(Str, :base(Radians))");
is_approx(atan2((-10).Num, (100).Str), -0.099668652491162, "atan2(Num, Str)");
is_approx(atan2((-10).Num, (-100).Str, Degrees), -174.2894068625, "atan2(Num, Str, Degrees)");
is_approx(atan2(:y((-10).Num), :x((0.1).Str)), -1.56079666010823, "atan2(:y(Num), :x(Str))");
is_approx(atan2(:y((100).Num), :x((-10).Str), :base(Gradians)), 106.345103486111, "atan2(:y(Num), :x(Str), :base(Gradians))");

# Num vs DifferentReal tests
is_approx((1).Num.atan2(DifferentReal.new(-100)), 3.13159298690313, "Num.atan2(DifferentReal)");
is_approx((-100).Num.atan2(DifferentReal.new(0.1), Circles), -0.24984084510996, "Num.atan2(DifferentReal, Circles)");
is_approx((-0.1).Num.atan2(DifferentReal.new(-1), :base(Radians)), -3.04192400109863, "Num.atan2(DifferentReal, :base(Radians))");
is_approx(atan2((-1).Num, DifferentReal.new(-10)), -3.04192400109863, "atan2(Num, DifferentReal)");
is_approx(atan2((1).Num, DifferentReal.new(-100), Degrees), 179.427061302317, "atan2(Num, DifferentReal, Degrees)");
is_approx(atan2(:y((-10).Num), :x(DifferentReal.new(10))), -0.785398163397448, "atan2(:y(Num), :x(DifferentReal))");
is_approx(atan2(:y((1).Num), :x(DifferentReal.new(-1)), :base(Gradians)), 150, "atan2(:y(Num), :x(DifferentReal), :base(Gradians))");

# Rat tests
is_approx((-0.1).Rat(1e-9).atan2, -0.099668652491162, "Rat.atan2");
#?rakudo todo 'Cannot tell difference between TrigBase and Int'
is_approx((-1).Rat(1e-9).atan2(Circles), -0.125, "Rat.atan2(Circles)");
is_approx((1).Rat(1e-9).atan2(:base(Radians)), 0.785398163397448, "Rat.atan2(:base(Radians))");
is_approx(atan2((100).Rat(1e-9)), 1.56079666010823, "atan2(Rat)");
#?rakudo todo 'Cannot tell difference between TrigBase and Int'
is_approx(atan2((-1).Rat(1e-9), Degrees), -45, "atan2(Rat, Degrees)");
is_approx(atan2(:y((10).Rat(1e-9))), 1.47112767430373, "atan2(:y(Rat))");
is_approx(atan2(:y((100).Rat(1e-9)), :base(Gradians)), 99.3634014470183, "atan2(:y(Rat), :base(Gradians))");

# Rat vs Num tests
is_approx((0.1).Rat(1e-9).atan2((0.1).Num), 0.785398163397448, "Rat.atan2(Num)");
is_approx((1).Rat(1e-9).atan2((-10).Num, Circles), 0.484137241284723, "Rat.atan2(Num, Circles)");
is_approx((100).Rat(1e-9).atan2((-100).Num, :base(Radians)), 2.35619449019234, "Rat.atan2(Num, :base(Radians))");
is_approx(atan2((10).Rat(1e-9), (0.1).Num), 1.56079666010823, "atan2(Rat, Num)");
is_approx(atan2((100).Rat(1e-9), (10).Num, Degrees), 84.2894068625004, "atan2(Rat, Num, Degrees)");
is_approx(atan2(:y((10).Rat(1e-9)), :x((0.1).Num)), 1.56079666010823, "atan2(:y(Rat), :x(Num))");
is_approx(atan2(:y((1).Rat(1e-9)), :x((-0.1).Num), :base(Gradians)), 106.345103486111, "atan2(:y(Rat), :x(Num), :base(Gradians))");

# Rat vs Rat tests
is_approx((-0.1).Rat(1e-9).atan2((10).Rat(1e-9)), -0.00999966668666524, "Rat.atan2(Rat)");
is_approx((-0.1).Rat(1e-9).atan2((0.1).Rat(1e-9), Circles), -0.125, "Rat.atan2(Rat, Circles)");
is_approx((-1).Rat(1e-9).atan2((10).Rat(1e-9), :base(Radians)), -0.099668652491162, "Rat.atan2(Rat, :base(Radians))");
is_approx(atan2((-1).Rat(1e-9), (-0.1).Rat(1e-9)), -1.67046497928606, "atan2(Rat, Rat)");
is_approx(atan2((1).Rat(1e-9), (-10).Rat(1e-9), Degrees), 174.2894068625, "atan2(Rat, Rat, Degrees)");
is_approx(atan2(:y((0.1).Rat(1e-9)), :x((-100).Rat(1e-9))), 3.14059265392313, "atan2(:y(Rat), :x(Rat))");
is_approx(atan2(:y((10).Rat(1e-9)), :x((0.1).Rat(1e-9)), :base(Gradians)), 99.3634014470183, "atan2(:y(Rat), :x(Rat), :base(Gradians))");

# Rat vs Int tests
is_approx((-10).Rat(1e-9).atan2((100).Int), -0.099668652491162, "Rat.atan2(Int)");
is_approx((1).Rat(1e-9).atan2((10).Int, Circles), 0.0158627587152768, "Rat.atan2(Int, Circles)");
is_approx((-10).Rat(1e-9).atan2((-10).Int, :base(Radians)), -2.35619449019234, "Rat.atan2(Int, :base(Radians))");
is_approx(atan2((-0.1).Rat(1e-9), (-10).Int), -3.13159298690313, "atan2(Rat, Int)");
is_approx(atan2((1).Rat(1e-9), (-10).Int, Degrees), 174.2894068625, "atan2(Rat, Int, Degrees)");
is_approx(atan2(:y((10).Rat(1e-9)), :x((-100).Int)), 3.04192400109863, "atan2(:y(Rat), :x(Int))");
is_approx(atan2(:y((100).Rat(1e-9)), :x((-100).Int), :base(Gradians)), 150, "atan2(:y(Rat), :x(Int), :base(Gradians))");

# Rat vs Str tests
is_approx((0.1).Rat(1e-9).atan2((1).Str), 0.099668652491162, "Rat.atan2(Str)");
is_approx((-100).Rat(1e-9).atan2((-100).Str, Circles), -0.375, "Rat.atan2(Str, Circles)");
is_approx((-100).Rat(1e-9).atan2((1).Str, :base(Radians)), -1.56079666010823, "Rat.atan2(Str, :base(Radians))");
is_approx(atan2((1).Rat(1e-9), (-100).Str), 3.13159298690313, "atan2(Rat, Str)");
is_approx(atan2((100).Rat(1e-9), (-100).Str, Degrees), 135, "atan2(Rat, Str, Degrees)");
is_approx(atan2(:y((1).Rat(1e-9)), :x((100).Str)), 0.00999966668666524, "atan2(:y(Rat), :x(Str))");
is_approx(atan2(:y((-10).Rat(1e-9)), :x((100).Str), :base(Gradians)), -6.34510348611071, "atan2(:y(Rat), :x(Str), :base(Gradians))");

# Rat vs DifferentReal tests
is_approx((-100).Rat(1e-9).atan2(DifferentReal.new(100)), -0.785398163397448, "Rat.atan2(DifferentReal)");
is_approx((-1).Rat(1e-9).atan2(DifferentReal.new(10), Circles), -0.0158627587152768, "Rat.atan2(DifferentReal, Circles)");
is_approx((-10).Rat(1e-9).atan2(DifferentReal.new(1), :base(Radians)), -1.47112767430373, "Rat.atan2(DifferentReal, :base(Radians))");
is_approx(atan2((0.1).Rat(1e-9), DifferentReal.new(100)), 0.000999999666666867, "atan2(Rat, DifferentReal)");
is_approx(atan2((-100).Rat(1e-9), DifferentReal.new(-1), Degrees), -90.5729386976835, "atan2(Rat, DifferentReal, Degrees)");
is_approx(atan2(:y((-1).Rat(1e-9)), :x(DifferentReal.new(-10))), -3.04192400109863, "atan2(:y(Rat), :x(DifferentReal))");
is_approx(atan2(:y((1).Rat(1e-9)), :x(DifferentReal.new(-0.1)), :base(Gradians)), 106.345103486111, "atan2(:y(Rat), :x(DifferentReal), :base(Gradians))");

# Int tests
is_approx((100).Int.atan2, 1.56079666010823, "Int.atan2");
#?rakudo todo 'Cannot tell difference between TrigBase and Int'
is_approx((10).Int.atan2(Circles), 0.234137241284723, "Int.atan2(Circles)");
is_approx((-1).Int.atan2(:base(Radians)), -0.785398163397448, "Int.atan2(:base(Radians))");
is_approx(atan2((-100).Int), -1.56079666010823, "atan2(Int)");
#?rakudo todo 'Cannot tell difference between TrigBase and Int'
is_approx(atan2((-10).Int, Degrees), -84.2894068625004, "atan2(Int, Degrees)");
is_approx(atan2(:y((-10).Int)), -1.47112767430373, "atan2(:y(Int))");
is_approx(atan2(:y((10).Int), :base(Gradians)), 93.6548965138893, "atan2(:y(Int), :base(Gradians))");

# Int vs Num tests
is_approx((10).Int.atan2((10).Num), 0.785398163397448, "Int.atan2(Num)");
is_approx((-100).Int.atan2((-10).Num, Circles), -0.265862758715277, "Int.atan2(Num, Circles)");
is_approx((-1).Int.atan2((10).Num, :base(Radians)), -0.099668652491162, "Int.atan2(Num, :base(Radians))");
is_approx(atan2((-10).Int, (0.1).Num), -1.56079666010823, "atan2(Int, Num)");
is_approx(atan2((1).Int, (-10).Num, Degrees), 174.2894068625, "atan2(Int, Num, Degrees)");
is_approx(atan2(:y((1).Int), :x((0.1).Num)), 1.47112767430373, "atan2(:y(Int), :x(Num))");
is_approx(atan2(:y((1).Int), :x((10).Num), :base(Gradians)), 6.34510348611071, "atan2(:y(Int), :x(Num), :base(Gradians))");

# Int vs Rat tests
is_approx((100).Int.atan2((100).Rat(1e-9)), 0.785398163397448, "Int.atan2(Rat)");
is_approx((-1).Int.atan2((100).Rat(1e-9), Circles), -0.00159149638245413, "Int.atan2(Rat, Circles)");
is_approx((10).Int.atan2((0.1).Rat(1e-9), :base(Radians)), 1.56079666010823, "Int.atan2(Rat, :base(Radians))");
is_approx(atan2((-100).Int, (0.1).Rat(1e-9)), -1.56979632712823, "atan2(Int, Rat)");
is_approx(atan2((100).Int, (100).Rat(1e-9), Degrees), 45, "atan2(Int, Rat, Degrees)");
is_approx(atan2(:y((10).Int), :x((1).Rat(1e-9))), 1.47112767430373, "atan2(:y(Int), :x(Rat))");
is_approx(atan2(:y((-1).Int), :x((-10).Rat(1e-9)), :base(Gradians)), -193.654896513889, "atan2(:y(Int), :x(Rat), :base(Gradians))");

# Int vs Int tests
is_approx((1).Int.atan2((10).Int), 0.099668652491162, "Int.atan2(Int)");
is_approx((1).Int.atan2((-1).Int, Circles), 0.375, "Int.atan2(Int, Circles)");
is_approx((100).Int.atan2((1).Int, :base(Radians)), 1.56079666010823, "Int.atan2(Int, :base(Radians))");
is_approx(atan2((10).Int, (10).Int), 0.785398163397448, "atan2(Int, Int)");
is_approx(atan2((100).Int, (-10).Int, Degrees), 95.7105931374996, "atan2(Int, Int, Degrees)");
is_approx(atan2(:y((-10).Int), :x((1).Int)), -1.47112767430373, "atan2(:y(Int), :x(Int))");
is_approx(atan2(:y((1).Int), :x((-10).Int), :base(Gradians)), 193.654896513889, "atan2(:y(Int), :x(Int), :base(Gradians))");

# Int vs Str tests
is_approx((-1).Int.atan2((-1).Str), -2.35619449019234, "Int.atan2(Str)");
is_approx((-10).Int.atan2((1).Str, Circles), -0.234137241284723, "Int.atan2(Str, Circles)");
is_approx((100).Int.atan2((100).Str, :base(Radians)), 0.785398163397448, "Int.atan2(Str, :base(Radians))");
is_approx(atan2((100).Int, (1).Str), 1.56079666010823, "atan2(Int, Str)");
is_approx(atan2((100).Int, (-0.1).Str, Degrees), 90.0572957604145, "atan2(Int, Str, Degrees)");
is_approx(atan2(:y((-1).Int), :x((-1).Str)), -2.35619449019234, "atan2(:y(Int), :x(Str))");
is_approx(atan2(:y((-1).Int), :x((-0.1).Str), :base(Gradians)), -106.345103486111, "atan2(:y(Int), :x(Str), :base(Gradians))");

# Int vs DifferentReal tests
is_approx((-10).Int.atan2(DifferentReal.new(-10)), -2.35619449019234, "Int.atan2(DifferentReal)");
is_approx((-100).Int.atan2(DifferentReal.new(-1), Circles), -0.251591496382454, "Int.atan2(DifferentReal, Circles)");
is_approx((100).Int.atan2(DifferentReal.new(-10), :base(Radians)), 1.67046497928606, "Int.atan2(DifferentReal, :base(Radians))");
is_approx(atan2((10).Int, DifferentReal.new(-0.1)), 1.58079599348156, "atan2(Int, DifferentReal)");
is_approx(atan2((100).Int, DifferentReal.new(0.1), Degrees), 89.9427042395855, "atan2(Int, DifferentReal, Degrees)");
is_approx(atan2(:y((100).Int), :x(DifferentReal.new(-100))), 2.35619449019234, "atan2(:y(Int), :x(DifferentReal))");
is_approx(atan2(:y((-100).Int), :x(DifferentReal.new(10)), :base(Gradians)), -93.6548965138893, "atan2(:y(Int), :x(DifferentReal), :base(Gradians))");

# Str tests
is_approx((100).Str.atan2, 1.56079666010823, "Str.atan2");
#?rakudo todo 'Cannot tell difference between TrigBase and Int'
is_approx((0.1).Str.atan2(Circles), 0.0158627587152768, "Str.atan2(Circles)");
is_approx((1).Str.atan2(:base(Radians)), 0.785398163397448, "Str.atan2(:base(Radians))");
is_approx(atan2((-100).Str), -1.56079666010823, "atan2(Str)");
#?rakudo todo 'Cannot tell difference between TrigBase and Int'
is_approx(atan2((0.1).Str, Degrees), 5.71059313749964, "atan2(Str, Degrees)");
is_approx(atan2(:y((1).Str)), 0.785398163397448, "atan2(:y(Str))");
is_approx(atan2(:y((0.1).Str), :base(Gradians)), 6.34510348611071, "atan2(:y(Str), :base(Gradians))");

# Str vs Num tests
is_approx((-100).Str.atan2((10).Num), -1.47112767430373, "Str.atan2(Num)");
is_approx((1).Str.atan2((-0.1).Num, Circles), 0.265862758715277, "Str.atan2(Num, Circles)");
is_approx((0.1).Str.atan2((-1).Num, :base(Radians)), 3.04192400109863, "Str.atan2(Num, :base(Radians))");
is_approx(atan2((-10).Str, (0.1).Num), -1.56079666010823, "atan2(Str, Num)");
is_approx(atan2((-10).Str, (-100).Num, Degrees), -174.2894068625, "atan2(Str, Num, Degrees)");
is_approx(atan2(:y((1).Str), :x((0.1).Num)), 1.47112767430373, "atan2(:y(Str), :x(Num))");
is_approx(atan2(:y((0.1).Str), :x((-10).Num), :base(Gradians)), 199.363401447018, "atan2(:y(Str), :x(Num), :base(Gradians))");

# Str vs Rat tests
is_approx((-100).Str.atan2((-100).Rat(1e-9)), -2.35619449019234, "Str.atan2(Rat)");
is_approx((-1).Str.atan2((0.1).Rat(1e-9), Circles), -0.234137241284723, "Str.atan2(Rat, Circles)");
is_approx((1).Str.atan2((-1).Rat(1e-9), :base(Radians)), 2.35619449019234, "Str.atan2(Rat, :base(Radians))");
is_approx(atan2((-10).Str, (-10).Rat(1e-9)), -2.35619449019234, "atan2(Str, Rat)");
is_approx(atan2((100).Str, (-1).Rat(1e-9), Degrees), 90.5729386976835, "atan2(Str, Rat, Degrees)");
is_approx(atan2(:y((10).Str), :x((1).Rat(1e-9))), 1.47112767430373, "atan2(:y(Str), :x(Rat))");
is_approx(atan2(:y((-100).Str), :x((-100).Rat(1e-9)), :base(Gradians)), -150, "atan2(:y(Str), :x(Rat), :base(Gradians))");

# Str vs Int tests
is_approx((1).Str.atan2((1).Int), 0.785398163397448, "Str.atan2(Int)");
is_approx((-100).Str.atan2((100).Int, Circles), -0.125, "Str.atan2(Int, Circles)");
is_approx((-0.1).Str.atan2((100).Int, :base(Radians)), -0.000999999666666867, "Str.atan2(Int, :base(Radians))");
is_approx(atan2((0.1).Str, (-100).Int), 3.14059265392313, "atan2(Str, Int)");
is_approx(atan2((0.1).Str, (100).Int, Degrees), 0.0572957604145006, "atan2(Str, Int, Degrees)");
is_approx(atan2(:y((0.1).Str), :x((-1).Int)), 3.04192400109863, "atan2(:y(Str), :x(Int))");
is_approx(atan2(:y((10).Str), :x((-100).Int), :base(Gradians)), 193.654896513889, "atan2(:y(Str), :x(Int), :base(Gradians))");

# Str vs Str tests
is_approx((-1).Str.atan2((-0.1).Str), -1.67046497928606, "Str.atan2(Str)");
is_approx((-1).Str.atan2((-100).Str, Circles), -0.498408503617546, "Str.atan2(Str, Circles)");
is_approx((-1).Str.atan2((10).Str, :base(Radians)), -0.099668652491162, "Str.atan2(Str, :base(Radians))");
is_approx(atan2((1).Str, (-100).Str), 3.13159298690313, "atan2(Str, Str)");
is_approx(atan2((-100).Str, (-100).Str, Degrees), -135, "atan2(Str, Str, Degrees)");
is_approx(atan2(:y((10).Str), :x((0.1).Str)), 1.56079666010823, "atan2(:y(Str), :x(Str))");
is_approx(atan2(:y((0.1).Str), :x((0.1).Str), :base(Gradians)), 50, "atan2(:y(Str), :x(Str), :base(Gradians))");

# Str vs DifferentReal tests
is_approx((-0.1).Str.atan2(DifferentReal.new(0.1)), -0.785398163397448, "Str.atan2(DifferentReal)");
is_approx((-100).Str.atan2(DifferentReal.new(-1), Circles), -0.251591496382454, "Str.atan2(DifferentReal, Circles)");
is_approx((-1).Str.atan2(DifferentReal.new(100), :base(Radians)), -0.00999966668666524, "Str.atan2(DifferentReal, :base(Radians))");
is_approx(atan2((100).Str, DifferentReal.new(1)), 1.56079666010823, "atan2(Str, DifferentReal)");
is_approx(atan2((-100).Str, DifferentReal.new(-10), Degrees), -95.7105931374996, "atan2(Str, DifferentReal, Degrees)");
is_approx(atan2(:y((-1).Str), :x(DifferentReal.new(-100))), -3.13159298690313, "atan2(:y(Str), :x(DifferentReal))");
is_approx(atan2(:y((100).Str), :x(DifferentReal.new(1)), :base(Gradians)), 99.3634014470183, "atan2(:y(Str), :x(DifferentReal), :base(Gradians))");

# DifferentReal tests
is_approx(DifferentReal.new(1).atan2, 0.785398163397448, "DifferentReal.atan2");
#?rakudo todo 'Cannot tell difference between TrigBase and Int'
is_approx(DifferentReal.new(1).atan2(Circles), 0.125, "DifferentReal.atan2(Circles)");
is_approx(DifferentReal.new(-0.1).atan2(:base(Radians)), -0.099668652491162, "DifferentReal.atan2(:base(Radians))");
is_approx(atan2(DifferentReal.new(-100)), -1.56079666010823, "atan2(DifferentReal)");
#?rakudo todo 'Cannot tell difference between TrigBase and Int'
is_approx(atan2(DifferentReal.new(100), Degrees), 89.4270613023165, "atan2(DifferentReal, Degrees)");
is_approx(atan2(:y(DifferentReal.new(1))), 0.785398163397448, "atan2(:y(DifferentReal))");
is_approx(atan2(:y(DifferentReal.new(-1)), :base(Gradians)), -50, "atan2(:y(DifferentReal), :base(Gradians))");

# DifferentReal vs Num tests
is_approx(DifferentReal.new(-1).atan2((0.1).Num), -1.47112767430373, "DifferentReal.atan2(Num)");
is_approx(DifferentReal.new(0.1).atan2((-0.1).Num, Circles), 0.375, "DifferentReal.atan2(Num, Circles)");
is_approx(DifferentReal.new(-100).atan2((10).Num, :base(Radians)), -1.47112767430373, "DifferentReal.atan2(Num, :base(Radians))");
is_approx(atan2(DifferentReal.new(-10), (1).Num), -1.47112767430373, "atan2(DifferentReal, Num)");
is_approx(atan2(DifferentReal.new(-0.1), (10).Num, Degrees), -0.572938697683486, "atan2(DifferentReal, Num, Degrees)");
is_approx(atan2(:y(DifferentReal.new(100)), :x((-100).Num)), 2.35619449019234, "atan2(:y(DifferentReal), :x(Num))");
is_approx(atan2(:y(DifferentReal.new(1)), :x((-10).Num), :base(Gradians)), 193.654896513889, "atan2(:y(DifferentReal), :x(Num), :base(Gradians))");

# DifferentReal vs Rat tests
is_approx(DifferentReal.new(0.1).atan2((1).Rat(1e-9)), 0.099668652491162, "DifferentReal.atan2(Rat)");
is_approx(DifferentReal.new(-0.1).atan2((100).Rat(1e-9), Circles), -0.000159154890040279, "DifferentReal.atan2(Rat, Circles)");
is_approx(DifferentReal.new(-0.1).atan2((-100).Rat(1e-9), :base(Radians)), -3.14059265392313, "DifferentReal.atan2(Rat, :base(Radians))");
is_approx(atan2(DifferentReal.new(10), (-10).Rat(1e-9)), 2.35619449019234, "atan2(DifferentReal, Rat)");
is_approx(atan2(DifferentReal.new(1), (-0.1).Rat(1e-9), Degrees), 95.7105931374996, "atan2(DifferentReal, Rat, Degrees)");
is_approx(atan2(:y(DifferentReal.new(0.1)), :x((0.1).Rat(1e-9))), 0.785398163397448, "atan2(:y(DifferentReal), :x(Rat))");
is_approx(atan2(:y(DifferentReal.new(-100)), :x((-0.1).Rat(1e-9)), :base(Gradians)), -100.063661956016, "atan2(:y(DifferentReal), :x(Rat), :base(Gradians))");

# DifferentReal vs Int tests
is_approx(DifferentReal.new(100).atan2((-100).Int), 2.35619449019234, "DifferentReal.atan2(Int)");
is_approx(DifferentReal.new(-100).atan2((-1).Int, Circles), -0.251591496382454, "DifferentReal.atan2(Int, Circles)");
is_approx(DifferentReal.new(1).atan2((-1).Int, :base(Radians)), 2.35619449019234, "DifferentReal.atan2(Int, :base(Radians))");
is_approx(atan2(DifferentReal.new(0.1), (100).Int), 0.000999999666666867, "atan2(DifferentReal, Int)");
is_approx(atan2(DifferentReal.new(0.1), (-1).Int, Degrees), 174.2894068625, "atan2(DifferentReal, Int, Degrees)");
is_approx(atan2(:y(DifferentReal.new(-0.1)), :x((-100).Int)), -3.14059265392313, "atan2(:y(DifferentReal), :x(Int))");
is_approx(atan2(:y(DifferentReal.new(0.1)), :x((1).Int), :base(Gradians)), 6.34510348611071, "atan2(:y(DifferentReal), :x(Int), :base(Gradians))");

# DifferentReal vs Str tests
is_approx(DifferentReal.new(-1).atan2((-10).Str), -3.04192400109863, "DifferentReal.atan2(Str)");
is_approx(DifferentReal.new(-0.1).atan2((-10).Str, Circles), -0.498408503617546, "DifferentReal.atan2(Str, Circles)");
is_approx(DifferentReal.new(-10).atan2((0.1).Str, :base(Radians)), -1.56079666010823, "DifferentReal.atan2(Str, :base(Radians))");
is_approx(atan2(DifferentReal.new(-1), (1).Str), -0.785398163397448, "atan2(DifferentReal, Str)");
is_approx(atan2(DifferentReal.new(-0.1), (0.1).Str, Degrees), -45, "atan2(DifferentReal, Str, Degrees)");
is_approx(atan2(:y(DifferentReal.new(-100)), :x((-100).Str)), -2.35619449019234, "atan2(:y(DifferentReal), :x(Str))");
is_approx(atan2(:y(DifferentReal.new(-100)), :x((-100).Str), :base(Gradians)), -150, "atan2(:y(DifferentReal), :x(Str), :base(Gradians))");

# DifferentReal vs DifferentReal tests
is_approx(DifferentReal.new(-1).atan2(DifferentReal.new(-0.1)), -1.67046497928606, "DifferentReal.atan2(DifferentReal)");
is_approx(DifferentReal.new(-10).atan2(DifferentReal.new(10), Circles), -0.125, "DifferentReal.atan2(DifferentReal, Circles)");
is_approx(DifferentReal.new(10).atan2(DifferentReal.new(-10), :base(Radians)), 2.35619449019234, "DifferentReal.atan2(DifferentReal, :base(Radians))");
is_approx(atan2(DifferentReal.new(10), DifferentReal.new(-0.1)), 1.58079599348156, "atan2(DifferentReal, DifferentReal)");
is_approx(atan2(DifferentReal.new(10), DifferentReal.new(-0.1), Degrees), 90.5729386976835, "atan2(DifferentReal, DifferentReal, Degrees)");
is_approx(atan2(:y(DifferentReal.new(1)), :x(DifferentReal.new(-1))), 2.35619449019234, "atan2(:y(DifferentReal), :x(DifferentReal))");
is_approx(atan2(:y(DifferentReal.new(10)), :x(DifferentReal.new(1)), :base(Gradians)), 93.6548965138893, "atan2(:y(DifferentReal), :x(DifferentReal), :base(Gradians))");

done_testing;

# vim: ft=perl6 nomodifiable
