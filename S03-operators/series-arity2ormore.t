use v6;
use Test;

# L<S03/List infix precedence/"the series operator">

plan *;

# some tests without regard to ending 

is (1, 1, { $^a + $^b } ... *).batch(6).join(', '), '1, 1, 2, 3, 5, 8', 'arity-2 Fibonacci';
is (1, 1, 2, -> $a, $b { $a + $b } ... *).batch(6).join(', '), '1, 1, 2, 3, 5, 8', 'arity-2 Fibonacci, 3 seeds';
is (1, 1, 2, 3, { $^a + $^b } ... *).batch(6).join(', '), '1, 1, 2, 3, 5, 8', 'arity-2 Fibonacci, 4 seeds';

# some tests which exactly hit a limit

is (1, 1, { $^a + $^b } ... 8).batch(20).join(', '), '1, 1, 2, 3, 5, 8', 'arity-2 Fibonacci';
is (1, 1, 2, -> $a, $b { $a + $b } ... 8).batch(20).join(', '), '1, 1, 2, 3, 5, 8', 'arity-2 Fibonacci, 3 seeds';
is (1, 1, 2, 3, { $^a + $^b } ... 8).batch(20).join(', '), '1, 1, 2, 3, 5, 8', 'arity-2 Fibonacci, 4 seeds';

# some tests which go past a limit

is (1, 1, { $^a + $^b } ... 9).batch(20).join(', '), '1, 1, 2, 3, 5, 8', 'arity-2 Fibonacci';
is (1, 1, 2, -> $a, $b { $a + $b } ... 9).batch(20).join(', '), '1, 1, 2, 3, 5, 8', 'arity-2 Fibonacci, 3 seeds';
is (1, 1, 2, 3, { $^a + $^b } ... 9).batch(20).join(', '), '1, 1, 2, 3, 5, 8', 'arity-2 Fibonacci, 4 seeds';

done_testing;