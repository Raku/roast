# WARNING:
# This is a generated file and should not be edited directly.
# look into generate-tests.pl instead

use v6;
use Test;
BEGIN { @*INC.push("t/spec/packages/") };
use TrigTestSupport;


# tanh tests

my $iter_count = 0;
for TrigTest::sines() -> $angle
{
    next if abs(cosh($angle.num())) < 1e-6;
    my $desired-result = sinh($angle.num()) / cosh($angle.num());

    # Num.tanh tests -- very thorough
    is_approx($angle.num().tanh, $desired-result, 
              "Num.tanh - {$angle.num()}");

    # Complex.tanh tests -- also very thorough
    my Complex $zp0 = $angle.num + 0.0i;
    my Complex $sz0 = $desired-result + 0i;
    my Complex $zp1 = $angle.num + 1.0i;
    my Complex $sz1 = { sinh($_) / cosh($_) }($zp1);
    my Complex $zp2 = $angle.num + 2.0i;
    my Complex $sz2 = { sinh($_) / cosh($_) }($zp2);
    
    is_approx($zp0.tanh, $sz0, "Complex.tanh - $zp0");
    is_approx($zp1.tanh, $sz1, "Complex.tanh - $zp1");
    is_approx($zp2.tanh, $sz2, "Complex.tanh - $zp2");
}

is(tanh(Inf), 1, "tanh(Inf) -");
is(tanh(-Inf), -1, "tanh(-Inf) -");
        
# Num tests
is_approx(tanh((-6.28318530723787).Num), -0.999993025339611, "tanh(Num) - -6.28318530723787");
is_approx(tanh(:x((-3.92699081702367).Num)), -0.999223894878698, "tanh(:x(Num)) - -3.92699081702367");

# Rat tests
is_approx((-0.523598775603156).Rat(1e-9).tanh, -0.480472778160188, "Rat.tanh - -0.523598775603156");
is_approx(tanh((0).Rat(1e-9)), 0, "tanh(Rat) - 0");
is_approx(tanh(:x((0.523598775603156).Rat(1e-9))), 0.480472778160188, "tanh(:x(Rat)) - 0.523598775603156");

# Complex tests
is_approx(tanh((0.785398163404734 + 2i).Complex), 1.24023479948939 - 0.407862181685885i, "tanh(Complex) - 0.785398163404734 + 2i");
is_approx(tanh(:x((1.57079632680947 + 2i).Complex)), 1.05580658455051 - 0.0691882492979498i, "tanh(:x(Complex)) - 1.57079632680947 + 2i");

# Str tests
is_approx((2.3561944902142).Str.tanh, 0.98219338000801, "Str.tanh - 2.3561944902142");
is_approx(tanh((3.14159265361894).Str), 0.996272076220967, "tanh(Str) - 3.14159265361894");
is_approx(tanh(:x((3.92699081702367).Str)), 0.999223894878698, "tanh(:x(Str)) - 3.92699081702367");

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

    is_approx(NotComplex.new(4.7123889804284 + 2i).tanh, 1.00010549555372 - 0.0001221600793053i, "NotComplex.tanh - 4.7123889804284 + 2i");
    is_approx(tanh(NotComplex.new(5.49778714383314 + 2i)), 1.00002193068325 - 2.53924635030599e-05i, "tanh(NotComplex) - 5.49778714383314 + 2i");
    is_approx(tanh(:x(NotComplex.new(6.28318530723787 + 2i))), 1.00000455895463 - 5.27848285809169e-06i, "tanh(:x(NotComplex)) - 6.28318530723787 + 2i");
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

    is_approx(DifferentReal.new(6.80678408284103).tanh, 0.999997552447981, "DifferentReal.tanh - 6.80678408284103");
    is_approx(tanh(DifferentReal.new(10.2101761242615)), 0.999999997292405, "tanh(DifferentReal) - 10.2101761242615");
    is_approx(tanh(:x(DifferentReal.new(12.5663706144757))), 0.999999999975677, "tanh(:x(DifferentReal)) - 12.5663706144757");
}


# atanh tests

for TrigTest::sines() -> $angle
{
    next if abs(cosh($angle.num())) < 1e-6;
    my $desired-result = sinh($angle.num()) / cosh($angle.num());

    # Num.atanh tests -- thorough
    is_approx($desired-result.Num.atanh.tanh, $desired-result, 
              "Num.atanh - {$angle.num()}");
    
    # Num.atanh(Complex) tests -- thorough
    for ($desired-result + 0i, $desired-result + .5i, $desired-result + 2i) -> $z {
        is_approx(tanh(atanh($z)), $z, 
                  "atanh(Complex) - {$angle.num()}");
        is_approx($z.atanh.tanh, $z, 
                  "Complex.atanh - {$angle.num()}");
    }
}
        
# Num tests
is_approx(atanh((0.480472778160188).Num), 0.523598775603156, "atanh(Num) - 0.523598775603156");
is_approx(atanh(:x((0.655794202636825).Num)), 0.785398163404734, "atanh(:x(Num)) - 0.785398163404734");

# Rat tests
is_approx(((0.480472778160188).Rat(1e-9)).atanh, 0.523598775603156, "Rat.atanh - 0.523598775603156");
is_approx(atanh((0.655794202636825).Rat(1e-9)), 0.785398163404734, "atanh(Rat) - 0.785398163404734");
is_approx(atanh(:x((0.480472778160188).Rat(1e-9))), 0.523598775603156, "atanh(:x(Rat)) - 0.523598775603156");

# Complex tests
is_approx(atanh((0.785398163404734 + 2i).Complex), 0.143655432578432 + 1.15296697280152i, "atanh(Complex) - 0.143655432578432 + 1.15296697280152i");
is_approx(atanh(:x((0.523598775603156 + 2i).Complex)), 0.100612672097949 + 1.12836985373239i, "atanh(:x(Complex)) - 0.100612672097949 + 1.12836985373239i");

# Str tests
is_approx(((0.655794202636825).Str).atanh, 0.785398163404734, "Str.atanh - 0.785398163404734");
is_approx(atanh((0.480472778160188).Str), 0.523598775603156, "atanh(Str) - 0.523598775603156");
is_approx(atanh(:x((0.655794202636825).Str)), 0.785398163404734, "atanh(:x(Str)) - 0.785398163404734");

# NotComplex tests
is_approx((NotComplex.new(0.523598775603156 + 2i)).atanh, 0.100612672097949 + 1.12836985373239i, "NotComplex.atanh - 0.100612672097949 + 1.12836985373239i");
is_approx(atanh(NotComplex.new(0.785398163404734 + 2i)), 0.143655432578432 + 1.15296697280152i, "atanh(NotComplex) - 0.143655432578432 + 1.15296697280152i");
is_approx(atanh(:x(NotComplex.new(0.523598775603156 + 2i))), 0.100612672097949 + 1.12836985373239i, "atanh(:x(NotComplex)) - 0.100612672097949 + 1.12836985373239i");

# DifferentReal tests
is_approx((DifferentReal.new(0.655794202636825)).atanh, 0.785398163404734, "DifferentReal.atanh - 0.785398163404734");
is_approx(atanh(DifferentReal.new(0.480472778160188)), 0.523598775603156, "atanh(DifferentReal) - 0.523598775603156");
is_approx(atanh(:x(DifferentReal.new(0.655794202636825))), 0.785398163404734, "atanh(:x(DifferentReal)) - 0.785398163404734");

done;

# vim: ft=perl6 nomodifiable
