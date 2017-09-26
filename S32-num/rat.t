use v6;
use lib <t/spec/packages>;
use Test;
use Test::Util;

plan 845;

# Basic test functions specific to rational numbers.

# Test ways of making Rats
isa-ok(Rat.new(1,4), Rat, "Rat.new makes a Rat");
isa-ok(1 / 4, Rat, "/ makes a Rat");
isa-ok( 1.Int.Rat, Rat, "cast of Int makes a Rat");
isa-ok( 1.Num.Rat, Rat, "cast of Num makes a Rat");

isa-ok( Rat.new, Rat, 'Rat.new is Rat' );
isa-ok( EVAL(Rat.new.perl), Rat, 'EVAL Rat.new.perl is Rat' );
isa-ok( EVAL(Rat.new(1, 3).perl), Rat, 'EVAL Rat.new(1, 3).perl is Rat' );
is( (EVAL Rat.new(1, 3).perl), 1/3, 'EVAL Rat.new(1, 3).perl is 1/3' );
isa-ok( EVAL((1/3).perl), Rat, 'EVAL (1/3).perl is Rat' );
is( (EVAL (1/3).perl), 1/3, 'EVAL (1/3).perl is 1/3' );
is( (1/10).perl, "0.1", '(1/10).perl is 0.1' );
is( (1/5).perl, "0.2", '(1/5).perl is .2' );
is( (1/2).perl, "0.5", '(1/2).perl is .5' );
is 1/128, (1/128).perl.EVAL, '(1/128).perl.EVAL round trips with sufficient accuracy';
is 1/128, (1/128).perl.EVAL, '(1/128).perl.EVAL round trips with sufficient accuracy';
# RT #126873
is(Rat.new(807412079564, 555).perl.EVAL, Rat.new(807412079564, 555), '807412079564/555 round trips without a compile_time_value error');

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
is(Rat.new(1141234123, 0).nude, (1141234123, 0), "Huge over zero stays huge over zero");
is(Rat.new(-7, 0).nude, (-7, 0), "Negative seven over zero stays negative seven over zero");
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

# SHOULD: Add zero denominator tests
# Added three constructor tests above.  Unsure about the
# wisdom of allowing math with zero denominator Rats,
# so I'm holding off on writing tests for it.

# there are a few division by zero tests in S03-operator/div.t

is NaN.Rat, NaN, "NaN.Rat == NaN";

{
    is Inf.Rat, Inf, "Inf.Rat == Inf";
    is (-Inf).Rat, -Inf, "(-Inf).Rat == -Inf";

    # RT #74648
    #?rakudo skip 'RT #74648'
    isa-ok Inf.Int / 1, Rat, "Inf.Int / 1 is a Rat";
}

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

# RT #72870
is .88888888888.WHAT.gist, Rat.gist, 'WHAT works on Rat created from 11 digit decimal fraction';

# RT #74624
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

#RT #112822
is 241025348275725.3352.Str, "241025348275725.3352", 'stringification of bigish Rats';

#RT #126391
try {say 42/(.1+.2-.3)};
isa-ok( $!.numerator, 42, "got the answer rather than 420");

# RT#126016
subtest '0.9999999999999999999999 to string conversions' => {
    plan 3;

    constant r = 0.9999999999999999999999;
    is-deeply r.Str, '1', '.Str rounds off correctly';
    is-deeply r.perl, '<9999999999999999999999/10000000000000000000000>',
        '.perl gives accurate result';
    is-deeply r.perl.EVAL, r, '.perl.EVAL roundtrips';
}

# RT#130427
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
    plan 15;

    is-deeply  <0/0> ===  <0/0>,  True, ' 0/0 ===  0/0';
    is-deeply  <2/0> ===  <2/0>,  True, ' 2/0 ===  2/0';
    is-deeply <-2/0> === <-2/0>,  True, '-2/0 === -2/0';

    is-deeply  <0/0> ===  <2/0>, False, ' 0/0 ===  2/0';
    is-deeply  <2/0> ===  <0/0>, False, ' 2/0 ===  0/0';
    is-deeply  <5/0> ===  <2/0>, False, ' 5/0 ===  2/0';
    is-deeply  <2/0> ===  <5/0>, False, ' 2/0 ===  5/0';
    is-deeply <-5/0> === <-2/0>, False, '-5/0 === -2/0';
    is-deeply <-2/0> === <-5/0>, False, '-2/0 === -5/0';

    is-deeply  <0/0> ===  <2/2>, False, ' 0/0 ===  2/2';
    is-deeply  <2/2> ===  <0/0>, False, ' 2/2 ===  0/0';
    is-deeply  <5/2> ===  <2/0>, False, ' 5/2 ===  2/0';
    is-deeply  <2/0> ===  <5/2>, False, ' 2/0 ===  5/2';
    is-deeply <-5/2> === <-2/0>, False, '-5/2 === -2/0';
    is-deeply <-2/0> === <-5/2>, False, '-2/0 === -5/2';
}

# RT #130606
eval-lives-ok ｢5 cmp <.5>｣, 'Real cmp RatStr does not crash';

{ # https://irclog.perlgeek.de/perl6-dev/2017-01-20#i_13961843
    my class Foo does Rational[Int,Int] {};
    my class Bar is Foo {};
    lives-ok { Bar.new: 42, 42 },
        'subclass of class that does Rational can be instantiated';
}

# https://github.com/rakudo/rakudo/commit/79553d0fc3
is-deeply (<1/2> + <3/2>).ceiling, 2,
    '.ceiling is right for unreduced whole Rats, like <4/2>';

# https://github.com/rakudo/rakudo/commit/aac9efcbda
subtest '.norm returns reduced Rat' => {
    plan 2;
    given (2/3 + 1/3).norm {
        is-deeply .denominator, 1, 'denominator got reduced';
        is-deeply .numerator, 1, 'numerator got reduced';
    }
}

#?rakudo.jvm skip 'Type check failed in binding to "nu"; expected Int but got Str ("42.0")'
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

# RT#130845
is-deeply (4.99999999999999999999999999999999999999999999 ~~ 0..^5), True,
    'literal with denominator > 64bit does not aquire f.p. noise';

# https://github.com/rakudo/rakudo/commit/0961abe8ff
subtest '.^roles on Rationals does not hang' => {
    plan 3;
    does-ok   42.2.^roles.grep(Rational).head, Rational, 'Rat:D';
    does-ok FatRat.^roles.grep(Rational).head, Rational, 'FatRat:U';

    my class Irrational does Rational[UInt, Int] {};
    does-ok Irrational.new.^roles.grep(Rational).head, Rational[UInt, Int],
        'custom class :D';
}

# vim: ft=perl6
