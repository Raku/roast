# WARNING:
# This is a generated file and should not be edited directly.
# look into generate-tests.pl instead

use v6;
use Test;
BEGIN { @*INC.push("t/spec/packages/") };
use TrigTestSupport;


# cosech tests

my $iter_count = 0;
for TrigTest::sines() -> $angle
{
    next if abs(sinh($angle.num())) < 1e-6;
    my $desired-result = 1.0 / sinh($angle.num());

    # Num.cosech tests -- very thorough
    is_approx($angle.num().cosech, $desired-result, 
              "Num.cosech - {$angle.num()}");

    # Complex.cosech tests -- also very thorough
    my Complex $zp0 = $angle.num + 0.0i;
    my Complex $sz0 = $desired-result + 0i;
    my Complex $zp1 = $angle.num + 1.0i;
    my Complex $sz1 = { 1.0 / sinh($_) }($zp1);
    my Complex $zp2 = $angle.num + 2.0i;
    my Complex $sz2 = { 1.0 / sinh($_) }($zp2);
    
    is_approx($zp0.cosech, $sz0, "Complex.cosech - $zp0");
    is_approx($zp1.cosech, $sz1, "Complex.cosech - $zp1");
    is_approx($zp2.cosech, $sz2, "Complex.cosech - $zp2");
}

is(cosech(Inf), 0, "cosech(Inf) -");
is(cosech(-Inf), "-0", "cosech(-Inf) -");
        
# Num tests
is_approx(cosech((-6.28318530723787).Num), -0.00373489848806798, "cosech(Num) - -6.28318530723787");
is_approx(cosech(:x((-3.92699081702367).Num)), -0.0394210493494572, "cosech(:x(Num)) - -3.92699081702367");

# Rat tests
is_approx((-0.523598775603156).Rat(1e-9).cosech, -1.8253055746695, "Rat.cosech - -0.523598775603156");
is_approx(cosech((0.523598775603156).Rat(1e-9)), 1.8253055746695, "cosech(Rat) - 0.523598775603156");
is_approx(cosech(:x((0.785398163404734).Rat(1e-9))), 1.15118387090806, "cosech(:x(Rat)) - 0.785398163404734");

# Complex tests
is_approx(cosech((1.57079632680947 + 2i).Complex), -0.156411854193272 - 0.372638353746799i, "cosech(Complex) - 1.57079632680947 + 2i");
is_approx(cosech(:x((2.3561944902142 + 2i).Complex)), -0.0772627459225851 - 0.171882832059526i, "cosech(:x(Complex)) - 2.3561944902142 + 2i");

# Str tests
is_approx((3.14159265361894).Str.cosech, 0.086589537527514, "Str.cosech - 3.14159265361894");
is_approx(cosech((3.92699081702367).Str), 0.0394210493494572, "cosech(Str) - 3.92699081702367");
is_approx(cosech(:x((4.7123889804284).Str)), 0.0179680320529917, "cosech(:x(Str)) - 4.7123889804284");

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

    is_approx(NotComplex.new(5.49778714383314 + 2i).cosech, -0.00340879719539436 - 0.00744860766594804i, "NotComplex.cosech - 5.49778714383314 + 2i");
    is_approx(cosech(NotComplex.new(6.28318530723787 + 2i)), -0.00155424826436473 - 0.00339611810181237i, "cosech(NotComplex) - 6.28318530723787 + 2i");
    is_approx(cosech(:x(NotComplex.new(6.80678408284103 + 2i))), -0.000920717929196107 - 0.00201181030212346i, "cosech(:x(NotComplex)) - 6.80678408284103 + 2i");
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

    is_approx(DifferentReal.new(10.2101761242615).cosech, 7.35879739979009e-05, "DifferentReal.cosech - 10.2101761242615");
    is_approx(cosech(DifferentReal.new(12.5663706144757)), 6.97468471168976e-06, "cosech(DifferentReal) - 12.5663706144757");
    is_approx(cosech(:x(DifferentReal.new(-6.28318530723787))), -0.00373489848806798, "cosech(:x(DifferentReal)) - -6.28318530723787");
}


# acosech tests

for TrigTest::sines() -> $angle
{
    next if abs(sinh($angle.num())) < 1e-6;
    my $desired-result = 1.0 / sinh($angle.num());

    # Num.acosech tests -- thorough
    is_approx($desired-result.Num.acosech.cosech, $desired-result, 
              "Num.acosech - {$angle.num()}");
    
    # Num.acosech(Complex) tests -- thorough
    for ($desired-result + 0i, $desired-result + .5i, $desired-result + 2i) -> $z {
        is_approx(cosech(acosech($z)), $z, 
                  "acosech(Complex) - {$angle.num()}");
        is_approx($z.acosech.cosech, $z, 
                  "Complex.acosech - {$angle.num()}");
    }
}
        
# Num tests
is_approx(acosech((1.8253055746695).Num), 0.523598775603156, "acosech(Num) - 0.523598775603156");
is_approx(acosech(:x((1.15118387090806).Num)), 0.785398163404734, "acosech(:x(Num)) - 0.785398163404734");

# Rat tests
is_approx(((1.8253055746695).Rat(1e-9)).acosech, 0.523598775603156, "Rat.acosech - 0.523598775603156");
is_approx(acosech((1.15118387090806).Rat(1e-9)), 0.785398163404734, "acosech(Rat) - 0.785398163404734");
is_approx(acosech(:x((1.8253055746695).Rat(1e-9))), 0.523598775603156, "acosech(:x(Rat)) - 0.523598775603156");

# Complex tests
is_approx(acosech((0.785398163404734 + 2i).Complex), 0.186914543518615 - 0.439776333846415i, "acosech(Complex) - 0.186914543518615 - 0.439776333846415i");
is_approx(acosech(:x((0.523598775603156 + 2i).Complex)), 0.137815559024863 - 0.481963452541975i, "acosech(:x(Complex)) - 0.137815559024863 - 0.481963452541975i");

# Str tests
is_approx(((1.15118387090806).Str).acosech, 0.785398163404734, "Str.acosech - 0.785398163404734");
is_approx(acosech((1.8253055746695).Str), 0.523598775603156, "acosech(Str) - 0.523598775603156");
is_approx(acosech(:x((1.15118387090806).Str)), 0.785398163404734, "acosech(:x(Str)) - 0.785398163404734");

# NotComplex tests
is_approx((NotComplex.new(0.523598775603156 + 2i)).acosech, 0.137815559024863 - 0.481963452541975i, "NotComplex.acosech - 0.137815559024863 - 0.481963452541975i");
is_approx(acosech(NotComplex.new(0.785398163404734 + 2i)), 0.186914543518615 - 0.439776333846415i, "acosech(NotComplex) - 0.186914543518615 - 0.439776333846415i");
is_approx(acosech(:x(NotComplex.new(0.523598775603156 + 2i))), 0.137815559024863 - 0.481963452541975i, "acosech(:x(NotComplex)) - 0.137815559024863 - 0.481963452541975i");

# DifferentReal tests
is_approx((DifferentReal.new(1.15118387090806)).acosech, 0.785398163404734, "DifferentReal.acosech - 0.785398163404734");
is_approx(acosech(DifferentReal.new(1.8253055746695)), 0.523598775603156, "acosech(DifferentReal) - 0.523598775603156");
is_approx(acosech(:x(DifferentReal.new(1.15118387090806))), 0.785398163404734, "acosech(:x(DifferentReal)) - 0.785398163404734");

done;

# vim: ft=perl6 nomodifiable
