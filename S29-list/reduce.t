use v6;

use Test;

=begin description

This test tests the C<reduce> builtin.

Reference:
L<"http://groups.google.com/groups?selm=420DB295.3000902%40conway.org">

=end description

plan 11;

# L<S29/List/=item reduce>

{
  my @array = <5 -3 7 0 1 -9>;
  my $sum   = 5 + -3 + 7 + 0 + 1 + -9; # laziness :)

  is((reduce { $^a + $^b }, 0, @array), $sum, "basic reduce works (1)");
  is((reduce { $^a + $^b }: 100, @array), 100 + $sum, "basic reduce works (2)");
  is(({ $^a * $^b }.reduce: 1,2,3,4,5), 120, "basic reduce works (3)");
}

# Reduce with n-ary functions
{
  my @array  = <1 2 3 4 5 6 7 8>;
  my $result = (((1 + 2 * 3) + 4 * 5) + 6 * 7) + 8 * undef;

  is @array.reduce: { $^a + $^b * $^c }, $result, "n-ary reduce() works";
}

# .reduce shouldn't work on non-arrays
{
#?pugs 2 todo 'bug'
  dies_ok { 42.reduce: { $^a + $^b } },    "method form of reduce should not work on numbers";
  dies_ok { "str".reduce: { $^a + $^b } }, "method form of reduce should not work on strings";
  is (42,).reduce: { $^a + $^b }, 42,      "method form of reduce should work on arrays";
}

{
  my $hash = {a => {b => {c => 42}}};
  my @reftypes;
  sub foo (Hash $hash, String $key) {
    push @reftypes, $hash.WHAT;
    $hash.{$key};
  }
  is((reduce(&foo, $hash, <a b c>)), 42, 'reduce(&foo) (foo ~~ .{}) works three levels deep');
  is(@reftypes[0], "Hash", "first application of reduced hash subscript passed in a Hash");
  is(@reftypes[1], "Hash", "second application of reduced hash subscript passed in a Hash");
  is(@reftypes[2], "Hash", "third application of reduced hash subscript passed in a Hash");
}
