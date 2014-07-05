use v6;

# L<S09/Lazy lists>

# Tests for lazy lists
#
# TODO - add timeout control, in tests that may loop forever
# TODO - the backends that don't have infinite lists implemented
#        should warn of this, instead of entering an infinite loop.
# TODO - add test for 2D array

# TODO - there used to be tests here (that were never run) for deleting
#        elements from a lazy list. Can't seem to reproduce them with
#        current spec.

use Test;

plan 23;

{
    my @a = (1..Inf);
    is( @a.splice( 2, 3 ),
        (3, 4, 5),
        "splice" );
}

# basic list operations

is( (1...Inf).elems,
    Inf,
    "elems" );

is( (1...Inf).shift,
    1,
    "shift" );

is( (1...Inf)[2..5],
    [3, 4, 5, 6],
    "simple slice" );

{
    my @a = (1..Inf);
    is( @a[2..5],
        [3, 4, 5, 6],
        "simple slice" );
}

# array assignment

{
    my @a = (1..Inf);
    @a[1] = 99;
    is @a[0, 1, 2].join(' '), '1 99 3', 'assignment to infinite list';
}

{
    my @a = (1..Inf);
    @a[0,1] = (98, 99);
    is( ~@a[0..2],
        "98 99 3",
        "array slice assignment" );
}

{
    my @a = (1..Inf);
    @a[1..10002] = @a[9..10010];
    is( ~@a[0, 1, 2],
        '1 10 11',
        "big slice assignment" );
}

my $was-lazy = 1;
sub make-lazy-list($num) { gather { take $_ for 0..^$num; $was-lazy = 0 } };

{
    $was-lazy = 1;
    my @a = make-lazy-list(4);
    nok $was-lazy, "sanity: make-lazy-list sets $was-lazy.";
    $was-lazy = 1;
    my @b := make-lazy-list(4);
    ok $was-lazy, "sanity: binding won't slurp up the lazy list";
}

{
    $was-lazy = 1;
    my @one := make-lazy-list(10);
    is @one.first(*.is-prime), 2, "sanity: first is-prime is 2";
    ok $was-lazy, "first is lazy";
}

{
    $was-lazy = 1;
    my @one := make-lazy-list(10);
    is @one.grep(*.is-prime)[^3], (2, 3, 5), "sanity: first three primes are 2, 3 and 5";
    ok $was-lazy, "grep is lazy";
}

{
    $was-lazy = 1;
    my @one := make-lazy-list(10);
    is @one.map({ $^num * 2 })[^3], (0, 2, 4), "sanity: first three numbers doubled are 0, 2, 4";
    ok $was-lazy, "map is lazy";
}

{
    $was-lazy = 1;
    my @one := make-lazy-list(10);
    my @two = <a b c d e f>;
    my @res = (@one Z @two)[^3];
    ok $was-lazy, "first argument of Z is lazy";
}

{
    $was-lazy = 1;
    my @two := make-lazy-list(10);
    my @one = <a b c d e f>;
    my @res = (@one Z @two)[^3];
    ok $was-lazy, "second argument of Z is lazy";
}

{
    $was-lazy = 1;
    my @one := make-lazy-list(10);
    my @two = <a b c d e f>;
    my @res = (@one X @two)[^20];
    ok $was-lazy, "first argument of X is lazy";
}

{
    $was-lazy = 1;
    my @one := make-lazy-list(10);
    my @two = <a b c d e f>;
    my @res = (@one X~ @two)[^20];
    ok $was-lazy, "first argument of X~ is lazy";
}

# RT121994
{
    my @a;
    @a.push: $("one,two,three".split(","));
    is_deeply @a, [(<one two three>).list.item], "push: did we not lose the split?";
    my @b;
    @b.unshift: $("one,two,three".split(","));
    is_deeply @b, [(<one two three>).list.item], "unshift: did we not lose the split?";
}

# RT120035
{
    my $i;
    for gather { $i++, .take for 1..5 } {
        last
    }
    is $i, 1, 'for gather { ... } { last } properly lazy';
}

# vim: ft=perl6
