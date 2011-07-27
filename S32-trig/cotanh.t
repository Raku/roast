# WARNING:
# This is a generated file and should not be edited directly.
# look into generate-tests.pl instead

use v6;
use Test;
BEGIN { @*INC.push("t/spec/packages/") };
use TrigTestSupport;


# cotanh tests

my $iter_count = 0;
for TrigTest::sines() -> $angle
{
    next if abs(sinh($angle.key())) < 1e-6;
    my $desired-result = cosh($angle.key()) / sinh($angle.key());

    # Num.cotanh tests -- very thorough
    is_approx($angle.key().cotanh, $desired-result, 
              "Num.cotanh - {$angle.key()}");

    # Complex.cotanh tests -- also very thorough
    my Complex $zp0 = $angle.key + 0.0i;
    my Complex $sz0 = $desired-result + 0i;
    my Complex $zp1 = $angle.key + 1.0i;
    my Complex $sz1 = { cosh($_) / sinh ($_) }($zp1);
    my Complex $zp2 = $angle.key + 2.0i;
    my Complex $sz2 = { cosh($_) / sinh ($_) }($zp2);
    
    is_approx($zp0.cotanh, $sz0, "Complex.cotanh - $zp0");
    is_approx($zp1.cotanh, $sz1, "Complex.cotanh - $zp1");
    is_approx($zp2.cotanh, $sz2, "Complex.cotanh - $zp2");
}

is(cotanh(Inf), 1, "cotanh(Inf) -");
is(cotanh(-Inf), -1, "cotanh(-Inf) -");
        
# Num tests
is_approx(cotanh((-6.28318530723787).Num), -1.00000697470903, "cotanh(Num) - -6.28318530723787");
is_approx(cotanh(:x((-3.92699081702367).Num)), -1.0007767079283, "cotanh(:x(Num)) - -3.92699081702367");

# Rat tests
is_approx((-0.523598775603156).Rat(1e-9).cotanh, -2.08128336391745, "Rat.cotanh - -0.523598775603156");
is_approx(cotanh((0.523598775603156).Rat(1e-9)), 2.08128336391745, "cotanh(Rat) - 0.523598775603156");
is_approx(cotanh(:x((0.785398163404734).Rat(1e-9))), 1.52486861881241, "cotanh(:x(Rat)) - 0.785398163404734");

# Complex tests
is_approx(cotanh((1.57079632680947 + 2i).Complex), 0.94309321587152 + 0.0618020094643598i, "cotanh(Complex) - 1.57079632680947 + 2i");
is_approx(cotanh(:x((2.3561944902142 + 2i).Complex)), 0.988233985768855 + 0.0134382542728859i, "cotanh(:x(Complex)) - 2.3561944902142 + 2i");

# Str tests
is_approx((3.14159265361894).Str.cotanh, 1.0037418731971, "Str.cotanh - 3.14159265361894");
is_approx(cotanh((3.92699081702367).Str), 1.0007767079283, "cotanh(Str) - 3.92699081702367");
is_approx(cotanh(:x((4.7123889804284).Str)), 1.000161412061, "cotanh(:x(Str)) - 4.7123889804284");

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

    is_approx(NotComplex.new(5.49778714383314 + 2i).cotanh, 0.999978069152959 + 2.53913497751775e-05i, "NotComplex.cotanh - 5.49778714383314 + 2i");
    is_approx(cotanh(NotComplex.new(6.28318530723787 + 2i)), 0.999995441038292 + 5.27843472954601e-06i, "cotanh(NotComplex) - 6.28318530723787 + 2i");
    is_approx(cotanh(:x(NotComplex.new(6.80678408284103 + 2i))), 0.999998400170843 + 1.85231277868836e-06i, "cotanh(:x(NotComplex)) - 6.80678408284103 + 2i");
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

    is_approx(DifferentReal.new(10.2101761242615).cotanh, 1.00000000270759, "DifferentReal.cotanh - 10.2101761242615");
    is_approx(cotanh(DifferentReal.new(12.5663706144757)), 1.00000000002432, "cotanh(DifferentReal) - 12.5663706144757");
    is_approx(cotanh(:x(DifferentReal.new(-6.28318530723787))), -1.00000697470903, "cotanh(:x(DifferentReal)) - -6.28318530723787");
}


# acotanh tests

for TrigTest::sines() -> $angle
{
    next if abs(sinh($angle.key())) < 1e-6;
    my $desired-result = cosh($angle.key()) / sinh($angle.key());

    # Num.acotanh tests -- thorough
    is_approx($desired-result.Num.acotanh.cotanh, $desired-result, 
              "Num.acotanh - {$angle.key()}");
    
    # Num.acotanh(Complex) tests -- thorough
    for ($desired-result + 0i, $desired-result + .5i, $desired-result + 2i) -> $z {
        is_approx(cotanh(acotanh($z)), $z, 
                  "acotanh(Complex) - {$angle.key()}");
        is_approx($z.acotanh.cotanh, $z, 
                  "Complex.acotanh - {$angle.key()}");
    }
}
        
# Num tests
is_approx(acotanh((2.08128336391745).Num), 0.523598775603156, "acotanh(Num) - 0.523598775603156");
is_approx(acotanh(:x((1.52486861881241).Num)), 0.785398163404734, "acotanh(:x(Num)) - 0.785398163404734");

# Rat tests
is_approx(((2.08128336391745).Rat(1e-9)).acotanh, 0.523598775603156, "Rat.acotanh - 0.523598775603156");
is_approx(acotanh((1.52486861881241).Rat(1e-9)), 0.785398163404734, "acotanh(Rat) - 0.785398163404734");
is_approx(acotanh(:x((2.08128336391745).Rat(1e-9))), 0.523598775603156, "acotanh(:x(Rat)) - 0.523598775603156");

# Complex tests
is_approx(acotanh((0.785398163404734 + 2i).Complex), 0.143655432578432 - 0.417829353993379i, "acotanh(Complex) - 0.143655432578432 - 0.417829353993379i");
is_approx(acotanh(:x((0.523598775603156 + 2i).Complex)), 0.100612672097949 - 0.442426473062511i, "acotanh(:x(Complex)) - 0.100612672097949 - 0.442426473062511i");

# Str tests
is_approx(((1.52486861881241).Str).acotanh, 0.785398163404734, "Str.acotanh - 0.785398163404734");
is_approx(acotanh((2.08128336391745).Str), 0.523598775603156, "acotanh(Str) - 0.523598775603156");
is_approx(acotanh(:x((1.52486861881241).Str)), 0.785398163404734, "acotanh(:x(Str)) - 0.785398163404734");

# NotComplex tests
is_approx((NotComplex.new(0.523598775603156 + 2i)).acotanh, 0.100612672097949 - 0.442426473062511i, "NotComplex.acotanh - 0.100612672097949 - 0.442426473062511i");
is_approx(acotanh(NotComplex.new(0.785398163404734 + 2i)), 0.143655432578432 - 0.417829353993379i, "acotanh(NotComplex) - 0.143655432578432 - 0.417829353993379i");
is_approx(acotanh(:x(NotComplex.new(0.523598775603156 + 2i))), 0.100612672097949 - 0.442426473062511i, "acotanh(:x(NotComplex)) - 0.100612672097949 - 0.442426473062511i");

# DifferentReal tests
is_approx((DifferentReal.new(1.52486861881241)).acotanh, 0.785398163404734, "DifferentReal.acotanh - 0.785398163404734");
is_approx(acotanh(DifferentReal.new(2.08128336391745)), 0.523598775603156, "acotanh(DifferentReal) - 0.523598775603156");
is_approx(acotanh(:x(DifferentReal.new(1.52486861881241))), 0.785398163404734, "acotanh(:x(DifferentReal)) - 0.785398163404734");

done;

# vim: ft=perl6 nomodifiable
