# WARNING:
# This is a generated file and should not be edited directly.
# look into generate-tests.pl instead

use v6;
use Test;

sub degrees-to-radians($x) {
    $x * (312689/99532) / 180;
}

my @sines = (
    degrees-to-radians(-360) => 0,
    degrees-to-radians(135 - 360) => 1/2*sqrt(2),
    degrees-to-radians(330 - 360) => -0.5,
    degrees-to-radians(0) => 0,
    degrees-to-radians(30) => 0.5,
    degrees-to-radians(45) => 1/2*sqrt(2),
    degrees-to-radians(90) => 1,
    degrees-to-radians(135) => 1/2*sqrt(2),
    degrees-to-radians(180) => 0,
    degrees-to-radians(225) => -1/2*sqrt(2),
    degrees-to-radians(270) => -1,
    degrees-to-radians(315) => -1/2*sqrt(2),
    degrees-to-radians(360) => 0,
    degrees-to-radians(30 + 360) => 0.5,
    degrees-to-radians(225 + 360) => -1/2*sqrt(2),
    degrees-to-radians(720) => 0
);

my @cosines = @sines.map({; $_.key - degrees-to-radians(90) => $_.value });

my @sinhes = @sines.grep({ $_.key < degrees-to-radians(500) }).map({; $_.key =>
                                                (exp($_.key) - exp(-$_.key)) / 2.0 });

my @coshes = @sines.grep({ $_.key < degrees-to-radians(500) }).map({; $_.key =>
                                                (exp($_.key) + exp(-$_.key)) / 2.0 });



# atan2 tests

# First, test atan2 with x = 1

for TrigTest::sines() -> $angle
{
    next if abs(cos($angle.key())) < 1e-6;     
	my $desired-result = sin($angle.key()) / cos($angle.key());

    # Num.atan2 tests
    is_approx($desired-result.Num.atan2.tan, $desired-result, 
              "Num.atan2() - {$angle.key()}");
    is_approx($desired-result.Num.atan2(1.Num).tan, $desired-result, 
              "Num.atan2(1.Num) - {$angle.key()}");
}

# check that the proper quadrant is returned

is_approx(atan2(4, 4), pi / 4, "atan2(4, 4) is pi / 4");
is_approx(atan2(-4, 4), -pi / 4, "atan2(-4, 4) is -pi / 4");
is_approx(atan2(4, -4), 3 * pi / 4, "atan2(4, -4) is 3pi / 4");
is_approx(atan2(-4, -4), -3 * pi / 4, "atan2(-4, -4) is -3pi / 4");

# Num tests
is_approx(atan2((1).Num), 0.785398163397448, "atan2(Num)");
is_approx(atan2(:y((-1).Num)), -0.785398163397448, "atan2(:y(Num))");

# Num vs Num tests
is_approx((1).Num.atan2((-100).Num), 3.13159298690313, "Num.atan2(Num)");
is_approx(atan2((10).Num, (10).Num), 0.785398163397448, "atan2(Num, Num)");
is_approx(atan2(:y((-0.1).Num), :x((1).Num)), -0.099668652491162, "atan2(:y(Num), :x(Num))");

# Num vs Rat tests
is_approx((-10).Num.atan2((-1).Rat(1e-9)), -1.67046497928606, "Num.atan2(Rat)");
is_approx(atan2((10).Num, (100).Rat(1e-9)), 0.099668652491162, "atan2(Num, Rat)");
is_approx(atan2(:y((10).Num), :x((0.1).Rat(1e-9))), 1.56079666010823, "atan2(:y(Num), :x(Rat))");

# Num vs Int tests
is_approx((100).Num.atan2((-100).Int), 2.35619449019234, "Num.atan2(Int)");
is_approx(atan2((-10).Num, (-10).Int), -2.35619449019234, "atan2(Num, Int)");
is_approx(atan2(:y((0.1).Num), :x((10).Int)), 0.00999966668666524, "atan2(:y(Num), :x(Int))");

# Num vs Str tests
is_approx((-10).Num.atan2((-10).Str), -2.35619449019234, "Num.atan2(Str)");
is_approx(atan2((10).Num, (0.1).Str), 1.56079666010823, "atan2(Num, Str)");
is_approx(atan2(:y((0.1).Num), :x((10).Str)), 0.00999966668666524, "atan2(:y(Num), :x(Str))");

# Num vs DifferentReal tests
is_approx((10).Num.atan2(DifferentReal.new(-0.1)), 1.58079599348156, "Num.atan2(DifferentReal)");
is_approx(atan2((-100).Num, DifferentReal.new(100)), -0.785398163397448, "atan2(Num, DifferentReal)");
is_approx(atan2(:y((-10).Num), :x(DifferentReal.new(-100))), -3.04192400109863, "atan2(:y(Num), :x(DifferentReal))");

# Rat tests
is_approx((-0.1).Rat(1e-9).atan2, -0.099668652491162, "Rat.atan2");
is_approx(atan2((1).Rat(1e-9)), 0.785398163397448, "atan2(Rat)");
is_approx(atan2(:y((-100).Rat(1e-9))), -1.56079666010823, "atan2(:y(Rat))");

# Rat vs Num tests
is_approx((-100).Rat(1e-9).atan2((0.1).Num), -1.56979632712823, "Rat.atan2(Num)");
is_approx(atan2((10).Rat(1e-9), (-10).Num), 2.35619449019234, "atan2(Rat, Num)");
is_approx(atan2(:y((-1).Rat(1e-9)), :x((1).Num)), -0.785398163397448, "atan2(:y(Rat), :x(Num))");

# Rat vs Rat tests
is_approx((10).Rat(1e-9).atan2((0.1).Rat(1e-9)), 1.56079666010823, "Rat.atan2(Rat)");
is_approx(atan2((-1).Rat(1e-9), (-100).Rat(1e-9)), -3.13159298690313, "atan2(Rat, Rat)");
is_approx(atan2(:y((1).Rat(1e-9)), :x((1).Rat(1e-9))), 0.785398163397448, "atan2(:y(Rat), :x(Rat))");

# Rat vs Int tests
is_approx((-0.1).Rat(1e-9).atan2((-10).Int), -3.13159298690313, "Rat.atan2(Int)");
is_approx(atan2((-10).Rat(1e-9), (100).Int), -0.099668652491162, "atan2(Rat, Int)");
is_approx(atan2(:y((10).Rat(1e-9)), :x((100).Int)), 0.099668652491162, "atan2(:y(Rat), :x(Int))");

# Rat vs Str tests
is_approx((100).Rat(1e-9).atan2((100).Str), 0.785398163397448, "Rat.atan2(Str)");
is_approx(atan2((0.1).Rat(1e-9), (10).Str), 0.00999966668666524, "atan2(Rat, Str)");
is_approx(atan2(:y((10).Rat(1e-9)), :x((1).Str)), 1.47112767430373, "atan2(:y(Rat), :x(Str))");

# Rat vs DifferentReal tests
is_approx((-10).Rat(1e-9).atan2(DifferentReal.new(-0.1)), -1.58079599348156, "Rat.atan2(DifferentReal)");
is_approx(atan2((1).Rat(1e-9), DifferentReal.new(1)), 0.785398163397448, "atan2(Rat, DifferentReal)");
is_approx(atan2(:y((-10).Rat(1e-9)), :x(DifferentReal.new(1))), -1.47112767430373, "atan2(:y(Rat), :x(DifferentReal))");

# Int tests
is_approx((-10).Int.atan2, -1.47112767430373, "Int.atan2");
is_approx(atan2((-1).Int), -0.785398163397448, "atan2(Int)");
is_approx(atan2(:y((10).Int)), 1.47112767430373, "atan2(:y(Int))");

# Int vs Num tests
is_approx((-100).Int.atan2((-10).Num), -1.67046497928606, "Int.atan2(Num)");
is_approx(atan2((-1).Int, (1).Num), -0.785398163397448, "atan2(Int, Num)");
is_approx(atan2(:y((100).Int), :x((1).Num)), 1.56079666010823, "atan2(:y(Int), :x(Num))");

# Int vs Rat tests
is_approx((-1).Int.atan2((100).Rat(1e-9)), -0.00999966668666524, "Int.atan2(Rat)");
is_approx(atan2((10).Int, (-0.1).Rat(1e-9)), 1.58079599348156, "atan2(Int, Rat)");
is_approx(atan2(:y((100).Int), :x((-0.1).Rat(1e-9))), 1.57179632646156, "atan2(:y(Int), :x(Rat))");

# Int vs Int tests
is_approx((10).Int.atan2((-10).Int), 2.35619449019234, "Int.atan2(Int)");
is_approx(atan2((1).Int, (-100).Int), 3.13159298690313, "atan2(Int, Int)");
is_approx(atan2(:y((1).Int), :x((1).Int)), 0.785398163397448, "atan2(:y(Int), :x(Int))");

# Int vs Str tests
is_approx((1).Int.atan2((10).Str), 0.099668652491162, "Int.atan2(Str)");
is_approx(atan2((1).Int, (-0.1).Str), 1.67046497928606, "atan2(Int, Str)");
is_approx(atan2(:y((-100).Int), :x((-1).Str)), -1.58079599348156, "atan2(:y(Int), :x(Str))");

# Int vs DifferentReal tests
is_approx((-1).Int.atan2(DifferentReal.new(-1)), -2.35619449019234, "Int.atan2(DifferentReal)");
is_approx(atan2((-10).Int, DifferentReal.new(10)), -0.785398163397448, "atan2(Int, DifferentReal)");
is_approx(atan2(:y((10).Int), :x(DifferentReal.new(10))), 0.785398163397448, "atan2(:y(Int), :x(DifferentReal))");

# Str tests
is_approx((-10).Str.atan2, -1.47112767430373, "Str.atan2");
is_approx(atan2((-0.1).Str), -0.099668652491162, "atan2(Str)");
is_approx(atan2(:y((-100).Str)), -1.56079666010823, "atan2(:y(Str))");

# Str vs Num tests
is_approx((0.1).Str.atan2((-10).Num), 3.13159298690313, "Str.atan2(Num)");
is_approx(atan2((10).Str, (1).Num), 1.47112767430373, "atan2(Str, Num)");
is_approx(atan2(:y((-1).Str), :x((-0.1).Num)), -1.67046497928606, "atan2(:y(Str), :x(Num))");

# Str vs Rat tests
is_approx((-100).Str.atan2((-100).Rat(1e-9)), -2.35619449019234, "Str.atan2(Rat)");
is_approx(atan2((-100).Str, (-1).Rat(1e-9)), -1.58079599348156, "atan2(Str, Rat)");
is_approx(atan2(:y((1).Str), :x((-10).Rat(1e-9))), 3.04192400109863, "atan2(:y(Str), :x(Rat))");

# Str vs Int tests
is_approx((0.1).Str.atan2((10).Int), 0.00999966668666524, "Str.atan2(Int)");
is_approx(atan2((-100).Str, (-10).Int), -1.67046497928606, "atan2(Str, Int)");
is_approx(atan2(:y((10).Str), :x((-1).Int)), 1.67046497928606, "atan2(:y(Str), :x(Int))");

# Str vs Str tests
is_approx((10).Str.atan2((1).Str), 1.47112767430373, "Str.atan2(Str)");
is_approx(atan2((10).Str, (100).Str), 0.099668652491162, "atan2(Str, Str)");
is_approx(atan2(:y((-0.1).Str), :x((-100).Str)), -3.14059265392313, "atan2(:y(Str), :x(Str))");

# Str vs DifferentReal tests
is_approx((0.1).Str.atan2(DifferentReal.new(10)), 0.00999966668666524, "Str.atan2(DifferentReal)");
is_approx(atan2((-0.1).Str, DifferentReal.new(-100)), -3.14059265392313, "atan2(Str, DifferentReal)");
is_approx(atan2(:y((10).Str), :x(DifferentReal.new(10))), 0.785398163397448, "atan2(:y(Str), :x(DifferentReal))");

# DifferentReal tests
is_approx(DifferentReal.new(0.1).atan2, 0.099668652491162, "DifferentReal.atan2");
is_approx(atan2(DifferentReal.new(-100)), -1.56079666010823, "atan2(DifferentReal)");
is_approx(atan2(:y(DifferentReal.new(-0.1))), -0.099668652491162, "atan2(:y(DifferentReal))");

# DifferentReal vs Num tests
is_approx(DifferentReal.new(0.1).atan2((-0.1).Num), 2.35619449019234, "DifferentReal.atan2(Num)");
is_approx(atan2(DifferentReal.new(10), (-0.1).Num), 1.58079599348156, "atan2(DifferentReal, Num)");
is_approx(atan2(:y(DifferentReal.new(10)), :x((10).Num)), 0.785398163397448, "atan2(:y(DifferentReal), :x(Num))");

# DifferentReal vs Rat tests
is_approx(DifferentReal.new(10).atan2((1).Rat(1e-9)), 1.47112767430373, "DifferentReal.atan2(Rat)");
is_approx(atan2(DifferentReal.new(-0.1), (-10).Rat(1e-9)), -3.13159298690313, "atan2(DifferentReal, Rat)");
is_approx(atan2(:y(DifferentReal.new(-10)), :x((100).Rat(1e-9))), -0.099668652491162, "atan2(:y(DifferentReal), :x(Rat))");

# DifferentReal vs Int tests
is_approx(DifferentReal.new(-0.1).atan2((-1).Int), -3.04192400109863, "DifferentReal.atan2(Int)");
is_approx(atan2(DifferentReal.new(100), (-100).Int), 2.35619449019234, "atan2(DifferentReal, Int)");
is_approx(atan2(:y(DifferentReal.new(-1)), :x((-10).Int)), -3.04192400109863, "atan2(:y(DifferentReal), :x(Int))");

# DifferentReal vs Str tests
is_approx(DifferentReal.new(-1).atan2((100).Str), -0.00999966668666524, "DifferentReal.atan2(Str)");
is_approx(atan2(DifferentReal.new(1), (0.1).Str), 1.47112767430373, "atan2(DifferentReal, Str)");
is_approx(atan2(:y(DifferentReal.new(-0.1)), :x((100).Str)), -0.000999999666666867, "atan2(:y(DifferentReal), :x(Str))");

# DifferentReal vs DifferentReal tests
is_approx(DifferentReal.new(10).atan2(DifferentReal.new(100)), 0.099668652491162, "DifferentReal.atan2(DifferentReal)");
is_approx(atan2(DifferentReal.new(100), DifferentReal.new(-0.1)), 1.57179632646156, "atan2(DifferentReal, DifferentReal)");
is_approx(atan2(:y(DifferentReal.new(100)), :x(DifferentReal.new(-10))), 1.67046497928606, "atan2(:y(DifferentReal), :x(DifferentReal))");

done;

# vim: ft=perl6 nomodifiable
