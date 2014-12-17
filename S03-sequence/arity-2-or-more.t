use v6;
use Test;

# L<S03/List infix precedence/"the sequence operator">

plan 20;

# some tests without regard to ending

is (1, 1, { $^a + $^b } ... *).[^6].join(', '), '1, 1, 2, 3, 5, 8', 'arity-2 Fibonacci';
is (1, 1, &infix:<+> ... *).[^6].join(', '), '1, 1, 2, 3, 5, 8', 'arity-2 Fibonacci, using "&infix:<+>"';
#?niecza skip "Undeclared names: '[+]'"
is (1, 1, &[+] ... *).[^6].join(', '), '1, 1, 2, 3, 5, 8', 'arity-2 Fibonacci, using "&[+]"';
is (0, 1, { $^a + $^b } ... *).[^7].join(', '), '0, 1, 1, 2, 3, 5, 8', 'arity-2 Fibonacci, 0 1 seeds';
is (1, 1, 2, -> $a, $b { $a + $b } ... *).[^6].join(', '), '1, 1, 2, 3, 5, 8', 'arity-2 Fibonacci, 3 seeds';
is (1, 1, 2, 3, { $^a + $^b } ... *).[^6].join(', '), '1, 1, 2, 3, 5, 8', 'arity-2 Fibonacci, 4 seeds';
is (0, 1, 1, 2, 3, { $^a + $^b } ... *).[^7].join(', '), '0, 1, 1, 2, 3, 5, 8', 'arity-2 Fibonacci, 5 seeds';

# some tests which exactly hit a limit

is (1, 1, { $^a + $^b } ... 8).join(', '), '1, 1, 2, 3, 5, 8', 'arity-2 Fibonacci';
is (1, 1, 2, -> $a, $b { $a + $b } ... 8).join(', '), '1, 1, 2, 3, 5, 8', 'arity-2 Fibonacci, 3 seeds';
is (1, 1, 2, 3, { $^a + $^b } ... 8).join(', '), '1, 1, 2, 3, 5, 8', 'arity-2 Fibonacci, 4 seeds';
# adapted from http://www.perlmonks.org/?node_id=772778
#?niecza skip "Undeclared names: '[%]'"
is (42, 24, &[%] ... 0)[*-2], 6, 'arity-2 GCD';
#?niecza skip "Undeclared names: '[%]'"
is (42, 24, &[%] ...^ 0)[*-1], 6, 'arity-2 GCD with excluded limit';
is (42, 24, * % * ... 0)[*-2], 6, 'arity-2 GCD';
is (42, 24, * % * ...^ 0)[*-1], 6, 'arity-2 GCD with excluded limit';

# some tests which miss a limit

is (1, 1, { $^a + $^b } ... 9).[^7].join(', '), '1, 1, 2, 3, 5, 8, 13', 'arity-2 Fibonacci';
is (1, 1, 2, -> $a, $b { $a + $b } ... 9).[^7].join(', '), '1, 1, 2, 3, 5, 8, 13', 'arity-2 Fibonacci, 3 seeds';
is (1, 1, 2, 3, { $^a + $^b } ... 9).[^7].join(', '), '1, 1, 2, 3, 5, 8, 13', 'arity-2 Fibonacci, 4 seeds';

# sequence with slurpy functions
{
    sub nextprime( *@prev_primes ) {
        my $current = @prev_primes[*-1];
        1 while ++$current % any(@prev_primes) == 0;
        return $current;
    }
    is (2, &nextprime ... 13).join(' '), '2 3 5 7 11 13', 'slurpy prime generator';
}
is (1, 2, sub {[*] @_[*-1], @_ + 1} ... 720).join(' '), '1 2 6 24 120 720', 'slurpy factorial generator';

# RT #117825
# TODO: better test (e.g. typed exception instead of testing for backend specific error messages
#?rakudo.parrot skip 'RT #117825'
{
    throws_like { ( ^1, *+* ... * )[^20] }, Exception,
        message => {
            m/
                'Too few positionals passed; expected 2 arguments but got 1'
                |
                'Not enough positional parameters passed; got 1 but expected 2'
            /
        },
        'no internals leaking out with series operator used wrongly (arity 2)';
}

done;
