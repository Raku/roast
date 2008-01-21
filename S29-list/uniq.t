use v6-alpha;

use Test;

plan 9;

=head1 DESCRIPTION

This test tests the C<uniq> builtin.

Reference:
L<"http://groups.google.com/groups?selm=420DB295.3000902%40conway.org">

See the thread "[S29] uniq" on p6l, too.

=cut

{
  my @array = <a b b c d e b b b b f b>;
  is ~@array, "a b b c d e b b b b f b",  "basic sanity";
  is ~@array.uniq,  "a b c d e f", "method form of uniq works";
  is ~uniq(@array), "a b c d e f", "subroutine form of uniq works";
  ok @array .= uniq,                 "inplace form of uniq works (1)";
  is      ~@array,  "a b c d e f", "inplace form of uniq works (2)";
}

# With a userspecified criterion
{
  my @array = <a b A c b d>;
  # Semantics w/o junctions
  is ~@array.uniq:{ lc $^a eq lc $^b },  "a b c d", "method form of uniq with own comparator works";
  is ~uniq({ lc $^a eq lc $^b }, @array), "a b c d", "subroutine form of uniq with own comparator works";

  # Semantics w/ junctions
  # is eval('~@array.uniq:{ lc $^a eq lc $^b }.values.sort'),
  #   "A b c d a b c d", :todo;
}

# Error cases
{
  dies_ok { 42.uniq }, ".uniq should not work on scalars", :todo<bug>;
  is (42,).uniq, 42,   ".uniq should work on one-elem arrays";
}
