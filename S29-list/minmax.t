use v6;

use Test;

plan 24;

=begin description

This test tests the C<min> and C<max> builtins.

Reference:
L<"http://groups.google.com/groups?selm=420DB295.3000902%40conway.org">
L<S29/"List"/"=item min">
L<S29/"List"/"=item max">

=end description

my @array = <5 -3 7 0 1 -9>;

# Tests for C<min>:
is @array.min,  -9, "basic method form of min works";
is min(@array), -9, "basic subroutine form of min works";

is @array.min: { $^a <=> $^b }, -9,
  "method form of min with identity comparison block works";
isnt @array.min: { $^a <=> $^b }, 7,
  "bug -- method form of min with identity comparison block returning max";

is min({ $^a <=> $^b }, @array), -9,
  "subroutine form of min with identity comparison block works";
isnt min({ $^a <=> $^b }, @array), 7,
  "bug -- subroutine form of min with identity comparison block returning max";

is @array.min: { abs $^a <=> abs $^b }, 0,
  "method form of min taking a comparision block works";
is min({ abs $^a <=> abs $^b }, @array), 0,
  "subroutine form of min taking a comparision block works";

# Tests for C<max>:
is @array.max,  7, "basic method form of max works";
is max(@array), 7, "basic subroutine form of max works";

is @array.max: { $^a <=> $^b }, 7,
  "method form of max with identity comparison block works";
isnt @array.max: { $^a <=> $^b }, -9,
  "bug -- method form of max with identity comparison block returning min";

is max({ $^a <=> $^b }, @array), 7,
  "subroutine form of max with identity comparison block works";
isnt max({ $^a <=> $^b }, @array), -9,
  "bug -- subroutine form of max with identity comparison block returning min";

is @array.max: { abs $^a <=> abs $^b }, -9,
  "method form of max taking a comparision block works";
is max({ abs $^a <=> abs $^b }, @array), -9,
  "subroutine form of max taking a comparision block works";

# Error cases:
#?pugs 2 todo 'bug'
dies_ok { 42.max }, ".max should not work on scalars";
dies_ok { 42.min }, ".min should not work on scalars";
is (42,).max, 42, ".max should work on one-elem arrays";
is (42,).max, 42, ".max should work on one-elem arrays";

# Tests with literals:
is (1,2,3).max, 3, "method form of max with literals works";
is (1,2,3).min, 1, "method form of min with literals works";
is max(1,2,3),  3, "subroutine form of max with literals works";
is min(1,2,3),  1, "subroutine form of min with literals works";
