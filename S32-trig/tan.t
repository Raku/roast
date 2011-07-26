# WARNING:
# This is a generated file and should not be edited directly.
# look into generate-tests.pl instead

use v6;
use Test;
BEGIN { @*INC.push("t/spec/packages/") };
use TrigTestSupport;


# tan tests

my $iter_count = 0;
for TrigTest::sines() -> $angle
{
    next if abs(cos($angle.num())) < 1e-6;
    my $desired-result = sin($angle.num()) / cos($angle.num());

    # Num.tan tests -- very thorough
    is_approx($angle.num().tan, $desired-result, 
              "Num.tan - {$angle.num()}");

    # Complex.tan tests -- also very thorough
    my Complex $zp0 = $angle.num + 0.0i;
    my Complex $sz0 = $desired-result + 0i;
    my Complex $zp1 = $angle.num + 1.0i;
    my Complex $sz1 = { sin($_) / cos($_) }($zp1);
    my Complex $zp2 = $angle.num + 2.0i;
    my Complex $sz2 = { sin($_) / cos($_) }($zp2);
    
    is_approx($zp0.tan, $sz0, "Complex.tan - $zp0");
    is_approx($zp1.tan, $sz1, "Complex.tan - $zp1");
    is_approx($zp2.tan, $sz2, "Complex.tan - $zp2");
}

is(tan(Inf), NaN, "tan(Inf) -");
is(tan(-Inf), NaN, "tan(-Inf) -");
        
# Num tests
is_approx(tan((-6.28318530723787).Num), -5.82864638634609e-11, "tan(Num) - -6.28318530723787");
is_approx(tan(:x((-3.92699081702367).Num)), -1.00000000007286, "tan(:x(Num)) - -3.92699081702367");

# Rat tests
is_approx((-0.523598775603156).Rat(1e-9).tan, -0.577350269196102, "Rat.tan - -0.523598775603156");
is_approx(tan((0).Rat(1e-9)), 0, "tan(Rat) - 0");
is_approx(tan(:x((0.523598775603156).Rat(1e-9))), 0.577350269196102, "tan(:x(Rat)) - 0.523598775603156");

# Complex tests
is_approx(tan((0.785398163404734 + 2i).Complex), 0.036618993473706 + 0.9993292997396i, "tan(Complex) - 0.785398163404734 + 2i");
is_approx(tan(:x((2.3561944902142 + 2i).Complex)), -0.0366189934736279 + 0.999329299737467i, "tan(:x(Complex)) - 2.3561944902142 + 2i");

# Str tests
is_approx((3.14159265361894).Str.tan, 2.91432319317304e-11, "Str.tan - 3.14159265361894");
is_approx(tan((3.92699081702367).Str), 1.00000000007286, "tan(Str) - 3.92699081702367");
is_approx(tan(:x((5.49778714383314).Str)), -0.999999999897998, "tan(:x(Str)) - 5.49778714383314");

{
    # NotComplex tests

    class NotComplex is Cool {
        has $.value;

        multi method new(Complex $value is copy) {
            self.bless(*, :$value);
        }

        multi method Numeric() {
            self.value;
        }
    }

    is_approx(NotComplex.new(6.28318530723787 + 2i).tan, 4.11798674972768e-12 + 0.964027580075817i, "NotComplex.tan - 6.28318530723787 + 2i");
    is_approx(tan(NotComplex.new(6.80678408284103 + 2i)), 0.0311427701629906 + 0.9813610723904i, "tan(NotComplex) - 6.80678408284103 + 2i");
    is_approx(tan(:x(NotComplex.new(10.2101761242615 + 2i))), 0.0366189934739407 + 0.999329299745999i, "tan(:x(NotComplex)) - 10.2101761242615 + 2i");
}

{
    # DifferentReal tests

    class DifferentReal is Real {
        has $.value;

        multi method new($value is copy) {
            self.bless(*, :$value);
        }

        multi method Bridge() {
            self.value;
        }
    }            

    is_approx(DifferentReal.new(12.5663706144757).tan, 1.16572927726922e-10, "DifferentReal.tan - 12.5663706144757");
    is_approx(tan(DifferentReal.new(-6.28318530723787)), -5.82864638634609e-11, "tan(DifferentReal) - -6.28318530723787");
    is_approx(tan(:x(DifferentReal.new(-3.92699081702367))), -1.00000000007286, "tan(:x(DifferentReal)) - -3.92699081702367");
}


# atan tests

for TrigTest::sines() -> $angle
{
    next if abs(cos($angle.num())) < 1e-6;
    my $desired-result = sin($angle.num()) / cos($angle.num());

    # Num.atan tests -- thorough
    is_approx($desired-result.Num.atan.tan, $desired-result, 
              "Num.atan - {$angle.num()}");
    
    # Num.atan(Complex) tests -- thorough
    for ($desired-result + 0i, $desired-result + .5i, $desired-result + 2i) -> $z {
        is_approx(tan(atan($z)), $z, 
                  "atan(Complex) - {$angle.num()}");
        is_approx($z.atan.tan, $z, 
                  "Complex.atan - {$angle.num()}");
    }
}
        
# Num tests
is_approx(atan((0.577350269196102).Num), 0.523598775603156, "atan(Num) - 0.523598775603156");
is_approx(atan(:x((1.00000000001457).Num)), 0.785398163404734, "atan(:x(Num)) - 0.785398163404734");

# Rat tests
is_approx(((0.577350269196102).Rat(1e-9)).atan, 0.523598775603156, "Rat.atan - 0.523598775603156");
is_approx(atan((1.00000000001457).Rat(1e-9)), 0.785398163404734, "atan(Rat) - 0.785398163404734");
is_approx(atan(:x((0.577350269196102).Rat(1e-9))), 0.523598775603156, "atan(:x(Rat)) - 0.523598775603156");

# Complex tests
is_approx(atan((0.785398163404734 + 2i).Complex), 1.36593583676998 + 0.445759203696597i, "atan(Complex) - 1.36593583676998 + 0.445759203696597i");
is_approx(atan(:x((0.523598775603156 + 2i).Complex)), 1.41601859067084 + 0.496236956634457i, "atan(:x(Complex)) - 1.41601859067084 + 0.496236956634457i");

# Str tests
is_approx(((1.00000000001457).Str).atan, 0.785398163404734, "Str.atan - 0.785398163404734");
is_approx(atan((0.577350269196102).Str), 0.523598775603156, "atan(Str) - 0.523598775603156");
is_approx(atan(:x((1.00000000001457).Str)), 0.785398163404734, "atan(:x(Str)) - 0.785398163404734");

# NotComplex tests
is_approx((NotComplex.new(0.523598775603156 + 2i)).atan, 1.41601859067084 + 0.496236956634457i, "NotComplex.atan - 1.41601859067084 + 0.496236956634457i");
is_approx(atan(NotComplex.new(0.785398163404734 + 2i)), 1.36593583676998 + 0.445759203696597i, "atan(NotComplex) - 1.36593583676998 + 0.445759203696597i");
is_approx(atan(:x(NotComplex.new(0.523598775603156 + 2i))), 1.41601859067084 + 0.496236956634457i, "atan(:x(NotComplex)) - 1.41601859067084 + 0.496236956634457i");

# DifferentReal tests
is_approx((DifferentReal.new(1.00000000001457)).atan, 0.785398163404734, "DifferentReal.atan - 0.785398163404734");
is_approx(atan(DifferentReal.new(0.577350269196102)), 0.523598775603156, "atan(DifferentReal) - 0.523598775603156");
is_approx(atan(:x(DifferentReal.new(1.00000000001457))), 0.785398163404734, "atan(:x(DifferentReal)) - 0.785398163404734");

done;

# vim: ft=perl6 nomodifiable
