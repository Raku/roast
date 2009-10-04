use v6;
use Test;

# L<S03/List infix precedence/"the series operator">

plan 63;

# some tests firsts that don't require lazy lists

{
    # arity 1
    my @a = 1...{ $_ >= 3 ?? () !! $_ + 1 };
    is @a.join(', '), '1, 2, 3', 'simply series with one item on the LHS';
}

{
    # arity 2
    # http://www.perlmonks.org/?node_id=772778
    sub gcd ($a, $b) {
        ($a, $b ... { $^x % $^y || () })[*-1]
    }
    is gcd(2, 1), 1, 'gcd with infix:<...> (1)';
    is gcd(42, 24), 6, 'gcd with infix:<...> (2)';
}

{
    # slurpy
	sub nextprime( *@prev_primes ) {
        state $iterations = 0;
		return () if $iterations > 3;
		++$iterations;
		my $current = @prev_primes[*-1];
		while ++$current {
            return $current if $current % all(@prev_primes) != 0;
        }
    }
    my @seed = 2, 3;
	my @primes = @seed ... &nextprime;
	is @primes[0], 2, 'prime generator with series op works (0)';
	is @primes[1], 3, 'prime generator with series op works (0)';
	is @primes[2], 5, 'prime generator with series op works (0)';
	is @primes[3], 7, 'prime generator with series op works (0)';
	is @primes[4], 11, 'prime generator with series op works (0)';
	is @primes[5], 13, 'prime generator with series op works (0)';
}

#?rakudo skip 'lazy lists'
{
    my @fib = 1, 1 ... {$^x + $^y};
    is @fib[0], 1, 'fibonacci generator with series op works (0)';
    is @fib[1], 1, 'fibonacci generator with series op works (1)';
    is @fib[2], 2, 'fibonacci generator with series op works (2)';
    is @fib[3], 3, 'fibonacci generator with series op works (3)';
    is @fib[4], 5, 'fibonacci generator with series op works (4)';
    is @fib[5], 8, 'fibonacci generator with series op works (5)';
}

#?rakudo skip 'lazy lists'
{
    my @fib = 1, 1 ... &infix:<+>;
    is @fib[0], 1, 'fibonacci generator with series op works (0)';
    is @fib[1], 1, 'fibonacci generator with series op works (1)';
    is @fib[2], 2, 'fibonacci generator with series op works (2)';
    is @fib[3], 3, 'fibonacci generator with series op works (3)';
    is @fib[4], 5, 'fibonacci generator with series op works (4)';
    is @fib[5], 8, 'fibonacci generator with series op works (5)';
}

#?rakudo skip 'lazy lists'
{
    my @even = 0 ... { $_ + 2 };
    is @even[0], 0, 'infix:<...> with arity one works (0)';
    is @even[1], 2, 'infix:<...> with arity one works (1)';
    is @even[2], 4, 'infix:<...> with arity one works (2)';
    is @even[3], 6, 'infix:<...> with arity one works (3)';
}

#?rakudo skip 'lazy lists'
{
    my @letters = <a b> ... { .succ };
    is @letters[0], 'a', 'infix:<...> works arith arity one (.succ) (0)';
    is @letters[1], 'b', 'infix:<...> works arith arity one (.succ) (1)';
    is @letters[2], 'c', 'infix:<...> works arith arity one (.succ) (2)';
    is @letters[3], 'd', 'infix:<...> works arith arity one (.succ) (3)';
}

#?rakudo skip 'lazy lists'
{
    my @even = 0, 2, 4, ... *;
    is @even[0], 0,  'infix:<...> with * magic (arithmetic, 0)';
    is @even[1], 2 , 'infix:<...> with * magic (arithmetic, 1)';
    is @even[2], 4,  'infix:<...> with * magic (arithmetic, 2)';
    is @even[3], 6,  'infix:<...> with * magic (arithmetic, 3)';
    is @even[4], 8,  'infix:<...> with * magic (arithmetic, 4)';
    is @even[5], 10, 'infix:<...> with * magic (arithmetic, 5)';
}

#?rakudo skip 'lazy lists'
{
    my @dec = 8, 7, 6 ... *;
    is @dec[0..5].join('|'), '8|7|6|5|4|3', 'magic series with decreasing values';
}

#?rakudo skip 'lazy lists'
{
    my @np = 16, 8, 4 ... *;
    is @np[0..4].join('|'), '16|8|4|2|1', 'magic, decreasing power series';
}

#?rakudo skip 'lazy lists'
{
    my @powers_of_two = 1, 2, 4, 8 ... *;
    is @powers_of_two[0..5].join('|'),
       '1|2|4|8|16|32',
       'infix:<...> with * magic (geometric)';
}

#?rakudo skip 'lazy lists'
{
    my @multi = 1 ... { 2 * $_ if $_ < 10 },
                  ... { 3 };
    is @multi[0..9].join('|'),
       '1|2|3|4|8|16|3|3|3|3',
       'block transfer control to next block once empty list is returned';

}

#?rakudo skip 'lazy lists'
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

# L<S03/List infix precedence/If the right operand is * (Whatever)>

#?rakudo skip 'lazy lists'
{
    my @abc = <a b c>;
    my @abccc = @abc, *;
    is @abccc[0], 'a', '@array, * will repeat last element (0)';
    is @abccc[1], 'b', '@array, * will repeat last element (1)';
    is @abccc[2], 'c', '@array, * will repeat last element (2)';
    is @abccc[3], 'c', '@array, * will repeat last element (3)';
    is @abccc[4], 'c', '@array, * will repeat last element (4)';
}


{
    is ~(1, 2 ... *+1, 5),  ~(1..5),
        'series operator with closure and limit (1)';
    is ~(5, 4 ... *-1, 1),  ~(5, 4, 3, 2, 1),
        'series operator with closure and limit (negative increment) (2)';
    is ~(1, 3 ... *+2, 5),  ~(1, 3, 5),
        'series operator with closure and limit (3)';
    is ~(2, 4 ... *+2, 7),  ~(2, 4, 6),
        'series operator with closure and limit that does not match';
    #?rakudo skip 'lazy lists'
    is (1, 3 ... *+2, -1)[4], 9,
       '*+2 closure with limit < last number results in infinite list';
}

{
    is ~( 1  ...  1 ), '1',        '1 ... 1 works (degenerate case';
    is ~( 1  ...  4 ), ~<1 2 3 4>, 'Int ... Int works (forward)';
    is ~( 4  ...  1 ), ~<4 3 2 1>, 'Int ... Int works (backward)';
    is ~('a' ... 'd'), ~<a b c d>, 'Str ... Str works (forward)';
    is ~('d' ... 'a'), ~<d c b a>, 'Str ... Str works (backward)';
}

#?rakudo skip 'slices, series'
{
    is ~( 1 ... *+1, 5 ... *+2, 9), ~<1 2 3 4 5 7 9>,
            'expression with two magic series operators';
    is ~( 1 ... *+2, 6 ... *+3, 9), ~<1 3 5 8>,
            'expression with two magic series operators and non-matching end points';
}

# vim: ft=perl6
