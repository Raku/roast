# WARNING:
# This is a generated file and should not be edited directly.
# look into generate-tests.pl instead

use v6;
use Test;
BEGIN { @*INC.push("t/spec/packages/") };
use TrigTestSupport;


# tan tests

my $base_list = (TrigTest::official_bases() xx *).flat;
my $iter_count = 0;
for TrigTest::sines() -> $angle
{
    next if abs(cos($angle.num(Radians))) < 1e-6;
    my $desired-result = sin($angle.num(Radians)) / cos($angle.num(Radians));

    # Num.tan tests -- very thorough
    is_approx($angle.num(Radians).tan, $desired-result, 
              "Num.tan - {$angle.num(Radians)} default");
    for TrigTest::official_bases() -> $base {
        is_approx($angle.num($base).tan($base), $desired-result, 
                  "Num.tan - {$angle.num($base)} $base");
    }

    # Complex.tan tests -- also very thorough
    my Complex $zp0 = $angle.complex(0.0, Radians);
    my Complex $sz0 = $desired-result + 0i;
    my Complex $zp1 = $angle.complex(1.0, Radians);
    my Complex $sz1 = { sin($_) / cos($_) }($zp1);
    my Complex $zp2 = $angle.complex(2.0, Radians);
    my Complex $sz2 = { sin($_) / cos($_) }($zp2);
    
    is_approx($zp0.tan, $sz0, "Complex.tan - $zp0 default");
    is_approx($zp1.tan, $sz1, "Complex.tan - $zp1 default");
    is_approx($zp2.tan, $sz2, "Complex.tan - $zp2 default");
    
    for TrigTest::official_bases() -> $base {
        my Complex $z = $angle.complex(0.0, $base);
        is_approx($z.tan($base), $sz0, "Complex.tan - $z $base");
    
        $z = $angle.complex(1.0, $base);
        is_approx($z.tan($base), $sz1, "Complex.tan - $z $base");
    
        $z = $angle.complex(2.0, $base);
        is_approx($z.tan($base), $sz2, "Complex.tan - $z $base");
    }
}

is(tan(Inf), NaN, "tan(Inf) - default");
is(tan(-Inf), NaN, "tan(-Inf) - default");
given $base_list.shift
{
    is(tan(Inf,  $_), NaN, "tan(Inf) - $_");
    is(tan(-Inf, $_), NaN, "tan(-Inf) - $_");
}
        
# Num tests
is_approx((-6.28318530723787).Num.tan(:base(Radians)), -5.82873520418806e-11, "Num.tan(:base(Radians)) - -6.28318530723787");
is_approx(tan((-3.92699081702367).Num), -1.00000000007286, "tan(Num) - -3.92699081702367");
is_approx(tan((-30).Num, Degrees), -0.577350269196102, "tan(Num, Degrees) - -30");
is_approx(tan(:x((0).Num)), 0, "tan(:x(Num)) - 0");
is_approx(tan(:x((33.3333333333333).Num), :base(Gradians)), 0.577350269196102, "tan(:x(Num), :base(Gradians)) - 33.3333333333333");

# Rat tests
is_approx((0.785398163404734).Rat(1e-9).tan, 1.00000000001457, "Rat.tan - 0.785398163404734");
is_approx((0.375).Rat(1e-9).tan(Circles), -0.999999999956285, "Rat.tan(Circles) - 0.375");
is_approx((3.14159265361894).Rat(1e-9).tan(:base(Radians)), 2.91436760209403e-11, "Rat.tan(:base(Radians)) - 3.14159265361894");
is_approx(tan((3.92699081702367).Rat(1e-9)), 1.00000000007286, "tan(Rat) - 3.92699081702367");
is_approx(tan((315).Rat(1e-9), Degrees), -0.999999999897998, "tan(Rat, Degrees) - 315");
is_approx(tan(:x((6.28318530723787).Rat(1e-9))), 5.82873520418806e-11, "tan(:x(Rat)) - 6.28318530723787");
is_approx(tan(:x((433.333333333333).Rat(1e-9)), :base(Gradians)), 0.577350269273818, "tan(:x(Rat), :base(Gradians)) - 433.333333333333");

# Complex tests
is_approx((1.625 + 0.318309886183791i).Complex.tan(:base(Circles)), 0.0366189934739407 + 0.999329299745999i, "Complex.tan(:base(Circles)) - 1.625 + 0.318309886183791i");
is_approx(tan((12.5663706143592 + 2i).Complex), 8.23609900053128e-12 + 0.964027580075817i, "tan(Complex) - 12.5663706143592 + 2i");
is_approx(tan((-6.28318530717959 + 2i).Complex, Radians), -4.11804950026564e-12 + 0.964027580075817i, "tan(Complex, Radians) - -6.28318530717959 + 2i");
is_approx(tan(:x((-3.92699081698724 + 2i).Complex)), -0.0366189934737844 + 0.999329299741733i, "tan(:x(Complex)) - -3.92699081698724 + 2i");
is_approx(tan(:x((-30 + 114.591559026165i).Complex), :base(Degrees)), -0.0311427701607815 + 0.981361072386838i, "tan(:x(Complex), :base(Degrees)) - -30 + 114.591559026165i");

# Str tests
is_approx((0).Str.tan, 0, "Str.tan - 0");
is_approx((33.3333333333333).Str.tan(Gradians), 0.577350269196102, "Str.tan(Gradians) - 33.3333333333333");
is_approx((0.125).Str.tan(:base(Circles)), 1.00000000001457, "Str.tan(:base(Circles)) - 0.125");
is_approx(tan((2.3561944902142).Str), -0.999999999956285, "tan(Str) - 2.3561944902142");
is_approx(tan((3.14159265361894).Str, Radians), 2.91436760209403e-11, "tan(Str, Radians) - 3.14159265361894");
is_approx(tan(:x((3.92699081702367).Str)), 1.00000000007286, "tan(:x(Str)) - 3.92699081702367");
is_approx(tan(:x((315).Str), :base(Degrees)), -0.999999999897998, "tan(:x(Str), :base(Degrees)) - 315");

# NotComplex tests
is_approx(NotComplex.new(6.28318530717959 + 2i).tan, 4.11804950026564e-12 + 0.964027580075817i, "NotComplex.tan - 6.28318530717959 + 2i");
is_approx(NotComplex.new(433.333333333333 + 127.323954473516i).tan(Gradians), 0.0311427701629906 + 0.9813610723904i, "NotComplex.tan(Gradians) - 433.333333333333 + 127.323954473516i");
is_approx(NotComplex.new(1.625 + 0.318309886183791i).tan(:base(Circles)), 0.0366189934739407 + 0.999329299745999i, "NotComplex.tan(:base(Circles)) - 1.625 + 0.318309886183791i");
is_approx(tan(NotComplex.new(12.5663706143592 + 2i)), 8.23609900053128e-12 + 0.964027580075817i, "tan(NotComplex) - 12.5663706143592 + 2i");
is_approx(tan(NotComplex.new(-6.28318530717959 + 2i), Radians), -4.11804950026564e-12 + 0.964027580075817i, "tan(NotComplex, Radians) - -6.28318530717959 + 2i");
is_approx(tan(:x(NotComplex.new(-3.92699081698724 + 2i))), -0.0366189934737844 + 0.999329299741733i, "tan(:x(NotComplex)) - -3.92699081698724 + 2i");
is_approx(tan(:x(NotComplex.new(-30 + 114.591559026165i)), :base(Degrees)), -0.0311427701607815 + 0.981361072386838i, "tan(:x(NotComplex), :base(Degrees)) - -30 + 114.591559026165i");

# DifferentReal tests
is_approx(DifferentReal.new(0).tan, 0, "DifferentReal.tan - 0");
is_approx(DifferentReal.new(33.3333333333333).tan(Gradians), 0.577350269196102, "DifferentReal.tan(Gradians) - 33.3333333333333");
is_approx(DifferentReal.new(0.125).tan(:base(Circles)), 1.00000000001457, "DifferentReal.tan(:base(Circles)) - 0.125");
is_approx(tan(DifferentReal.new(2.3561944902142)), -0.999999999956285, "tan(DifferentReal) - 2.3561944902142");
is_approx(tan(DifferentReal.new(3.14159265361894), Radians), 2.91436760209403e-11, "tan(DifferentReal, Radians) - 3.14159265361894");
is_approx(tan(:x(DifferentReal.new(3.92699081702367))), 1.00000000007286, "tan(:x(DifferentReal)) - 3.92699081702367");
is_approx(tan(:x(DifferentReal.new(315)), :base(Degrees)), -0.999999999897998, "tan(:x(DifferentReal), :base(Degrees)) - 315");

# Int tests
is_approx((360).Int.tan(:base(Degrees)), 5.82873520418806e-11, "Int.tan(:base(Degrees)) - 360");
is_approx(tan((390).Int, Degrees), 0.577350269273818, "tan(Int, Degrees) - 390");
is_approx(tan(:x((650).Int), :base(Gradians)), 1.00000000018943, "tan(:x(Int), :base(Gradians)) - 650");

# atan tests

for TrigTest::sines() -> $angle
{
    next if abs(cos($angle.num(Radians))) < 1e-6;
    my $desired-result = sin($angle.num(Radians)) / cos($angle.num(Radians));

    # Num.atan tests -- thorough
    is_approx($desired-result.Num.atan.tan, $desired-result, 
              "Num.atan - {$angle.num(Radians)} default");
    for TrigTest::official_bases() -> $base {
        is_approx($desired-result.Num.atan($base).tan($base), $desired-result,
                  "Num.atan - {$angle.num($base)} $base");
    }
    
    # Num.atan(Complex) tests -- thorough
    for ($desired-result + 0i, $desired-result + .5i, $desired-result + 2i) -> $z {
        is_approx(tan(atan($z)), $z, 
                  "atan(Complex) - {$angle.num(Radians)} default");
        is_approx($z.atan.tan, $z, 
                  "Complex.atan - {$angle.num(Radians)} default");
        for TrigTest::official_bases() -> $base {
            is_approx($z.atan($base).tan($base), $z, 
                      "Complex.atan - {$angle.num($base)} $base");
        }
    }
}
        
# Num tests
is_approx((0.577350269196102).Num.atan(:base(Radians)), 0.523598775603156, "Num.atan(:base(Radians)) - 0.523598775603156");
is_approx(atan((1.00000000001457).Num), 0.785398163404734, "atan(Num) - 0.785398163404734");
is_approx(atan((0.577350269196102).Num, Degrees), 30, "atan(Num, Degrees) - 30");
is_approx(atan(:x((1.00000000001457).Num)), 0.785398163404734, "atan(:x(Num)) - 0.785398163404734");
is_approx(atan(:x((0.577350269196102).Num), :base(Gradians)), 33.3333333333333, "atan(:x(Num), :base(Gradians)) - 33.3333333333333");

# Rat tests
is_approx(((1.00000000001457).Rat(1e-9)).atan, 0.785398163404734, "Rat.atan - 0.785398163404734");
is_approx((0.577350269196102).Rat(1e-9).atan(Circles), 0.0833333333333333, "Rat.atan(Circles) - 0.0833333333333333");
is_approx((1.00000000001457).Rat(1e-9).atan(:base(Radians)), 0.785398163404734, "Rat.atan(:base(Radians)) - 0.785398163404734");
is_approx(atan((0.577350269196102).Rat(1e-9)), 0.523598775603156, "atan(Rat) - 0.523598775603156");
is_approx(atan((1.00000000001457).Rat(1e-9), Degrees), 45, "atan(Rat, Degrees) - 45");
is_approx(atan(:x((0.577350269196102).Rat(1e-9))), 0.523598775603156, "atan(:x(Rat)) - 0.523598775603156");
is_approx(atan(:x((1.00000000001457).Rat(1e-9)), :base(Gradians)), 50, "atan(:x(Rat), :base(Gradians)) - 50");

# Complex tests
is_approx((0.523598775603156 + 2i).Complex.atan(:base(Circles)), 0.225366358215284 + 0.0789785645932523i, "Complex.atan(:base(Circles)) - 0.225366358215284 + 0.0789785645932523i");
is_approx(atan((0.785398163404734 + 2i).Complex), 1.36593583676998 + 0.445759203696597i, "atan(Complex) - 1.36593583676998 + 0.445759203696597i");
is_approx(atan((0.523598775603156 + 2i).Complex, Radians), 1.41601859067084 + 0.496236956634457i, "atan(Complex, Radians) - 1.41601859067084 + 0.496236956634457i");
is_approx(atan(:x((0.785398163404734 + 2i).Complex)), 1.36593583676998 + 0.445759203696597i, "atan(:x(Complex)) - 1.36593583676998 + 0.445759203696597i");
is_approx(atan(:x((0.523598775603156 + 2i).Complex), :base(Degrees)), 81.1318889575022 + 28.4322832535708i, "atan(:x(Complex), :base(Degrees)) - 81.1318889575022 + 28.4322832535708i");

# Str tests
is_approx(((1.00000000001457).Str).atan, 0.785398163404734, "Str.atan - 0.785398163404734");
is_approx((0.577350269196102).Str.atan(Gradians), 33.3333333333333, "Str.atan(Gradians) - 33.3333333333333");
is_approx((1.00000000001457).Str.atan(:base(Circles)), 0.125, "Str.atan(:base(Circles)) - 0.125");
is_approx(atan((0.577350269196102).Str), 0.523598775603156, "atan(Str) - 0.523598775603156");
is_approx(atan((1.00000000001457).Str, Radians), 0.785398163404734, "atan(Str, Radians) - 0.785398163404734");
is_approx(atan(:x((0.577350269196102).Str)), 0.523598775603156, "atan(:x(Str)) - 0.523598775603156");
is_approx(atan(:x((1.00000000001457).Str), :base(Degrees)), 45, "atan(:x(Str), :base(Degrees)) - 45");

# NotComplex tests
is_approx((NotComplex.new(0.523598775603156 + 2i)).atan, 1.41601859067084 + 0.496236956634457i, "NotComplex.atan - 1.41601859067084 + 0.496236956634457i");
is_approx(NotComplex.new(0.785398163404734 + 2i).atan(Gradians), 86.9581761473227 + 28.3779122788082i, "NotComplex.atan(Gradians) - 86.9581761473227 + 28.3779122788082i");
is_approx(NotComplex.new(0.523598775603156 + 2i).atan(:base(Circles)), 0.225366358215284 + 0.0789785645932523i, "NotComplex.atan(:base(Circles)) - 0.225366358215284 + 0.0789785645932523i");
is_approx(atan(NotComplex.new(0.785398163404734 + 2i)), 1.36593583676998 + 0.445759203696597i, "atan(NotComplex) - 1.36593583676998 + 0.445759203696597i");
is_approx(atan(NotComplex.new(0.523598775603156 + 2i), Radians), 1.41601859067084 + 0.496236956634457i, "atan(NotComplex, Radians) - 1.41601859067084 + 0.496236956634457i");
is_approx(atan(:x(NotComplex.new(0.785398163404734 + 2i))), 1.36593583676998 + 0.445759203696597i, "atan(:x(NotComplex)) - 1.36593583676998 + 0.445759203696597i");
is_approx(atan(:x(NotComplex.new(0.523598775603156 + 2i)), :base(Degrees)), 81.1318889575022 + 28.4322832535708i, "atan(:x(NotComplex), :base(Degrees)) - 81.1318889575022 + 28.4322832535708i");

# DifferentReal tests
is_approx((DifferentReal.new(1.00000000001457)).atan, 0.785398163404734, "DifferentReal.atan - 0.785398163404734");
is_approx(DifferentReal.new(0.577350269196102).atan(Gradians), 33.3333333333333, "DifferentReal.atan(Gradians) - 33.3333333333333");
is_approx(DifferentReal.new(1.00000000001457).atan(:base(Circles)), 0.125, "DifferentReal.atan(:base(Circles)) - 0.125");
is_approx(atan(DifferentReal.new(0.577350269196102)), 0.523598775603156, "atan(DifferentReal) - 0.523598775603156");
is_approx(atan(DifferentReal.new(1.00000000001457), Radians), 0.785398163404734, "atan(DifferentReal, Radians) - 0.785398163404734");
is_approx(atan(:x(DifferentReal.new(0.577350269196102))), 0.523598775603156, "atan(:x(DifferentReal)) - 0.523598775603156");
is_approx(atan(:x(DifferentReal.new(1.00000000001457)), :base(Degrees)), 45, "atan(:x(DifferentReal), :base(Degrees)) - 45");

done_testing;

# vim: ft=perl6 nomodifiable
