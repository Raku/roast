use v6;

use Test;

plan 186;

# basic Range
# L<S02/Immutable types/A pair of Ordered endpoints>

my $r = 1..5;
isa-ok $r, Range, 'Type';
is $r.WHAT.gist, Range.gist, 'Type';
is $r.perl, '1..5', 'canonical representation';

# XXX unspecced: exact value of Range.perl
is (1..5).perl, '1..5', ".perl ..";
is (1^..5).perl, '1^..5', ".perl ^..";
is (1..^5).perl, '1..^5', ".perl ..^";
is (1^..^5).perl, '1^..^5', ".perl ^..^";

my @r = $r;
is @r.perl, "[1..5,]", 'got the right array';

# Range of Str

$r = 'a'..'c';
isa-ok $r, Range;
# XXX unspecced: exact value of Range.perl
is $r.perl, '"a".."c"', 'canonical representation';
@r = $r;
is @r.perl, '["a".."c",]', 'got the right array';

# Stationary ranges
is (1..1).perl, '1..1', "stationary num .perl ..";
is (1..1), [1,], 'got the right array';
is ('a'..'a').perl, '"a".."a"', "stationary str .perl ..";
is ('a'..'a'), "a", 'got the right stationary string';

#?niecza skip 'Unable to resolve method reverse in class Range'
{
    my $x = 0;
    $x++ for (1..4).reverse;
    is $x, 4, '(1..4).reverse still turns into a list of four items';
    my $y = 0;
    $y++ for @( EVAL((1..4).reverse.perl) );
    is $y, 4, '(1..4).reverse.perl returns something useful';
}

# ACCEPTS and equals tests
{
    my $r = 1..5;
    ok(($r).ACCEPTS($r), 'accepts self');
    ok(($r).ACCEPTS(1..5), 'accepts same');
    ok($r ~~ $r, 'accepts self');
    ok($r ~~ 1..5, 'accepts same');
    # TODO check how to avoid "eager is", test passes but why?
    is($r, $r, "equals to self");
    my $s = 1..5;
    is($r, $s, "equals");
}


# Range in comparisons
ok((1..5).ACCEPTS(3), 'int in range');
ok(3 ~~ 1..5, 'int in range');
ok(3 !~~ 6..8, 'int not in range');

ok(('a'..'z').ACCEPTS('x'), 'str in range');
ok('x' ~~ 'a'..'z', 'str in range');
ok('x' !~~ 'a'..'c', 'str not in range');
ok(('aa'..'zz').ACCEPTS('ax'), 'str in range');
ok(('a'..'zz').ACCEPTS('ax'), 'str in range');

is(+(6..6), 1, 'numification');
is(+(6^..6), 0, 'numification');
is(+(6..^6), 0, 'numification');
is(+(6..^6.1), 1, 'numification');
is(+(6..8), 3, 'numification');
is(+(1^..10), 9, 'numification');
is(+(1..^10), 9, 'numification');
is(+(1^..^10), 8, 'numification');
is(+(10..9), 0, 'numification');
is(+(1.2..4), 3, 'numification');
is(+(1..^3.3), 3, 'numification');
is(+(2.3..3.1), 1, 'numification');
#?niecza skip 'Attempted to access slot $!min of type object for Range'
is(+Range, 0, 'type numification');

# immutability
{
    my $r = 1..5;

    for <push pop shift unshift append prepend> -> $method {
        throws-like { $r."$method"(42) }, X::Immutable,
          method   => $method,
          typename => 'Range',
          "range is immutable ($method)",
        ;
    }

    #?rakudo.jvm 4 todo 'got X::Method::NotFound, RT #130470'
    throws-like { $r.min = 2 }, X::Assignment::RO, "range.min ro";
    throws-like { $r.max = 4 }, X::Assignment::RO, "range.max ro";
    throws-like { $r.excludes-min = True }, X::Assignment::RO,
        "range.excludes-min ro";
    throws-like { $r.excludes-max = True }, X::Assignment::RO,
        "range.excludes-max ro";

    # RT #125791
    {
        for 0,1 -> $i {
            #?rakudo.jvm todo 'got X::Method::NotFound, RT #130470'
            throws-like { (^10).bounds[$i] = 1 }, X::Assignment::RO,
                typename => / ^ 'Int' | 'value' $ /,
                "is Range.bounds[$i] ro";
        }
    }

    my $s = 1..5;
    is $r, $s, 'range has not changed';
}

# simple range
{
    my $r = 1 .. 5;
    is($r.min, 1, 'range.min');
    is($r.max, 5, 'range.max');
    is($r.bounds, (1,5), 'range.bounds');
}

# uneven ranges
{
    my $r = 1 .. 4.5;
    is($r.min, 1,   'range.min');
    is($r.max, 4.5, 'range.max');
    is($r.bounds, (1, 4.5), 'range.bounds');
}

# infinite ranges
{
    my $inf = -Inf..Inf;

    ok(42  ~~ $inf, 'positive integer matches -Inf..Inf');
    ok(.2  ~~ $inf, 'positive non-int matches -Inf..Inf');
    ok(-2  ~~ $inf, 'negative integer matches -Inf..Inf');
    ok(-.2 ~~ $inf, 'negative non-int matches -Inf..Inf');
}

# infinite ranges using Whatever
{
    my $inf = *..*;

    is($inf.min, -Inf, 'bottom end of *..* is -Inf (1)');
    is($inf.max, Inf, 'top end of *..* is Inf (1)');

    is($inf.elems, Inf, 'testing number of elements');

    ok(42  ~~ $inf, 'positive integer matches *..*');
    ok(.2  ~~ $inf, 'positive non-int matches *..*');
    ok(-2  ~~ $inf, 'negative integer matches *..*');
    ok(-.2 ~~ $inf, 'negative non-int matches *..*');
}

# ranges constructed from parameters, from RT #63002
{
    sub foo($a) { ~($a .. 5) };
    is(foo(5), '5', 'range constructed from parameter OK');
}

# ranges constructed from parameters, #2
{
    for 1 -> $i {
        for $i..5 -> $j { };
        is($i, 1, 'Iter range from param doesnt modify param (RT #66280)');
    }
}

{
    is((1..8)[*-1], 8, 'postcircumfix:<[ ]> on range works');
    is((1..8)[1,3], [2,4], 'postcircumfix:<[ ]> on range works');
}

{
    my @b = pick(*, 1..100);
    is @b.elems, 100, "pick(*, 1..100) returns the correct number of elements";
    is ~@b.sort, ~(1..100), "pick(*, 1..100) returns the correct elements";
    is ~@b.grep(Int).elems, 100, "pick(*, 1..100) returns Ints";

    @b = (1..100).pick(*);
    is @b.elems, 100, "pick(*, 1..100) returns the correct number of elements";
    is ~@b.sort, ~(1..100), "pick(*, 1..100) returns the correct elements";
    is ~@b.grep(Int).elems, 100, "pick(*, 1..100) returns Ints";

    isa-ok (1..100).pick, Int, "picking a single element from an range of Ints produces an Int";
    ok (1..100).pick ~~ 1..100, "picking a single element from an range of Ints produces one of them";

    isa-ok (1..100).pick(1), Seq, "picking 1 from an range of Ints produces a Seq";
    ok (1..100).pick(1)[0] ~~ 1..100, "picking 1 from an range of Ints produces one of them";

    my @c = (1..100).pick(2);
    isa-ok @c[0], Int, "picking 2 from an range of Ints produces an Int...";
    isa-ok @c[1], Int, "... and an Int";
    ok (@c[0] ~~ 1..100) && (@c[1] ~~ 1..100), "picking 2 from an range of Ints produces two of them";
    ok @c[0] != @c[1], "picking 2 from an range of Ints produces two distinct results";

    is (1..100).pick("25").elems, 25, ".pick works Str arguments";
    is pick("25", 1..100).elems, 25, "pick works Str arguments";
}

{
    my @b = pick(*, 'b' .. 'y');
    is @b.elems, 24, "pick(*, 'b' .. 'y') returns the correct number of elements";
    is ~@b.sort, ~('b' .. 'y'), "pick(*, 'b' .. 'y') returns the correct elements";
    is ~@b.grep(Str).elems, 24, "pick(*, 'b' .. 'y') returns Strs";

    @b = ('b' .. 'y').pick(*);
    is @b.elems, 24, "pick(*, 'b' .. 'y') returns the correct number of elements";
    is ~@b.sort, ~('b' .. 'y'), "pick(*, 'b' .. 'y') returns the correct elements";
    is ~@b.grep(Str).elems, 24, "pick(*, 'b' .. 'y') returns Strs";

    isa-ok ('b' .. 'y').pick, Str, "picking a single element from an range of Strs produces an Str";
    ok ('b' .. 'y').pick ~~ 'b' .. 'y', "picking a single element from an range of Strs produces one of them";

    isa-ok ('b' .. 'y').pick(1), Seq, "picking 1 from an range of Strs produces a Seq";
    ok ('b' .. 'y').pick(1)[0] ~~ 'b' .. 'y', "picking 1 from an range of Strs produces one of them";

    my @c = ('b' .. 'y').pick(2);
    isa-ok @c[0], Str, "picking 2 from an range of Strs produces an Str...";
    isa-ok @c[1], Str, "... and an Str";
    ok (@c[0] ~~ 'b' .. 'y') && (@c[1] ~~ 'b' .. 'y'), "picking 2 from an range of Strs produces two of them";
    ok @c[0] ne @c[1], "picking 2 from an range of Strs produces two distinct results";

    is ('b' .. 'y').pick("10").elems, 10, ".pick works Str arguments";
    is pick("10", 'b' .. 'y').elems, 10, "pick works Str arguments";
}

{
    my @b = roll(100, 1..100);
    is @b.elems, 100, "roll(100, 1..100) returns the correct number of elements";
    is ~@b.grep(1..100).elems, 100, "roll(100, 1..100) returns elements from 1..100";
    is ~@b.grep(Int).elems, 100, "roll(100, 1..100) returns Ints";

    @b = (1..100).roll(100);
    is @b.elems, 100, "roll(100, 1..100) returns the correct number of elements";
    is ~@b.grep(1..100).elems, 100, "roll(100, 1..100) returns elements from 1..100";
    is ~@b.grep(Int).elems, 100, "roll(100, 1..100) returns Ints";

    isa-ok (1..100).roll, Int, "rolling a single element from an range of Ints produces an Int";
    ok (1..100).roll ~~ 1..100, "rolling a single element from an range of Ints produces one of them";

    isa-ok (1..100).roll(1), Seq, "rolling 1 from an range of Ints produces a Seq";
    ok (1..100).roll(1)[0] ~~ 1..100, "rolling 1 from an range of Ints produces one of them";

    my @c = (1..100).roll(2);
    isa-ok @c[0], Int, "rolling 2 from an range of Ints produces an Int...";
    isa-ok @c[1], Int, "... and an Int";
    ok (@c[0] ~~ 1..100) && (@c[1] ~~ 1..100), "rolling 2 from an range of Ints produces two of them";

    is (1..100).roll("25").elems, 25, ".roll works Str arguments";
    is roll("25", 1..100).elems, 25, "roll works Str arguments";
}

{
    my @b = roll(100, 'b' .. 'y');
    is @b.elems, 100, "roll(100, 'b' .. 'y') returns the correct number of elements";
    is ~@b.grep('b' .. 'y').elems, 100, "roll(100, 'b' .. 'y') returns elements from b..y";
    is ~@b.grep(Str).elems, 100, "roll(100, 'b' .. 'y') returns Strs";

    @b = ('b' .. 'y').roll(100);
    is @b.elems, 100, "roll(100, 'b' .. 'y') returns the correct number of elements";
    is ~@b.grep('b' .. 'y').elems, 100, "roll(100, 'b' .. 'y') returns elements from b..y";
    is ~@b.grep(Str).elems, 100, "roll(100, 'b' .. 'y') returns Strs";

    isa-ok ('b' .. 'y').roll, Str, "rolling a single element from an range of Strs produces an Str";
    ok ('b' .. 'y').roll ~~ 'b' .. 'y', "rolling a single element from an range of Strs produces one of them";

    isa-ok ('b' .. 'y').roll(1), Seq, "rolling 1 from an range of Strs produces a Seq";
    ok ('b' .. 'y').roll(1)[0] ~~ 'b' .. 'y', "rolling 1 from an range of Strs produces one of them";

    my @c = ('b' .. 'y').roll(2);
    isa-ok @c[0], Str, "rolling 2 from an range of Strs produces an Str...";
    isa-ok @c[1], Str, "... and an Str";
    ok (@c[0] ~~ 'b' .. 'y') && (@c[1] ~~ 'b' .. 'y'), "rolling 2 from an range of Strs produces two of them";

    is ('b' .. 'y').roll("10").elems, 10, ".roll works Str arguments";
    is roll("10", 'b' .. 'y').elems, 10, "roll works Str arguments";
}

is join(':',grep 1..3, 0..5), '1:2:3', "ranges itemize or flatten lazily";

lives-ok({'A'..'a'}, "A..a range completes");
lives-ok({"\0".."~"}, "low ascii range completes");

# shifting and scaling intervals
{
    my $r = 1..10;
    is ($r + 5).gist, '6..15', "can shift a left .. range up";
    is (5 + $r).gist, '6..15', "can shift a right .. range up";
    is ($r * 2).gist, '2..20', "can scale a left .. range up";
    is (2 * $r).gist, '2..20', "can scale a right .. range up";
    is ($r - 1).gist, '0..9', "can shift a .. range down";
    is ($r / 2).gist, '0.5..5.0', "can scale a .. range down";

    $r = 1..^10;
    is ($r + 5).gist, '6..^15', "can shift a left ..^ range up";
    is (5 + $r).gist, '6..^15', "can shift a right ..^ range up";
    is ($r * 2).gist, '2..^20', "can scale a left ..^ range up";
    is (2 * $r).gist, '2..^20', "can scale a right ..^ range up";
    is ($r - 1).gist, '^9', "can shift a ..^ range down";
    is ($r / 2).gist, '0.5..^5.0', "can scale a ..^ range down";

    $r = 1^..10;
    is ($r + 5).gist, '6^..15', "can shift a left ^.. range up";
    is (5 + $r).gist, '6^..15', "can shift a right ^.. range up";
    is ($r * 2).gist, '2^..20', "can scale a left ^.. range up";
    is (2 * $r).gist, '2^..20', "can scale a right ^.. range up";
    is ($r - 1).gist, '0^..9', "can shift a ^.. range down";
    is ($r / 2).gist, '0.5^..5.0', "can scale a ^.. range down";

    $r = 1^..^10;
    is ($r + 5).gist, '6^..^15', "can shift a left ^..^ range up";
    is (5 + $r).gist, '6^..^15', "can shift a right ^..^ range up";
    is ($r * 2).gist, '2^..^20', "can scale a left ^..^ range up";
    is (2 * $r).gist, '2^..^20', "can scale a right ^..^ range up";
    is ($r - 1).gist, '0^..^9', "can shift a ^..^ range down";
    is ($r / 2).gist, '0.5^..^5.0', "can scale a ^..^ range down";
}

{
    sub test($range,$min,$max,$minbound,$maxbound) {
        subtest {
            plan 5;
            ok $range.is-int, "is $range.gist() an integer range";
            is $range.min, $min, "is $range.gist().min $min";
            is $range.max, $max, "is $range.gist().max $max";
            my ($low,$high) = $range.int-bounds;
            is  $low, $minbound, "is $range.gist().int-bounds[0] $minbound";
            is $high, $maxbound, "is $range.gist().int-bounds[1] $maxbound";
        }, "Testing min, max, int-bounds on $range.gist()";
    }

    test(     ^10,  0, 10,  0,  9);
    test(  -1..10, -1, 10, -1, 10);
    test( -1^..10, -1, 10,  0, 10);
    test( -1..^10, -1, 10, -1,  9);
    test(-1^..^10, -1, 10,  0,  9);
}

{
    ok 0 <= (^10).rand < 10, 'simple rand';
    ok 1 < (1..10).rand < 10, 'no borders excluded';
    ok 0.1 < (0.1^..0.3).rand <= 0.3, 'lower border excluded';
    throws-like ("a".."z").rand, Exception, 'cannot rand on string range';
}

{
    is (1..10).minmax,        '1 10',     "simple Range.minmax on Ints";
    is (3.5..4.5).minmax,     '3.5 4.5',  "simple Range.minmax on Rats";
    is (3.5e1..4.5e1).minmax, '35 45',    "simple Range.minmax on Reals";
    is ("a".."z").minmax,     'a z',      "simple Range.minmax on Strs";
    is (-Inf..Inf).minmax,    '-Inf Inf', "simple Range.minmax on Nums";
    is (^10).minmax,          '0 9',      "Range.minmax on Ints with exclusion";
    dies-ok { ^Inf .minmax },  "cannot have exclusions for minmax otherwise";
}

# RT #126990
is-deeply Int.Range, -Inf^..^Inf, 'Int.range is -Inf^..^Inf';

# RT #128887
is-deeply (eager (^10+5)/2), (2.5, 3.5, 4.5, 5.5, 6.5),
    'Rat range constructed with Range ops does not explode';

# RT #129104
subtest '.rand does not generate value equal to excluded endpoints' => {
    plan 3;

    my $seen = 0;
    for ^10000 { $seen = 1 if (1..^(1+10e-15)).rand == 1+10e-15 };
    ok $seen == 0, '..^ range';

    $seen = 0;
    for ^10000 { $seen = 1 if (1^..(1+10e-15)).rand == 1 };
    ok $seen == 0, '^.. range';

    $seen = 0;
    for ^10000 {
        my $v = (1^..^(1+10e-15)).rand;
        $seen = 1 if $v == 1 or $v == 1+10e-15
    };
    ok $seen == 0, '^..^ range';
}

# vim:set ft=perl6
