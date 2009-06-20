use v6;

use Test;

plan 109;

=begin pod

Basic tests for the rand builtin

=end pod

# L<S32::Numeric/Num/"=item rand">

ok(rand >= 0, 'rand returns numbers greater than or equal to 0');
ok(rand < 1, 'rand returns numbers less than 1');

sub test_rand_range(Int $num) {
  for 1..20 {
    my $result = $num.rand;
    ok($num > $result >= 0, "rand returns numbers in [0, $num)");
  }
}

test_rand_range(2);
test_rand_range(3);
test_rand_range(5);
test_rand_range(7);
test_rand_range(11);

# L<S32::Numeric/Num/"=item srand">

lives_ok { srand(1) }, 'srand(1) lives and parses';

{
    my sub repeat_rand ($seed) {
        srand($seed);
        for 1..99 { rand; }
        return rand;
    }

    ok(repeat_rand(314159) == repeat_rand(314159),
        'srand() provides repeatability for rand');

    ok(repeat_rand(0) == repeat_rand(0),
        'edge case: srand(0) provides repeatability');

    ok(repeat_rand(0) != repeat_rand(1),
        'edge case: srand(0) not the same as srand(1)');
}

{
    my sub repeat_rand ($seed) {
        srand(:x($seed));
        for 1..99 { rand; }
        return rand;
    }

    ok(repeat_rand(314159) == repeat_rand(314159),
        'srand(:x(...)) provides repeatability for rand');

    ok(repeat_rand(0) == repeat_rand(0),
        'edge case: srand(:x(0)) provides repeatability');

    ok(repeat_rand(0) != repeat_rand(1),
        'edge case: srand(:x(0)) not the same as srand(:x(1))');
}

# vim: ft=perl6
