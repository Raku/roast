use v6;
use Test;

plan 30;

#?pugs   skip "is cached NYI"
#?niecza skip "is cached NYI"
{
    my @seen;
    sub fib(Int $x) is cached {
        @seen.push: $x;
        $x <= 1 ?? 1 !! fib($x - 1) + fib($x - 2);
    }
    is fib(9), 55, 'does fib(9) work';
    is @seen, (9,8,7,6,5,4,3,2,1,0), 'did we call them all (1)';
    is fib(10), 89, 'does fib(10) work';
    is @seen, (9,8,7,6,5,4,3,2,1,0,10), 'did we call them all (2)';
    is fib(10), 89, 'does fib(10) work';
    is @seen, (9,8,7,6,5,4,3,2,1,0,10), 'did we call them all (3)';
} #6

#?pugs   skip "is cached NYI"
#?niecza skip "is cached NYI"
{
    my @seen;
    sub duh ( :$foo = 'duh', :$bar = 'doh' ) is cached {
        @seen.push: $foo, $bar;
        $foo ~ $bar;
    }
    is duh(), 'duhdoh', 'no args case(1)';
    is @seen, <duh doh>, 'did we run (1)';
    is duh(), 'duhdoh', 'no args case (2)';
    is @seen, <duh doh>, 'did we run (2)';
    is duh(:foo<foo>), 'foodoh', 'foo arg case (1)';
    is @seen, <duh doh foo doh>, 'did we run (3)';
    is duh(:foo<foo>), 'foodoh', 'foo arg case (2)';
    is @seen, <duh doh foo doh>, 'did we run (4)';
    is duh(:bar<bar>), 'duhbar', 'bar arg case (1)';
    is @seen, <duh doh foo doh duh bar>, 'did we run (5)';
    is duh(:bar<bar>), 'duhbar', 'bar arg case (2)';
    is @seen, <duh doh foo doh duh bar>, 'did we run (6)';
    is duh(:foo<foo>, :bar<bar>), 'foobar', 'foo,bar arg case (1)';
    is @seen, <duh doh foo doh duh bar foo bar>, 'did we run (7)';
    is duh(:foo<foo>, :bar<bar>), 'foobar', 'foo,bar arg case (2)';
    is @seen, <duh doh foo doh duh bar foo bar>, 'did we run (8)';
} #16

#?pugs   skip "is cached NYI"
#?niecza skip "is cached NYI"
{
    my @seen;
    sub noflat (@a) is cached {
        @seen.push: @a;
        [~] @a;
    }
    my @b = <foo bar>;
    is noflat($@b), 'foobar', 'foo,bar case(1)';
    is @seen, [<foo bar>], 'did we run (1)';
    is noflat($@b), 'foobar', 'foo,bar case(2)';
    is @seen, [<foo bar>], 'did we run (2)';

    # make sure the cache key is value based
    @b.push: <baz>;
    is noflat($@b), 'foobarbaz', 'foo,bar,baz case(1)';
    is @seen, [<foo bar foo bar baz>], 'did we run (3)';
    is noflat($@b), 'foobarbaz', 'foo,bar,baz case(2)';
    is @seen, [<foo bar foo bar baz>], 'did we run (4)';
} #8

# vim: ft=perl6
