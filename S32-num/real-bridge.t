use v6;
use Test;
plan 200;

=begin pod

Basic tests easily defining a Real type

=end pod

class Fixed2 does Real {
    has Int $.one-hundredths;

    multi method new(Int $a) {
        self.bless(*, :one-hundredths($a * 100));
    }

    multi method new(Rat $a) {
        self.bless(*, :one-hundredths(floor($a * 100)));
    }

    method Bridge() {
        $.one-hundredths.Bridge / 100.Bridge;
    }
}

my $zero = Fixed2.new(0);
my $one = Fixed2.new(1);
my $one-and-one-hundredth = Fixed2.new(1.01);
my $one-and-ninety-nine-hundredths = Fixed2.new(1.99);  
my $three = Fixed2.new(3);
my $ten = Fixed2.new(10);
my $neg-pi = Fixed2.new(-3.14);

isa_ok $zero, Fixed2, "Fixed2 sanity test";
isa_ok $one, Fixed2, "Fixed2 sanity test";
isa_ok $one-and-one-hundredth, Fixed2, "Fixed2 sanity test";
isa_ok $neg-pi, Fixed2, "Fixed2 sanity test";
ok $zero ~~ Real, "Fixed2 sanity test";
ok $one ~~ Real, "Fixed2 sanity test";
ok $one-and-one-hundredth ~~ Real, "Fixed2 sanity test";
ok $neg-pi ~~ Real, "Fixed2 sanity test";

is_approx $zero.succ, 1, "0.succ works";
is_approx $neg-pi.succ, -2.14, "(-3.14).succ works";
is_approx $zero.pred, -1, "0.pred works";
is_approx $neg-pi.pred, -4.14, "(-3.14).pred works";

{
    my $i = $zero.Bool;
    isa_ok $i, Bool, "0.Bool is an Bool";
    is $i, Bool::False, "0.Bool is False";
    
    $i = $one-and-ninety-nine-hundredths.Bool;
    isa_ok $i, Bool, "1.99.Bool is an Bool";
    is $i, Bool::True, "1.99.Bool is True";
}

{
    my $i = $neg-pi.Int;
    isa_ok $i, Int, "-3.14.Int is an Int";
    is $i, -3, "-3.14.Int is -3";
    
    $i = $one-and-ninety-nine-hundredths.Int;
    isa_ok $i, Int, "1.99.Int is an Int";
    is $i, 1, "1.99.Int is 1";
}

{
    my $i = $neg-pi.Rat;
    isa_ok $i, Rat, "-3.14.Rat is an Rat";
    is_approx $i, -3.14, "-3.14.Rat is -3.14";
    
    $i = $one-and-ninety-nine-hundredths.Rat;
    isa_ok $i, Rat, "1.99.Rat is an Rat";
    is_approx $i, 1.99, "1.99.Rat is 1.99";
}

{
    my $i = $neg-pi.Num;
    isa_ok $i, Num, "-3.14.Num is an Num";
    is_approx $i, -3.14, "-3.14.Num is -3.14";
    
    $i = $one-and-ninety-nine-hundredths.Num;
    isa_ok $i, Num, "1.99.Num is an Num";
    is_approx $i, 1.99, "1.99.Num is 1.99";
}

{
    my $s = $one-and-ninety-nine-hundredths.Str;
    isa_ok $s, Str, "1.99.Str is a Str";
    is $s, "1.99", '1.99.Str is "1.99"';

    $s = $neg-pi.Str;
    isa_ok $s, Str, "-3.14.Str is a Str";
    is $s, "-3.14", '-3.14.Str is "-3.14"';
}

is_approx $zero.abs, 0, "0.abs works";
ok $zero.abs ~~ Real, "0.abs produces a Real";
is_approx $one.abs, 1, "1.abs works";
ok $one.abs ~~ Real, "1.abs produces a Real";
is_approx $one-and-one-hundredth.abs, 1.01, "1.01.abs works";
ok $one-and-one-hundredth.abs ~~ Real, "1.01.abs produces a Real";
is_approx $neg-pi.abs, 3.14, "-3.14.abs works";
ok $neg-pi.abs ~~ Real, "-3.14.abs produces a Real";

is_approx $zero.sign, 0, "0.sign works";
is_approx $one.sign, 1, "1.sign works";
is_approx $one-and-one-hundredth.sign, 1, "1.01.sign works";
is_approx $neg-pi.sign, -1, "-3.14.sign works";

is $zero <=> 0, Same, "0 <=> 0 is Same";
is $one <=> 0.Num, Decrease, "1 <=> 0 is Decrease";
is $one-and-one-hundredth <=> 1.1, Increase, "1.01 <=> 1.1 is Increase";
is $neg-pi <=> -3, Increase, "-3.14 <=> -3 is Increase";
is -1 <=> $zero, Increase, "-1 <=> 0 is Increase";
is 1.Rat <=> $one, Same, "1 <=> 1 is Same";
is 1.001 <=> $one-and-one-hundredth, Increase, "1.001 <=? 1.01 is Increase";
is $neg-pi <=> -3.14, Same, "-3.14 <=> -3.14 is Same";

nok $zero < 0, "not 0 < 0";
nok $one < 0.Num, "not 1 < 0";
ok $one-and-one-hundredth < 1.1, "1.01 < 1.1";
ok $neg-pi < -3, "-3.14 < -3";
ok -1 < $zero, "-1 < 0";
nok 1.Rat < $one, "not 1 < 1";
ok 1.001 < $one-and-one-hundredth, "1.001 < 1.01";
nok $neg-pi < -3.14, "not -3.14 < -3.14";

ok $zero <= 0, "0 <= 0";
nok $one <= 0.Num, "not 1 <= 0";
ok $one-and-one-hundredth <= 1.1, "1.01 <= 1.1";
ok $neg-pi <= -3, "-3.14 <= -3";
ok -1 <= $zero, "-1 <= 0";
ok 1.Rat <= $one, "1 <= 1";
ok 1.001 <= $one-and-one-hundredth, "1.001 <= 1.01";
ok $neg-pi <= -3.14, "-3.14 <= -3.14";

nok $zero > 0, "not 0 > 0";
ok $one > 0.Num, "1 > 0";
nok $one-and-one-hundredth > 1.1, "not 1.01 > 1.1";
nok $neg-pi > -3, "not -3.14 > -3";
nok -1 > $zero, "not -1 > 0";
nok 1.Rat > $one, "not 1 > 1";
nok 1.001 > $one-and-one-hundredth, "not 1.001 > 1.01";
nok $neg-pi > -3.14, "not -3.14 > -3.14";

ok $zero >= 0, "0 >= 0";
ok $one >= 0.Num, "1 >= 0";
nok $one-and-one-hundredth >= 1.1, "not 1.01 >= 1.1";
nok $neg-pi >= -3, "not -3.14 >= -3";
nok -1 >= $zero, "not -1 >= 0";
ok 1.Rat >= $one, "1 >= 1";
nok 1.001 >= $one-and-one-hundredth, "not 1.001 >= 1.01";
ok $neg-pi >= -3.14, "-3.14 >= -3.14";

ok $zero == 0, "0 == 0";
nok $one == 0.Num, "not 1 == 0";
nok $one-and-one-hundredth == 1.1, "not 1.01 == 1.1";
nok $neg-pi == -3, "not -3.14 == -3";
nok -1 == $zero, "not -1 == 0";
ok 1.Rat == $one, "1 == 1";
nok 1.001 == $one-and-one-hundredth, "not 1.001 == 1.01";
ok $neg-pi == -3.14, "-3.14 == -3.14";

# bonus round!
isa_ok $zero.Complex, Complex, "0.Complex is a Complex";
ok $zero == $zero.Complex, "0 == 0.Complex";
ok $neg-pi == $neg-pi.Complex, "-3.14 == -3.14.Complex";
ok $neg-pi == -3.14.Complex, "-3.14 == -3.14.Complex";
ok -3.14 == $neg-pi.Complex, "-3.14 == -3.14.Complex";
nok $zero == $neg-pi.Complex, "not 0 == -3.14.Complex";

nok $zero != 0, "not 0 != 0";
ok $one != 0.Num, "1 != 0";
ok $one-and-one-hundredth != 1.1, "1.01 != 1.1";
ok $neg-pi != -3, "-3.14 != -3";
ok -1 != $zero, "-1 != 0";
nok 1.Rat != $one, "not 1 != 1";
ok 1.001 != $one-and-one-hundredth, "1.001 != 1.01";
nok $neg-pi != -3.14, "not -3.14 != -3.14";

# bonus round!
nok $zero != $zero.Complex, "not 0 != 0.Complex";
nok $neg-pi != $neg-pi.Complex, "not -3.14 != -3.14.Complex";
nok $neg-pi != -3.14.Complex, "not -3.14 != -3.14.Complex";
nok -3.14 != $neg-pi.Complex, "not -3.14 != -3.14.Complex";
ok $zero != $neg-pi.Complex, "0 != -3.14.Complex";

is $zero cmp 0, Same, "0 cmp 0 is Order::Same";
is $one cmp 0.Num, Decrease, "1 cmp 0 is Order::Decrease";
is $one-and-one-hundredth cmp 1.1, Increase, "1.01 cmp 1.1 is Order::Increase";
is $neg-pi cmp -3, Increase, "-3.14 cmp -3 is Order::Increase";
is -1 cmp $zero, Increase, "-1 cmp 0 is Order::Increase";
is 1.Rat cmp $one, Same, "1 cmp 1 is Order::Same";
is 1.001 cmp $one-and-one-hundredth, Increase, "1.001 cmp 1.01 is Order::Increase";
is $neg-pi cmp -3.14, Same, "-3.14 cmp -3.14 is Order::Same";

nok $zero before 0, "not 0 before 0";
nok $one before 0.Num, "not 1 before 0";
ok $one-and-one-hundredth before 1.1, "1.01 before 1.1";
ok $neg-pi before -3, "-3.14 before -3";
ok -1 before $zero, "-1 before 0";
nok 1.Rat before $one, "not 1 before 1";
ok 1.001 before $one-and-one-hundredth, "1.001 before 1.01";
nok $neg-pi before -3.14, "not -3.14 before -3.14";

nok $zero after 0, "not 0 after 0";
ok $one after 0.Num, "1 after 0";
nok $one-and-one-hundredth after 1.1, "not 1.01 after 1.1";
nok $neg-pi after -3, "not -3.14 after -3";
nok -1 after $zero, "not -1 after 0";
nok 1.Rat after $one, "not 1 after 1";
nok 1.001 after $one-and-one-hundredth, "not 1.001 after 1.01";
nok $neg-pi after -3.14, "not -3.14 after -3.14";

is_approx -$zero, 0, "-0 == 0";
is_approx -$one, -1, "-1 == -1";
is_approx -$one-and-one-hundredth, -1.01, "-1.01 == -1.01";
is_approx -$neg-pi, 3.14, "-(-3.14) == 3.14";

is $one + $one, 2, "1 + 1 == 2";
is $one + -1, 0, "1 + -1 == 0";
is $one-and-one-hundredth + $one-and-one-hundredth, 2.02, "1.01 + 1.01 == 2.02";
is_approx 1.01 + -$one, 0.01, "1.01 + -1 == 0.01";
is_approx $one-and-one-hundredth + 1.Num, 2.01, "1.01 + 1 == 2.01";

is $one - $one, 0, "1 - 1 == 0";
is $one - 1, 0, "1 - 1 == 0";
is $one-and-one-hundredth - $one-and-one-hundredth, 0, "1.01 - 1.01 == 0";
is $one-and-one-hundredth - 1.01, 0, "1.01 - 1.01 == 0";
is_approx 1.01 - $one, 0.01, "1.01 - 1 == 0.01";
is_approx $one-and-one-hundredth - 1.Num, 0.01, "1.01 - 1 == 0.01";

is_approx $one * $one, $one, "1 * 1 == 1";
is_approx $one * 1, $one, "1 * 1 == 1";
is_approx $one-and-one-hundredth * $one, 1.01, "1.01 * 1 == 1.01";
is_approx -1 * $neg-pi, 3.14, "-1 * -3.14 == 3.14";
is_approx $one-and-one-hundredth * 2.Num, 2.02, "1.01 * 2 == 2.02";

is_approx $one / $one, $one, "1 / 1 == 1";
is_approx $one / 1, $one, "1 / 1 == 1";
is_approx $one-and-one-hundredth / $one, 1.01, "1.01 / 1 == 1.01";
is_approx -1 / $neg-pi, 1 / 3.14, "-1 / -3.14 == 1 / 3.14";
is_approx $neg-pi / 2.Num, -1.57, "-3.14 / 2 == -1.57";

is_approx $one % $one, $zero, "1 % 1 == 0";
is_approx $ten % $three, $one, "10 % 3 == 1";
is_approx $one-and-ninety-nine-hundredths % $one-and-one-hundredth, 0.98, "1.99 % 1.01 = 0.98";
is_approx 10 % $one-and-ninety-nine-hundredths, 0.05, "10 % 1.99 = 0.05";
is_approx $one-and-one-hundredth % 0.2, 0.01, "1.01 % 0.2 = 0.01";

is_approx $one-and-one-hundredth.log, 1.01.log, "1.01.log is correct";
is_approx log($one-and-one-hundredth), 1.01.log, "log(1.01) is correct";
is_approx $one-and-one-hundredth.log($ten), 1.01.log10, "1.01.log(10) is correct";
is_approx log($one-and-one-hundredth, $ten), 1.01.log10, "log(1.01, 10) is correct";
is_approx $one-and-one-hundredth.log($ten * 1i), 1.01.log / log(10i), "1.01.log(10i) is correct";
is_approx ($one-and-one-hundredth * 1i).log($ten), log(1.01i) / log(10), "1.01i.log(10) is correct";

is_approx $one-and-one-hundredth.cis, 1.01.cis, "1.01.cis is correct";
is_approx cis($one-and-one-hundredth), 1.01.cis, "cis(1.01) is correct";
is_approx $one-and-one-hundredth.unpolar($neg-pi), 1.01.unpolar(-3.14), "1.01.unpolar(-3.14) is correct";
is_approx unpolar($one-and-one-hundredth, $neg-pi), 1.01.unpolar(-3.14), "1.01.unpolar(-3.14) is correct";

is $one-and-one-hundredth.floor, 1, "1.01.floor is correct";
is floor(1), 1, "1.floor is correct";
is $one-and-one-hundredth.ceiling, 2, "1.01.ceiling is correct";
is ceiling(1), 1, "1.ceiling is correct";
is $one-and-one-hundredth.truncate, 1, "1.01.truncate is correct";
is truncate($neg-pi), -3, "-3.14.truncate is correct";
is $one-and-one-hundredth.round(1/100), 1.01, "1.01.round(1/100) is correct";
is round($one-and-one-hundredth, 1/10), 1, "1.01.round(1/10) is correct";
is round($one-and-one-hundredth), 1, "1.01.round is correct";

is $one-and-one-hundredth ** $neg-pi, 1.01 ** -3.14, "1.01 ** -3.14 is correct";
is $neg-pi ** $one, -3.14 ** 1, "-3.14 ** 1 is correct";

is $one-and-one-hundredth.exp, 1.01.exp, "1.01.exp is correct";
is $neg-pi.exp, (-3.14).exp, "-3.14.exp is correct";
is $one-and-one-hundredth.exp(10.Rat), 1.01.exp(10), "1.01.exp(10) is correct";
is 2.exp($neg-pi), 2.exp(-3.14), "2.exp(-3.14) is correct";
is_approx $one-and-one-hundredth.exp(10i), 1.01.exp(10i), "1.01.exp(10i) is correct";

{
    my @l = $neg-pi.roots(4);
    ok(@l.elems == 4, '(-3.14).roots(4) returns 4 elements');
    my $quartic = (-3.14.Complex) ** .25;
    ok(@l.grep({ ($_ - $quartic).abs < 1e-5 }).Bool, '(-3.14) ** 1/4 is a quartic root of -3.14');
    ok(@l.grep({ ($_ + $quartic).abs < 1e-5 }).Bool, '-(-3.14) ** 1/4 is a quartic root of -3.14');
    ok(@l.grep({ ($_ - $quartic\i).abs < 1e-5 }).Bool, '(-3.14)i ** 1/4 is a quartic root of -3.14');
    ok(@l.grep({ ($_ + $quartic\i).abs < 1e-5 }).Bool, '-(-3.14)i ** 1/4 is a quartic root of -3.14');
}

ok 0 <= 4.rand < 4, "Int.rand returns a valid result";
ok 0 <= (4/3).rand < 4/3, "Rat.rand returns a valid result";
ok 0 <= $one-and-one-hundredth.rand < $one-and-one-hundredth, "Fixed2.rand returns a valid result";
ok 0 <= 32.75.Num.rand < 32.75, "Num.rand returns a valid result";

done;

# vim: ft=perl6
