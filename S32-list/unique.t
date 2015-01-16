use v6;

use Test;

plan 33;

=begin description

This test tests the C<unique> builtin.

=end description

{
    my @array = <a b b c d e b b b b f b>;
    is_deeply @array.unique,  <a b c d e f>.list.item,
      "method form of unique works";
    is_deeply unique(@array), <a b c d e f>.list.item,
      "subroutine form of unique works";
    is_deeply @array .= unique, [<a b c d e f>],
      "inplace form of unique works";
    is_deeply @array, [<a b c d e f>],
      "final result of in place";
} #4

{
    is_deeply unique('a', 'b', 'b', 'c', 'd', 'e', 'b', 'b', 'b', 'b', 'f', 'b'),
      <a b c d e f>.list.item,
      'slurpy subroutine form of unique works';
} #1

# With a userspecified criterion
#?niecza skip "with NYI"
{
    my @array = <a b d A c b>;
    # Semantics w/o junctions
    is ~@array.unique( with => { lc($^a) eq lc($^b) } ),  "a b d c",
      "method form of unique with own comparator works";
    is ~unique(@array, with => { lc($^a) eq lc($^b) }), "a b d c",
      "subroutine form of unique with own comparator works";
  
    # Semantics w/ junctions
    is EVAL('~@array.unique(with => { lc($^a) eq lc($^b) }).values.sort'), "a b c d", 'sorting the result';
} #3

{
    is 42.unique, 42,    ".unique can work on scalars";
    is (42,).unique, 42, ".unique can work on one-elem arrays";
} #2

# http://irclog.perlgeek.de/perl6/2009-10-31#i_1669037
{
    my $range = [1..4];
    my @array = $range, $range.WHICH;
    is @array.elems, 2,      ".unique does not use naive WHICH (1)";
    is @array.unique.elems, 2, ".unique does not use naive WHICH (2)";
} #2

# RT #111360
{
    my class A { method Str { '' } };
    is (A.new, A.new).unique.elems, 2, 'unique has === semantics';
} #1

# RT #83454
{
    my @list = 1, "1";
    my @unique = unique(@list);
    is @unique, @list, "unique has === semantics";
} #1

# RT #121434
{
    my $a = <a b c b d>;
    $a .= unique;
    is_deeply( $a, <a b c d>.list.item, '.= unique in sink context works on $a' );
    my @a = <a b c b d>;
    @a .= unique;
    is_deeply( @a, [<a b c d>], '.= unique in sink context works on @a' );
} #2

#?niecza skip 'NYI'
{
    my @array = <a b bb c d e b bbbb b b f b>;
    my $as    = *.substr: 0,1;
    is_deeply @array.unique(:$as),  <a b c d e f>.list.item,
      "method form of unique with :as works";
    is_deeply unique(@array,:$as), <a b c d e f>.list.item,
      "subroutine form of unique with :as works";
    is_deeply @array .= unique(:$as), [<a b c d e f>],
      "inplace form of unique with :as works";
    is_deeply @array, [<a b c d e f>],
      "final result with :as in place";
} #4

#?niecza skip 'NYI'
{
    my @array = <a b bb c d e b bbbb b b f b>;
    my $with  = { substr($^a,0,1) eq substr($^b,0,1) }
    is_deeply @array.unique(:$with),  <a b c d e f>.list.item,
      "method form of unique with :with works";
    is_deeply unique(@array,:$with), <a b c d e f>.list.item,
      "subroutine form of unique with :with works";
    is_deeply @array .= unique(:$with), [<a b c d e f>],
      "inplace form of unique with :with works";
    is_deeply @array, [<a b c d e f>],
      "final result with :with in place";
} #4

#?niecza skip 'NYI'
{
    my @array = <a b bb c d e b bbbb b b f b>;
    my $as    = *.substr(0,1).ord;
    my $with  = &[==];
    is_deeply @array.unique(:$as),  <a b c d e f>.list.item,
      "method form of unique with :as works";
    is_deeply unique(@array,:$as), <a b c d e f>.list.item,
      "subroutine form of unique with :as works";
    is_deeply @array .= unique(:$as), [<a b c d e f>],
      "inplace form of unique with :as works";
    is_deeply @array, [<a b c d e f>],
      "final result with :as in place";
} #4

#?niecza skip 'NYI'
{
    my @array = ({:a<1>}, {:b<1>}, {:a<1>});
    my $with  = &[eqv];
    is_deeply @array.unique(:$with),  ({:a<1>}, {:b<1>}).list.item,
      "method form of unique with [eqv] and objects works";
    is_deeply unique(@array,:$with), ({:a<1>}, {:b<1>}).list.item,
      "subroutine form of unique with [eqv] and objects works";
    is_deeply @array .= unique(:$with), [{:a<1>}, {:b<1>}],
      "inplace form of unique with [eqv] and objects works";
    is_deeply @array, [{:a<1>}, {:b<1>}],
      "final result with [eqv] and objects in place";
} #4

# RT #121434
{
    my %a;
    %a<foo> = <a b c>;
    %a<foo>.=unique;
    is_deeply %a<foo>, <a b c>.list.item,
      "\%a<foo> not clobbered by .=unique";
} # 1

# vim: ft=perl6
