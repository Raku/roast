use v6;

use Test;

plan 38;

=begin description

This test tests the C<squish> builtin and .squish method on Any/List.

=end description

#?niecza skip 'NYI'
{
    my @array = <a b b c d e f f a>;
    is-deeply @array.squish.list,  <a b c d e f a>,
      "method form of squish works";
    is-deeply squish(@array).list, <a b c d e f a>,
      "subroutine form of squish works";
    is-deeply @array .= squish, [<a b c d e f a>],
      "inplace form of squish works";
    is-deeply @array, [<a b c d e f a>],
      "final result of in place";
} #4

{
    is-deeply squish(Any,'a', 'b', 'b', 'c', 'd', 'e', 'f', 'f', 'a').list,
      (flat Any, <a b c d e f a>),
      'slurpy subroutine form of squish works';
} #1

#?niecza skip 'NYI'
{
    is 42.squish, 42,    ".squish can work on scalars";
    is (42,).squish, 42, ".squish can work on one-elem arrays";
} #2

#?niecza skip 'NYI'
{
    my class A { method Str { '' } };
    is (A.new, A.new).squish.elems, 2, 'squish has === semantics for objects';
} #1

#?niecza skip 'NYI'
{
    my @list = 1, "1";
    my @squish = squish(@list);
    is @squish, @list, "squish has === semantics for containers";
} #1

#?niecza skip 'NYI'
{
    my \a := squish( 1..Inf );
    ok a.is-lazy, 'squish knows itself to be lazy';
    is a[3], 4, '... can access elements from lazy iterator';
} #1

#?niecza skip 'NYI'
{
    my @array = <a b bb c d e f f a>;
    my $as    = *.substr: 0,1;
    is-deeply @array.squish(:$as).list,  <a b c d e f a>,
      "method form of squish with :as works";
    is-deeply squish(@array,:$as).list, <a b c d e f a>,
      "subroutine form of squish with :as works";
    is-deeply @array .= squish(:$as), [<a b c d e f a>],
      "inplace form of squish with :as works";
    is-deeply @array, [<a b c d e f a>],
      "final result with :as in place";
} #4

#?niecza skip 'NYI'
{
    my @rt124204 = ('', '', Any, Any);
    is-deeply @rt124204.squish(:as(-> $x {$x})).list, ('', Any),
      "method form of squish with :as does not needlessly stringify";
    is-deeply @rt124204.squish.list, ('', Any),
      "method form of squish without :as does not needlessly stringify";
    is-deeply @rt124204.squish(:as(-> $x {$x}), :with({$^b === $^a})).list, ('', Any),
      "method form of squish with :as and :with does not needlessly stringify";
    is-deeply @rt124204.squish(:with({$^b === $^a})).list, ('', Any),
      "method form of squish with :with does not needlessly stringify";
} #4

#?niecza skip 'NYI'
#?rakudo todo 'RT #124205'
{
    my @rt124205 = <a a>;

    is-deeply @rt124205.squish(:as(-> $x {1}), :with(-> $a, $b {1})).list, <a>.list,
      "method form of squish with :as and :with always returns at least the first element";
    is-deeply @rt124205.squish(:with(-> $a, $b {1})).list, <a>.list,
      "method form of squish with :with always returns at least the first element";

    # somewhat more real-world examples:

    my @rt124205_b = '', '', <b b B B>;

    is-deeply @rt124205_b.squish(:with(*.Str eq *.Str)).list, ('', 'b', 'B'),
      "method form of squish with :with preserves the first element even if it stringifies to ''";

    is-deeply @rt124205_b.squish(:as(*.Str), :with(&infix:<eq>)).list, ('', 'b', 'B'),
      "method form of squish with :as and :with preserves the first element even if it stringifies to ''";

} #4

#?niecza skip 'NYI'
{
    my @array = <a aa b bb c d e f f a>;
    my $with  = { substr($^a,0,1) eq substr($^b,0,1) }
    is-deeply @array.squish(:$with).list,  <a b c d e f a>,
      "method form of squish with :with works";
    is-deeply squish(@array,:$with).list, <a b c d e f a>,
      "subroutine form of squish with :with works";
    is-deeply @array .= squish(:$with), [<a b c d e f a>],
      "inplace form of squish with :with works";
    is-deeply @array, [<a b c d e f a>],
      "final result with :with in place";
} #4

#?niecza skip 'NYI'
{
    my @array = <a aa b bb c d e f f a>;
    my $as    = *.substr(0,1).ord;
    my $with  = &[==];
    is-deeply @array.squish(:$as, :$with).list,  <a b c d e f a>,
      "method form of squish with :as and :with works";
    is-deeply squish(@array,:$as, :$with).list, <a b c d e f a>,
      "subroutine form of squish with :as and :with works";
    is-deeply @array .= squish(:$as, :$with), [<a b c d e f a>],
      "inplace form of squish with :as and :with works";
    is-deeply @array, [<a b c d e f a>],
      "final result with :as and :with in place";
} #4

#?niecza skip 'NYI'
{
    my @array = ({:a<1>}, {:a<1>}, {:b<1>});
    my $with  = &[eqv];
    is-deeply @array.squish(:$with).list,  ({:a<1>}, {:b<1>}),
      "method form of squish with [eqv] and objects works";
    is-deeply squish(@array,:$with).list, ({:a<1>}, {:b<1>}),
      "subroutine form of squish with [eqv] and objects works";
    is-deeply @array .= squish(:$with), [{:a<1>}, {:b<1>}],
      "inplace form of squish with [eqv] and objects works";
    is-deeply @array, [{:a<1>}, {:b<1>}],
      "final result with [eqv] and objects in place";
} #4

# RT #121434
{
    my $a = <a b b c>;
    $a .= squish;
    is-deeply( $a.list, <a b c>, '.= squish in sink context works on $a' );
    my @a = <a b b c>;
    @a .= squish;
    is-deeply( @a, [<a b c>], '.= squish in sink context works on @a' );
} #2

my @a := (1, 2);
is ((3,3,1),@a,@a).squish.list.Str, '3 3 1 1 2', ".squish doesn't flatten";
# vim: ft=perl6
