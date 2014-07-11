use v6;

use Test;

plan 129;

# basic Range
# L<S02/Immutable types/A pair of Ordered endpoints>

my $r = 1..5;
isa_ok $r, Range, 'Type';
is $r.WHAT.gist, Range.gist, 'Type';
is $r.perl, '1..5', 'canonical representation';

# XXX unspecced: exact value of Range.perl
is (1..5).perl, '1..5', ".perl ..";
is (1^..5).perl, '1^..5', ".perl ^..";
is (1..^5).perl, '1..^5', ".perl ..^";
is (1^..^5).perl, '1^..^5', ".perl ^..^";

my @r = $r;
is @r, [1, 2, 3, 4, 5], 'got the right array';

# Range of Str

$r = 'a'..'c';
isa_ok $r, Range;
# XXX unspecced: exact value of Range.perl
is $r.perl, '"a".."c"', 'canonical representation';
@r = $r;
is @r, [< a b c >], 'got the right array';

# Stationary ranges
is (1..1).perl, '1..1', "stationary num .perl ..";
is (1..1), [1,], 'got the right array';
is ('a'..'a').perl, '"a".."a"', "stationary str .perl ..";
is ('a'..'a'), [< a >], 'got the right array';

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

    dies_ok { $r.shift       }, 'range is immutable (shift)';
    dies_ok { $r.pop         }, 'range is immutable (pop)';
    dies_ok { $r.push(10)    }, 'range is immutable (push)';
    dies_ok { $r.unshift(10) }, 'range is immutable (unshift)';

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
#?niecza skip 'Undeclared name: "Failure"'
{
    my $inf = *..*;
    ok($inf ~~ Failure, "*..* is illegal");
}

# ranges constructed from parameters, from RT#63002.
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

    isa_ok (1..100).pick, Int, "picking a single element from an range of Ints produces an Int";
    ok (1..100).pick ~~ 1..100, "picking a single element from an range of Ints produces one of them";

    isa_ok (1..100).pick(1), Int, "picking 1 from an range of Ints produces an Int";
    ok (1..100).pick(1) ~~ 1..100, "picking 1 from an range of Ints produces one of them";

    my @c = (1..100).pick(2);
    isa_ok @c[0], Int, "picking 2 from an range of Ints produces an Int...";
    isa_ok @c[1], Int, "... and an Int";
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

    isa_ok ('b' .. 'y').pick, Str, "picking a single element from an range of Strs produces an Str";
    ok ('b' .. 'y').pick ~~ 'b' .. 'y', "picking a single element from an range of Strs produces one of them";

    isa_ok ('b' .. 'y').pick(1), Str, "picking 1 from an range of Strs produces an Str";
    ok ('b' .. 'y').pick(1) ~~ 'b' .. 'y', "picking 1 from an range of Strs produces one of them";

    my @c = ('b' .. 'y').pick(2);
    isa_ok @c[0], Str, "picking 2 from an range of Strs produces an Str...";
    isa_ok @c[1], Str, "... and an Str";
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

    isa_ok (1..100).roll, Int, "rolling a single element from an range of Ints produces an Int";
    ok (1..100).roll ~~ 1..100, "rolling a single element from an range of Ints produces one of them";

    isa_ok (1..100).roll(1), Int, "rolling 1 from an range of Ints produces an Int";
    ok (1..100).roll(1) ~~ 1..100, "rolling 1 from an range of Ints produces one of them";

    my @c = (1..100).roll(2);
    isa_ok @c[0], Int, "rolling 2 from an range of Ints produces an Int...";
    isa_ok @c[1], Int, "... and an Int";
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

    isa_ok ('b' .. 'y').roll, Str, "rolling a single element from an range of Strs produces an Str";
    ok ('b' .. 'y').roll ~~ 'b' .. 'y', "rolling a single element from an range of Strs produces one of them";

    isa_ok ('b' .. 'y').roll(1), Str, "rolling 1 from an range of Strs produces an Str";
    ok ('b' .. 'y').roll(1) ~~ 'b' .. 'y', "rolling 1 from an range of Strs produces one of them";

    my @c = ('b' .. 'y').roll(2);
    isa_ok @c[0], Str, "rolling 2 from an range of Strs produces an Str...";
    isa_ok @c[1], Str, "... and an Str";
    ok (@c[0] ~~ 'b' .. 'y') && (@c[1] ~~ 'b' .. 'y'), "rolling 2 from an range of Strs produces two of them";

    is ('b' .. 'y').roll("10").elems, 10, ".roll works Str arguments";
    is roll("10", 'b' .. 'y').elems, 10, "roll works Str arguments";
}

is join(':',grep 1..3, 0..5), '1:2:3', "ranges itemize or flatten lazily";

lives_ok({'A'..'a'}, "A..a range completes");
lives_ok({"\0".."~"}, "low ascii range completes");

# vim:set ft=perl6
