use v6;

use Test;

plan 2 + 2*10 + 4;

=begin pod

Basic tests for the rand() builtin

=end pod

# L<S29/Num/"=item rand">

ok(rand() >= 0, 'rand() returns numbers greater than or equal to 0');
ok(rand() < 1, 'rand() returns numbers less than 1');

for 1 .. 10 {
  ok rand(10) >=  0, "rand(10) always returns numbers greater than or equal to 0 ($_)";
  ok rand(10)  < 10, "rand(10) always returns numbers less than 10 ($_)";
}

# L<S29/Num/"=item srand">

#?rakudo skip 'parsefail'
ok(srand(1), 'srand(1) parses');

#?rakudo skip 'parsefail'
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
