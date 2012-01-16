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

my @cosines = @sines.map({; $_.key - degrees-to-radians(90) => $_.value }); #OK

my @sinhes = @sines.grep({ $_.key < degrees-to-radians(500) }).map({; $_.key => #OK
                                                (exp($_.key) - exp(-$_.key)) / 2.0 });

my @coshes = @sines.grep({ $_.key < degrees-to-radians(500) }).map({; $_.key => #OK
                                                (exp($_.key) + exp(-$_.key)) / 2.0 });

class NotComplex is Cool {
    has $.value;

    multi method new(Complex $value is copy) {
        self.bless(*, :$value);
    }

    multi method Numeric() {
        self.value;
    }
}

class DifferentReal is Real {
    has $.value;

    multi method new($value is copy) {
        self.bless(*, :$value);
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

{
    # Num tests
    is_approx(atan2((-0.1).Num), -0.099668652491162, "atan2(Num)");
}

{
    # Num vs Num tests
    is_approx((-100).Num.atan2((100).Num), -0.785398163397448, "Num.atan2(Num)");
    is_approx(atan2((0.1).Num, (-0.1).Num), 2.35619449019234, "atan2(Num, Num)");
}

{
    # Num vs Rat tests
    is_approx((10).Num.atan2((-10).Rat(1e-9)), 2.35619449019234, "Num.atan2(Rat)");
    is_approx(atan2((-100).Num, (-100).Rat(1e-9)), -2.35619449019234, "atan2(Num, Rat)");
}

{
    # Num vs Int tests
    is_approx((-0.1).Num.atan2((1).Int), -0.099668652491162, "Num.atan2(Int)");
    is_approx(atan2((-10).Num, (-1).Int), -1.67046497928606, "atan2(Num, Int)");
}

{
    # Num vs Str tests
    is_approx((-1).Num.atan2((0.1).Str), -1.47112767430373, "Num.atan2(Str)");
    is_approx(atan2((10).Num, (-0.1).Str), 1.58079599348156, "atan2(Num, Str)");
}

{
    # Num vs DifferentReal tests
    is_approx((-1).Num.atan2(DifferentReal.new(-10)), -3.04192400109863, "Num.atan2(DifferentReal)");
    is_approx(atan2((100).Num, DifferentReal.new(-100)), 2.35619449019234, "atan2(Num, DifferentReal)");
}

#?rakudo skip 'FatRat math NYI'
{
    # Num vs FatRat tests
    is_approx((-100).Num.atan2((10).FatRat), -1.47112767430373, "Num.atan2(FatRat)");
    is_approx(atan2((0.1).Num, (-1).FatRat), 3.04192400109863, "atan2(Num, FatRat)");
}

{
    # Rat tests
    is_approx((10).Rat(1e-9).atan2, 1.47112767430373, "Rat.atan2");
    is_approx(atan2((1).Rat(1e-9)), 0.785398163397448, "atan2(Rat)");
}

{
    # Rat vs Num tests
    is_approx((-0.1).Rat(1e-9).atan2((0.1).Num), -0.785398163397448, "Rat.atan2(Num)");
    is_approx(atan2((0.1).Rat(1e-9), (-1).Num), 3.04192400109863, "atan2(Rat, Num)");
}

{
    # Rat vs Rat tests
    is_approx((-0.1).Rat(1e-9).atan2((-0.1).Rat(1e-9)), -2.35619449019234, "Rat.atan2(Rat)");
    is_approx(atan2((10).Rat(1e-9), (-10).Rat(1e-9)), 2.35619449019234, "atan2(Rat, Rat)");
}

{
    # Rat vs Int tests
    is_approx((-0.1).Rat(1e-9).atan2((1).Int), -0.099668652491162, "Rat.atan2(Int)");
    is_approx(atan2((100).Rat(1e-9), (100).Int), 0.785398163397448, "atan2(Rat, Int)");
}

{
    # Rat vs Str tests
    is_approx((0.1).Rat(1e-9).atan2((0.1).Str), 0.785398163397448, "Rat.atan2(Str)");
    is_approx(atan2((1).Rat(1e-9), (-10).Str), 3.04192400109863, "atan2(Rat, Str)");
}

{
    # Rat vs DifferentReal tests
    is_approx((-100).Rat(1e-9).atan2(DifferentReal.new(1)), -1.56079666010823, "Rat.atan2(DifferentReal)");
    is_approx(atan2((0.1).Rat(1e-9), DifferentReal.new(1)), 0.099668652491162, "atan2(Rat, DifferentReal)");
}

#?rakudo skip 'FatRat math NYI'
{
    # Rat vs FatRat tests
    is_approx((-0.1).Rat(1e-9).atan2((1).FatRat), -0.099668652491162, "Rat.atan2(FatRat)");
    is_approx(atan2((-10).Rat(1e-9), (-100).FatRat), -3.04192400109863, "atan2(Rat, FatRat)");
}

{
    # Int tests
    is_approx((-10).Int.atan2, -1.47112767430373, "Int.atan2");
    is_approx(atan2((1).Int), 0.785398163397448, "atan2(Int)");
}

{
    # Int vs Num tests
    is_approx((-1).Int.atan2((100).Num), -0.00999966668666524, "Int.atan2(Num)");
    is_approx(atan2((-100).Int, (100).Num), -0.785398163397448, "atan2(Int, Num)");
}

{
    # Int vs Rat tests
    is_approx((10).Int.atan2((-10).Rat(1e-9)), 2.35619449019234, "Int.atan2(Rat)");
    is_approx(atan2((-10).Int, (100).Rat(1e-9)), -0.099668652491162, "atan2(Int, Rat)");
}

{
    # Int vs Int tests
    is_approx((-100).Int.atan2((1).Int), -1.56079666010823, "Int.atan2(Int)");
    is_approx(atan2((-1).Int, (-100).Int), -3.13159298690313, "atan2(Int, Int)");
}

{
    # Int vs Str tests
    is_approx((-1).Int.atan2((1).Str), -0.785398163397448, "Int.atan2(Str)");
    is_approx(atan2((-1).Int, (-0.1).Str), -1.67046497928606, "atan2(Int, Str)");
}

{
    # Int vs DifferentReal tests
    is_approx((1).Int.atan2(DifferentReal.new(-0.1)), 1.67046497928606, "Int.atan2(DifferentReal)");
    is_approx(atan2((1).Int, DifferentReal.new(10)), 0.099668652491162, "atan2(Int, DifferentReal)");
}

#?rakudo skip 'FatRat math NYI'
{
    # Int vs FatRat tests
    is_approx((-1).Int.atan2((-100).FatRat), -3.13159298690313, "Int.atan2(FatRat)");
    is_approx(atan2((-1).Int, (-0.1).FatRat), -1.67046497928606, "atan2(Int, FatRat)");
}

{
    # Str tests
    is_approx((1).Str.atan2, 0.785398163397448, "Str.atan2");
    is_approx(atan2((-1).Str), -0.785398163397448, "atan2(Str)");
}

{
    # Str vs Num tests
    is_approx((-10).Str.atan2((10).Num), -0.785398163397448, "Str.atan2(Num)");
    is_approx(atan2((0.1).Str, (1).Num), 0.099668652491162, "atan2(Str, Num)");
}

{
    # Str vs Rat tests
    is_approx((100).Str.atan2((-10).Rat(1e-9)), 1.67046497928606, "Str.atan2(Rat)");
    is_approx(atan2((0.1).Str, (-10).Rat(1e-9)), 3.13159298690313, "atan2(Str, Rat)");
}

{
    # Str vs Int tests
    is_approx((-100).Str.atan2((-100).Int), -2.35619449019234, "Str.atan2(Int)");
    is_approx(atan2((0.1).Str, (-10).Int), 3.13159298690313, "atan2(Str, Int)");
}

{
    # Str vs Str tests
    is_approx((-1).Str.atan2((0.1).Str), -1.47112767430373, "Str.atan2(Str)");
    is_approx(atan2((-10).Str, (1).Str), -1.47112767430373, "atan2(Str, Str)");
}

{
    # Str vs DifferentReal tests
    is_approx((-0.1).Str.atan2(DifferentReal.new(100)), -0.000999999666666867, "Str.atan2(DifferentReal)");
    is_approx(atan2((0.1).Str, DifferentReal.new(1)), 0.099668652491162, "atan2(Str, DifferentReal)");
}

#?rakudo skip 'FatRat math NYI'
{
    # Str vs FatRat tests
    is_approx((10).Str.atan2((-100).FatRat), 3.04192400109863, "Str.atan2(FatRat)");
    is_approx(atan2((1).Str, (-10).FatRat), 3.04192400109863, "atan2(Str, FatRat)");
}

{
    # DifferentReal tests
    is_approx(DifferentReal.new(0.1).atan2, 0.099668652491162, "DifferentReal.atan2");
    is_approx(atan2(DifferentReal.new(0.1)), 0.099668652491162, "atan2(DifferentReal)");
}

{
    # DifferentReal vs Num tests
    is_approx(DifferentReal.new(-10).atan2((10).Num), -0.785398163397448, "DifferentReal.atan2(Num)");
    is_approx(atan2(DifferentReal.new(-100), (-1).Num), -1.58079599348156, "atan2(DifferentReal, Num)");
}

{
    # DifferentReal vs Rat tests
    is_approx(DifferentReal.new(1).atan2((10).Rat(1e-9)), 0.099668652491162, "DifferentReal.atan2(Rat)");
    is_approx(atan2(DifferentReal.new(-10), (-100).Rat(1e-9)), -3.04192400109863, "atan2(DifferentReal, Rat)");
}

{
    # DifferentReal vs Int tests
    is_approx(DifferentReal.new(10).atan2((-10).Int), 2.35619449019234, "DifferentReal.atan2(Int)");
    is_approx(atan2(DifferentReal.new(100), (-1).Int), 1.58079599348156, "atan2(DifferentReal, Int)");
}

{
    # DifferentReal vs Str tests
    is_approx(DifferentReal.new(-1).atan2((-100).Str), -3.13159298690313, "DifferentReal.atan2(Str)");
    is_approx(atan2(DifferentReal.new(-100), (1).Str), -1.56079666010823, "atan2(DifferentReal, Str)");
}

{
    # DifferentReal vs DifferentReal tests
    is_approx(DifferentReal.new(-10).atan2(DifferentReal.new(100)), -0.099668652491162, "DifferentReal.atan2(DifferentReal)");
    is_approx(atan2(DifferentReal.new(1), DifferentReal.new(-100)), 3.13159298690313, "atan2(DifferentReal, DifferentReal)");
}

#?rakudo skip 'FatRat math NYI'
{
    # DifferentReal vs FatRat tests
    is_approx(DifferentReal.new(1).atan2((100).FatRat), 0.00999966668666524, "DifferentReal.atan2(FatRat)");
    is_approx(atan2(DifferentReal.new(0.1), (-100).FatRat), 3.14059265392313, "atan2(DifferentReal, FatRat)");
}

#?rakudo skip 'FatRat math NYI'
{
    # FatRat tests
    is_approx((0.1).FatRat.atan2, 0.099668652491162, "FatRat.atan2");
    is_approx(atan2((-0.1).FatRat), -0.099668652491162, "atan2(FatRat)");
}

#?rakudo skip 'FatRat math NYI'
{
    # FatRat vs Num tests
    is_approx((1).FatRat.atan2((10).Num), 0.099668652491162, "FatRat.atan2(Num)");
    is_approx(atan2((0.1).FatRat, (0.1).Num), 0.785398163397448, "atan2(FatRat, Num)");
}

#?rakudo skip 'FatRat math NYI'
{
    # FatRat vs Rat tests
    is_approx((10).FatRat.atan2((-0.1).Rat(1e-9)), 1.58079599348156, "FatRat.atan2(Rat)");
    is_approx(atan2((0.1).FatRat, (1).Rat(1e-9)), 0.099668652491162, "atan2(FatRat, Rat)");
}

#?rakudo skip 'FatRat math NYI'
{
    # FatRat vs Int tests
    is_approx((10).FatRat.atan2((1).Int), 1.47112767430373, "FatRat.atan2(Int)");
    is_approx(atan2((-100).FatRat, (100).Int), -0.785398163397448, "atan2(FatRat, Int)");
}

#?rakudo skip 'FatRat math NYI'
{
    # FatRat vs Str tests
    is_approx((100).FatRat.atan2((100).Str), 0.785398163397448, "FatRat.atan2(Str)");
    is_approx(atan2((-0.1).FatRat, (100).Str), -0.000999999666666867, "atan2(FatRat, Str)");
}

#?rakudo skip 'FatRat math NYI'
{
    # FatRat vs DifferentReal tests
    is_approx((100).FatRat.atan2(DifferentReal.new(-10)), 1.67046497928606, "FatRat.atan2(DifferentReal)");
    is_approx(atan2((-10).FatRat, DifferentReal.new(-0.1)), -1.58079599348156, "atan2(FatRat, DifferentReal)");
}

#?rakudo skip 'FatRat math NYI'
{
    # FatRat vs FatRat tests
    is_approx((0.1).FatRat.atan2((-1).FatRat), 3.04192400109863, "FatRat.atan2(FatRat)");
    is_approx(atan2((0.1).FatRat, (-10).FatRat), 3.13159298690313, "atan2(FatRat, FatRat)");
}

done;

# vim: ft=perl6 nomodifiable
