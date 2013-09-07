use v6;

use Test;

plan 30;

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
#?niecza skip "with NYI"
#?pugs skip "Named argument found where no matched parameter expected"
{
    my @array = <a b d A c b>;
    # Semantics w/o junctions
    is ~@array.uniq( with => { lc($^a) eq lc($^b) } ),  "a b d c",
      "method form of uniq with own comparator works";
    is ~uniq(@array, with => { lc($^a) eq lc($^b) }), "a b d c",
      "subroutine form of uniq with own comparator works";
  
    # Semantics w/ junctions
    is eval('~@array.uniq(with => { lc($^a) eq lc($^b) }).values.sort'), "a b c d", 'sorting the result';
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

#?pugs   skip 'NYI'
#?niecza skip 'NYI'
{
    my @array = <a b bb c d e b bbbb b b f b>;
    my $as    = *.substr: 0,1;
    is_deeply @array.uniq(:$as),  <a b c d e f>.list.item,
      "method form of uniq with :as works";
    is_deeply uniq(@array,:$as), <a b c d e f>.list.item,
      "subroutine form of uniq with :as works";
    is_deeply @array .= uniq(:$as), [<a b c d e f>],
      "inplace form of uniq with :as works";
    is_deeply @array, [<a b c d e f>],
      "final result with :as in place";
} #4

#?pugs   skip 'NYI'
#?niecza skip 'NYI'
{
    my @array = <a b bb c d e b bbbb b b f b>;
    my $with  = { substr($^a,0,1) eq substr($^b,0,1) }
    is_deeply @array.uniq(:$with),  <a b c d e f>.list.item,
      "method form of uniq with :with works";
    is_deeply uniq(@array,:$with), <a b c d e f>.list.item,
      "subroutine form of uniq with :with works";
    is_deeply @array .= uniq(:$with), [<a b c d e f>],
      "inplace form of uniq with :with works";
    is_deeply @array, [<a b c d e f>],
      "final result with :with in place";
} #4

#?pugs   skip 'NYI'
#?niecza skip 'NYI'
{
    my @array = <a b bb c d e b bbbb b b f b>;
    my $as    = *.substr(0,1).ord;
    my $with  = &[==];
    is_deeply @array.uniq(:$as),  <a b c d e f>.list.item,
      "method form of uniq with :as works";
    is_deeply uniq(@array,:$as), <a b c d e f>.list.item,
      "subroutine form of uniq with :as works";
    is_deeply @array .= uniq(:$as), [<a b c d e f>],
      "inplace form of uniq with :as works";
    is_deeply @array, [<a b c d e f>],
      "final result with :as in place";
} #4

#?pugs   skip 'NYI'
#?niecza skip 'NYI'
{
    my @array = ({:a<1>}, {:b<1>}, {:a<1>});
    my $with  = &[eqv];
    is_deeply @array.uniq(:$with),  ({:a<1>}, {:b<1>}).list.item,
      "method form of uniq with [eqv] and objects works";
    is_deeply uniq(@array,:$with), ({:a<1>}, {:b<1>}).list.item,
      "subroutine form of uniq with [eqv] and objects works";
    is_deeply @array .= uniq(:$with), [{:a<1>}, {:b<1>}],
      "inplace form of uniq with [eqv] and objects works";
    is_deeply @array, [{:a<1>}, {:b<1>}],
      "final result with [eqv] and objects in place";
} #4

# vim: ft=perl6
