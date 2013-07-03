use v6;

use Test;

plan 14;

=begin description

This test tests the C<uniq> builtin.

See the thread "[S32::Containers] uniq" on p6l, too.

=end description

{
    my @array = <a b b c d e b b b b f b>;
    is_deeply @array.uniq,  <a b c d e f>.list.item,
      "method form of uniq works";
    is_deeply uniq(@array), <a b c d e f>.list.item,
      "subroutine form of uniq works";
    is_deeply @array .= uniq, [<a b c d e f>],
      "inplace form of uniq works";
    is_deeply @array, [<a b c d e f>],
      "final result of in place";
} #4

{
    is_deeply uniq('a', 'b', 'b', 'c', 'd', 'e', 'b', 'b', 'b', 'b', 'f', 'b'),
      <a b c d e f>.list.item,
      'slurpy subroutine form of uniq works';
} #1

# With a userspecified criterion
#?rakudo skip "Not spec'd, and this seems unlikely to be how it will be spec'd"
#?pugs todo
{
    my @array = <a b A c b d>;
    # Semantics w/o junctions
    is ~@array.uniq({ lc($^a) eq lc($^b) }),  "a b c d",
      "method form of uniq with own comparator works";
    is ~uniq({ lc($^a) eq lc($^b) }, @array), "a b c d",
      "subroutine form of uniq with own comparator works";
  
    # Semantics w/ junctions
    is eval('~@array.uniq({ lc $^a eq lc $^b }).values.sort'), "A b c d a b c d";
} #3

#?pugs todo 'bug'
{
    is 42.uniq, 42,    ".uniq can work on scalars";
    is (42,).uniq, 42, ".uniq can work on one-elem arrays";
} #2

# http://irclog.perlgeek.de/perl6/2009-10-31#i_1669037
#?pugs todo
{
    my $range = [1..4];
    my @array = $range, $range.WHICH;
    is @array.elems, 2,      ".uniq does not use naive WHICH (1)";
    is @array.uniq.elems, 2, ".uniq does not use naive WHICH (2)";
} #2

# RT #111360
{
    my class A { method Str { '' } };
    is (A.new, A.new).uniq.elems, 2, 'uniq has === semantics';
} #1

# RT #83454
{
    my @list = 1, "1";
    my @uniq = uniq(@list);
    is @uniq, @list, "uniq has === semantics";
} #1

# vim: ft=perl6
