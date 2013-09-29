use v6;
use Test;

plan 8;

=begin description

Basic C<exists> tests on arrays, see S32.

=end description

# L<S32::Containers/"Array"/=item exists>

my @array = <a b c d>;
ok @array[0]:exists,    "exists(positive index) on arrays (1)";
ok @array[3]:exists,    "exists(positive index) on arrays (1)";
ok @array[0]:exists,    "exists(positive index) on arrays (1)";
ok @array[1]:exists,    "exists(positive index) on arrays (2)";
ok @array[2]:exists,    "exists(positive index) on arrays (3)";
ok @array[3]:exists,    "exists(positive index) on arrays (4)";
ok @array[4]:!exists,   "exists(positive index) on arrays (5)";
ok @array[42]:!exists,  "exists(positive index) on arrays (2)";

# vim: ft=perl6
