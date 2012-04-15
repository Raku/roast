use v6;

use Test;

plan 12;

=begin description

This test tests the C<uniq> builtin.

Reference:
L<"http://groups.google.com/groups?selm=420DB295.3000902%40conway.org">

See the thread "[S32::Containers] uniq" on p6l, too.

Not (yet?) in the spec, but implemented by (nearly?) all implementations.

=end description

{
  my @array = <a b b c d e b b b b f b>;
  is ~@array, "a b b c d e b b b b f b",  "basic sanity";
  is ~@array.uniq,  "a b c d e f", "method form of uniq works";
  is ~uniq(@array), "a b c d e f", "subroutine form of uniq works";
  ok @array .= uniq,                 "inplace form of uniq works (1)";
  is      ~@array,  "a b c d e f", "inplace form of uniq works (2)";
}

is uniq('a', 'b', 'b', 'c', 'd', 'e', 'b', 'b', 'b', 'b', 'f', 'b'),
    'a b c d e f',
    'slurpy subroutine form of uniq works';

# With a userspecified criterion
#?rakudo skip "Not spec'd, and this seems unlikely to be how it will be spec'd"
#?pugs todo
{
  my @array = <a b A c b d>;
  # Semantics w/o junctions
  is ~@array.uniq({ lc($^a) eq lc($^b) }),  "a b c d", "method form of uniq with own comparator works";
  is ~uniq({ lc($^a) eq lc($^b) }, @array), "a b c d", "subroutine form of uniq with own comparator works";

  # Semantics w/ junctions
  # is eval('~@array.uniq({ lc $^a eq lc $^b }).values.sort'), "A b c d a b c d";
}

# Error cases
{
  #?pugs todo 'bug'
  #?rakudo todo "Not spec'd, and why shouldn't it work anyway?"
  dies_ok { 42.uniq }, ".uniq should not work on scalars";
  is (42,).uniq, 42,   ".uniq should work on one-elem arrays";
}

# http://irclog.perlgeek.de/perl6/2009-10-31#i_1669037
#?pugs todo
{
    my $range = [1..4];
    my @array = $range, $range.WHICH;
    is @array.elems, 2, ".uniq does not use naive WHICH (1)";
    is @array.uniq.elems, 2, ".uniq does not use naive WHICH (2)";
}

# vim: ft=perl6
