use v6;

use Test;

plan 32;

=begin description

This test tests the C<min> and C<max> builtins.

Reference:
L<"http://groups.google.com/groups?selm=420DB295.3000902%40conway.org">
L<S32::Containers/"List"/"=item min">
L<S32::Containers/"List"/"=item max">

As per S32, the sub form requires a comparison function. The form without
comparison function is spelled [min]

=end description

my @array = <5 -3 7 0 1 -9>;

# Tests for C<min>:
is @array.min,  -3, "basic method form of min works";
dies_ok {min(@array)}, 'min() requires comparison function';
#?rakudo skip 'named args'
is min({$^a <=> $^b }, :values(@array)), -3, "basic subroutine form of min works with named args";

is (@array.min: { $^a <=> $^b }), -9,
  "method form of min with identity comparison block works";
isnt (@array.min: { $^a <=> $^b }), 7,
  "method form of min with identity comparison block";

is min({ $^a <=> $^b }, @array), -9,
  "subroutine form of min with identity comparison block works";
isnt min({ $^a <=> $^b }, @array), 7,
  "subroutine form of min with identity comparison block";

is (@array.min: { abs $^a <=> abs $^b }), 0,
  "method form of min taking a comparision block works";
is min({ abs $^a <=> abs $^b }, @array), 0,
  "subroutine form of min taking a comparision block works";

is ((-10..10).min: { abs $^a <=> abs $^b }), 0,
  "method form of min on Ranges taking a comparision block works";

# Tests for C<max>:
is (@array.max),  7, "basic method form of max works";
is max({ $^a <=> $^b }, @array), 7, "basic subroutine form of max works";
#?rakudo skip 'named args'
is max(:values(@array)), 7, "basic subroutine form of max works with named args";

is (@array.max: { $^a <=> $^b }), 7,
  "method form of max with identity comparison block works";
isnt (@array.max: { $^a <=> $^b }), -9,
  "method form of max with identity comparison block";

is ((-10..9).max: { abs $^a <=> abs $^b }), -10,
  "method form of max on Ranges taking a comparision block works";

is max({ $^a <=> $^b }, @array), 7,
  "subroutine form of max with identity comparison block works";
isnt max({ $^a <=> $^b }, @array), -9,
  "bug -- subroutine form of max with identity comparison block returning min";

is (@array.max: { abs $^a <=> abs $^b }), -9,
  "method form of max taking a comparision block works";
is max({ abs $^a <=> abs $^b }, @array), -9,
  "subroutine form of max taking a comparision block works";

# Error cases:
#?pugs 2 todo 'bug'
is 42.min, 42, ".min should work on scalars";
is 42.max, 42, ".max should work on scalars";
is (42,).min, 42, ".min should work on one-elem arrays";
is (42,).max, 42, ".max should work on one-elem arrays";

# Tests with literals:
is (1,2,3).max, 3, "method form of max with literals works";
is (1,2,3).min, 1, "method form of min with literals works";
is max({$^a <=> $^b}, 1,2,3),  3, "subroutine form of max with literals works";
is min({$^a <=> $^b}, 1,2,3),  1, "subroutine form of min with literals works";

# Try to read numbers from a file
@array = lines("t/spec/S32-list/numbers.data");
is @array.max, 5, "max of strings read from a file works";
#?rakudo 1 todo 'Parrot happens to append a newline to any file'
is @array.min, -80, "min of strings read from a file works";

# Same, but numifying the numbers first
@array = map { +$_ }, @array;
is @array.max, 28, "max of strings read from a file works";
is @array.min, -80, "min of strings read from a file works";

