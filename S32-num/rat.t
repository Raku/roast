use v6;

use Test;

plan 824;

# Basic test functions specific to rational numbers.

# Test ways of making Rats
#?pugs skip 'Must only use named arguments to new() constructor'
isa_ok(Rat.new(1,4), Rat, "Rat.new makes a Rat");
isa_ok(1 / 4, Rat, "/ makes a Rat");
isa_ok( 1.Int.Rat, Rat, "cast of Int makes a Rat");
isa_ok( 1.Num.Rat, Rat, "cast of Num makes a Rat");

#?niecza skip 'No value for parameter $n in CORE Rat.new'
isa_ok( Rat.new, Rat, 'Rat.new is Rat' );
#?niecza skip 'No value for parameter $n in CORE Rat.new'
#?pugs todo
isa_ok( eval(Rat.new.perl), Rat, 'eval Rat.new.perl is Rat' );
#?pugs 2 skip 'Must only use named arguments to new() constructor'
#?rakudo 4 todo '<1/3> literal should be Rat'
isa_ok( eval(Rat.new(1, 3).perl), Rat, 'eval Rat.new(1, 3).perl is Rat' );
is( (eval Rat.new(1, 3).perl), 1/3, 'eval Rat.new(1, 3).perl is 1/3' );
isa_ok( eval((1/3).perl), Rat, 'eval (1/3).perl is Rat' );
is( (eval (1/3).perl), 1/3, 'eval (1/3).perl is 1/3' );
#?pugs 3 todo 'tenths'
is( (1/10).perl, "0.1", '(1/10).perl is 0.1' );
is( (1/5).perl, "0.2", '(1/5).perl is .2' );
is( (1/2).perl, "0.5", '(1/2).perl is .5' );

# Test ~
#?pugs 4 skip 'Must only use named arguments to new() constructor'
is(~(Rat.new(1,4)), ~(0.25e0), "Rats stringify properly");
is(~(Rat.new(-1,2)), ~(-0.5e0), "Rats stringify properly");
is(~(Rat.new(7,4)), ~(1.75e0), "Rats stringify properly");
is(~(Rat.new(7,-1)), ~(-7), "Rats stringify properly");

# Test new
#?pugs 9 skip 'Must only use named arguments to new() constructor'
is(Rat.new(1, -7).nude, (-1, 7), "Negative signs move to numerator");
is(Rat.new(-32, -33).nude, (32, 33), "Double negatives cancel out");
is(Rat.new(2, 4).nude, (1, 2), "Reduce to simplest form in constructor");
is(Rat.new(39, 33).nude, (13, 11), "Reduce to simplest form in constructor");
is(Rat.new(0, 33).nude, (0, 1), "Reduce to simplest form in constructor");
is(Rat.new(1451234131, 60).nude, (1451234131, 60), "Reduce huge number to simplest form in constructor");
#?niecza skip 'Unable to resolve method nude in class Num'
is(Rat.new(1141234123, 0).nude, (1, 0), "Huge over zero becomes one over zero");
#?niecza skip 'Unable to resolve method nude in class Num'
is(Rat.new(-7, 0).nude, (-1, 0), "Negative over zero becomes negative one over zero");
#?niecza todo
dies_ok( { Rat.new(0, 0) }, "Zero over zero is not a legal Rat");

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
#?pugs skip '.nude'
is((1 / 4 - 3 / 4).nude, (-1, 2), "1/4 - 3/4 = -1/2 is simplified internally");
isa_ok((1 / 4 - 3 / 4), Rat, "1/4 - 3/4 is a Rat");
is(1 / 4 - 1, -3/4, "1/4 - 1 = -3/4");
isa_ok(1 / 4 - 1, Rat, "1/4 - 1 is a Rat");
is(1 - 1 / 4, 3/4, "1 - 1/4 = 3/4");
isa_ok(1 - 1 / 4, Rat, "1 - 1/4 is a Rat");

is((2 / 3) * (5 / 4), 5/6, "2/3 * 5/4 = 5/6");
#?pugs skip '.nude'
is(((2 / 3) * (5 / 4)).nude, (5, 6), "2/3 * 5/4 = 5/6 is simplified internally");
isa_ok((2 / 3) * (5 / 4), Rat, "2/3 * 5/4 is a Rat");
is((2 / 3) * 2, 4/3, "2/3 * 2 = 4/3");
isa_ok((2 / 3) * 2, Rat, "2/3 * 2 is a Rat");
#?pugs skip '.nude'
is(((2 / 3) * 3).nude, (2, 1), "2/3 * 3 = 2 is simplified internally");
is(2 * (2 / 3), 4/3, "2 * 2/3 = 4/3");
isa_ok(2 * (2 / 3), Rat, "2 * 2/3 is a Rat");
#?pugs skip '.nude'
is((3 * (2 / 3)).nude, (2, 1), "3 * 2/3 = 2 is simplified internally");

is((2 / 3) / (5 / 4), 8/15, "2/3 / 5/4 = 8/15");
isa_ok((2 / 3) / (5 / 4), Rat, "2/3 / 5/4 is a Rat");
is((2 / 3) / 2, 1/3, "2/3 / 2 = 1/3");
#?pugs skip '.nude'
is(((2 / 3) / 2).nude, (1, 3), "2/3 / 2 = 1/3 is simplified internally");
isa_ok((2 / 3) / 2, Rat, "2/3 / 2 is a Rat");
is(2 / (1 / 3), 6, "2 / 1/3 = 6");
isa_ok(2 / (1 / 3), Rat, "2 / 1/3 is a Rat");
#?pugs skip '.nude'
is((2 / (2 / 3)).nude, (3, 1), "2 / 2/3 = 3 is simplified internally");

{
    # use numbers that can be exactly represented as floating points
    # so there's no need to use is_approx 

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
}

#pugs needs a reset here...
#?DOES 1 

# used to be a (never ticketed) Rakudo bug: sin(Rat) died
# (note that trig on Rats is tested extensively in S32-trig)

is_approx sin(5.0e0), sin(10/2), 'sin(Rat) works';

# SHOULD: Add divide by zero / zero denominator tests
# Added three constructor tests above.  Unsure about the
# wisdom of allowing math with zero denominator Rats,
# so I'm holding off on writing tests for it.

#?niecza todo
#?pugs todo 'NaN.Rat'
is NaN.Rat, NaN, "NaN.Rat == NaN";

{
    #?pugs todo 'Inf.Rat'
    #?niecza todo
    is Inf.Rat, Inf, "Inf.Rat == Inf";
    #?pugs todo 'Inf.Rat'
    #?niecza todo
    is (-Inf).Rat, -Inf, "(-Inf).Rat == -Inf";

    # RT #74648
    #?rakudo skip 'RT 74648'
    #?niecza todo
    isa_ok Inf.Int / 1, Rat, "Inf.Int / 1 is a Rat";
}

# Quick test of some basic mixed type math

is_approx (1 / 2) + 3.5e0, 4.0, "1/2 + 3.5 = 4.0";
is_approx 3.5e0 + (1 / 2), 4.0, "3.5 + 1/2 = 4.0";
is_approx (1 / 2) - 3.5e0, -3.0, "1/2 - 3.5 = -3.0";
is_approx 3.5e0 - (1 / 2), 3.0, "3.5 - 1/2 = 3.0";
is_approx (1 / 3) * 6.6e0, 2.2, "1/3 * 6.6 = 2.2";
is_approx 6.6e0 * (1 / 3), 2.2, "6.6 * 1/3 = 2.2";
is_approx (1 / 3) / 2.0e0, 1 / 6, "1/3 / 2.0 = 1/6";
is_approx 2.0e0 / (1 / 3), 6.0, "2.0 / 1/3 = 6.0";

is_approx (1 / 2) + 3.5e0 + 1i, 4.0 + 1i, "1/2 + 3.5 + 1i = 4.0 + 1i";
is_approx (3.5e0 + 1i) + (1 / 2), 4.0 + 1i, "(3.5 + 1i) + 1/2 = 4.0 + 1i";
is_approx (1 / 2) - (3.5e0 + 1i), -3.0 - 1i, "1/2 - (3.5 + 1i) = -3.0 - 1i";
is_approx (3.5e0 + 1i) - (1 / 2), 3.0 + 1i, "(3.5 + 1i) - 1/2 = 3.0 + 1i";
is_approx (1 / 3) * (6.6e0 + 1i), 2.2 + (1i/3), "1/3 * (6.6 + 1i) = 2.2 + (1/3)i";
is_approx (6.6e0 + 1i) * (1 / 3), 2.2 + (1i/3), "(6.6 + 1i) * 1/3 = 2.2 + (1/3)i";
is_approx (1 / 3) / 2.0i, 1 / (6.0i), "1/3 / 2.0i = 1/(6i)";
is_approx 2.0i / (1 / 3), 6.0i, "2.0i / 1/3 = 6.0i";

# Cast from Num uses an epsilon value.
#?pugs 3 skip 'Must only use named arguments to new() constructor'
is( exp(1).Rat, Rat.new(2721, 1001), "Num to Rat with default epsilon");
is( exp(1).Rat(1e-4), Rat.new(193, 71), "Num to Rat with epsilon 1e-4");
is( exp(1).Rat(Rat.new(1,1e4.Int)), Rat.new(193, 71),
    "Num to Rat with epsilon of Rat");

is (5/4).Int,       1, 'Rat.Int';
is <a b c>.[4/3],  'b', 'Indexing an array with a Rat (RT 69738)';

is_approx 424/61731 + 832/61731, 424.Num / 61731.Num + 832.Num / 61731.Num, "424/61731 + 832/61731 works";
is_approx 424/61731 - 832/61731, 424.Num / 61731.Num - 832.Num / 61731.Num, "424/61731 - 832/61731 works";
is_approx 424/61731 + 833/123462, 424.Num / 61731.Num + 833.Num / 123462.Num, "424/61731 + 833/123462 works";
is_approx 424/61731 - 833/123462, 424.Num / 61731.Num - 833.Num / 123462.Num, "424/61731 - 833/123462 works";

isa_ok 424/61731 + 832/61731, Rat, "424/61731 + 832/61731 is a Rat";
isa_ok 424/61731 - 832/61731, Rat, "424/61731 - 832/61731 is a Rat";
isa_ok 424/61731 + 833/123462, Rat, "424/61731 + 833/123462 is a Rat";
isa_ok 424/61731 - 833/123462, Rat, "424/61731 - 833/123462 is a Rat";

is_approx 61731 + 832/61731, 61731.Num + 832.Num / 61731.Num, "61731 + 832/61731 works";
is_approx 832/61731 + 61731, 61731.Num + 832.Num / 61731.Num, "832/61731 + 61731 works";
is_approx 61731 - 832/61731, 61731.Num - 832.Num / 61731.Num, "61731 - 832/61731 works";
is_approx 832/61731 - 61731, 832.Num / 61731.Num - 61731.Num, "832/61731 - 61731 works";

is_approx 424/61731 + 832/61733, 424.Num / 61731.Num + 832.Num / 61733.Num, "424/61731 + 832/61733 works";
is_approx 424/61731 - 832/61733, 424.Num / 61731.Num - 832.Num / 61733.Num, "424/61731 - 832/61733 works";

is_approx (424/61731) * (832/61731), (424.Num / 61731.Num) * (832.Num / 61731.Num), "424/61731 * 832/61731 works";
is_approx (424/61731) / (61731/832), (424.Num / 61731.Num) / (61731.Num / 832.Num), "424/61731 / 61731/832 works";

is_approx 61731 * (61731/832), 61731.Num * (61731.Num / 832.Num), "61731 * 61731/832 works";
is_approx (61731/832) * 61731, 61731.Num * (61731.Num / 832.Num), "61731/832 * 61731 works";
is_approx (832/61731) / 61731, (832.Num / 61731.Num) / 61731.Num, "832/61731 / 61731 works";
is_approx 61731 / (832/61731), 61731.Num / (832.Num / 61731.Num), "61731 / 832/61731 works";

is_approx (424/61731) * (61731/61733), (424.Num / 61731.Num) * (61731.Num / 61733.Num), "424/61731 * 61731/61733 works";
isa_ok (424/61731) * (61731/61733), Rat, "424/61731 * 61731/61733 is a Rat";
is_approx (424/61731) / (61733/61731), (424.Num / 61731.Num) / (61733.Num / 61731.Num), "424/61731 / 61733/61731 works";
isa_ok (424/61731) / (61733/61731), Rat, "424/61731 / 61733/61731 is a Rat";

ok (1/2) == (1/2).Rat, 'Rat.Rat works';
isa_ok (1/2).Rat, Rat, '... and actually returns a Rat';

ok 1/2 === 1/2, 'Rats are value types, so 1/2 === 1/2';
ok 1/2 !=== 1/3, '=== with false outcome';

# http://irclog.perlgeek.de/perl6/2010-02-24#i_2027452
#?pugs 2 skip 'Illegal division by zero'
is (3/0).Num, Inf, "(3/0).Num = +Inf";
is (-42/0).Num, -Inf, "(-42/0).Num = -Inf";

#?niecza skip 'No value for parameter $n in CORE Rat.new'
#?pugs skip 'Cannot cast from VObject to Double'
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
    isa_ok $a, Rat, 'Any() + 0.1 is a Rat';
}

isa_ok (2/3) ** 3, Rat, "Rat raised to a positive Int power is a Rat";
is (2/3) ** 3, 8/27, "Rat raised to a positive Int power gets correct answer";

# the spec says that Rat denominators can't grow larger than a uint64,
# and arithmetic operations need to spill over to Num
{
    # taken from http://www.perlmonks.org/?node_id=952765
    my $s = 0;
    for 1..1000 {
        $s += 1/$_**2
    };
    is_approx $s, 1.64393456668156, 'can sum up 1/$_**2 in a loop';
    isa_ok $s, Num, 'and we had an overflow to Num';
    my $bigish = 2 ** 34;
    my $bigish_n = $bigish.Num;
    # TODO: not just check the type of the results, but also the numeric value
    isa_ok (1/$bigish) * (1/$bigish),       Num, 'multiplication overflows to Num';
    is_approx (1/$bigish) * (1/$bigish), (1/$bigish_n) * (1/$bigish_n), '... right result';
    isa_ok (1/$bigish) ** 2,                Num, 'exponentation overflows to Num';
    is_approx (1/$bigish) ** 2, (1/$bigish_n) ** 2, '... right result';
    is_approx (1/$bigish) * (1/$bigish), (1/$bigish_n) * (1/$bigish_n), '... right result';
    isa_ok (1/$bigish) + (1 / ($bigish+1)), Num, 'addition overflows to Num';
    is_approx (1/$bigish) + (1/($bigish+1)), (1/$bigish_n) + (1/($bigish_n+1)), '... right result';
    isa_ok (1/$bigish) - (1 / ($bigish+1)), Num, 'subtraction overflows to Num';
    is_approx (1/$bigish) - (1/($bigish+1)), (1/$bigish_n) - (1/($bigish_n+1)), '... right result';
    isa_ok (1/$bigish) / (($bigish+1)/3),   Num, 'division overflows to Num';
    is_approx (1/$bigish) / (($bigish+1)/3), (1/$bigish_n) / (($bigish_n+1)/3), '... right result';

}

#?pugs skip 'Must only use named arguments to new() constructor'
is Rat.new(9,33).norm.nude, (3, 11), ".norm exists and doesn't hurt matters";

isa_ok 241025348275725.3352, Rat, "241025348275725.3352 is a Rat";
#?pugs skip 'No such method in class Rat: "&norm"'
is 241025348275725.3352.Rat.norm.nude, (301281685344656669, 1250), "Rat.Rat yields correct Rat";

#RT #112822
#?pugs skip 'No such method in class Rat: "&norm"'
is 241025348275725.3352.Str, "241025348275725.3352", 'stringification of bigish Rats';

done;

# vim: ft=perl6
