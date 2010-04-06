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

done_testing;

# vim: ft=perl6
