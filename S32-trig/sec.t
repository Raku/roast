# WARNING:
# This is a generated file and should not be edited directly.
# look into generate-tests.pl instead

use v6;
use Test;
BEGIN { @*INC.push("t/spec/packages/") };
use TrigTestSupport;


# sec tests

my $base_list = (TrigTest::official_bases() xx *).flat;
my $iter_count = 0;
for TrigTest::cosines() -> $angle
{
    next if abs(cos($angle.num(Radians))) < 1e-6;
    my $desired-result = 1.0 / cos($angle.num(Radians));

    # Num.sec tests -- very thorough
    is_approx($angle.num(Radians).sec, $desired-result, 
              "Num.sec - {$angle.num(Radians)} default");
    for TrigTest::official_bases() -> $base {
        is_approx($angle.num($base).sec($base), $desired-result, 
                  "Num.sec - {$angle.num($base)} $base");
    }

    # Complex.sec tests -- also very thorough
    my Complex $zp0 = $angle.complex(0.0, Radians);
    my Complex $sz0 = $desired-result + 0i;
    my Complex $zp1 = $angle.complex(1.0, Radians);
    my Complex $sz1 = { 1.0 / cos($_) }($zp1);
    my Complex $zp2 = $angle.complex(2.0, Radians);
    my Complex $sz2 = { 1.0 / cos($_) }($zp2);
    
    is_approx($zp0.sec, $sz0, "Complex.sec - $zp0 default");
    is_approx($zp1.sec, $sz1, "Complex.sec - $zp1 default");
    is_approx($zp2.sec, $sz2, "Complex.sec - $zp2 default");
    
    for TrigTest::official_bases() -> $base {
        my Complex $z = $angle.complex(0.0, $base);
        is_approx($z.sec($base), $sz0, "Complex.sec - $z $base");
    
        $z = $angle.complex(1.0, $base);
        is_approx($z.sec($base), $sz1, "Complex.sec - $z $base");
    
        $z = $angle.complex(2.0, $base);
        is_approx($z.sec($base), $sz2, "Complex.sec - $z $base");
    }
}

is(sec(Inf), NaN, "sec(Inf) - default");
is(sec(-Inf), NaN, "sec(-Inf) - default");
given $base_list.shift
{
    is(sec(Inf,  $_), NaN, "sec(Inf) - $_");
    is(sec(-Inf, $_), NaN, "sec(-Inf) - $_");
}
        
# Num tests
is_approx((-5.49778714383314).Num.sec(:base(Radians)), 1.41421356230097, "Num.sec(:base(Radians)) - -5.49778714383314");
is_approx(sec((-2.09439510241262).Num), -1.9999999999327, "sec(Num) - -2.09439510241262");
is_approx(sec((-60).Num, Degrees), 2.00000000003365, "sec(Num, Degrees) - -60");
is_approx(sec(:x((-0.785398163404734).Num)), 1.4142135623834, "sec(:x(Num)) - -0.785398163404734");
is_approx(sec(:x((0).Num), :base(Gradians)), 1, "sec(:x(Num), :base(Gradians)) - 0");

# Rat tests
is_approx((0.785398163404734).Rat(1e-9).sec, 1.4142135623834, "Rat.sec - 0.785398163404734");
is_approx((0.375).Rat(1e-9).sec(Circles), -1.41421356234218, "Rat.sec(Circles) - 0.375");
is_approx((3.14159265361894).Rat(1e-9).sec(:base(Radians)), -1, "Rat.sec(:base(Radians)) - 3.14159265361894");
is_approx(sec((3.92699081702367).Rat(1e-9)), -1.41421356242461, "sec(Rat) - 3.92699081702367");
is_approx(sec((300).Rat(1e-9), Degrees), 1.99999999983174, "sec(Rat, Degrees) - 300");
is_approx(sec(:x((8.63937979745208).Rat(1e-9))), -1.41421356225975, "sec(:x(Rat)) - 8.63937979745208");
is_approx(sec(:x((-350).Rat(1e-9)), :base(Gradians)), 1.41421356230097, "sec(:x(Rat), :base(Gradians)) - -350");

# Complex tests
is_approx((-0.333333333333333 + 0.318309886183791i).Complex.sec(:base(Circles)), -0.140337325261927 + -0.234327511876613i, "Complex.sec(:base(Circles)) - -0.333333333333333 + 0.318309886183791i");
is_approx(sec((-1.0471975511966 + 2i).Complex), 0.140337325255107 + -0.234327511880997i, "sec(Complex) - -1.0471975511966 + 2i");
is_approx(sec((-0.785398163397448 + 2i).Complex, Radians), 0.194833118735496 + -0.187824499975941i, "sec(Complex, Radians) - -0.785398163397448 + 2i");
is_approx(sec(:x((0 + 2i).Complex)), 0.26580222883408 + 0i, "sec(:x(Complex)) - 0 + 2i");
is_approx(sec(:x((45 + 114.591559026165i).Complex), :base(Degrees)), 0.194833118735496 + 0.187824499975941i, "sec(:x(Complex), :base(Degrees)) - 45 + 114.591559026165i");

# Str tests
is_approx((2.3561944902142).Str.sec, -1.41421356234218, "Str.sec - 2.3561944902142");
is_approx((200).Str.sec(Gradians), -1, "Str.sec(Gradians) - 200");
is_approx((0.625).Str.sec(:base(Circles)), -1.41421356242461, "Str.sec(:base(Circles)) - 0.625");
is_approx(sec((5.23598775603156).Str), 1.99999999983174, "sec(Str) - 5.23598775603156");
is_approx(sec((8.63937979745208).Str, Radians), -1.41421356225975, "sec(Str, Radians) - 8.63937979745208");
is_approx(sec(:x((-5.49778714383314).Str)), 1.41421356230097, "sec(:x(Str)) - -5.49778714383314");
is_approx(sec(:x((-120).Str), :base(Degrees)), -1.9999999999327, "sec(:x(Str), :base(Degrees)) - -120");

# NotComplex tests
is_approx(NotComplex.new(-1.0471975511966 + 2i).sec, 0.140337325255107 + -0.234327511880997i, "NotComplex.sec - -1.0471975511966 + 2i");
is_approx(NotComplex.new(-50 + 127.323954473516i).sec(Gradians), 0.194833118735496 + -0.187824499975941i, "NotComplex.sec(Gradians) - -50 + 127.323954473516i");
is_approx(NotComplex.new(0 + 0.318309886183791i).sec(:base(Circles)), 0.26580222883408 + 0i, "NotComplex.sec(:base(Circles)) - 0 + 0.318309886183791i");
is_approx(sec(NotComplex.new(0.785398163397448 + 2i)), 0.194833118735496 + 0.187824499975941i, "sec(NotComplex) - 0.785398163397448 + 2i");
is_approx(sec(NotComplex.new(2.35619449019234 + 2i), Radians), -0.194833118740758 + 0.187824499970067i, "sec(NotComplex, Radians) - 2.35619449019234 + 2i");
is_approx(sec(:x(NotComplex.new(3.14159265358979 + 2i))), -0.26580222883408 + -7.46779534503383e-12i, "sec(:x(NotComplex)) - 3.14159265358979 + 2i");
is_approx(sec(:x(NotComplex.new(225 + 114.591559026165i)), :base(Degrees)), -0.194833118730234 + -0.187824499981816i, "sec(:x(NotComplex), :base(Degrees)) - 225 + 114.591559026165i");

# DifferentReal tests
is_approx(DifferentReal.new(5.23598775603156).sec, 1.99999999983174, "DifferentReal.sec - 5.23598775603156");
is_approx(DifferentReal.new(550).sec(Gradians), -1.41421356225975, "DifferentReal.sec(Gradians) - 550");
is_approx(DifferentReal.new(-0.875).sec(:base(Circles)), 1.41421356230097, "DifferentReal.sec(:base(Circles)) - -0.875");
is_approx(sec(DifferentReal.new(-2.09439510241262)), -1.9999999999327, "sec(DifferentReal) - -2.09439510241262");
is_approx(sec(DifferentReal.new(-1.04719755120631), Radians), 2.00000000003365, "sec(DifferentReal, Radians) - -1.04719755120631");
is_approx(sec(:x(DifferentReal.new(-0.785398163404734))), 1.4142135623834, "sec(:x(DifferentReal)) - -0.785398163404734");
is_approx(sec(:x(DifferentReal.new(0)), :base(Degrees)), 1, "sec(:x(DifferentReal), :base(Degrees)) - 0");

# Int tests
is_approx((45).Int.sec(:base(Degrees)), 1.4142135623834, "Int.sec(:base(Degrees)) - 45");
is_approx(sec((135).Int, Degrees), -1.41421356234218, "sec(Int, Degrees) - 135");
is_approx(sec(:x((200).Int), :base(Gradians)), -1, "sec(:x(Int), :base(Gradians)) - 200");

# asec tests

for TrigTest::cosines() -> $angle
{
    next if abs(cos($angle.num(Radians))) < 1e-6;
    my $desired-result = 1.0 / cos($angle.num(Radians));

    # Num.asec tests -- thorough
    is_approx($desired-result.Num.asec.sec, $desired-result, 
              "Num.asec - {$angle.num(Radians)} default");
    for TrigTest::official_bases() -> $base {
        is_approx($desired-result.Num.asec($base).sec($base), $desired-result,
                  "Num.asec - {$angle.num($base)} $base");
    }
    
    # Num.asec(Complex) tests -- thorough
    for ($desired-result + 0i, $desired-result + .5i, $desired-result + 2i) -> $z {
        is_approx(sec(asec($z)), $z, 
                  "asec(Complex) - {$angle.num(Radians)} default");
        is_approx($z.asec.sec, $z, 
                  "Complex.asec - {$angle.num(Radians)} default");
        for TrigTest::official_bases() -> $base {
            is_approx($z.asec($base).sec($base), $z, 
                      "Complex.asec - {$angle.num($base)} $base");
        }
    }
}
        
# Num tests
is_approx((1.4142135623834).Num.asec(:base(Radians)), 0.785398163404734, "Num.asec(:base(Radians)) - 0.785398163404734");
is_approx(asec((1.4142135623834).Num), 0.785398163404734, "asec(Num) - 0.785398163404734");
is_approx(asec((1.4142135623834).Num, Degrees), 45, "asec(Num, Degrees) - 45");
is_approx(asec(:x((1.4142135623834).Num)), 0.785398163404734, "asec(:x(Num)) - 0.785398163404734");
is_approx(asec(:x((1.4142135623834).Num), :base(Gradians)), 50, "asec(:x(Num), :base(Gradians)) - 50");

# Rat tests
is_approx(((1.4142135623834).Rat(1e-9)).asec, 0.785398163404734, "Rat.asec - 0.785398163404734");
is_approx((1.4142135623834).Rat(1e-9).asec(Circles), 0.125, "Rat.asec(Circles) - 0.125");
is_approx((1.4142135623834).Rat(1e-9).asec(:base(Radians)), 0.785398163404734, "Rat.asec(:base(Radians)) - 0.785398163404734");
is_approx(asec((1.4142135623834).Rat(1e-9)), 0.785398163404734, "asec(Rat) - 0.785398163404734");
is_approx(asec((1.4142135623834).Rat(1e-9), Degrees), 45, "asec(Rat, Degrees) - 45");
is_approx(asec(:x((1.4142135623834).Rat(1e-9))), 0.785398163404734, "asec(:x(Rat)) - 0.785398163404734");
is_approx(asec(:x((1.4142135623834).Rat(1e-9)), :base(Gradians)), 50, "asec(:x(Rat), :base(Gradians)) - 50");

# Complex tests
is_approx((0.785398163404734 + 2i).Complex.asec(:base(Circles)), 0.225103444228091 + 0.0677341793491909i, "Complex.asec(:base(Circles)) - 0.225103444228091 + 0.0677341793491909i");
is_approx(asec((0.785398163404734 + 2i).Complex), 1.41436665336946 + 0.425586400480703i, "asec(Complex) - 1.41436665336946 + 0.425586400480703i");
is_approx(asec((0.785398163404734 + 2i).Complex, Radians), 1.41436665336946 + 0.425586400480703i, "asec(Complex, Radians) - 1.41436665336946 + 0.425586400480703i");
is_approx(asec(:x((0.785398163404734 + 2i).Complex)), 1.41436665336946 + 0.425586400480703i, "asec(:x(Complex)) - 1.41436665336946 + 0.425586400480703i");
is_approx(asec(:x((0.785398163404734 + 2i).Complex), :base(Degrees)), 81.0372399221129 + 24.3843045657087i, "asec(:x(Complex), :base(Degrees)) - 81.0372399221129 + 24.3843045657087i");

# Str tests
is_approx(((1.4142135623834).Str).asec, 0.785398163404734, "Str.asec - 0.785398163404734");
is_approx((1.4142135623834).Str.asec(Gradians), 50, "Str.asec(Gradians) - 50");
is_approx((1.4142135623834).Str.asec(:base(Circles)), 0.125, "Str.asec(:base(Circles)) - 0.125");
is_approx(asec((1.4142135623834).Str), 0.785398163404734, "asec(Str) - 0.785398163404734");
is_approx(asec((1.4142135623834).Str, Radians), 0.785398163404734, "asec(Str, Radians) - 0.785398163404734");
is_approx(asec(:x((1.4142135623834).Str)), 0.785398163404734, "asec(:x(Str)) - 0.785398163404734");
is_approx(asec(:x((1.4142135623834).Str), :base(Degrees)), 45, "asec(:x(Str), :base(Degrees)) - 45");

# NotComplex tests
is_approx((NotComplex.new(0.785398163404734 + 2i)).asec, 1.41436665336946 + 0.425586400480703i, "NotComplex.asec - 1.41436665336946 + 0.425586400480703i");
is_approx(NotComplex.new(0.785398163404734 + 2i).asec(Gradians), 90.0413776912366 + 27.0936717396764i, "NotComplex.asec(Gradians) - 90.0413776912366 + 27.0936717396764i");
is_approx(NotComplex.new(0.785398163404734 + 2i).asec(:base(Circles)), 0.225103444228091 + 0.0677341793491909i, "NotComplex.asec(:base(Circles)) - 0.225103444228091 + 0.0677341793491909i");
is_approx(asec(NotComplex.new(0.785398163404734 + 2i)), 1.41436665336946 + 0.425586400480703i, "asec(NotComplex) - 1.41436665336946 + 0.425586400480703i");
is_approx(asec(NotComplex.new(0.785398163404734 + 2i), Radians), 1.41436665336946 + 0.425586400480703i, "asec(NotComplex, Radians) - 1.41436665336946 + 0.425586400480703i");
is_approx(asec(:x(NotComplex.new(0.785398163404734 + 2i))), 1.41436665336946 + 0.425586400480703i, "asec(:x(NotComplex)) - 1.41436665336946 + 0.425586400480703i");
is_approx(asec(:x(NotComplex.new(0.785398163404734 + 2i)), :base(Degrees)), 81.0372399221129 + 24.3843045657087i, "asec(:x(NotComplex), :base(Degrees)) - 81.0372399221129 + 24.3843045657087i");

# DifferentReal tests
is_approx((DifferentReal.new(1.4142135623834)).asec, 0.785398163404734, "DifferentReal.asec - 0.785398163404734");
is_approx(DifferentReal.new(1.4142135623834).asec(Gradians), 50, "DifferentReal.asec(Gradians) - 50");
is_approx(DifferentReal.new(1.4142135623834).asec(:base(Circles)), 0.125, "DifferentReal.asec(:base(Circles)) - 0.125");
is_approx(asec(DifferentReal.new(1.4142135623834)), 0.785398163404734, "asec(DifferentReal) - 0.785398163404734");
is_approx(asec(DifferentReal.new(1.4142135623834), Radians), 0.785398163404734, "asec(DifferentReal, Radians) - 0.785398163404734");
is_approx(asec(:x(DifferentReal.new(1.4142135623834))), 0.785398163404734, "asec(:x(DifferentReal)) - 0.785398163404734");
is_approx(asec(:x(DifferentReal.new(1.4142135623834)), :base(Degrees)), 45, "asec(:x(DifferentReal), :base(Degrees)) - 45");

done_testing;

# vim: ft=perl6 nomodifiable
