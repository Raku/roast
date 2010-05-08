use v6;
use Test;
plan *;

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

is $zero <=> 0, 0, "0 == 0";
is $one <=> 0.Num, 1, "1 > 0";
is $one-and-one-hundredth <=> 1.1, -1, "1.01 < 1.1";
is $neg-pi <=> -3, -1, "-3.14 < -3";
is -1 <=> $zero, -1, "-1 < 0";
is 1.Rat <=> $one, 0, "1 == 1";
is 1.001 <=> $one-and-one-hundredth, -1, "1.001 < 1.01";
is $neg-pi <=> -3.14, 0, "-3.14 == -3.14";

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

nok $zero != 0, "not 0 != 0";
ok $one != 0.Num, "1 != 0";
ok $one-and-one-hundredth != 1.1, "1.01 != 1.1";
ok $neg-pi != -3, "-3.14 != -3";
ok -1 != $zero, "-1 != 0";
nok 1.Rat != $one, "not 1 != 1";
ok 1.001 != $one-and-one-hundredth, "1.001 != 1.01";
nok $neg-pi != -3.14, "not -3.14 != -3.14";

is_approx -$zero, 0, "-0 == 0";
is_approx -$one, -1, "-1 == -1";
is_approx -$one-and-one-hundredth, -1.01, "-1.01 == -1.01";
is_approx -$neg-pi, 3.14, "-(-3.14) == 3.14";

is $one - $one, 0, "1 - 1 == 0";
is $one - 1, 0, "1 - 1 == 0";
is $one-and-one-hundredth - $one-and-one-hundredth, 0, "1.01 - 1.01 == 0";
is $one-and-one-hundredth - 1.01, 0, "1.01 - 1.01 == 0";
is_approx 1.01 - $one, 0.01, "1.01 - 1 == 0.01";
is_approx $one-and-one-hundredth - 1.Num, 0.01, "1.01 - 1 == 0.01";

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
is $one-and-one-hundredth.exp(10i), 1.01.exp(10i), "1.01.exp(10i) is correct";
is 2i.exp($neg-pi), 2i.exp(-3.14), "2i.exp(-3.14) is correct";

done_testing;

# vim: ft=perl6
