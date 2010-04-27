use v6;

use Test;

plan 67;

# basic Range
# L<S02/Immutable types/A pair of Ordered endpoints>

my $r = 1..5;
isa_ok $r, Range, 'Type';
is $r.WHAT, Range, 'Type';
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

{
    my $x = 0;
    $x++ for (1..4).reverse;
    is $x, 4, '(1..4).reverse still turns into a list of four items';
    my $y = 0;
    $y++ for @( eval((1..4).reverse.perl) );
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
is(+(6..8), 3, 'numification');

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

# simple .to, .from
{
    my $r = 1 .. 5;
    is($r.from, 1, 'range.from');
    is($r.to,   5, 'range.to');

    is($r.min, 1, 'range.min');
    is($r.max, 5, 'range.max');
    is($r.bounds, (1,5), 'range.bounds');
}

# uneven ranges
{
    my $r = 1 .. 4.5;
    is($r.from, 1, 'uneven range.from');
    is($r.to, 4.5, 'uneven range.to');

    is($r.min, 1,   'range.min');
    is($r.max, 4.5, 'range.max');
    is($r.bounds, (1, 4.5), 'range.bounds');
}

# infinite ranges
{
    my $inf = -Inf..Inf;

    is($inf.from, -Inf, 'bottom end of -Inf..Inf is -Inf (1)');
    is($inf.to, Inf, 'top end of -Inf..Inf is Inf (1)');

    ok(42  ~~ $inf, 'positive integer matches -Inf..Inf');
    ok(.2  ~~ $inf, 'positive non-int matches -Inf..Inf');
    ok(-2  ~~ $inf, 'negative integer matches -Inf..Inf');
    ok(-.2 ~~ $inf, 'negative non-int matches -Inf..Inf');
}

# infinite ranges using Whatever
#?rakudo skip "infinite ranges not implemented"
{
    my $inf = *..*;

    is($inf.from, -Inf, 'bottom end of *..* is -Inf (1)');
    is($inf.to, Inf, 'top end of *..* is Inf (1)');

    is($inf.elems, Inf, 'testing number of elements');

    ok(42  ~~ $inf, 'positive integer matches *..*');
    ok(.2  ~~ $inf, 'positive non-int matches *..*');
    ok(-2  ~~ $inf, 'negative integer matches *..*');
    ok(-.2 ~~ $inf, 'negative non-int matches *..*');
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

#?rakudo skip "Neither *-1 or slices work yet in ng"
{
    is((1..8)[*-1], 8, 'postcircumfix:<[ ]> on range works');
    is((1..8)[1,3], [2,4], 'postcircumfix:<[ ]> on range works');
}

# vim:set ft=perl6
