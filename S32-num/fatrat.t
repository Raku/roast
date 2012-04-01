use v6;

use Test;

plan 253;

# Basic test functions specific to FatRats.

# Test ways of making Rats
isa_ok(FatRat.new(1,4), FatRat, "FatRat.new makes a FatRat");
isa_ok( (1/4).FatRat, FatRat, "cast of Rat makes a FatRat");
isa_ok( 1.Int.FatRat, FatRat, "cast of Int makes a FatRat");
isa_ok( 1.Num.FatRat, FatRat, "cast of Num makes a FatRat");

isa_ok(1 / 4, Rat, "/ makes a Rat");

isa_ok( eval(FatRat.new(1, 3).perl), FatRat, 'eval FatRat.new(1, 3).perl is FatRat' );
is_approx (eval FatRat.new(1, 3).perl), 1/3, 'eval FatRat.new(1, 3).perl is 1/3';

# Test ~
is(~(FatRat.new(1,4)), ~(0.25e0), "FatRats stringify properly");
is(~(FatRat.new(-1,2)), ~(-0.5e0), "FatRats stringify properly");
is(~(FatRat.new(7,4)), ~(1.75e0), "FatRats stringify properly");
is(~(FatRat.new(7,-1)), ~(-7), "FatRats stringify properly");

# Test new
is(FatRat.new(1, -7).nude, (-1, 7), "Negative signs move to numeFatRator");
is(FatRat.new(-32, -33).nude, (32, 33), "Double negatives cancel out");
is(FatRat.new(2, 4).nude, (1, 2), "Reduce to simplest form in constructor");
is(FatRat.new(39, 33).nude, (13, 11), "Reduce to simplest form in constructor");
is(FatRat.new(0, 33).nude, (0, 1), "Reduce to simplest form in constructor");
is(FatRat.new(1451234131, 60).nude, (1451234131, 60), "Reduce huge number to simplest form in constructor");

sub postfix:<R>($x) { $x.FatRat }

isa_ok 1R, FatRat, "1R is a FatRat";
is 1R, 1, "1R == 1";
isa_ok 1/4R, FatRat, "1/4R is a FatRat";
is 1/4R, 1/4, "1/4R == 1/4";
 
# Test basic math
is(1 / 4R + 1 / 4R, 1/2, "1/4R + 1/4R = 1/2");
isa_ok(1 / 4R + 1 / 4R, FatRat, "1/4R + 1/4R is a FatRat");
is(1 / 4 + 1 / 4R, 1/2, "1/4 + 1/4R = 1/2");
isa_ok(1 / 4 + 1 / 4R, FatRat, "1/4 + 1/4R is a FatRat");
is(1 / 4R + 1 / 4, 1/2, "1/4R + 1/4 = 1/2");
isa_ok(1 / 4R + 1 / 4, FatRat, "1/4R + 1/4 is a FatRat");
is(1 / 4R + 2 / 7R, 15/28, "1/4R + 2/7R = 15/28");
is(1 / 4R + 1, 5/4, "1/4R + 1 = 5/4");
isa_ok(1 / 4R + 1, FatRat, "1/4R + 1 is a FatRat");
is(1 + 1 / 4R, 5/4, "1 + 1/4R = 5/4");
isa_ok(1 + 1 / 4R, FatRat, "1 + 1/4R is a FatRat");

is(1 / 4R - 1 / 4R, 0/1, "1/4R - 1/4R = 0/1");
is(1 / 4R - 3 / 4R, -1/2, "1/4R - 3/4R = -1/2");
is((1 / 4R - 3 / 4R).nude, (-1, 2), "1/4R - 3/4R = -1/2 is simplified internally");
isa_ok((1 / 4R - 3 / 4R), FatRat, "1/4R - 3/4R is a FatRat");
isa_ok((1 / 4 - 3 / 4R), FatRat, "1/4 - 3/4R is a FatRat");
isa_ok((1 / 4R - 3 / 4), FatRat, "1/4R - 3/4 is a FatRat");
is(1 / 4R - 1, -3/4, "1/4R - 1 = -3/4R");
isa_ok(1 / 4R - 1, FatRat, "1/4R - 1 is a FatRat");
is(1 - 1 / 4R, 3/4, "1 - 1/4R = 3/4R");
isa_ok(1 - 1 / 4R, FatRat, "1 - 1/4R is a FatRat");

is((2 / 3R) * (5 / 4R), 5/6, "2/3R * 5/4R = 5/6");
is(((2 / 3R) * (5 / 4R)).nude, (5, 6), "2/3R * 5/4R = 5/6 is simplified internally");
isa_ok((2 / 3R) * (5 / 4R), FatRat, "2/3R * 5/4R is a FatRat");
isa_ok((2 / 3) * (5 / 4R), FatRat, "2/3 * 5/4R is a FatRat");
isa_ok((2 / 3R) * (5 / 4), FatRat, "2/3R * 5/4 is a FatRat");
is((2 / 3R) * 2, 4/3, "2/3R * 2 = 4/3");
isa_ok((2 / 3R) * 2, FatRat, "2/3R * 2 is a FatRat");
is(((2 / 3R) * 3).nude, (2, 1), "2R/3 * 3 = 2 is simplified internally");
is(2 * (2 / 3R), 4/3, "2 * 2/3R = 4/3");
isa_ok(2 * (2 / 3R), FatRat, "2 * 2/3R is a FatRat");
is((3 * (2 / 3R)).nude, (2, 1), "3 * 2/3R = 2 is simplified internally");

is((2 / 3R) / (5 / 4R), 8/15, "2/3R / 5/4R = 8/15");
isa_ok((2 / 3R) / (5 / 4R), FatRat, "2/3R / 5/4R is a FatRat");
isa_ok((2 / 3) / (5 / 4R), FatRat, "2/3 / 5/4R is a FatRat");
isa_ok((2 / 3R) / (5 / 4), FatRat, "2/3R / 5/4 is a FatRat");
is((2 / 3R) / 2, 1/3, "2/3R / 2 = 1/3");
is(((2 / 3R) / 2).nude, (1, 3), "2/3R / 2 = 1/3 is simplified internally");
isa_ok((2 / 3R) / 2, FatRat, "2/3R / 2 is a FatRat");
is(2 / (1 / 3R), 6, "2 / 1/3R = 6");
isa_ok(2 / (1 / 3R), FatRat, "2 / 1/3R is a FatRat");
is((2 / (2 / 3R)).nude, (3, 1), "2 / 2/3R = 3 is simplified internally");

{
    # use numbers that can be exactly represented as floating points
    # so there's no need to use is_approx 

    my $a = 1/2R;
    is ++$a, 3/2, 'prefix:<++> on FatRats';
    is $a++, 3/2, 'postfix:<++> on FatRats (1)';
    is $a,   5/2, 'postfix:<++> on FatRats (2)';
    isa_ok $a, FatRat, "and it's still a FatRat";
    $a = -15/8R;
    is ++$a, -7/8, 'prefix:<++> on negative FatRat';

    my $b = 5/2R;
    is --$b, 3/2, 'prefix:<--> on FatRats';
    is $b--, 3/2, 'postfix:<--> on FatRats (1)';
    is $b,   1/2, 'postfix:<--> on FatRats (2)';
    isa_ok $b, FatRat, "and it's still a FatRat";
    $b = -15/8R;
    is --$b, -23/8, 'prefix:<--> on negative FatRat';
}

# Give the arithmetical operators a workout

for -1/4R, 2/7R, 65/8R / 10**100 -> $a {
    for -7, 0, 1, 5 -> $b {
        is_approx($a + $b, $a.Num + $b.Num, "FatRat + Int works ($a, $b)");
        is_approx($b + $a, $b.Num + $a.Num, "Int + FatRat works ($a, $b)");
        is_approx($a - $b, $a.Num - $b.Num, "FatRat - Int works ($a, $b)");
        is_approx($b - $a, $b.Num - $a.Num, "Int - FatRat works ($a, $b)");
        is_approx($a * $b, $a.Num * $b.Num, "FatRat * Int works ($a, $b)");
        is_approx($b * $a, $b.Num * $a.Num, "Int * FatRat works ($a, $b)");
        is_approx($a / $b, $a.Num / $b.Num, "FatRat / Int works ($a, $b)") if $b != 0;
        is_approx($b / $a, $b.Num / $a.Num, "Int / FatRat works ($a, $b)");
    }

    for (1R/2**256, -4/5R) -> $b {
        is_approx($a + $b, $a.Num + $b.Num, "FatRat + FatRat works ($a, $b)");
        is_approx($b + $a, $b.Num + $a.Num, "FatRat + FatRat works ($a, $b)");
        is_approx($a - $b, $a.Num - $b.Num, "FatRat - FatRat works ($a, $b)");
        is_approx($b - $a, $b.Num - $a.Num, "FatRat - FatRat works ($a, $b)");
        is_approx($a * $b, $a.Num * $b.Num, "FatRat * FatRat works ($a, $b)");
        is_approx($b * $a, $b.Num * $a.Num, "FatRat * FatRat works ($a, $b)");
        is_approx($a / $b, $a.Num / $b.Num, "FatRat / FatRat works ($a, $b)");
        is_approx($b / $a, $b.Num / $a.Num, "FatRat / FatRat works ($a, $b)");
    }

    my $neg = -$a;
    isa_ok($neg, FatRat, "prefix<-> geneFatRates a FatRat on $a");
    is_approx($neg, -($a.Num), "prefix<-> geneFatRates the correct number for $a");
}

# (note that trig on Rats is tested extensively in S32-trig but not trig on FatRats.  yet.)

is_approx sin(5.0e0), sin(10/2R), 'sin(FatRat) works';

# Quick test of some basic mixed type math

is_approx (1 / 2R) + 3.5e0, 4.0, "1/2R + 3.5 = 4.0";
is_approx 3.5e0 + (1 / 2R), 4.0, "3.5 + 1/2R = 4.0";
is_approx (1 / 2R) - 3.5e0, -3.0, "1/2R - 3.5 = -3.0";
is_approx 3.5e0 - (1 / 2R), 3.0, "3.5 - 1/2R = 3.0";
is_approx (1 / 3R) * 6.6e0, 2.2, "1/3R * 6.6 = 2.2";
is_approx 6.6e0 * (1 / 3R), 2.2, "6.6 * 1/3R = 2.2";
is_approx (1 / 3R) / 2.0e0, 1 / 6, "1/3R / 2.0 = 1/6";
is_approx 2.0e0 / (1 / 3R), 6.0, "2.0 / 1/3R = 6.0";

is_approx (1 / 2R) + 3.5e0 + 1i, 4.0 + 1i, "1/2R + 3.5 + 1i = 4.0 + 1i";
is_approx (3.5e0 + 1i) + (1 / 2R), 4.0 + 1i, "(3.5 + 1i) + 1/2R = 4.0 + 1i";
is_approx (1 / 2R) - (3.5e0 + 1i), -3.0 - 1i, "1/2R - (3.5 + 1i) = -3.0 - 1i";
is_approx (3.5e0 + 1i) - (1 / 2R), 3.0 + 1i, "(3.5 + 1i) - 1/2R = 3.0 + 1i";
is_approx (1 / 3R) * (6.6e0 + 1i), 2.2 + (1i/3), "1/3R * (6.6 + 1i) = 2.2 + (1/3)i";
is_approx (6.6e0 + 1i) * (1 / 3R), 2.2 + (1i/3), "(6.6 + 1i) * 1/3R = 2.2 + (1/3)i";
is_approx (1 / 3R) / 2.0i, 1 / (6.0i), "1/3R / 2.0i = 1/(6i)";
is_approx 2.0i / (1 / 3R), 6.0i, "2.0i / 1/3R = 6.0i";

# # Cast from Num uses an epsilon value.
# -- Off because we need to figure out the right way to do this
# is( exp(1).FatRat, FatRat.new(2721, 1001), "Num to FatRat with default epsilon");
# is( exp(1).FatRat(1e-4), FatRat.new(193, 71), "Num to FatRat with epsilon 1e-4");
# is( exp(1).FatRat(FatRat.new(1,1e4.Int)), FatRat.new(193, 71),
#     "Num to FatRat with epsilon of FatRat");

is (5/4R).Int,       1, 'FatRat.Int';
is <a b c>.[4/3R],  'b', 'Indexing an array with a FatRat';

ok (1/2R) == (1/2).FatRat, 'Rat.FatRat works';
isa_ok (1/2).FatRat, FatRat, '... and actually returns a FatRat';
ok (1/2R) == (1/2R).FatRat, 'FatRat.FatRat works';
isa_ok (1/2R).FatRat, FatRat, '... and actually returns a FatRat';

ok 1/2R === 1/2R, 'FatRats are value types, so 1/2R === 1/2R';
ok 1/2R !=== 1/3R, '=== with false outcome';

#?rakudo skip 'FatRat arith + type objects'
{
    my FatRat $a;
    $a += 0.1 for ^10;
    ok $a == 1, 'can do += on variable initialized by type object';
    isa_ok $a, FatRat, "and it's the correct type";
}

ok 16/5R eqv 16/5R, 'infix:<eqv> works with FatRats';

#?rakudo todo 'unknown'
isa_ok .88888888888R.WHAT.gist, 'FatRat()', 'WHAT works on FatRat created from 11 digit decimal fraction';

{
    my $a += 0.1R;
    isa_ok $a, FatRat, 'Any() + 0.1R is a FatRat';
}

isa_ok (2/3R) ** 3, FatRat, "FatRat raised to a positive Int power is a FatRat";
is (2/3R) ** 3, 8/27, "FatRat raised to a positive Int power gets correct answer";

nok (1 - 0.5.FatRat ** 128) == 1, 'infix:<==> does not go through Num';

done;

# vim: ft=perl6
