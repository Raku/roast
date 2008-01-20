use v6-alpha;
use Test;

plan 12;

=begin description

Basic C<exists> tests on arrays, see S29.

=end description

# L<S29/"Array"/=item exists>

my @array = <a b c d>;
ok @array.exists(0),    "exists(positive index) on arrays (1)";
ok @array.exists(1),    "exists(positive index) on arrays (2)";
ok @array.exists(2),    "exists(positive index) on arrays (3)";
ok @array.exists(3),    "exists(positive index) on arrays (4)";
ok !@array.exists(4),   "exists(positive index) on arrays (5)";
ok !@array.exists(42),  "exists(positive index) on arrays (2)";
ok @array.exists(-1),   "exists(negative index) on arrays (1)";
ok @array.exists(-2),   "exists(negative index) on arrays (2)";
ok @array.exists(-3),   "exists(negative index) on arrays (3)";
ok @array.exists(-4),   "exists(negative index) on arrays (4)";
ok !@array.exists(-5),  "exists(negative index) on arrays (5)";
ok !@array.exists(-42), "exists(negative index) on arrays (6)";

