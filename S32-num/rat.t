use v6;

use Test;

plan *;

# Basic test functions specific to rational numbers.

# Test ~
is(~(Rat.new(1,4)), ~(0.25), "Rats stringify properly");
is(~(Rat.new(-1,2)), ~(-0.5), "Rats stringify properly");
is(~(Rat.new(7,4)), ~(1.75), "Rats stringify properly");
is(~(Rat.new(7,-1)), ~(-7), "Rats stringify properly");

# Test new
is(Rat.new(1, -7).nude, (-1, 7), "Negative signs move to numerator");
is(Rat.new(-32, -33).nude, (32, 33), "Double negatives cancel out");
is(Rat.new(2, 4).nude, (1, 2), "Reduce to simplest form in constructor");
is(Rat.new(39, 33).nude, (13, 11), "Reduce to simplest form in constructor");
is(Rat.new(0, 33).nude, (0, 1), "Reduce to simplest form in constructor");
is(Rat.new(1451234131, 60).nude, (1451234131, 60), "Reduce huge number to simplest form in constructor");

# Test basic math
is(1 / 4 + 1 / 4, 1/2, "1/4 + 1/4 = 1/2");
isa_ok(1 / 4 + 1 / 4, Rat, "1/4 + 1/4 is a Rat");
is(1 / 4 + 2 / 7, 15/28, "1/4 + 2/7 = 15/28");
is(1 / 4 + 1, 5/4, "1/4 + 1 = 5/4");
isa_ok(1 / 4 + 1, Rat, "1/4 + 1 is a Rat");
is(1 + 1 / 4, 5/4, "1 + 1/4 = 5/4");
isa_ok(1 + 1 / 4, Rat, "1 + 1/4 is a Rat");

is(1 / 4 - 1 / 4, 0/1, "1/4 - 1/4 = 0/1");
is(1 / 4 - 3 / 4, -1/2, "1/4 - 3/4 = -1/2");
is((1 / 4 - 3 / 4).nude, (-1, 2), "1/4 - 3/4 = -1/2 is simplified internally");
isa_ok((1 / 4 - 3 / 4), Rat, "1/4 - 3/4 is a Rat");
is(1 / 4 - 1, -3/4, "1/4 - 1 = -3/4");
isa_ok(1 / 4 - 1, Rat, "1/4 - 1 is a Rat");
is(1 - 1 / 4, 3/4, "1 - 1/4 = 3/4");
isa_ok(1 - 1 / 4, Rat, "1 - 1/4 is a Rat");

is((2 / 3) * (5 / 4), 5/6, "2/3 * 5/4 = 5/6");
is(((2 / 3) * (5 / 4)).nude, (5, 6), "2/3 * 5/4 = 5/6 is simplified internally");
isa_ok((2 / 3) * (5 / 4), Rat, "2/3 * 5/4 is a Rat");
is((2 / 3) * 2, 4/3, "2/3 * 2 = 4/3");
isa_ok((2 / 3) * 2, Rat, "2/3 * 2 is a Rat");
is(((2 / 3) * 3).nude, (2, 1), "2/3 * 3 = 2 is simplified internally");
is(2 * (2 / 3), 4/3, "2 * 2/3 = 4/3");
isa_ok(2 * (2 / 3), Rat, "2 * 2/3 is a Rat");
is((3 * (2 / 3)).nude, (2, 1), "3 * 2/3 = 2 is simplified internally");

is((2 / 3) / (5 / 4), 8/15, "2/3 / 5/4 = 8/15");
isa_ok((2 / 3) / (5 / 4), Rat, "2/3 / 5/4 is a Rat");
is((2 / 3) / 2, 1/3, "2/3 / 2 = 1/3");
is(((2 / 3) / 2).nude, (1, 3), "2/3 / 2 = 1/3 is simplified internally");
isa_ok((2 / 3) / 2, Rat, "2/3 / 2 is a Rat");
is(2 / (1 / 3), 6, "2 / 1/3 = 6");
isa_ok(2 / (1 / 3), Rat, "2 / 1/3 is a Rat");
is((2 / (2 / 3)).nude, (3, 1), "2 / 2/3 = 3 is simplified internally");

# Give the arithmetical operators a workout

for (1/2, 2/3, -1/4, 4/5, 2/7, 65/8) -> $a {
    for (-7, -1, 0, 1, 2, 5, 7, 42) -> $b {
        is_approx($a + $b, $a.Num + $b.Num, "Rat + Int works ($a, $b)");
        is_approx($b + $a, $b.Num + $a.Num, "Int + Rat works ($a, $b)");
        is_approx($a - $b, $a.Num - $b.Num, "Rat - Int works ($a, $b)");
        is_approx($b - $a, $b.Num - $a.Num, "Int - Rat works ($a, $b)");
        is_approx($a * $b, $a.Num * $b.Num, "Rat * Int works ($a, $b)");
        is_approx($b * $a, $b.Num * $a.Num, "Int * Rat works ($a, $b)");
        is_approx($a / $b, $a.Num / $b.Num, "Rat / Int works ($a, $b)") if $b != 0;
        is_approx($b / $a, $b.Num / $a.Num, "Int / Rat works ($a, $b)");
    }

    for (1/2, 2/3, -1/4, 4/5, 2/7, 65/8) -> $b {
        is_approx($a + $b, $a.Num + $b.Num, "Rat + Rat works ($a, $b)");
        is_approx($b + $a, $b.Num + $a.Num, "Rat + Rat works ($a, $b)");
        is_approx($a - $b, $a.Num - $b.Num, "Rat - Rat works ($a, $b)");
        is_approx($b - $a, $b.Num - $a.Num, "Rat - Rat works ($a, $b)");
        is_approx($a * $b, $a.Num * $b.Num, "Rat * Rat works ($a, $b)");
        is_approx($b * $a, $b.Num * $a.Num, "Rat * Rat works ($a, $b)");
        is_approx($a / $b, $a.Num / $b.Num, "Rat / Rat works ($a, $b)");
        is_approx($b / $a, $b.Num / $a.Num, "Rat / Rat works ($a, $b)");
    }

    my $neg = -$a;
    isa_ok($neg, Rat, "prefix<-> generates a Rat on $a");
    is_approx($neg, -($a.Num), "prefix<-> generates the correct number for $a");
}

# used to be a (never ticketed) Rakudo bug: sin(Rat) died

is_approx sin(5.0), sin(10/2), 'sin(Rat) works';

# SHOULD: Add divide by zero / zero denominator tests

done_testing;

# vim: ft=perl6
