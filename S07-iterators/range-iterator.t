use v6;
use lib $?FILE.IO.parent(2).add("packages");
use Test;
use Test::Util;

plan 61;

test-iter-opt (1..5).iterator,
    (1, 2, 3, 4, 5), '1..5';
test-iter-opt (-1.5.Num..^3).iterator, (
    (-1.5).Num, (-1.5).Num.succ, (-1.5).Num.succ.succ,
    (-1.5).Num.succ.succ.succ, (-1.5).Num.succ.succ.succ.succ), '-1.5.Num..^3';
test-iter-opt (-1.5..^3).iterator,
    (-1.5, -½, ½, 1.5, 2.5), '-1.5..^3';
test-iter-opt (-1.5.Num^..3).iterator, (
    (-1.5).Num.succ, (-1.5).Num.succ.succ, (-1.5).Num.succ.succ.succ,
    (-1.5).Num.succ.succ.succ.succ), '-1.5.Num^..3';
test-iter-opt ('d'..'g').iterator,
    <d e f g>, ｢'d'..'g'｣;
test-iter-opt (0..'50').iterator,
    (0…50), ｢0..'50'｣;

{
    my $r = (-1..*).iterator;
    does-ok $r, Iterator, '$r is an Iterator';
    ok $r.is-lazy, '$r.is-lazy works';
    is-deeply $r.pull-one, -1,
        '$r.pull-one == -1 and Range Iterator kept place';
    is-deeply $r.pull-one, 0, '$r.pull-one == 0';
    is-deeply $r.pull-one, 1, '$r.pull-one == 1';
    is-deeply $r.pull-one, 2, '$r.pull-one == 2';
    is-deeply $r.pull-one, 3, '$r.pull-one == 3';
    is-deeply $r.pull-one, 4, '$r.pull-one == 4';
    is-deeply $r.pull-one, 5, '$r.pull-one == 5';
    loop (my $i = 0; $i < 100; $i++) {
        $r.pull-one;  # 6 through 105
    }
    is-deeply $r.pull-one, 106, '$r.pull-one == 106';
}

{
    my $r = (-1.5.Num..*).iterator;
    does-ok $r, Iterator, '$r is an Iterator';
    ok $r.is-lazy, '$r.is-lazy works';

    is-deeply $r.pull-one, Num(-1.5),
        '$r.pull-one == -1.5 and Range Iterator kept place';
    is-deeply $r.pull-one, Num(-1.5).succ, '$r.pull-one == -0.5e0';
    is-deeply $r.pull-one, Num(-1.5).succ.succ, '$r.pull-one == .5e0';
    is-deeply $r.pull-one, Num(-1.5).succ.succ.succ, '$r.pull-one == 1.5e0';
    is-deeply $r.pull-one, Num(-1.5).succ.succ.succ.succ,
        '$r.pull-one == 2.5e0';
    is-deeply $r.pull-one, Num(-1.5).succ.succ.succ.succ.succ,
        '$r.pull-one == 3.5e0';
    is-deeply $r.pull-one, Num(-1.5).succ.succ.succ.succ.succ.succ,
        '$r.pull-one == 4.5e0';
}

{
    my $r = (-1.5..*).iterator;
    does-ok $r, Iterator, '$r is an Iterator';
    ok $r.is-lazy, '$r.is-lazy works';
    is-deeply $r.pull-one, -1.5,
        '$r.pull-one == -1.5 and Range Iterator kept place';
    is-deeply $r.pull-one, -.5, '$r.pull-one == -0.5';
    is-deeply $r.pull-one, .5, '$r.pull-one == .5';
    is-deeply $r.pull-one, 1.5, '$r.pull-one == 1.5';
    is-deeply $r.pull-one, 2.5, '$r.pull-one == 2.5';
    is-deeply $r.pull-one, 3.5, '$r.pull-one == 3.5';
    is-deeply $r.pull-one, 4.5, '$r.pull-one == 4.5';
}

{
    # Make sure we can read two different Iterators at the same time.
    # (May sound like an odd test, but as I type this, if Range iteration
    #  were implemented with gather/take, this test would fail.)
    my $r1 = (-1..*).iterator;
    my $r2 = (42..*).iterator;
    does-ok $r1, Iterator, '$r1 is an Iterator';
    does-ok $r2, Iterator, '$r2 is an Iterator';
    is $r1.pull-one, -1, '$r1.pull-one == -1';
    is $r2.pull-one, 42, '$r2.pull-one == 42';
    is $r1.pull-one, 0, '$r1.pull-one == 0';
    is $r2.pull-one, 43, '$r2.pull-one == 43';
    is $r1.pull-one, 1, '$r1.pull-one == 1';
    is $r2.pull-one, 44, '$r2.pull-one == 44';
    is $r1.pull-one, 2, '$r1.pull-one == 2';
    is $r2.pull-one, 45, '$r2.pull-one == 45';
    is $r1.pull-one, 3, '$r1.pull-one == 3';
    is $r2.pull-one, 46, '$r2.pull-one == 46';
    is $r1.pull-one, 4, '$r1.pull-one == 4';
    is $r2.pull-one, 47, '$r2.pull-one == 47';
    is $r1.pull-one, 5, '$r1.pull-one == 5';
    is $r2.pull-one, 48, '$r2.pull-one == 48';
}

{
    my $r = ('d'..*).iterator;
    does-ok $r, Iterator, '$r is an Iterator';
    ok $r.is-lazy, '$r.is-lazy works';
    is $r.pull-one, 'd', '$r.pull-one == d and Range Iterator kept place';
    is $r.pull-one, 'e', '$r.pull-one == e';
    is $r.pull-one, 'f', '$r.pull-one == f';
    is $r.pull-one, 'g', '$r.pull-one == g';
    is $r.pull-one, 'h', '$r.pull-one == h';
    is $r.pull-one, 'i', '$r.pull-one == i';
}

subtest 'Iterator.skip-one' => {
    plan 6;

    my $r = (1..5).iterator;
    ok $r.skip-one, '.skip-one returns truthy value on successfull skip';
    is-deeply $r.pull-one, 2, '.pull-one after .skip-one gives correct value';

    ok $r.skip-one, '.skip-one (1)';
    ok $r.skip-one, '.skip-one (2)';
    is-deeply $r.pull-one, 5, '.pull-one after 2 .skip-one gives correct value';
    nok $r.skip-one, '.skip-one returns falsy value when there is nothing to skip';
}

subtest 'Iterator.skip-at-least' => {
    plan 4;

    my $r = (1..5).iterator;
    ok        $r.skip-at-least(3),   'skipping 3 values succeeds';
    is-deeply $r.pull-one, 4,        'next value after skip is correct';
    nok       $r.skip-at-least(10),  'skipping more values than we have is falsy';
    ok $r.pull-one =:= IterationEnd, 'no more values to pull';
}

subtest 'Iterator.skip-at-least-pull-one' => {
    plan 3;

    my $r = (1..6).iterator;
    is-deeply $r.skip-at-least-pull-one(3), 4, 'method returns correct value';
    is-deeply $r.pull-one,                  5, 'value after skip is correct';
    ok $r.skip-at-least-pull-one(10) =:= IterationEnd,
        'when not enough values to skip, returns IterationEnd';
}
