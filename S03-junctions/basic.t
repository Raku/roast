use v6;

use Test;

plan 22;

=begin pod

More Junction Tests

These tests are derived from the Perl6 and Parrot Essentials Chapter 4, page 42

=end pod

my $j = any(1, 2, 3);
ok $j ~~ Junction, '$j is a Junction';

my @values = $j.values.sort;
is(+@values, 3, 'our junction has three values in it');

is(@values[0], 1, 'our junctions first value is 1');
is(@values[1], 2, 'our junctions second value is 2');
is(@values[2], 3, 'our junctions third value is 3');

my $sums = $j + 3;

ok $sums ~~ Junction, '$j + 3 is also a Junction';

my @sums_values = sort $sums.values;
is(+@sums_values, 3, 'our junction has three values in it');
is(@sums_values[0], 4, 'our junctions first value is 4');
is(@sums_values[1], 5, 'our junctions second value is 5');
is(@sums_values[2], 6, 'our junctions third value is 6');

# loop enough to go through it twice
for (1 .. 6) {
    ok((1 ^ 2 ^ 3) == $j.values.pick, 'it is always at least one');
    ok((1 | 2 | 3) == $j.values.pick, 'it is always one of them');
}
