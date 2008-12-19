use v6;
use Test;

# L<S03/List infix precedence/"the series operator">

plan 32;

{
    my @fib = 1, 1 ... {$^x + $^y};
    is @fib[0], 1, 'fibonacci generator with series op works (0)';
    is @fib[1], 1, 'fibonacci generator with series op works (1)';
    is @fib[2], 2, 'fibonacci generator with series op works (2)';
    is @fib[3], 3, 'fibonacci generator with series op works (3)';
    is @fib[4], 5, 'fibonacci generator with series op works (4)';
    is @fib[5], 8, 'fibonacci generator with series op works (5)';
}

{
    my @fib = 1, 1 ... &infix:<+>;
    is @fib[0], 1, 'fibonacci generator with series op works (0)';
    is @fib[1], 1, 'fibonacci generator with series op works (1)';
    is @fib[2], 2, 'fibonacci generator with series op works (2)';
    is @fib[3], 3, 'fibonacci generator with series op works (3)';
    is @fib[4], 5, 'fibonacci generator with series op works (4)';
    is @fib[5], 8, 'fibonacci generator with series op works (5)';
}

{
    my @even = 0 ... { $_ + 2 };
    is @even[0], 0, 'infix:<...> with arity one works (0)';
    is @even[1], 2, 'infix:<...> with arity one works (1)';
    is @even[2], 4, 'infix:<...> with arity one works (2)';
    is @even[3], 6, 'infix:<...> with arity one works (3)';
}

{
    my @letters = <a b> ... { .succ };
    is @letters[0], 'a', 'infix:<...> works arith arity one (.succ) (0)';
    is @letters[1], 'b', 'infix:<...> works arith arity one (.succ) (1)';
    is @letters[2], 'c', 'infix:<...> works arith arity one (.succ) (2)';
    is @letters[3], 'd', 'infix:<...> works arith arity one (.succ) (3)';
}

{
    my @even = 0, 2, 4, ... *;
    is @even[0], 0,  'infix:<...> with * magic (arithmetic, 0)';
    is @even[1], 2 , 'infix:<...> with * magic (arithmetic, 1)';
    is @even[2], 4,  'infix:<...> with * magic (arithmetic, 2)';
    is @even[3], 6,  'infix:<...> with * magic (arithmetic, 3)';
    is @even[4], 8,  'infix:<...> with * magic (arithmetic, 4)';
    is @even[5], 10, 'infix:<...> with * magic (arithmetic, 5)';
}

{
    my @dec = 8, 7, 6 ... *;
    is @dev[0..5].join('|'), '8|7|6|5|4|3', 'magic series with decreasing values';
}

{
    my @np = 16, 8, 4 ... *;
    is @np[0..4].join('|'), '16|8|4|2|1', 'magic, decreasing power series';
}

{
    my @powers_of_two = 1, 2, 4, 8 ... *;
    is @powers_of_two[0..5].join('|'), 
       '1|2|4|8|16|32',
       'infix:<...> with * magic (geometric)';
}

{
    my @multi = 1 ... { 2 * $_ if $_ < 10 },
                  ... { 3 };
    is @multi[0..9].join('|'),
       '1|2|3|4|8|16|3|3|3|3',
       'block transfer control to next block once empty list is returned';

}

{ # 1 1, 2 2s, 3 3s, etc.
    my @xxed = 1 ... { my $next = $^a + 1; $next xx $next };
    is @xxed[0], 1,  'infix:<...> with list return (0)';
    is @xxed[1], 2 , 'infix:<...> with list return (1)';
    is @xxed[2], 2,  'infix:<...> with list return (2)';
    is @xxed[3], 3,  'infix:<...> with list return (3)';
    is @xxed[4], 3,  'infix:<...> with list return (4)';
    is @xxed[5], 3, 'infix:<...> with list return (5)';
    is @xxed[6], 4, 'infix:<...> with list return (6)';
}

# vim: ft=perl6
