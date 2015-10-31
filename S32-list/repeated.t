use v6;

use Test;

plan 34;

=begin description

This test tests the C<repeated> builtin.

=end description

{
    my @array = <a b b c d e b b e b b f b>;
    is-deeply @array.repeated.List, <b b b e b b b>,
      "method form of repeated works";
    is-deeply repeated(@array).List, <b b b e b b b>,
      "subroutine form of repeated works";
    is-deeply @array .= repeated, [<b b b e b b b>],
      "inplace form of repeated works";
    is-deeply @array, [<b b b e b b b>],
      "final result of in place";
} #4

{
    is-deeply repeated('a', 'b', 'b', 'c', 'd', 'e', 'b', 'b', 'e', 'b', 'b', 'f', 'b').List,
      <b b b e b b b>.list.item,
      'slurpy subroutine form of repeated works';
} #1

# With a userspecified criterion
#?niecza skip "NYI"
{
    my @array = <b a b d A c>;
    # Semantics w/o junctions
    is ~@array.repeated( with => { lc($^a) eq lc($^b) } ),  "b A",
      "method form of repeated with own comparator works";
    is ~repeated(@array, with => { lc($^a) eq lc($^b) }), "b A",
      "subroutine form of repeated with own comparator works";
  
    # Semantics w/ junctions
    is EVAL('~@array.repeated(with => { lc($^a) eq lc($^b) }).values.sort'), "A b", 'sorting the result';
} #3

{
    is 42.repeated, (),    ".repeated can work on scalars";
    is (42,).repeated, (), ".repeated can work on one-elem arrays";
} #2

{
    my $range = [1..4];
    my @array = $range, $range.WHICH;
    is @array.elems, 2,      ".repeated does not use naive WHICH (1)";
    is @array.repeated.elems, 0, ".repeated does not use naive WHICH (2)";
} #2

{
    my class A { method Str { '' } };
    is (A.new, A.new).repeated.elems, 0, 'repeated has === semantics';
} #1

{
    my @list = 1, "1";
    my @repeated = repeated(@list);
    is @repeated, (), "repeated has === semantics";
} #1

{
    my $a = <a b c b d c>;
    $a .= repeated;
    is-deeply( $a.List, <b c>, '.= repeated in sink context works on $a' );
    my @a = <a b c b d c>;
    @a .= repeated;
    is-deeply( @a, [<b c>], '.= repeated in sink context works on @a' );
} #2

#?niecza skip 'NYI'
{
    my @array = <a b bb c d ee b bbbb e b b f b>;
    my $as    = *.substr: 0,1;
    is-deeply @array.repeated(:$as).List,  <bb b bbbb e b b b>,
      "method form of repeated with :as works";
    is-deeply repeated(@array,:$as).List, <bb b bbbb e b b b>,
      "subroutine form of repeated with :as works";
    is-deeply @array .= repeated(:$as), [<bb b bbbb e b b b>],
      "inplace form of repeated with :as works";
    is-deeply @array, [<bb b bbbb e b b b>],
      "final result with :as in place";
} #4

#?niecza skip 'NYI'
{
    my @array = <a b bb c d e b bbbb e b b f b>;
    my $with  = { substr($^a,0,1) eq substr($^b,0,1) }
    is-deeply @array.repeated(:$with).List,  <bb b bbbb e b b b>,
      "method form of repeated with :with works";
    is-deeply repeated(@array,:$with).List, <bb b bbbb e b b b>,
      "subroutine form of repeated with :with works";
    is-deeply @array .= repeated(:$with), [<bb b bbbb e b b b>],
      "inplace form of repeated with :with works";
    is-deeply @array, [<bb b bbbb e b b b>],
      "final result with :with in place";
} #4

#?niecza skip 'NYI'
{
    my @array = <a b bb c d e b bbbb e b b f b>;
    my $as    = *.substr(0,1).ord;
    my $with  = &[==];
    is-deeply @array.repeated(:$as).List,  <bb b bbbb e b b b>,
      "method form of repeated with :as works";
    is-deeply repeated(@array,:$as).List, <bb b bbbb e b b b>,
      "subroutine form of repeated with :as works";
    is-deeply @array .= repeated(:$as), [<bb b bbbb e b b b>],
      "inplace form of repeated with :as works";
    is-deeply @array, [<bb b bbbb e b b b>],
      "final result with :as in place";
} #4

#?niecza skip 'NYI'
{
    my @array = ({:a<1>}, {:b<1>}, {:a<1>});
    my $with  = &[eqv];
    is-deeply @array.repeated(:$with).List,  ({:a<1>},),
      "method form of repeated with [eqv] and objects works";
    is-deeply repeated(@array,:$with).List, ({:a<1>},),
      "subroutine form of repeated with [eqv] and objects works";
    is-deeply @array .= repeated(:$with), [{:a<1>},],
      "inplace form of repeated with [eqv] and objects works";
    is-deeply @array, [{:a<1>},],
      "final result with [eqv] and objects in place";
} #4

{
    my %a;
    %a<foo> = <a b c b c>;
    %a<foo>.=repeated;
    is-deeply %a<foo>.List, <b c>,
      "\%a<foo> not clobbered by .=repeated";
} # 1

is ((1,2,3),(1,3),(1,3)).repeated(:with({$^a eqv $^b})), "1 3", ".repeated doesn't flatten";

=finish

# vim: ft=perl6
