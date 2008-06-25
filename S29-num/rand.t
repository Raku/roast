use v6;

use Test;

plan 6;

=begin pod

Basic tests for the rand() builtin

=end pod

# L<S29/Num/"=item rand">

ok(rand() >= 0, 'rand() returns numbers greater than or equal to 0');
ok(rand() < 1, 'rand() returns numbers less than 1');

# L<S29/Num/"=item srand">

lives_ok { srand(1) }, 'srand(1) lives and parses';

#?rakudo skip 'dubious errors'
{
    sub repeat_rand ($seed) {
	    srand($seed);
    	for 1..99 { rand(); }
	    return rand();
    }

    ok(repeat_rand(314159) == repeat_rand(314159),
        'srand() provides repeatability for rand()');

    ok(repeat_rand(0) == repeat_rand(0),
        'edge case: srand(0) provides repeatability');

    ok(repeat_rand(0) != repeat_rand(1),
        'edge case: srand(0) not the same as srand(1)');
}
