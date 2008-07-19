use v6;

use Test;

plan 87;

# basic Range
# L<S02/Immutable types/A pair of Ordered endpoints; gens immutables when iterated>

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

my $r = 'a'..'c';
isa_ok $r, 'Range';
# XXX unspecced: exact value of Range.perl
is $r.perl, '"a".."c"', 'canonical representation';
my @r = $r;
is @r, [< a b c >], 'got the right array';

# Stationary ranges
is (1..1).perl, '1..1', "stationary num .perl ..";
is (1..1), [1,], 'got the right array';
is ('a'..'a').perl, '"a".."a"', "stationary str .perl ..";
is ('a'..'a'), [< a >], 'got the right array';

# Decreasing Ranges
#?rakudo 16 skip 'decreasing ranges are unspecced'
{
    my $r = 5..1;
    is $r.perl, '5..1', "decreasing num .perl ..";
    is @r, [5, 4, 3, 2, 1], 'got the right array';
    my $r = 5^..1;
    # XXX unspecced: exact value of Range.perl
    is $r.perl, '5^..1', "decreasing num .perl ^..";
    my @r = $r;
    is @r, [4, 3, 2, 1], 'got the right array';
    my $r = 5..^1;
    # XXX unspecced: exact value of Range.perl
    is $r.perl, '5..^1', "decreasing num .perl ..^";
    my @r = $r;
    is @r, [5, 4, 3, 2], 'got the right array';
    my $r = 5^..^1;
    # XXX unspecced: exact value of Range.perl
    is $r.perl, '5^..^1', "decreasing num .perl ^..^";
    my @r = $r;
    is @r, [4, 3, 2], 'got the right array';

    my $r = 'd'..'a';
    is $r.perl, '"d".."a"', "decreasing str .perl ..";
    is @r, [< d c b a >], 'got the right array';
    my $r = 'd'^..'a';
    # XXX unspecced: exact value of Range.perl
    is $r.perl, '"d"^.."a"', "decreasing str .perl ^..";
    my @r = $r;
    is @r, [< d, c, b, a >], 'got the right array';
    my $r = 'd'..^'a';
    # XXX unspecced: exact value of Range.perl
    is $r.perl, '"d"..^"a"', "decreasing str .perl ..^";
    my @r = $r;
    is @r, [< d, c, b >], 'got the right array';
    my $r = 'd'^..^'a';
    # XXX unspecced: exact value of Range.perl
    is $r.perl, '"d"^..^"a"', "decreasing str .perl ^..^";
    my @r = $r;
    is @r, [< c b >], 'got the right array';
}

# ACCEPTS and equals tests
{
    my $r = 1..5;
    #?rakudo 4 skip '.ACCEPTS not implemented between ranges'
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

# shift
{
    my $r = 1..5;
    my $n = $r.shift;
    is $n, 1, "got the right shift result";
    my @r = $r;
    is @r, [2, 3, 4, 5], 'got the right state change';
    my $s = 2..5;
    is $r, $s, "range modified after shift";
}

# simple .to, .from
{
    my $r = 1 .. 5;
    is($r.from, 1, 'range.from');
    is($r.to,   5, 'range.to');

    is($r.min, 1, 'range.min');
    is($r.max, 5, 'range.max');
    is($r.minmax, [1,5], 'range.minmax');

    ### pmichaud, 2008-07-04:  XXX  no spec for .reverse
    #?rakudo 2 skip '.reverse on ranges (missing List.from, List.to)'
    is($r.reverse.from, 5, 'range.reverse.from');
    is($r.reverse.to,   1, 'range.reverse.to');
    ### pmichaud, 2008-07-04:  XXX  doesn't test reversed min/max/minmax
    is($r.min, 1, 'range.reverse.min');
    is($r.max, 5, 'range.reverse.max');
    is($r.minmax, [1,5], 'range.reverse.minmax');
}

# uneven ranges
{
    my $r = 1 .. 4.5;
    is($r.from, 1, 'uneven range.from');
    is($r.to, 4.5, 'uneven range.to');

    is($r.min, 1,   'range.min');
    is($r.max, 4.5, 'range.max');
    is($r.minmax, [1, 4.5], 'range.minmax');

    #?rakudo 2 skip '.reverse on ranges'
    is($r.reverse.from, 4.5, 'uneven range.reverse.from');
    is($r.reverse.to,   1,   'uneven range.reverse.to');

    is($r.shift, 1, 'uneven range.shift (1)');
    is($r.pop, 4.5, 'uneven range.pop (1)');

    is($r.from,  2, 'uneven range.from after shift,pop');
    is($r.to,  3.5, 'uneven range.to after shift,pop');
    is($r.minmax, [2, 3.5], 'uneven range.minmax after shift,pop');

    is($r.shift, 2, 'uneven range.shift (2)');
    is($r.pop, 3.5, 'uneven range.pop (2)');
    #?rakudo skip 'XXX test error -- result should be undef?'
    is($r.shift, 3, 'uneven range.shift (3)');
    ok(!$r.pop,     'uneven range.pop (empty)');
    ok(!$r.shift,   'uneven range.shift (empty)');
}

# infinite ranges
#?rakudo skip 'infinite ranges not implemented'
{
    my $inf = *..*;

    is($inf.shift, -Inf, 'bottom end of *..* is -Inf (1)');
    is($inf.shift, -Inf, 'bottom end of *..* is still -Inf (2)');

    is($inf.pop, Inf, 'top end of *..* is Inf (1)');
    is($inf.pop, Inf, 'top end of *..* is still Inf (2)');

    ok(42  ~~ $inf, 'positive integer matches *..*');
    ok(.2  ~~ $inf, 'positive non-int matches *..*');
    ok(-2  ~~ $inf, 'negative integer matches *..*');
    ok(-.2 ~~ $inf, 'negative non-int matches *..*');
}

# vim:set ft=perl6
