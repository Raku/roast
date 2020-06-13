use v6;
use Test;
use lib $?FILE.IO.parent(2).add("packages/Test-Helpers");
use Test::Util;

plan 867;

# Basic test functions specific to rational numbers.

# Test ways of making Rats
isa-ok(Rat.new(1,4), Rat, "Rat.new makes a Rat");
isa-ok(1 / 4, Rat, "/ makes a Rat");
isa-ok( 1.Int.Rat, Rat, "cast of Int makes a Rat");
isa-ok( 1.Num.Rat, Rat, "cast of Num makes a Rat");

isa-ok( Rat.new, Rat, 'Rat.new is Rat' );
isa-ok( EVAL(Rat.new.raku), Rat, 'EVAL Rat.new.raku is Rat' );
isa-ok( EVAL(Rat.new(1, 3).raku), Rat, 'EVAL Rat.new(1, 3).raku is Rat' );
is( (EVAL Rat.new(1, 3).raku), 1/3, 'EVAL Rat.new(1, 3).raku is 1/3' );
isa-ok( EVAL((1/3).raku), Rat, 'EVAL (1/3).raku is Rat' );
is( (EVAL (1/3).raku), 1/3, 'EVAL (1/3).raku is 1/3' );
is( (1/10).raku, "0.1", '(1/10).raku is 0.1' );
is( (1/5).raku, "0.2", '(1/5).raku is .2' );
is( (1/2).raku, "0.5", '(1/2).raku is .5' );
is 1/128, (1/128).raku.EVAL, '(1/128).raku.EVAL round trips with sufficient accuracy';
is 1/128, (1/128).raku.EVAL, '(1/128).raku.EVAL round trips with sufficient accuracy';
# https://github.com/Raku/old-issue-tracker/issues/4845
is(Rat.new(807412079564, 555).raku.EVAL, Rat.new(807412079564, 555), '807412079564/555 round trips without a compile_time_value error');

# Test ~
is(~(Rat.new(1,4)), ~(0.25e0), "Rats stringify properly");
is(~(Rat.new(-1,2)), ~(-0.5e0), "Rats stringify properly");
is(~(Rat.new(7,4)), ~(1.75e0), "Rats stringify properly");
is(~(Rat.new(7,-1)), ~(-7), "Rats stringify properly");

# Test new
is(Rat.new(1, -7).nude, (-1, 7), "Negative signs move to numerator");
is(Rat.new(-32, -33).nude, (32, 33), "Double negatives cancel out");
is(Rat.new(2, 4).nude, (1, 2), "Reduce to simplest form in constructor");
is(Rat.new(39, 33).nude, (13, 11), "Reduce to simplest form in constructor");
is(Rat.new(0, 33).nude, (0, 1), "Reduce to simplest form in constructor");
is(Rat.new(1451234131, 60).nude, (1451234131, 60), "Reduce huge number to simplest form in constructor");
is(Rat.new(1141234123, 0).nude, (1, 0), "Huge over zero is normalized");
is(Rat.new(-7, 0).nude, (-1, 0), "Negative seven over zero is normalized");
is(Rat.new(0, 0).nude, (0,0), "Zero over zero stays zero over zero");

# Test basic math
is(1 / 4 + 1 / 4, 1/2, "1/4 + 1/4 = 1/2");
isa-ok(1 / 4 + 1 / 4, Rat, "1/4 + 1/4 is a Rat");
is(1 / 4 + 2 / 7, 15/28, "1/4 + 2/7 = 15/28");
is(1 / 4 + 1, 5/4, "1/4 + 1 = 5/4");
isa-ok(1 / 4 + 1, Rat, "1/4 + 1 is a Rat");
is(1 + 1 / 4, 5/4, "1 + 1/4 = 5/4");
isa-ok(1 + 1 / 4, Rat, "1 + 1/4 is a Rat");

is(1 / 4 - 1 / 4, 0/1, "1/4 - 1/4 = 0/1");
is(1 / 4 - 3 / 4, -1/2, "1/4 - 3/4 = -1/2");
is((1 / 4 - 3 / 4).nude, (-1, 2), "1/4 - 3/4 = -1/2 is simplified internally");
isa-ok((1 / 4 - 3 / 4), Rat, "1/4 - 3/4 is a Rat");
is(1 / 4 - 1, -3/4, "1/4 - 1 = -3/4");
isa-ok(1 / 4 - 1, Rat, "1/4 - 1 is a Rat");
is(1 - 1 / 4, 3/4, "1 - 1/4 = 3/4");
isa-ok(1 - 1 / 4, Rat, "1 - 1/4 is a Rat");

is((2 / 3) * (5 / 4), 5/6, "2/3 * 5/4 = 5/6");
is(((2 / 3) * (5 / 4)).nude, (5, 6), "2/3 * 5/4 = 5/6 is simplified internally");
isa-ok((2 / 3) * (5 / 4), Rat, "2/3 * 5/4 is a Rat");
is((2 / 3) * 2, 4/3, "2/3 * 2 = 4/3");
isa-ok((2 / 3) * 2, Rat, "2/3 * 2 is a Rat");
is(((2 / 3) * 3).nude, (2, 1), "2/3 * 3 = 2 is simplified internally");
is(2 * (2 / 3), 4/3, "2 * 2/3 = 4/3");
isa-ok(2 * (2 / 3), Rat, "2 * 2/3 is a Rat");
is((3 * (2 / 3)).nude, (2, 1), "3 * 2/3 = 2 is simplified internally");

is((2 / 3) / (5 / 4), 8/15, "2/3 / 5/4 = 8/15");
isa-ok((2 / 3) / (5 / 4), Rat, "2/3 / 5/4 is a Rat");
is((2 / 3) / 2, 1/3, "2/3 / 2 = 1/3");
is(((2 / 3) / 2).nude, (1, 3), "2/3 / 2 = 1/3 is simplified internally");
isa-ok((2 / 3) / 2, Rat, "2/3 / 2 is a Rat");
is(2 / (1 / 3), 6, "2 / 1/3 = 6");
isa-ok(2 / (1 / 3), Rat, "2 / 1/3 is a Rat");
is((2 / (2 / 3)).nude, (3, 1), "2 / 2/3 = 3 is simplified internally");

{
    # use numbers that can be exactly represented as floating points
    # so there's no need to use is-approx

    my $a = 1/2;
    is ++$a, 3/2, 'prefix:<++> on Rats';
    is $a++, 3/2, 'postfix:<++> on Rats (1)';
    is $a,   5/2, 'postfix:<++> on Rats (2)';
    $a = -15/8;
    is ++$a, -7/8, 'prefix:<++> on negative Rat';

    my $b = 5/2;
    is --$b, 3/2, 'prefix:<--> on Rats';
    is $b--, 3/2, 'postfix:<--> on Rats (1)';
    is $b,   1/2, 'postfix:<--> on Rats (2)';
    $b = -15/8;
    is --$b, -23/8, 'prefix:<--> on negative Rat';
}

# Give the arithmetical operators a workout

{
    for 1/2, 2/3, -1/4, 4/5, 2/7, 65/8 -> $a {
        for -7, -1, 0, 1, 2, 5, 7, 42 -> $b {
            is-approx($a + $b, $a.Num + $b.Num, "Rat + Int works ($a, $b)");
            is-approx($b + $a, $b.Num + $a.Num, "Int + Rat works ($a, $b)");
            is-approx($a - $b, $a.Num - $b.Num, "Rat - Int works ($a, $b)");
            is-approx($b - $a, $b.Num - $a.Num, "Int - Rat works ($a, $b)");
            is-approx($a * $b, $a.Num * $b.Num, "Rat * Int works ($a, $b)");
            is-approx($b * $a, $b.Num * $a.Num, "Int * Rat works ($a, $b)");
            is-approx($a / $b, $a.Num / $b.Num, "Rat / Int works ($a, $b)") if $b != 0;
            is-approx($b / $a, $b.Num / $a.Num, "Int / Rat works ($a, $b)");
        }

        for (1/2, 2/3, -1/4, 4/5, 2/7, 65/8) -> $b {
            is-approx($a + $b, $a.Num + $b.Num, "Rat + Rat works ($a, $b)");
            is-approx($b + $a, $b.Num + $a.Num, "Rat + Rat works ($a, $b)");
            is-approx($a - $b, $a.Num - $b.Num, "Rat - Rat works ($a, $b)");
            is-approx($b - $a, $b.Num - $a.Num, "Rat - Rat works ($a, $b)");
            is-approx($a * $b, $a.Num * $b.Num, "Rat * Rat works ($a, $b)");
            is-approx($b * $a, $b.Num * $a.Num, "Rat * Rat works ($a, $b)");
            is-approx($a / $b, $a.Num / $b.Num, "Rat / Rat works ($a, $b)");
            is-approx($b / $a, $b.Num / $a.Num, "Rat / Rat works ($a, $b)");
        }

        my $neg = -$a;
        isa-ok($neg, Rat, "prefix<-> generates a Rat on $a");
        is-approx($neg, -($a.Num), "prefix<-> generates the correct number for $a");
    }
}

# used to be a (never ticketed) Rakudo bug: sin(Rat) died
# (note that trig on Rats is tested extensively in S32-trig)

is-approx sin(5.0e0), sin(10/2), 'sin(Rat) works';

subtest '±Inf/NaN ⇿ Rat' => {
    plan 2*19;
    for <Rat  FatRat> -> $m {
        cmp-ok    NaN."$m"().Num, '===',  NaN,   "NaN.$m.Num roundtrips";
        cmp-ok    Inf."$m"().Num, '===',  Inf,   "Inf.$m.Num roundtrips";
        cmp-ok (-Inf)."$m"().Num, '===', -Inf, "(-Inf.$m.Num roundtrips";

        ok NaN."$m"().isNaN, "NaN.$m is a NaN";
        cmp-ok    Inf."$m"(), '==',  Inf,    "Inf.$m ==  Inf";
        cmp-ok (-Inf)."$m"(), '==', -Inf, "(-Inf).$m == -Inf";

        subtest 'Num ⇾ (zero-denominator Rationals) normalizes numerator' => {
            plan 6;
            is-deeply    NaN."$m"().nude,  (0, 0),    "NaN.$m";
            is-deeply    Inf."$m"().nude,  (1, 0),    "Inf.$m";
            is-deeply (-Inf)."$m"().nude, (-1, 0), "(-Inf).$m";

            is-deeply  <0/0>.Num."$m"().nude,  (0, 0),    "NaN.$m";
            is-deeply <42/0>.Num."$m"().nude,  (1, 0),    "Inf.$m";
            is-deeply <-2/0>.Num."$m"().nude, (-1, 0), "(-Inf).$m";
        }

        throws-like { NaN."$m"().Str }, X::Numeric::DivideByZero,
               "NaN.$m.Str throws division-by-zero";
        throws-like { Inf."$m"().Str }, X::Numeric::DivideByZero,
               "Inf.$m.Str throws division-by-zero";
        throws-like { (-Inf)."$m"().Str }, X::Numeric::DivideByZero,
            "(-Inf).$m.Str throws division-by-zero";

        # https://github.com/Raku/old-issue-tracker/issues/5822
        
        is-deeply    NaN."$m"().raku.EVAL, ::($m).new(0, 0),
               "NaN.$m.raku.EVAL roundtrips";
        is-deeply    Inf."$m"().raku.EVAL, ::($m).new(1, 0),
               "Inf.$m.raku.EVAL roundtrips";
        is-deeply (-Inf)."$m"().raku.EVAL, ::($m).new(-1, 0),
            "(-Inf).$m.raku.EVAL roundtrips";

        # https://github.com/Raku/old-issue-tracker/issues/5822
        
        is-deeply    NaN."$m"() * 0, ::($m).new(0, 0),
               "NaN.$m does not explode when used in Rational math";
        is-deeply    Inf."$m"() * 0, ::($m).new(0, 0),
               "Inf.$m does not explode when used in Rational math";
        is-deeply (-Inf)."$m"() * 0, ::($m).new(0, 0),
            "(-Inf).$m does not explode when used in Rational math";

        # https://github.com/Raku/old-issue-tracker/issues/5538
        
        cmp-ok    NaN."$m"(), '~~', ::($m),    "NaN.$m smartmatches with $m";
        cmp-ok    Inf."$m"(), '~~', ::($m),    "Inf.$m smartmatches with $m";
        cmp-ok (-Inf)."$m"(), '~~', ::($m), "(-Inf).$m smartmatches with $m";
    }
}

# https://github.com/Raku/old-issue-tracker/issues/1723
throws-like { Inf.Int / 1 }, X::Numeric::CannotConvert, 'Inf.Int / 1 throws';

# Quick test of some basic mixed type math

is-approx (1 / 2) + 3.5e0, 4.0, "1/2 + 3.5 = 4.0";
is-approx 3.5e0 + (1 / 2), 4.0, "3.5 + 1/2 = 4.0";
is-approx (1 / 2) - 3.5e0, -3.0, "1/2 - 3.5 = -3.0";
is-approx 3.5e0 - (1 / 2), 3.0, "3.5 - 1/2 = 3.0";
is-approx (1 / 3) * 6.6e0, 2.2, "1/3 * 6.6 = 2.2";
is-approx 6.6e0 * (1 / 3), 2.2, "6.6 * 1/3 = 2.2";
is-approx (1 / 3) / 2.0e0, 1 / 6, "1/3 / 2.0 = 1/6";
is-approx 2.0e0 / (1 / 3), 6.0, "2.0 / 1/3 = 6.0";

is-approx (1 / 2) + 3.5e0 + 1i, 4.0 + 1i, "1/2 + 3.5 + 1i = 4.0 + 1i";
is-approx (3.5e0 + 1i) + (1 / 2), 4.0 + 1i, "(3.5 + 1i) + 1/2 = 4.0 + 1i";
is-approx (1 / 2) - (3.5e0 + 1i), -3.0 - 1i, "1/2 - (3.5 + 1i) = -3.0 - 1i";
is-approx (3.5e0 + 1i) - (1 / 2), 3.0 + 1i, "(3.5 + 1i) - 1/2 = 3.0 + 1i";
is-approx (1 / 3) * (6.6e0 + 1i), 2.2 + (1i/3), "1/3 * (6.6 + 1i) = 2.2 + (1/3)i";
is-approx (6.6e0 + 1i) * (1 / 3), 2.2 + (1i/3), "(6.6 + 1i) * 1/3 = 2.2 + (1/3)i";
is-approx (1 / 3) / 2.0i, 1 / (6.0i), "1/3 / 2.0i = 1/(6i)";
is-approx 2.0i / (1 / 3), 6.0i, "2.0i / 1/3 = 6.0i";

# Cast from Num uses an epsilon value.
is( exp(1).Rat, Rat.new(2721, 1001), "Num to Rat with default epsilon");
is( exp(1).Rat(1e-4), Rat.new(193, 71), "Num to Rat with epsilon 1e-4");
is( exp(1).Rat(Rat.new(1,1e4.Int)), Rat.new(193, 71),
    "Num to Rat with epsilon of Rat");

is (5/4).Int,       1, 'Rat.Int';
# https://github.com/Raku/old-issue-tracker/issues/1358
is <a b c>.[4/3],  'b', 'Indexing an array with a Rat (RT #69738)';

is-approx 424/61731 + 832/61731, 424.Num / 61731.Num + 832.Num / 61731.Num, "424/61731 + 832/61731 works";
is-approx 424/61731 - 832/61731, 424.Num / 61731.Num - 832.Num / 61731.Num, "424/61731 - 832/61731 works";
is-approx 424/61731 + 833/123462, 424.Num / 61731.Num + 833.Num / 123462.Num, "424/61731 + 833/123462 works";
is-approx 424/61731 - 833/123462, 424.Num / 61731.Num - 833.Num / 123462.Num, "424/61731 - 833/123462 works";

isa-ok 424/61731 + 832/61731, Rat, "424/61731 + 832/61731 is a Rat";
isa-ok 424/61731 - 832/61731, Rat, "424/61731 - 832/61731 is a Rat";
isa-ok 424/61731 + 833/123462, Rat, "424/61731 + 833/123462 is a Rat";
isa-ok 424/61731 - 833/123462, Rat, "424/61731 - 833/123462 is a Rat";

is-approx 61731 + 832/61731, 61731.Num + 832.Num / 61731.Num, "61731 + 832/61731 works";
is-approx 832/61731 + 61731, 61731.Num + 832.Num / 61731.Num, "832/61731 + 61731 works";
is-approx 61731 - 832/61731, 61731.Num - 832.Num / 61731.Num, "61731 - 832/61731 works";
is-approx 832/61731 - 61731, 832.Num / 61731.Num - 61731.Num, "832/61731 - 61731 works";

is-approx 424/61731 + 832/61733, 424.Num / 61731.Num + 832.Num / 61733.Num, "424/61731 + 832/61733 works";
is-approx 424/61731 - 832/61733, 424.Num / 61731.Num - 832.Num / 61733.Num, "424/61731 - 832/61733 works";

is-approx (424/61731) * (832/61731), (424.Num / 61731.Num) * (832.Num / 61731.Num), "424/61731 * 832/61731 works";
is-approx (424/61731) / (61731/832), (424.Num / 61731.Num) / (61731.Num / 832.Num), "424/61731 / 61731/832 works";

is-approx 61731 * (61731/832), 61731.Num * (61731.Num / 832.Num), "61731 * 61731/832 works";
is-approx (61731/832) * 61731, 61731.Num * (61731.Num / 832.Num), "61731/832 * 61731 works";
is-approx (832/61731) / 61731, (832.Num / 61731.Num) / 61731.Num, "832/61731 / 61731 works";
is-approx 61731 / (832/61731), 61731.Num / (832.Num / 61731.Num), "61731 / 832/61731 works";

is-approx (424/61731) * (61731/61733), (424.Num / 61731.Num) * (61731.Num / 61733.Num), "424/61731 * 61731/61733 works";
isa-ok (424/61731) * (61731/61733), Rat, "424/61731 * 61731/61733 is a Rat";
is-approx (424/61731) / (61733/61731), (424.Num / 61731.Num) / (61733.Num / 61731.Num), "424/61731 / 61733/61731 works";
isa-ok (424/61731) / (61733/61731), Rat, "424/61731 / 61733/61731 is a Rat";

ok (1/2) == (1/2).Rat, 'Rat.Rat works';
isa-ok (1/2).Rat, Rat, '... and actually returns a Rat';

ok 1/2 === 1/2, 'Rats are value types, so 1/2 === 1/2';
ok 1/2 !=== 1/3, '=== with false outcome';

# http://irclog.perlgeek.de/perl6/2010-02-24#i_2027452
is (3/0).Num, Inf, "(3/0).Num = +Inf";
is (-42/0).Num, -Inf, "(-42/0).Num = -Inf";

ok Rat.new() == 0, 'Rat.new() is 0';

{
    my Rat $a;
    $a += 0.1 for ^10;
    ok $a == 1, 'can do += on variable initialized by type object';
}

ok 16/5 eqv 16/5, 'infix:<eqv> works with rats';

# https://github.com/Raku/old-issue-tracker/issues/1515
is .88888888888.WHAT.gist, Rat.gist, 'WHAT works on Rat created from 11 digit decimal fraction';

# https://github.com/Raku/old-issue-tracker/issues/1717
{
    my $a += 0.1;
    isa-ok $a, Rat, 'Any() + 0.1 is a Rat';
}

isa-ok (2/3) ** 3, Rat, "Rat raised to a positive Int power is a Rat";
is (2/3) ** 3, 8/27, "Rat raised to a positive Int power gets correct answer";
isa-ok (2/3) ** -3, Rat, "Rat raised to a negative Int power is a Rat";
is (2/3) ** -3, 27/8, "Rat raised to a negative Int power gets correct answer";
isa-ok 3 ** -3, Rat, "Int raised to a negative Int power is a Rat";
is 3 ** -3, 1/27, "Int raised to a negative Int power gets correct answer";

# the spec says that Rat denominators can't grow larger than a uint64,
# and arithmetic operations need to spill over to Num
{
    # taken from http://www.perlmonks.org/?node_id=952765
    my $s = 0;
    for 1..1000 {
        $s += 1/$_**2
    };
    is-approx $s, 1.64393456668156, 'can sum up 1/$_**2 in a loop';
    isa-ok $s, Num, 'and we had an overflow to Num';
    my $bigish = 2 ** 34;
    my $bigish_n = $bigish.Num;
    # TODO: not just check the type of the results, but also the numeric value
    isa-ok (1/$bigish) * (1/$bigish),       Num, 'multiplication overflows to Num';
    is-approx (1/$bigish) * (1/$bigish), (1/$bigish_n) * (1/$bigish_n), '... right result';
    isa-ok (1/$bigish) ** 2,                Num, 'exponentation overflows to Num';
    is-approx (1/$bigish) ** 2, (1/$bigish_n) ** 2, '... right result';
    is-approx (1/$bigish) * (1/$bigish), (1/$bigish_n) * (1/$bigish_n), '... right result';
    isa-ok (1/$bigish) + (1 / ($bigish+1)), Num, 'addition overflows to Num';
    is-approx (1/$bigish) + (1/($bigish+1)), (1/$bigish_n) + (1/($bigish_n+1)), '... right result';
    isa-ok (1/$bigish) - (1 / ($bigish+1)), Num, 'subtraction overflows to Num';
    is-approx (1/$bigish) - (1/($bigish+1)), (1/$bigish_n) - (1/($bigish_n+1)), '... right result';
    isa-ok (1/$bigish) / (($bigish+1)/3),   Num, 'division overflows to Num';
    is-approx (1/$bigish) / (($bigish+1)/3), (1/$bigish_n) / (($bigish_n+1)/3), '... right result';

}

is Rat.new(9,33).norm.nude, (3, 11), ".norm exists and doesn't hurt matters";

isa-ok 241025348275725.3352, Rat, "241025348275725.3352 is a Rat";
is 241025348275725.3352.Rat.norm.nude, (301281685344656669, 1250), "Rat.Rat yields correct Rat";

# https://github.com/Raku/old-issue-tracker/issues/2755
is 241025348275725.3352.Str, "241025348275725.3352", 'stringification of bigish Rats';

# https://github.com/Raku/old-issue-tracker/issues/4253

{
    isa-ok((10 ** -1).WHAT, Rat);
    isa-ok((9.0 ** -1).WHAT, Rat);
    isa-ok((9.0 ** 0.5).WHAT, Num);
}

# https://github.com/Raku/old-issue-tracker/issues/4660
try {say 42/(.1+.2-.3)}; isnt $!.numerator, 420, "no bogus errors";

# https://github.com/Raku/old-issue-tracker/issues/4524

subtest '0.9999999999999999999999 to string conversions' => {
    plan 4;

    constant r = 0.9999999999999999999999;
    # for this particular test, we simply check we don't have any weird
    # stuff like '0.A', but at least here we don't spec whether this Rat
    # would be output exactly or rounded off
    cmp-ok r.Str, '~~', '1'|'0.9999999999999999999999' ,
        'no weirdness in .Str';
    is-deeply r.raku, '<9999999999999999999999/10000000000000000000000>',
        '.raku gives accurate result';
    is-deeply r.raku.EVAL, r, '.raku.EVAL roundtrips';
    # https://github.com/Raku/old-issue-tracker/issues/4549
    nok 0.99999999999999999999999 > 1, '0.99999... not rounded to larger than 1';
}

# https://github.com/Raku/old-issue-tracker/issues/5926

cmp-ok Rat.Range, '===', -∞..∞,
    'Rat.Range is from -inf to inf, including end points';

subtest '== with 0-denominator Rats' => {
    plan 18;

    is-deeply  <0/0> == <42/1>, False, ' 0/0 == 42/1';
    is-deeply  <4/0> == <42/1>, False, ' 4/0 == 42/1';
    is-deeply <-4/0> == <42/1>, False, '-4/0 == 42/1';
    is-deeply <42/1> ==  <0/0>, False, '42/1 ==  0/0';
    is-deeply <42/1> ==  <4/0>, False, '42/1 ==  4/1';
    is-deeply <42/1> == <-4/0>, False, '42/1 == -4/1';

    # 0/0 is NaN and NaN != anything else
    is-deeply  <0/0> ==  <0/0>,  False, ' 0/0 ==  0/0';
    is-deeply  <0/0> ==  <2/0>,  False, ' 0/0 ==  2/0';
    is-deeply  <0/0> == <-2/0>,  False, ' 0/0 == -2/0';
    is-deeply  <2/0> ==  <0/0>,  False, ' 2/0 ==  0/0';
    is-deeply <-2/0> ==  <0/0>,  False, '-2/0 ==  0/0';

    # Positive/0 == +Inf
    is-deeply  <2/0> ==  <2/0>,  True, '  2/0 ==  0/0';
    is-deeply  <2/0> ==  <5/0>,  True,  ' 2/0 ==  5/0';
    is-deeply  <2/0> == <-2/0>,  False, ' 2/0 == -2/0';
    is-deeply  <5/0> ==  <2/0>,  True,  ' 5/0 ==  2/0';
    is-deeply <-2/0> ==  <2/0>,  False, '-2/0 ==  2/0';

    # Negative/0 == -Inf
    is-deeply  <-2/0> == <-2/0>,  True, '-2/0 == -2/0';
    is-deeply  <-2/0> == <-5/0>,  True, '-2/0 == -5/0';
}

subtest 'Rational.isNaN' => {
    plan 6;

    is-deeply  <0/0>.isNaN,  True, ' 0/0';
    is-deeply  <2/0>.isNaN, False, ' 2/0';
    is-deeply <-2/0>.isNaN, False, '-2/0';
    is-deeply  <0/2>.isNaN, False, ' 0/2';
    is-deeply  <4/5>.isNaN, False, ' 4/5';
    is-deeply <-4/5>.isNaN, False, '-5/5';
}

subtest '=== with 0-denominator Rats' => {
    plan 11;

    is-deeply  <0/0> ===  <0/0>,  True, ' 0/0 ===  0/0';
    is-deeply  <0/0> === <-2/0>, False, ' 0/0 === -2/0';
    is-deeply  <0/0> ===  <2/0>, False, ' 0/0 ===  2/0';

    is-deeply <-2/0> === <-2/0>,  True, '-2/0 === -2/0';
    is-deeply <-2/0> === <-4/0>,  True, '-2/0 === -4/0';
    is-deeply <-2/0> ===  <2/0>, False, '-2/0 === -2/0';
    is-deeply <-2/0> ===  <0/0>, False, '-2/0 === 0/0';

    is-deeply <2/0>  === <-2/0>, False, ' 2/0 === -2/0';
    is-deeply <2/0>  ===  <4/0>,  True, ' 2/0 ===  4/0';
    is-deeply <2/0>  ===  <2/0>,  True, ' 2/0 === 2/0';
    is-deeply <2/0>  ===  <0/0>, False, ' 2/0 === 0/0';
}

# https://github.com/Raku/old-issue-tracker/issues/6013
is-deeply 5   cmp <.5>, More, 'Real   cmp RatStr does not crash';
is-deeply <.5> cmp  .5, Same, 'RatStr cmp Real   does not crash';

# https://irclog.perlgeek.de/perl6-dev/2017-01-20#i_13961843
subtest 'subclass of class that does Rational can be instantiated' => {
    plan 2;
    my class Foo does Rational[Int,Int] {};
    my class Bar is Foo {};
    my $o := Bar.new: 42, 31337;
    cmp-ok $o, '~~', Bar & Foo & Rational, 'right type';
    is-deeply $o.nude, (42, 31337), 'right numerator/denominator';
}

# https://github.com/rakudo/rakudo/commit/79553d0fc3
is-deeply (<1/2> + <3/2>).ceiling, 2, '.ceiling with Rat sums';

# https://github.com/rakudo/rakudo/commit/aac9efcbda
subtest '.norm returns reduced Rat' => {
    # This is test (of a now-deprecated method) was added back when
    # some Rationals were allowed to be in unreduced form
    plan 2;
    given (2/3 + 1/3).norm {
        is-deeply .denominator, 1, 'denominator got reduced';
        is-deeply .numerator, 1, 'numerator got reduced';
    }
}

subtest '.Rat/.FatRat coercers' => {
    my @values =
        42, <42>, 42e0, <42e0>, 42.0, <42.0>, <42+0i>, < 42+0i>,
        FatRat.new(42, 1), "42", "42e0", "42.0", "42+0i", [^42], [^42].Seq,
        ^42, ^42 .kv.Map, Duration.new(42), Instant.from-posix(32), "42".IO,
        '42' ~~ /.+/, StrDistance.new(:before<a> :after('b' x 42));

    plan 4 + 2*@values;

    for @values {
        is-deeply .Rat,    <42/1>,            "{.^name}.Rat";
        is-deeply .FatRat, FatRat.new(42, 1), "{.^name}.FatRat";
    }

    quietly {
        isa-ok Nil.Rat,    Rat,     'Nil.Rat   .^isa';
        isa-ok Nil.FatRat, FatRat,  'Nil.FatRat.^isa';
        cmp-ok Nil.FatRat, '==', 0, 'Nil.FatRat is zero';
        cmp-ok Nil.Rat,    '==', 0, 'Nil.Rat    is zero';
    }
}

subtest 'Rational.Int on zero-denominator rats' => {
    plan 9;
    fails-like { (-1/0).Int }, X::Numeric::DivideByZero, '-1/0 (.Int method)';
    fails-like { ( 0/0).Int }, X::Numeric::DivideByZero,  '0/0 (.Int method)';
    fails-like { ( 1/0).Int }, X::Numeric::DivideByZero,  '1/0 (.Int method)';

    fails-like { Int(-1/0) }, X::Numeric::DivideByZero, '-1/0 (Int() coercer)';
    fails-like { Int( 0/0) }, X::Numeric::DivideByZero,  '0/0 (Int() coercer)';
    fails-like { Int( 1/0) }, X::Numeric::DivideByZero,  '1/0 (Int() coercer)';

    sub t ( Int() \x ) { return x }
    fails-like { t -1/0 }, X::Numeric::DivideByZero, '-1/0 (signature coercer)';
    fails-like { t  0/0 }, X::Numeric::DivideByZero,  '0/0 (signature coercer)';
    fails-like { t  1/0 }, X::Numeric::DivideByZero,  '1/0 (signature coercer)';
}

# https://github.com/Raku/old-issue-tracker/issues/6092

is-deeply (4.99999999999999999999999999999999999999999999 ~~ 0..^5), True,
    'literal with denominator > 64bit does not aquire f.p. noise';

# https://github.com/rakudo/rakudo/commit/0961abe8ff
subtest '.^roles on Rationals does not hang' => {
    plan 2;
    does-ok   42.2.^roles.grep(Rational).head, Rational, 'Rat:D';
    does-ok FatRat.^roles.grep(Rational).head, Rational, 'FatRat:U';
}

# https://github.com/Raku/old-issue-tracker/issues/2593
is-deeply <3147483648/1>.Int, 3147483648, 'numerators over 32 bits work';

# https://github.com/rakudo/rakudo/issues/1353
subtest 'eqv with zero-denominator Rationals' => {
    plan 2;
    sub e-so (\r1, \r2, \desc) { is-deeply r1 eqv r2, True,  desc }
    sub e-no (\r1, \r2, \desc) { is-deeply r1 eqv r2, False, desc }
    sub fr (\nu, \de) { FatRat.new: nu, de }

    subtest '±Inf Rationals `eqv` each other, even when numerators differ ' => {
        plan 20;

        e-no <0/0>, <70/0>,         ' NaN Rat,     Inf Rat';
        e-no <0/0>, <-7/0>,         ' NaN Rat,    -Inf Rat';
        e-no <0/0>, fr(0, 0),       ' NaN Rat,     NaN FatRat';

        e-so <42/0>, <70/0>,        ' Inf Rat,     Inf Rat';
        e-no <42/0>, <-7/0>,        ' Inf Rat,    -Inf Rat';
        e-no <42/0>, <0/0>,         ' Inf Rat,     NaN Rat';
        e-no <42/0>, fr(1, 0),      ' Inf Rat,     Inf FatRat';

        e-no <-2/0>, <70/0>,        '-Inf Rat,     Inf Rat';
        e-so <-2/0>, <-7/0>,        '-Inf Rat,    -Inf Rat';
        e-no <-2/0>, <0/0>,         '-Inf Rat,     NaN Rat';
        e-no <-2/0>, fr(-1, 0),     '-Inf Rat,    -Inf FatRat';

        e-no <42/0>, fr(70, 0),     ' Inf Rat,     Inf FatRat';
        e-no <42/0>, fr(-7, 0),     ' Inf Rat,    -Inf FatRat';
        e-no <42/0>, fr(0, 0),      ' Inf Rat,     NaN FatRat';

        e-so fr(1, 0),  fr(40, 0),  ' Inf FatRat,  Inf FatRat';
        e-no fr(1, 0),  <1/0>,      ' Inf FatRat,  Inf Rat';
        e-so fr(-1, 0), fr(-40, 0), '-Inf FatRat, -Inf FatRat';
        e-no fr(-1, 0), <-1/0>,     '-Inf FatRat,  Inf Rat';
        e-no fr(-1, 0), fr(40, 0),  '-Inf FatRat,  Inf FatRat';
        e-no fr(20, 0), fr(-4, 0),  ' Inf FatRat, -Inf FatRat';
    }

    subtest 'NaN-y Rationals `eqv` each other, as long as types match' => {
        plan 16;

        e-so <0/0>,         <0/0>,         'Rat literal, Rat literal';
        e-so <0/0>,          0/0,          'Rat literal, Rat /-op';
        e-so <0/0>,         Rat.new(0, 0), 'Rat new,     Rat.new';
        e-no <0/0>,         fr(0, 0),      'Rat new,     FatRat.new';

        e-so 0/0,           <0/0>,         'Rat /-op,    Rat literal';
        e-so 0/0,            0/0,          'Rat /-op,    Rat /-op';
        e-so 0/0,           Rat.new(0, 0), 'Rat /-op,    Rat.new';
        e-no 0/0,           fr(0, 0),      'Rat /-op,    FatRat.new';

        e-so Rat.new(0, 0), <0/0>,         'Rat.new,     Rat literal';
        e-so Rat.new(0, 0),  0/0,          'Rat.new,     Rat /-op';
        e-so Rat.new(0, 0), Rat.new(0, 0), 'Rat.new,     Rat.new';
        e-no Rat.new(0, 0), fr(0, 0),      'Rat.new,     FatRat.new';

        e-no fr(0, 0), <0/0>,              'FatRat.new,  Rat literal';
        e-no fr(0, 0),  0/0,               'FatRat.new,  Rat /-op';
        e-no fr(0, 0), Rat.new(0, 0),      'FatRat.new,  Rat.new';
        e-so fr(0, 0), fr(0, 0),           'FatRat.new,  FatRat.new';
    }
}

# https://github.com/rakudo/rakudo/issues/1552
subtest 'Rational.Bool' => {
    # If numerator is zero, the Rational is False, otherwise, it's True.
    # This applies to <0/0> as well. It is False, despite Num's NaN being True.
    # Allomorphs, use .Bool of their numeric portion.

    my class MyCustomRational does Rational[Int, Int] {};
    my @true  := ((-42, 42) X (-42, -1, 0, 1, 42)).map({
        Rat.new(|$_), FatRat.new(|$_), MyCustomRational.new(|$_),
        RatStr.new: Rat.new(|$_), ~$_
    }).flat.List;
    my @false := (((0,) X (-42, -1, 0, 1, 42)).map({
        Rat.new(|$_), FatRat.new(|$_), MyCustomRational.new(|$_),
        RatStr.new: Rat.new(|$_), ~$_
    }), Rat,  RatStr, FatRat,  MyCustomRational).flat.List;

    plan @true + @false;

    is-deeply .so, True,  .raku for @true;
    is-deeply .so, False, .raku for @false;
}

subtest 'Rational.WHICH' => {
    plan 4;
    is (2       /2).WHICH, (1       /2+1/2).WHICH,
        'WHICH is identical for practically identical Rats';
    is (2.FatRat/2).WHICH, (1.FatRat/2+1/2).WHICH,
        'WHICH is identical for practically identical FatRats';
    is-deeply (2       /2, 1       /2+1/2).unique, (1.0,),
        '.unique filters out practically identical Rats';
    is-deeply (2.FatRat/2, 1.FatRat/2+1/2).unique, (1.0.FatRat,),
        '.unique filters out practically identical FatRats';
}

subtest 'Rational keeps nu/de in proper types' => {
    plan 4;

    my class Foo is Int {};
    class Bar does Rational[Foo, Foo] {};
    with Bar.new: Foo.new(10), Foo.new: 20 {
        # nu/de should get normalized
        is-deeply .numerator,   Foo.new(1), 'numerator';
        is-deeply .denominator, Foo.new(2), 'denominator';
    }

    with Bar.new: Foo.new(42), Foo.new: 0 {
        # numerator is meant to be normalized, so it'll end up as 1
        is-deeply .numerator,   Foo.new(1), 'numerator (zero-denom rational)';
        is-deeply .denominator, Foo.new(0), 'denominator (zero-denom rational)';
    }
}

fails-like { <42/0>.floor   }, X::Numeric::DivideByZero,
    'Rational.floor   fails for zero-denominator-rationals';
fails-like { <42/0>.ceiling }, X::Numeric::DivideByZero,
    'Rational.ceiling fails for zero-denominator-rationals';
fails-like { <42/0>.round }, X::Numeric::DivideByZero,
    'Rational.round fails for zero-denominator-rationals';

group-of 4 => 'no funny business in stringification of huge Rationals' => {
    is        Rat.new(10⁴⁰⁰, 9⁹⁹⁹).Str,  '0',   '   Rat.new(10⁴⁰⁰, 9⁹⁹⁹).Str';
    is        Rat.new(10⁴⁰⁰, 9⁹⁹⁹).gist, '0',   '   Rat.new(10⁴⁰⁰, 9⁹⁹⁹).gist';
    unlike FatRat.new(10⁴⁰⁰, 9⁹⁹⁹).Str,  /Inf/, 'FatRat.new(10⁴⁰⁰, 9⁹⁹⁹).Str';
    unlike FatRat.new(10⁴⁰⁰, 9⁹⁹⁹).gist, /Inf/, 'FatRat.new(10⁴⁰⁰, 9⁹⁹⁹).gist';
}

# R#2578
{
    is-deeply 1/0 == 1/3, False, 'Inf == 1/3 should be false';
    is-deeply 1/3 == 1/0, False, '1/3 == Inf should be false';
    is-deeply 0/0 == 0/0, False, '0/0 == 0/0 should be false';
}

{
    is-deeply < 42/17> + 1,  59/17, 'Can we perform + Int on a RatStr';
    is-deeply < 42/17> - 1,  25/17, 'Can we perform - Int on a RatStr';
    is-deeply < 42/17> * 2,  84/17, 'Can we perform * Int on a RatStr';
    is-deeply < 42/17> / 3,  14/17, 'Can we perform / Int on a RatStr';
    is-deeply 1 + < 42/17>,  59/17, 'Can we perform Int + on a RatStr';
    is-deeply 1 - < 42/17>, -25/17, 'Can we perform Int - on a RatStr';
    is-deeply 2 * < 42/17>,  84/17, 'Can we perform Int * on a RatStr';
    is-deeply 3 / < 42/17>,  17/14, 'Can we perform Int / on a RatStr';
}

# vim: expandtab shiftwidth=4
