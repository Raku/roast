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

done_testing;

# vim: ft=perl6
