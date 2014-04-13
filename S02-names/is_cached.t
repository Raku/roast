use v6;
use Test;

plan 6;

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

# vim: ft=perl6
