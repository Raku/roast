use v6.c;
# WARNING:
# This is a generated file and should not be edited directly.
# look into generate-tests.pl instead

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

my @cosines = @sines.map({; $_.key - degrees-to-radians(90) => $_.value }); #OK

my @sinhes = @sines.grep({ $_.key < degrees-to-radians(500) }).map({; $_.key => #OK
                                                (exp($_.key) - exp(-$_.key)) / 2.0 });

my @coshes = @sines.grep({ $_.key < degrees-to-radians(500) }).map({; $_.key => #OK
                                                (exp($_.key) + exp(-$_.key)) / 2.0 });

class NotComplex is Cool {
    has $.value;

    multi method new(Complex $value is copy) {
        self.bless(:$value);
    }

    multi method Numeric() {
        self.value;
    }
}

class DifferentReal is Real {
    has $.value;

    multi method new($value is copy) {
        self.bless(:$value);
    }

    multi method Bridge() {
        self.value.Num;
    }
}            



# atan2 tests

# First, test atan2 with x = 1

for @sines -> $angle
{
    next if abs(cos($angle.key())) < 1e-6;     
	my $desired-result = sin($angle.key()) / cos($angle.key());

    # Num.atan2 tests
    is-approx($desired-result.Num.atan2.tan, $desired-result, 
              "Num.atan2() - {$angle.key()}");
    is-approx($desired-result.Num.atan2(1.Num).tan, $desired-result, 
              "Num.atan2(1.Num) - {$angle.key()}");
}

# check that the proper quadrant is returned

is-approx(atan2(4, 4), pi / 4, "atan2(4, 4) is pi / 4");
is-approx(atan2(-4, 4), -pi / 4, "atan2(-4, 4) is -pi / 4");
is-approx(atan2(4, -4), 3 * pi / 4, "atan2(4, -4) is 3pi / 4");
is-approx(atan2(-4, -4), -3 * pi / 4, "atan2(-4, -4) is -3pi / 4");

{
    # Num tests
    is-approx(atan2((10).Num), 1.47112767430373, "atan2(Num)");
}

{
    # Num vs Num tests
    is-approx((-0.1).Num.atan2((1).Num), -0.099668652491162, "Num.atan2(Num)");
    is-approx(atan2((100).Num, (-100).Num), 2.35619449019234, "atan2(Num, Num)");
}

{
    # Num vs Rat tests
    is-approx((-1).Num.atan2((0.1).Rat(1e-9)), -1.47112767430373, "Num.atan2(Rat)");
    is-approx(atan2((-0.1).Num, (-10).Rat(1e-9)), -3.13159298690313, "atan2(Num, Rat)");
}

{
    # Num vs Int tests
    is-approx((100).Num.atan2((10).Int), 1.47112767430373, "Num.atan2(Int)");
    is-approx(atan2((0.1).Num, (1).Int), 0.099668652491162, "atan2(Num, Int)");
}

{
    # Num vs Str tests
    is-approx((-0.1).Num.atan2((-1).Str), -3.04192400109863, "Num.atan2(Str)");
    is-approx(atan2((10).Num, (0.1).Str), 1.56079666010823, "atan2(Num, Str)");
}

{
    # Num vs DifferentReal tests
    is-approx((10).Num.atan2(DifferentReal.new(-100)), 3.04192400109863, "Num.atan2(DifferentReal)");
    is-approx(atan2((-1).Num, DifferentReal.new(0.1)), -1.47112767430373, "atan2(Num, DifferentReal)");
}

{
    # Num vs FatRat tests
    is-approx((0.1).Num.atan2((10).FatRat), 0.00999966668666524, "Num.atan2(FatRat)");
    is-approx(atan2((-10).Num, (-0.1).FatRat), -1.58079599348156, "atan2(Num, FatRat)");
}

{
    # Rat tests
    is-approx((-0.1).Rat(1e-9).atan2, -0.099668652491162, "Rat.atan2");
    is-approx(atan2((-0.1).Rat(1e-9)), -0.099668652491162, "atan2(Rat)");
}

{
    # Rat vs Num tests
    is-approx((-100).Rat(1e-9).atan2((0.1).Num), -1.56979632712823, "Rat.atan2(Num)");
    is-approx(atan2((100).Rat(1e-9), (-0.1).Num), 1.57179632646156, "atan2(Rat, Num)");
}

{
    # Rat vs Rat tests
    is-approx((100).Rat(1e-9).atan2((-0.1).Rat(1e-9)), 1.57179632646156, "Rat.atan2(Rat)");
    is-approx(atan2((1).Rat(1e-9), (-100).Rat(1e-9)), 3.13159298690313, "atan2(Rat, Rat)");
}

{
    # Rat vs Int tests
    is-approx((1).Rat(1e-9).atan2((-1).Int), 2.35619449019234, "Rat.atan2(Int)");
    is-approx(atan2((0.1).Rat(1e-9), (1).Int), 0.099668652491162, "atan2(Rat, Int)");
}

{
    # Rat vs Str tests
    is-approx((-0.1).Rat(1e-9).atan2((-100).Str), -3.14059265392313, "Rat.atan2(Str)");
    is-approx(atan2((-10).Rat(1e-9), (-10).Str), -2.35619449019234, "atan2(Rat, Str)");
}

{
    # Rat vs DifferentReal tests
    is-approx((-100).Rat(1e-9).atan2(DifferentReal.new(-1)), -1.58079599348156, "Rat.atan2(DifferentReal)");
    is-approx(atan2((10).Rat(1e-9), DifferentReal.new(100)), 0.099668652491162, "atan2(Rat, DifferentReal)");
}

{
    # Rat vs FatRat tests
    is-approx((10).Rat(1e-9).atan2((0.1).FatRat), 1.56079666010823, "Rat.atan2(FatRat)");
    is-approx(atan2((100).Rat(1e-9), (-0.1).FatRat), 1.57179632646156, "atan2(Rat, FatRat)");
}

{
    # Int tests
    is-approx((1).Int.atan2, 0.785398163397448, "Int.atan2");
    is-approx(atan2((10).Int), 1.47112767430373, "atan2(Int)");
}

{
    # Int vs Num tests
    is-approx((-1).Int.atan2((100).Num), -0.00999966668666524, "Int.atan2(Num)");
    is-approx(atan2((10).Int, (0.1).Num), 1.56079666010823, "atan2(Int, Num)");
}

{
    # Int vs Rat tests
    is-approx((-10).Int.atan2((100).Rat(1e-9)), -0.099668652491162, "Int.atan2(Rat)");
    is-approx(atan2((-1).Int, (0.1).Rat(1e-9)), -1.47112767430373, "atan2(Int, Rat)");
}

{
    # Int vs Int tests
    is-approx((10).Int.atan2((-100).Int), 3.04192400109863, "Int.atan2(Int)");
    is-approx(atan2((10).Int, (-1).Int), 1.67046497928606, "atan2(Int, Int)");
}

{
    # Int vs Str tests
    is-approx((-1).Int.atan2((-10).Str), -3.04192400109863, "Int.atan2(Str)");
    is-approx(atan2((-10).Int, (100).Str), -0.099668652491162, "atan2(Int, Str)");
}

{
    # Int vs DifferentReal tests
    is-approx((100).Int.atan2(DifferentReal.new(-10)), 1.67046497928606, "Int.atan2(DifferentReal)");
    is-approx(atan2((-1).Int, DifferentReal.new(10)), -0.099668652491162, "atan2(Int, DifferentReal)");
}

{
    # Int vs FatRat tests
    is-approx((10).Int.atan2((-100).FatRat), 3.04192400109863, "Int.atan2(FatRat)");
    is-approx(atan2((100).Int, (0.1).FatRat), 1.56979632712823, "atan2(Int, FatRat)");
}

{
    # Str tests
    is-approx((-0.1).Str.atan2, -0.099668652491162, "Str.atan2");
    is-approx(atan2((100).Str), 1.56079666010823, "atan2(Str)");
}

{
    # Str vs Num tests
    is-approx((-100).Str.atan2((1).Num), -1.56079666010823, "Str.atan2(Num)");
    is-approx(atan2((-0.1).Str, (-1).Num), -3.04192400109863, "atan2(Str, Num)");
}

{
    # Str vs Rat tests
    is-approx((-100).Str.atan2((-100).Rat(1e-9)), -2.35619449019234, "Str.atan2(Rat)");
    is-approx(atan2((-100).Str, (10).Rat(1e-9)), -1.47112767430373, "atan2(Str, Rat)");
}

{
    # Str vs Int tests
    is-approx((-1).Str.atan2((100).Int), -0.00999966668666524, "Str.atan2(Int)");
    is-approx(atan2((-1).Str, (100).Int), -0.00999966668666524, "atan2(Str, Int)");
}

{
    # Str vs Str tests
    is-approx((-10).Str.atan2((-0.1).Str), -1.58079599348156, "Str.atan2(Str)");
    is-approx(atan2((-100).Str, (1).Str), -1.56079666010823, "atan2(Str, Str)");
}

{
    # Str vs DifferentReal tests
    is-approx((10).Str.atan2(DifferentReal.new(1)), 1.47112767430373, "Str.atan2(DifferentReal)");
    is-approx(atan2((-100).Str, DifferentReal.new(1)), -1.56079666010823, "atan2(Str, DifferentReal)");
}

{
    # Str vs FatRat tests
    is-approx((100).Str.atan2((10).FatRat), 1.47112767430373, "Str.atan2(FatRat)");
    is-approx(atan2((-0.1).Str, (100).FatRat), -0.000999999666666867, "atan2(Str, FatRat)");
}

{
    # DifferentReal tests
    is-approx(DifferentReal.new(-1).atan2, -0.785398163397448, "DifferentReal.atan2");
    is-approx(atan2(DifferentReal.new(0.1)), 0.099668652491162, "atan2(DifferentReal)");
}

{
    # DifferentReal vs Num tests
    is-approx(DifferentReal.new(0.1).atan2((100).Num), 0.000999999666666867, "DifferentReal.atan2(Num)");
    is-approx(atan2(DifferentReal.new(-0.1), (-0.1).Num), -2.35619449019234, "atan2(DifferentReal, Num)");
}

{
    # DifferentReal vs Rat tests
    is-approx(DifferentReal.new(-0.1).atan2((0.1).Rat(1e-9)), -0.785398163397448, "DifferentReal.atan2(Rat)");
    is-approx(atan2(DifferentReal.new(-0.1), (-100).Rat(1e-9)), -3.14059265392313, "atan2(DifferentReal, Rat)");
}

{
    # DifferentReal vs Int tests
    is-approx(DifferentReal.new(-1).atan2((-10).Int), -3.04192400109863, "DifferentReal.atan2(Int)");
    is-approx(atan2(DifferentReal.new(10), (-1).Int), 1.67046497928606, "atan2(DifferentReal, Int)");
}

{
    # DifferentReal vs Str tests
    is-approx(DifferentReal.new(-10).atan2((100).Str), -0.099668652491162, "DifferentReal.atan2(Str)");
    is-approx(atan2(DifferentReal.new(-1), (100).Str), -0.00999966668666524, "atan2(DifferentReal, Str)");
}

{
    # DifferentReal vs DifferentReal tests
    is-approx(DifferentReal.new(0.1).atan2(DifferentReal.new(-10)), 3.13159298690313, "DifferentReal.atan2(DifferentReal)");
    is-approx(atan2(DifferentReal.new(-100), DifferentReal.new(10)), -1.47112767430373, "atan2(DifferentReal, DifferentReal)");
}

{
    # DifferentReal vs FatRat tests
    is-approx(DifferentReal.new(10).atan2((0.1).FatRat), 1.56079666010823, "DifferentReal.atan2(FatRat)");
    is-approx(atan2(DifferentReal.new(100), (1).FatRat), 1.56079666010823, "atan2(DifferentReal, FatRat)");
}

{
    # FatRat tests
    is-approx((-100).FatRat.atan2, -1.56079666010823, "FatRat.atan2");
    is-approx(atan2((-0.1).FatRat), -0.099668652491162, "atan2(FatRat)");
}

{
    # FatRat vs Num tests
    is-approx((-1).FatRat.atan2((-100).Num), -3.13159298690313, "FatRat.atan2(Num)");
    is-approx(atan2((10).FatRat, (10).Num), 0.785398163397448, "atan2(FatRat, Num)");
}

{
    # FatRat vs Rat tests
    is-approx((10).FatRat.atan2((-100).Rat(1e-9)), 3.04192400109863, "FatRat.atan2(Rat)");
    is-approx(atan2((0.1).FatRat, (-10).Rat(1e-9)), 3.13159298690313, "atan2(FatRat, Rat)");
}

{
    # FatRat vs Int tests
    is-approx((-100).FatRat.atan2((-1).Int), -1.58079599348156, "FatRat.atan2(Int)");
    is-approx(atan2((-100).FatRat, (-100).Int), -2.35619449019234, "atan2(FatRat, Int)");
}

{
    # FatRat vs Str tests
    is-approx((10).FatRat.atan2((0.1).Str), 1.56079666010823, "FatRat.atan2(Str)");
    is-approx(atan2((0.1).FatRat, (-10).Str), 3.13159298690313, "atan2(FatRat, Str)");
}

{
    # FatRat vs DifferentReal tests
    is-approx((0.1).FatRat.atan2(DifferentReal.new(10)), 0.00999966668666524, "FatRat.atan2(DifferentReal)");
    is-approx(atan2((-100).FatRat, DifferentReal.new(-0.1)), -1.57179632646156, "atan2(FatRat, DifferentReal)");
}

{
    # FatRat vs FatRat tests
    is-approx((0.1).FatRat.atan2((-10).FatRat), 3.13159298690313, "FatRat.atan2(FatRat)");
    is-approx(atan2((0.1).FatRat, (-100).FatRat), 3.14059265392313, "atan2(FatRat, FatRat)");
}

done-testing;

# vim: ft=perl6 nomodifiable
