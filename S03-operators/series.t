use v6;
use Test;

# L<S03/List infix precedence/"the series operator">

plan *;

# some tests firsts that don't require lazy lists

is (1 ... 5).join(', '), '1, 2, 3, 4, 5', 'simple series with one item on the LHS';
is (1, 3 ... 7).join(', '), '1, 3, 5, 7', 'simple additive series with two items on the LHS';
is (1, 3, 5 ... 9).join(', '), '1, 3, 5, 7, 9', 'simple additive series with three items on the LHS';
is (1, 3, 9 ... 81).join(', '), '1, 3, 9, 27, 81', 'simple multiplicative series with three items on the LHS';
is (1, { $_ + 2 } ... 7).join(', '), '1, 3, 5, 7', 'simple series with one item and closure on the LHS';

is (1, 1, { $^x + $^y } ... 13).join(', '), '1, 1, 2, 3, 5, 8, 13', 'limited fibonacci generator';


#?rakudo skip "Not up to current spec"
{
    # arity 2
    # http://www.perlmonks.org/?node_id=772778
    sub gcd ($a, $b) {
        ($a, $b ... { $^x % $^y || () })[*-1]
    }
    is gcd(2, 1), 1, 'gcd with infix:<...> (1)';
    is gcd(42, 24), 6, 'gcd with infix:<...> (2)';
}

is (1 ... *).batch(5).join(', '), '1, 2, 3, 4, 5', 'lazy series with one item on the LHS';
is (1, 3 ... *).batch(5).join(', '), '1, 3, 5, 7, 9', 'lazy additive series with two items on the LHS';
is (1, 3, 5 ... *).batch(5).join(', '), '1, 3, 5, 7, 9', 'lazy additive series with three items on the LHS';
is (1, 3, 9 ... *).batch(5).join(', '), '1, 3, 9, 27, 81', 'lazy multiplicative series with three items on the LHS';
is (1, 1 ... *).batch(5).join(', '), '1, 1, 1, 1, 1', 'lazy "additive" series with two items on the LHS';
is (1, 1, 1 ... *).batch(5).join(', '), '1, 1, 1, 1, 1', 'lazy "additive" series with three items on the LHS';
is (1, { $_ + 2 } ... *).batch(5).join(', '), '1, 3, 5, 7, 9', 'lazy series with one item and arity-1 closure on the LHS';

is (1, 1, { $^x + $^y } ... *).batch(7).join(', '), '1, 1, 2, 3, 5, 8, 13', 'infinite fibonacci generator';
#?rakudo skip "Symbol '&infix:<+>' not predeclared in <anonymous>"
is (1, 1, &infix:<+> ... *).batch(7).join(', '), '1, 1, 2, 3, 5, 8, 13', 'infinite fibonacci generator';

#?rakudo skip "state NYI"
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

is ('a'  ... *).batch(7).join(', '), 'a, b, c, d, e, f, g', 'string from single generator';
is (<a b> ... *).batch(7).join(', '), 'a, b, c, d, e, f, g', 'string from double generator';
is (<a b>, { .succ } ... *).batch(7).join(', '), 'a, b, c, d, e, f, g', 'string and arity-1';

is (8, 7 ... *).batch(5).join(', '), '8, 7, 6, 5, 4', 'arith decreasing';
is (8, 7, 6 ... *).batch(5).join(', '), '8, 7, 6, 5, 4', 'arith decreasing';
is (16, 8, 4 ... *).batch(5).join(', '), '16, 8, 4, 2, 1', 'geom decreasing';



#?rakudo skip 'chained series NYI'
{
    my @multi = 1 ... { 2 * $_ if $_ < 10 },
                  ... { 3 };
    is @multi[0..9].join('|'),
       '1|2|3|4|8|16|3|3|3|3',
       'block transfer control to next block once empty list is returned';

}

#?rakudo skip 'Is this really what this should do?'
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

# L<S03/List infix precedence/If the limit is *>

# Does this test belond in series?
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
    is ~(1, 2, *+1 ... 5),  ~(1..5),
        'series operator with closure and limit (1)';
    is ~(5, 4, *-1 ... 1),  ~(5, 4, 3, 2, 1),
        'series operator with closure and limit (negative increment) (2)';
    is ~(1, 3, *+2 ... 5),  ~(1, 3, 5),
        'series operator with closure and limit (3)';
    is ~(2, 4, *+2 ... 7),  ~(2, 4, 6),
        'series operator with closure and limit that does not match';
    is ~(2, *+1 ... 5),  ~(2..5),
        'series operator with closure and limit (1) (one item on LHS)';
    is ~(4, *-1 ... 1),  ~(4, 3, 2, 1),
        'series operator with closure and limit (negative increment) (2) (one item on LHS)';
    is ~(3, *+2 ... 5),  ~(3, 5),
        'series operator with closure and limit (3) (one item on LHS)';
    is ~(4, *+2 ... 7),  ~(4, 6),
        'series operator with closure and limit that does not match (one item on LHS)';
    #?rakudo skip "[4] is eager rather than lazy ATM"
    is (1, 3, *+2 ... -1)[4], 9,
       '*+2 closure with limit < last number results in infinite list';
}

{
    is ~( 1  ...  1 ), '1',        '1 ... 1 works (degenerate case)';
    is ~( 1  ...  4 ), ~<1 2 3 4>, 'Int ... Int works (forward)';
    is ~( 4  ...  1 ), ~<4 3 2 1>, 'Int ... Int works (backward)';
    is ~('a' ... 'd'), ~<a b c d>, 'Str ... Str works (forward)';
    is ~('d' ... 'a'), ~<d c b a>, 'Str ... Str works (backward)';
}

#?rakudo skip 'slices, series'
{
    is ~( 1, *+1 ... 5, *+2 ... 9), ~<1 2 3 4 5 7 9>,
            'expression with two magic series operators';
    is ~( 1, *+2 ... 6, *+3 ... 9), ~<1 3 5 8>,
            'expression with two magic series operators and non-matching end points';
}

done_testing;

# vim: ft=perl6
