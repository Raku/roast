# WARNING:
# This is a generated file and should not be edited directly.
# look into generate-tests.pl instead

use v6;
use Test;
BEGIN { @*INC.push("t/spec/packages/") };
use TrigTestSupport;


# cotan tests

my $base_list = (TrigTest::official_bases() xx *).flat;
my $iter_count = 0;
for TrigTest::sines() -> $angle
{
    next if abs(sin($angle.num(Radians))) < 1e-6;
    my $desired-result = cos($angle.num(Radians)) / sin($angle.num(Radians));

    # Num.cotan tests -- very thorough
    is_approx($angle.num(Radians).cotan, $desired-result, 
              "Num.cotan - {$angle.num(Radians)} default");
    for TrigTest::official_bases() -> $base {
        is_approx($angle.num($base).cotan($base), $desired-result, 
                  "Num.cotan - {$angle.num($base)} $base");
    }

    # Complex.cotan tests -- also very thorough
    my Complex $zp0 = $angle.complex(0.0, Radians);
    my Complex $sz0 = $desired-result + 0i;
    my Complex $zp1 = $angle.complex(1.0, Radians);
    my Complex $sz1 = { cos($_) / sin($_) }($zp1);
    my Complex $zp2 = $angle.complex(2.0, Radians);
    my Complex $sz2 = { cos($_) / sin($_) }($zp2);
    
    is_approx($zp0.cotan, $sz0, "Complex.cotan - $zp0 default");
    is_approx($zp1.cotan, $sz1, "Complex.cotan - $zp1 default");
    is_approx($zp2.cotan, $sz2, "Complex.cotan - $zp2 default");
    
    for TrigTest::official_bases() -> $base {
        my Complex $z = $angle.complex(0.0, $base);
        is_approx($z.cotan($base), $sz0, "Complex.cotan - $z $base");
    
        $z = $angle.complex(1.0, $base);
        is_approx($z.cotan($base), $sz1, "Complex.cotan - $z $base");
    
        $z = $angle.complex(2.0, $base);
        is_approx($z.cotan($base), $sz2, "Complex.cotan - $z $base");
    }
}

is(cotan(Inf), NaN, "cotan(Inf) - default");
is(cotan(-Inf), NaN, "cotan(-Inf) - default");
given $base_list.shift
{
    is(cotan(Inf,  $_), NaN, "cotan(Inf) - $_");
    is(cotan(-Inf, $_), NaN, "cotan(-Inf) - $_");
}
        
# Num tests
is_approx((-3.92699081702367).Num.cotan(:base(Radians)), -0.999999999927141, "Num.cotan(:base(Radians)) - -3.92699081702367");
is_approx(cotan((-0.523598775603156).Num), -1.73205080754945, "cotan(Num) - -0.523598775603156");
is_approx(cotan((30).Num, Degrees), 1.73205080754945, "cotan(Num, Degrees) - 30");
is_approx(cotan(:x((0.785398163404734).Num)), 0.999999999985428, "cotan(:x(Num)) - 0.785398163404734");
is_approx(cotan(:x((100).Num), :base(Gradians)), -1.45718380104701e-11, "cotan(:x(Num), :base(Gradians)) - 100");

# Rat tests
is_approx((2.3561944902142).Rat(1e-9).cotan, -1.00000000004372, "Rat.cotan - 2.3561944902142");
is_approx((0.625).Rat(1e-9).cotan(Circles), 0.999999999927141, "Rat.cotan(Circles) - 0.625");
is_approx((4.7123889804284).Rat(1e-9).cotan(:base(Radians)), -4.37150699422006e-11, "Rat.cotan(:base(Radians)) - 4.7123889804284");
is_approx(cotan((5.49778714383314).Rat(1e-9)), -1.000000000102, "cotan(Rat) - 5.49778714383314");
is_approx(cotan((390).Rat(1e-9), Degrees), 1.7320508073163, "cotan(Rat, Degrees) - 390");
is_approx(cotan(:x((10.2101761242615).Rat(1e-9))), 0.999999999810569, "cotan(:x(Rat)) - 10.2101761242615");
is_approx(cotan(:x((-250).Rat(1e-9)), :base(Gradians)), -0.999999999927141, "cotan(:x(Rat), :base(Gradians)) - -250");

# Complex tests
is_approx((-0.0833333333333333 + 0.318309886183791i).Complex.cotan(:base(Circles)), -0.0323044569586672 + -1.01796777743797i, "Complex.cotan(:base(Circles)) - -0.0833333333333333 + 0.318309886183791i");
is_approx(cotan((0.523598775598299 + 2i).Complex), 0.0323044569586672 + -1.01796777743797i, "cotan(Complex) - 0.523598775598299 + 2i");
is_approx(cotan((0.785398163397448 + 2i).Complex, Radians), 0.036618993473667 + -0.999329299738534i, "cotan(Complex, Radians) - 0.785398163397448 + 2i");
is_approx(cotan(:x((1.5707963267949 + 2i).Complex)), -1.02951237506641e-12 + -0.964027580075817i, "cotan(:x(Complex)) - 1.5707963267949 + 2i");
is_approx(cotan(:x((135 + 114.591559026165i).Complex), :base(Degrees)), -0.0366189934737451 + -0.999329299740667i, "cotan(:x(Complex), :base(Degrees)) - 135 + 114.591559026165i");

# Str tests
is_approx((3.92699081702367).Str.cotan, 0.999999999927141, "Str.cotan - 3.92699081702367");
is_approx((300).Str.cotan(Gradians), -4.37150699422006e-11, "Str.cotan(Gradians) - 300");
is_approx((0.875).Str.cotan(:base(Circles)), -1.000000000102, "Str.cotan(:base(Circles)) - 0.875");
is_approx(cotan((6.80678408284103).Str), 1.7320508073163, "cotan(Str) - 6.80678408284103");
is_approx(cotan((10.2101761242615).Str, Radians), 0.999999999810569, "cotan(Str, Radians) - 10.2101761242615");
is_approx(cotan(:x((-3.92699081702367).Str)), -0.999999999927141, "cotan(:x(Str)) - -3.92699081702367");
is_approx(cotan(:x((-30).Str), :base(Degrees)), -1.73205080754945, "cotan(:x(Str), :base(Degrees)) - -30");

# NotComplex tests
is_approx(NotComplex.new(0.523598775598299 + 2i).cotan, 0.0323044569586672 + -1.01796777743797i, "NotComplex.cotan - 0.523598775598299 + 2i");
is_approx(NotComplex.new(50 + 127.323954473516i).cotan(Gradians), 0.036618993473667 + -0.999329299738534i, "NotComplex.cotan(Gradians) - 50 + 127.323954473516i");
is_approx(NotComplex.new(0.25 + 0.318309886183791i).cotan(:base(Circles)), -1.02951237506641e-12 + -0.964027580075817i, "NotComplex.cotan(:base(Circles)) - 0.25 + 0.318309886183791i");
is_approx(cotan(NotComplex.new(2.35619449019234 + 2i)), -0.0366189934737451 + -0.999329299740667i, "cotan(NotComplex) - 2.35619449019234 + 2i");
is_approx(cotan(NotComplex.new(3.92699081698724 + 2i), Radians), 0.036618993473589 + -0.999329299736401i, "cotan(NotComplex, Radians) - 3.92699081698724 + 2i");
is_approx(cotan(:x(NotComplex.new(4.71238898038469 + 2i))), -3.08850574993026e-12 + -0.964027580075817i, "cotan(:x(NotComplex)) - 4.71238898038469 + 2i");
is_approx(cotan(:x(NotComplex.new(315 + 114.591559026165i)), :base(Degrees)), -0.0366189934738233 + -0.9993292997428i, "cotan(:x(NotComplex), :base(Degrees)) - 315 + 114.591559026165i");

# DifferentReal tests
is_approx(DifferentReal.new(6.80678408284103).cotan, 1.7320508073163, "DifferentReal.cotan - 6.80678408284103");
is_approx(DifferentReal.new(650).cotan(Gradians), 0.999999999810569, "DifferentReal.cotan(Gradians) - 650");
is_approx(DifferentReal.new(-0.625).cotan(:base(Circles)), -0.999999999927141, "DifferentReal.cotan(:base(Circles)) - -0.625");
is_approx(cotan(DifferentReal.new(-0.523598775603156)), -1.73205080754945, "cotan(DifferentReal) - -0.523598775603156");
is_approx(cotan(DifferentReal.new(0.523598775603156), Radians), 1.73205080754945, "cotan(DifferentReal, Radians) - 0.523598775603156");
is_approx(cotan(:x(DifferentReal.new(0.785398163404734))), 0.999999999985428, "cotan(:x(DifferentReal)) - 0.785398163404734");
is_approx(cotan(:x(DifferentReal.new(90)), :base(Degrees)), -1.45718380104701e-11, "cotan(:x(DifferentReal), :base(Degrees)) - 90");

# Int tests
is_approx((135).Int.cotan(:base(Degrees)), -1.00000000004372, "Int.cotan(:base(Degrees)) - 135");
is_approx(cotan((225).Int, Degrees), 0.999999999927141, "cotan(Int, Degrees) - 225");
is_approx(cotan(:x((300).Int), :base(Gradians)), -4.37150699422006e-11, "cotan(:x(Int), :base(Gradians)) - 300");

# acotan tests

for TrigTest::sines() -> $angle
{
    next if abs(sin($angle.num(Radians))) < 1e-6;
    my $desired-result = cos($angle.num(Radians)) / sin($angle.num(Radians));

    # Num.acotan tests -- thorough
    is_approx($desired-result.Num.acotan.cotan, $desired-result, 
              "Num.acotan - {$angle.num(Radians)} default");
    for TrigTest::official_bases() -> $base {
        is_approx($desired-result.Num.acotan($base).cotan($base), $desired-result,
                  "Num.acotan - {$angle.num($base)} $base");
    }
    
    # Num.acotan(Complex) tests -- thorough
    for ($desired-result + 0i, $desired-result + .5i, $desired-result + 2i) -> $z {
        is_approx(cotan(acotan($z)), $z, 
                  "acotan(Complex) - {$angle.num(Radians)} default");
        is_approx($z.acotan.cotan, $z, 
                  "Complex.acotan - {$angle.num(Radians)} default");
        for TrigTest::official_bases() -> $base {
            is_approx($z.acotan($base).cotan($base), $z, 
                      "Complex.acotan - {$angle.num($base)} $base");
        }
    }
}
        
# Num tests
is_approx((1.73205080754945).Num.acotan(:base(Radians)), 0.523598775603156, "Num.acotan(:base(Radians)) - 0.523598775603156");
is_approx(acotan((0.999999999985428).Num), 0.785398163404734, "acotan(Num) - 0.785398163404734");
is_approx(acotan((1.73205080754945).Num, Degrees), 30, "acotan(Num, Degrees) - 30");
is_approx(acotan(:x((0.999999999985428).Num)), 0.785398163404734, "acotan(:x(Num)) - 0.785398163404734");
is_approx(acotan(:x((1.73205080754945).Num), :base(Gradians)), 33.3333333333333, "acotan(:x(Num), :base(Gradians)) - 33.3333333333333");

# Rat tests
is_approx(((0.999999999985428).Rat(1e-9)).acotan, 0.785398163404734, "Rat.acotan - 0.785398163404734");
is_approx((1.73205080754945).Rat(1e-9).acotan(Circles), 0.0833333333333333, "Rat.acotan(Circles) - 0.0833333333333333");
is_approx((0.999999999985428).Rat(1e-9).acotan(:base(Radians)), 0.785398163404734, "Rat.acotan(:base(Radians)) - 0.785398163404734");
is_approx(acotan((1.73205080754945).Rat(1e-9)), 0.523598775603156, "acotan(Rat) - 0.523598775603156");
is_approx(acotan((0.999999999985428).Rat(1e-9), Degrees), 45, "acotan(Rat, Degrees) - 45");
is_approx(acotan(:x((1.73205080754945).Rat(1e-9))), 0.523598775603156, "acotan(:x(Rat)) - 0.523598775603156");
is_approx(acotan(:x((0.999999999985428).Rat(1e-9)), :base(Gradians)), 50, "acotan(:x(Rat), :base(Gradians)) - 50");

# Complex tests
is_approx((0.523598775603156 + 2i).Complex.acotan(:base(Circles)), 0.0246336417847161 + -0.0789785645932523i, "Complex.acotan(:base(Circles)) - 0.0246336417847161 + -0.0789785645932523i");
is_approx(acotan((0.785398163404734 + 2i).Complex), 0.204860490024916 + -0.445759203696597i, "acotan(Complex) - 0.204860490024916 + -0.445759203696597i");
is_approx(acotan((0.523598775603156 + 2i).Complex, Radians), 0.154777736124053 + -0.496236956634457i, "acotan(Complex, Radians) - 0.154777736124053 + -0.496236956634457i");
is_approx(acotan(:x((0.785398163404734 + 2i).Complex)), 0.204860490024916 + -0.445759203696597i, "acotan(:x(Complex)) - 0.204860490024916 + -0.445759203696597i");
is_approx(acotan(:x((0.523598775603156 + 2i).Complex), :base(Degrees)), 8.8681110424978 + -28.4322832535708i, "acotan(:x(Complex), :base(Degrees)) - 8.8681110424978 + -28.4322832535708i");

# Str tests
is_approx(((0.999999999985428).Str).acotan, 0.785398163404734, "Str.acotan - 0.785398163404734");
is_approx((1.73205080754945).Str.acotan(Gradians), 33.3333333333333, "Str.acotan(Gradians) - 33.3333333333333");
is_approx((0.999999999985428).Str.acotan(:base(Circles)), 0.125, "Str.acotan(:base(Circles)) - 0.125");
is_approx(acotan((1.73205080754945).Str), 0.523598775603156, "acotan(Str) - 0.523598775603156");
is_approx(acotan((0.999999999985428).Str, Radians), 0.785398163404734, "acotan(Str, Radians) - 0.785398163404734");
is_approx(acotan(:x((1.73205080754945).Str)), 0.523598775603156, "acotan(:x(Str)) - 0.523598775603156");
is_approx(acotan(:x((0.999999999985428).Str), :base(Degrees)), 45, "acotan(:x(Str), :base(Degrees)) - 45");

# NotComplex tests
is_approx((NotComplex.new(0.523598775603156 + 2i)).acotan, 0.154777736124053 + -0.496236956634457i, "NotComplex.acotan - 0.154777736124053 + -0.496236956634457i");
is_approx(NotComplex.new(0.785398163404734 + 2i).acotan(Gradians), 13.0418238526773 + -28.3779122788082i, "NotComplex.acotan(Gradians) - 13.0418238526773 + -28.3779122788082i");
is_approx(NotComplex.new(0.523598775603156 + 2i).acotan(:base(Circles)), 0.0246336417847161 + -0.0789785645932523i, "NotComplex.acotan(:base(Circles)) - 0.0246336417847161 + -0.0789785645932523i");
is_approx(acotan(NotComplex.new(0.785398163404734 + 2i)), 0.204860490024916 + -0.445759203696597i, "acotan(NotComplex) - 0.204860490024916 + -0.445759203696597i");
is_approx(acotan(NotComplex.new(0.523598775603156 + 2i), Radians), 0.154777736124053 + -0.496236956634457i, "acotan(NotComplex, Radians) - 0.154777736124053 + -0.496236956634457i");
is_approx(acotan(:x(NotComplex.new(0.785398163404734 + 2i))), 0.204860490024916 + -0.445759203696597i, "acotan(:x(NotComplex)) - 0.204860490024916 + -0.445759203696597i");
is_approx(acotan(:x(NotComplex.new(0.523598775603156 + 2i)), :base(Degrees)), 8.8681110424978 + -28.4322832535708i, "acotan(:x(NotComplex), :base(Degrees)) - 8.8681110424978 + -28.4322832535708i");

# DifferentReal tests
is_approx((DifferentReal.new(0.999999999985428)).acotan, 0.785398163404734, "DifferentReal.acotan - 0.785398163404734");
is_approx(DifferentReal.new(1.73205080754945).acotan(Gradians), 33.3333333333333, "DifferentReal.acotan(Gradians) - 33.3333333333333");
is_approx(DifferentReal.new(0.999999999985428).acotan(:base(Circles)), 0.125, "DifferentReal.acotan(:base(Circles)) - 0.125");
is_approx(acotan(DifferentReal.new(1.73205080754945)), 0.523598775603156, "acotan(DifferentReal) - 0.523598775603156");
is_approx(acotan(DifferentReal.new(0.999999999985428), Radians), 0.785398163404734, "acotan(DifferentReal, Radians) - 0.785398163404734");
is_approx(acotan(:x(DifferentReal.new(1.73205080754945))), 0.523598775603156, "acotan(:x(DifferentReal)) - 0.523598775603156");
is_approx(acotan(:x(DifferentReal.new(0.999999999985428)), :base(Degrees)), 45, "acotan(:x(DifferentReal), :base(Degrees)) - 45");

done_testing;

# vim: ft=perl6 nomodifiable
