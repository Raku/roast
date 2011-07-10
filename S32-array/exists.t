use v6;
use Test;

plan 15;

=begin description

Basic C<exists> tests on arrays, see S32.

=end description

# L<S32::Containers/"Array"/=item exists>

my @array = <a b c d>;
#?rakudo 2 skip 'attributes'
ok @array[0]:exists,    "exists(positive index) on arrays (1)";
ok @array[3]:exists,    "exists(positive index) on arrays (1)";
ok @array.exists(0),    "exists(positive index) on arrays (1)";
ok @array.exists(1),    "exists(positive index) on arrays (2)";
ok @array.exists(2),    "exists(positive index) on arrays (3)";
ok @array.exists(3),    "exists(positive index) on arrays (4)";
ok !@array.exists(4),   "exists(positive index) on arrays (5)";
ok !@array.exists(42),  "exists(positive index) on arrays (2)";
#?rakudo todo 'nom regression'
ok !@array.exists(-1),   "exists(negative index) on arrays (1)";
#?rakudo 6 skip 'Pm wants spec clarification'
ok @array.exists(*-1),   "exists(negative index) on arrays (1)";
ok @array.exists(*-2),   "exists(negative index) on arrays (2)";
ok @array.exists(*-3),   "exists(negative index) on arrays (3)";
ok @array.exists(*-4),   "exists(negative index) on arrays (4)";
ok !@array.exists(*-5),  "exists(negative index) on arrays (5)";
ok !@array.exists(*-42), "exists(negative index) on arrays (6)";

# vim: ft=perl6
