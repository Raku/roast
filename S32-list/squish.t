use v6;

use Test;

plan 62;

=begin description

This test tests the C<squish> builtin and .squish method on Any/List.

=end description

{
    my @array = <a b b c d e f f a>;
    is-deeply @array.squish,  <a b c d e f a>,
      "method form of squish works";
    is-deeply squish(@array), <a b c d e f a>,
      "subroutine form of squish works";
    is-deeply @array .= squish, [<a b c d e f a>],
      "inplace form of squish works";
    is-deeply @array, [<a b c d e f a>],
      "final result of in place";
} #4

{
    is squish(Any,'a', 'b', 'b', 'c', 'd', 'e', 'f', 'f', 'a'),
      (Any, <a b c d e f a>),
      'slurpy subroutine form of squish works';
} #1

{
    is 42.squish, 42,    ".squish can work on scalars";
    is (42,).squish, 42, ".squish can work on one-elem arrays";
} #2

{
    my class A { method Str { '' } };
    is (A.new, A.new).squish.elems, 2, 'squish has === semantics for objects';
} #1

{
    my @list = 1, "1";
    my @squish = squish(@list);
    is @squish, @list, "squish has === semantics for containers";
} #1

{
    my \a := squish( 1..Inf );
    ok a.is-lazy, 'squish knows itself to be lazy';
    is a[3], 4, '... can access elements from lazy iterator';
} #1

{
    my @array = <a b bb c d e f f a>;
    my $as    = *.substr: 0,1;
    is-deeply @array.squish(:$as),  <a b c d e f a>,
      "method form of squish with :as works";
    is-deeply squish(@array,:$as), <a b c d e f a>,
      "subroutine form of squish with :as works";
    is-deeply @array .= squish(:$as), [<a b c d e f a>],
      "inplace form of squish with :as works";
    is-deeply @array, [<a b c d e f a>],
      "final result with :as in place";
} #4

{
    my @rt124204 = ('', '', Any, Any);
    is-deeply @rt124204.squish(:as(-> $x {$x})), ('', Any),
      "method form of squish with :as does not needlessly stringify";
    is-deeply @rt124204.squish, ('', Any),
      "method form of squish without :as does not needlessly stringify";
    is-deeply @rt124204.squish(:as(-> $x {$x}), :with({$^b === $^a})), ('', Any),
      "method form of squish with :as and :with does not needlessly stringify";
    is-deeply @rt124204.squish(:with({$^b === $^a})), ('', Any),
      "method form of squish with :with does not needlessly stringify";
} #4

{
    my @rt124205 = <a a>;

    is @rt124205.squish(:as(-> $x {1}), :with(-> $a, $b {1})), <a>,
      "method form of squish with :as and :with always returns at least the first element";
    is @rt124205.squish(:with(-> $a, $b {1})), <a>,
      "method form of squish with :with always returns at least the first element";

    # somewhat more real-world examples:

    my @rt124205_b = '', '', |<b b B B>;

    is-deeply @rt124205_b.squish(:with(*.Str eq *.Str)), ('', 'b', 'B'),
      "method form of squish with :with preserves the first element even if it stringifies to ''";

    is-deeply @rt124205_b.squish(:as(*.Str), :with(&infix:<eq>)), ('', 'b', 'B'),
      "method form of squish with :as and :with preserves the first element even if it stringifies to ''";

} #4

{
    my @array = <a aa b bb c d e f f a>;
    my $with  = { substr($^a,0,1) eq substr($^b,0,1) }
    is-deeply @array.squish(:$with),  <a b c d e f a>,
      "method form of squish with :with works";
    is-deeply squish(@array,:$with), <a b c d e f a>,
      "subroutine form of squish with :with works";
    is-deeply @array .= squish(:$with), [<a b c d e f a>],
      "inplace form of squish with :with works";
    is-deeply @array, [<a b c d e f a>],
      "final result with :with in place";
} #4

{
    my @array = <a aa b bb c d e f f a>;
    my $as    = *.substr(0,1).ord;
    my $with  = &[==];
    is-deeply @array.squish(:$as, :$with),  <a b c d e f a>,
      "method form of squish with :as and :with works";
    is-deeply squish(@array,:$as, :$with), <a b c d e f a>,
      "subroutine form of squish with :as and :with works";
    is-deeply @array .= squish(:$as, :$with), [<a b c d e f a>],
      "inplace form of squish with :as and :with works";
    is-deeply @array, [<a b c d e f a>],
      "final result with :as and :with in place";
} #4


{
    my @a;
    my $as = { @a.push($_); $_ };
    my @w;
    my $with = { @w.push("$^a $^b"); $^a + 1 == $^b };
    is (1,2,3,2,1,0).squish(:$as,:$with), (1,2,1,0),
        'Order of :with operands, and first one of each run (:as)';
    is bag(@a), bag(1,2,3,2,1,0), ':as callbacks called once per element';
    is bag(@w), bag("1 2","2 3","3 2","2 1","1 0"),
        ':with callbacks called minimumish number of times (:as)';
    @w = ();
    is (1,2,3,2,1,0).squish(:$with), (1,2,1,0),
        'Order of :with operands, and first one of each run';
    is bag(@w), bag("1 2","2 3","3 2","2 1","1 0"),
        ':with callbacks called minimumish number of times.';
    @a = (); @w = ();
    is (1).squish(:$with, :$as), (1),
        'Single element list with :as and :with';
    ok so all((@a.elems,@w.elems) Z< 2, 1),
        'at most one :as and no :with callbacks with single element list';
    @a = (); @w = ();
    is (1).squish(:$with), (1),
        'Single element list with :with';
    is @w, [], "No callbacks with single element list";
    @w = ();
    my $i = (1,2,3,2,1,0).squish(:$as,:$with).iterator;
    is $i.pull-one, 1, '.pull-one with :with and :as';
    ok so all((@a.elems,@w.elems) Z< 2, 1),
        '.pull-one called at most one :as and no :with on first pull';
    is $i.pull-one, 2, 'second .pull-one with :with and :as';
    ok so all((@a.elems,@w.elems) Z== 4, 3),
        'second .pull-one called 4 :as and three :with';
    my @c;
    $i.push-all(@c);
    is @c, (1,0), 'push-all after a couple pull-ones works (:as)';
    is bag(@a), bag(1,2,3,2,1,0), ':as callbacks called once per element (fragged)';
    is bag(@w), bag("1 2","2 3","3 2","2 1","1 0"),
        ':with callbacks called minimumish number of times (:as, fragged)';
    @w = ();
    $i = (1,2,3,2,1,0).squish(:$with).iterator;
    is $i.pull-one, 1, '.pull-one with :with';
    nok @w.elems, 'no :with called on first pull';
    is $i.pull-one, 2, 'second .pull-one with :with';
    ok @w.elems == 3, 'second .pull-one called three :with';
    @c = ();
    $i.push-all(@c);
    is @c, (1,0), 'push-all after a couple pull-ones works';
    is bag(@w), bag("1 2","2 3","3 2","2 1","1 0"),
        ':with callbacks called minimumish number of times (:as, fragged)';
}

{
    my @array = ({:a<1>}, {:a<1>}, {:b<1>});
    my $with  = &[eqv];
    is-deeply @array.squish(:$with),  ({:a<1>}, {:b<1>}),
      "method form of squish with [eqv] and objects works";
    is-deeply squish(@array,:$with), ({:a<1>}, {:b<1>}),
      "subroutine form of squish with [eqv] and objects works";
    is-deeply @array .= squish(:$with), [{:a<1>}, {:b<1>}],
      "inplace form of squish with [eqv] and objects works";
    is-deeply @array, [{:a<1>}, {:b<1>}],
      "final result with [eqv] and objects in place";
} #4

# RT #121434
{
    my $a = <a b b c>;
    #?rakudo.jvm emit # hangs because squish gives back infinite list with Mu.new
    $a .= squish;
    #?rakudo.jvm todo 'fails due to above failure'
    is-deeply( $a, <a b c>, '.= squish in sink context works on $a' );
    my @a = <a b b c>;
    @a .= squish;
    is-deeply( @a, [<a b c>], '.= squish in sink context works on @a' );
} #2

my @a := (1, 2);
is ((3,3,1),@a,@a).squish.Str, '3 3 1 1 2', ".squish doesn't flatten";

# RT #126293
{
    is <a a b b c c>.squish, <a b c>, 'do we squish at all?';
    my $as = *.lc;
    is <a A b B c>.squish(:$as), <a b c>, 'do we squish at all with :as?';
}

# vim: ft=perl6
