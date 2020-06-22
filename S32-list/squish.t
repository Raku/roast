use v6;

use Test;

plan 31;

=begin description

This test tests the C<squish> builtin and .squish method on Any/List.

=end description

{
    my @array = <a b b c d e f f a>;
    is-deeply @array.squish,     <a b c d e f a>.Seq, 'method form';
    is-deeply squish(@array),    <a b c d e f a>.Seq, 'subroutine form';
    is-deeply @array .= squish, [<a b c d e f a>], 'meta-assign form (return)';
    is-deeply @array,           [<a b c d e f a>], 'meta-assign form (result)';
}

is-deeply squish(Any, 'a', 'b', 'b', 'c', 'd', 'e', 'f', 'f', 'a'),
    (Any, |<a b c d e f a>).Seq, 'slurpy subroutine form of squish';

is-deeply  42  .squish, (42,).Seq, '.squish with Int';
is-deeply (42,).squish, (42,).Seq, '.squish with one-elem list';

{
    my class A { }
    my @dif := A.new, 1, <1>, <1>, "1", $_, $_ with A.new;
    is-deeply @dif.squish, @dif[0,1,2,4,5].Seq, 'squish has === semantics';
}

{
    my \a := squish 1..Inf;
    is-deeply a.is-lazy, True, 'squish propagates is-lazy';
    is-deeply a[3], 4, 'can access elements from infinite squish';
}

subtest 'with :as' => {
    plan 4;

    my @a  = <a b bb c d e f f a>;
    my $as = *.substr: 0, 1;
    is-deeply @a.squish(:$as),    <a b c d e f a>.Seq, '    method form';
    is-deeply squish(@a,:$as),    <a b c d e f a>.Seq, 'subroutine form';
    is-deeply @a .=squish(:$as), [<a b c d e f a>], 'meta-assign form (return)';
    is-deeply @a,                [<a b c d e f a>], 'meta-assign form (result)';
}

# https://github.com/Raku/old-issue-tracker/issues/3761
subtest 'method form of squish does not stringify' => {
    plan 4;
    my @a = '', '', Any, Any;
    my $with := {$^b === $^a};
    is-deeply @a.squish,                  ('', Any).Seq, 'no args';
    is-deeply @a.squish(:as{$_}),         ('', Any).Seq, 'with :as';
    is-deeply @a.squish(:$with),          ('', Any).Seq, 'with :with';
    is-deeply @a.squish(:as{$_}, :$with), ('', Any).Seq, 'with :as and :with';
}

subtest 'method form of squish returns at least the first element' => {
    plan 4;
    my @rt124205 = <a a>;
    is-deeply @rt124205.squish(:as{1}, :with(-> $a, $b {1})), <a>.Seq,
        'with :as and :with';
    is-deeply @rt124205.squish(:with(-> $a, $b {1})), <a>.Seq,
        'with :with only';

    # somewhat more real-world examples:
    my @rt124205_b = '', '', |<b b B B>;
    is-deeply @rt124205_b.squish(:with(*.Str eq *.Str)), ('', 'b', 'B').Seq,
        "with :with, first element stringifies to ''";

    is-deeply @rt124205_b.squish(:as(*.Str), :with(&infix:<eq>)),
        ('', 'b', 'B').Seq,
        "with :with and :as, first element stringifies to ''";
}

subtest 'with :with' => {
    plan 4;
    my @array = <a aa b bb c d e f f a>;
    my $with  = { substr($^a,0,1) eq substr($^b,0,1) }
    is-deeply @array.squish(:$with),     <a b c d e f a>.Seq, 'method form';
    is-deeply squish(@array,:$with),     <a b c d e f a>.Seq, 'subroutine form';
    is-deeply @array .= squish(:$with), [<a b c d e f a>],
        'meta-assign form (return)';
    is-deeply @array, [<a b c d e f a>], 'meta-assign form (result)';
}

subtest 'with :with and :as' => {
    plan 4;
    my @array = <a aa b bb c d e f f a>;
    my $as    = *.substr(0,1).ord;
    my $with  = &[==];
    is-deeply @array.squish(:$as, :$with), <a b c d e f a>.Seq, 'method form';
    is-deeply squish(@array,:$as, :$with), <a b c d e f a>.Seq, 'sub form';
    is-deeply @array .= squish(:$as, :$with), [<a b c d e f a>],
        'meta-assign form (return)';
    is-deeply @array, [<a b c d e f a>], 'meta-assign form (result)';
}


{
    my @as;
    my $as = { @as.push: $_; $_ };
    my @with;
    my $with = { @with.push: "$^a $^b"; $^a + 1 == $^b };
    is-deeply (1,2,3,2,1,0).squish(:$as,:$with), (1,2,1,0).Seq,
        'order of :with operands, and first one of each run (:as)';
    is-deeply bag(@as),   bag(1,2,3,2,1,0), ':as callbacks called once per element';
    is-deeply bag(@with), bag("1 2","2 3","3 2","2 1","1 0"),
        ':with callbacks called minimum-ish number of times (:as)';

    @with = ();
    is-deeply (1,2,3,2,1,0).squish(:$with), (1,2,1,0).Seq,
        'order of :with operands, and first one of each run';
    is-deeply bag(@with), bag("1 2","2 3","3 2","2 1","1 0"),
        ':with callbacks called minimum-ish number of times.';

    subtest 'squish with single element list with :as and :with' => {
        plan 3;
        @as = (); @with = ();
        is-deeply (1).squish(:$with, :$as), 1.Seq, 'result';
        cmp-ok @as,   '<=', 1, 'at most one :as callback call';
        cmp-ok @with, '==', 0, 'no :with callback calls';
    }

    @as = (); @with = ();
    is-deeply (1).squish(:$with), 1.Seq, 'single element list with :with';
    cmp-ok @with, '==', 0, 'no callback calls with single element list';

    subtest ':as + :with, iterator use' => {
        plan 5;
        my $i := (1,2,3,2,1,0).squish(:$as, :$with).iterator;

        subtest 'first .pull-one' => {
            plan 3;
            @with = (); @as = ();
            is-deeply $i.pull-one, 1, 'value';
            cmp-ok @as,   '<=', 1, 'at most 1 :as callback call';
            cmp-ok @with, '==', 0, 'no :with callback calls';
        }

        subtest 'second .pull-one' => {
            plan 3;
            is-deeply $i.pull-one, 2, 'value';
            cmp-ok @as,   '==', 4, '4 total :as callback calls so far';
            cmp-ok @with, '==', 3, '3 total :with callback calls so far';
        }

        $i.push-all: my @c;
        is-deeply @c, [1, 0], '.push-all values';

        is-deeply bag(@as), bag(1,2,3,2,1,0),
            ':as callbacks called once per element (fragged)';
        is-deeply bag(@with), bag("1 2","2 3","3 2","2 1","1 0"),
            ':with callbacks called minimumish number of times (:as, fragged)';
    }

    subtest ':with + iterator use' => {
        plan 6;
        @with = ();
        my $i := (1,2,3,2,1,0).squish(:$with).iterator;
        is-deeply $i.pull-one, 1, 'first .pull-one value';
        cmp-ok @with, '==', 0, 'no :with called on first pull';

        is-deeply $i.pull-one, 2, 'second .pull-one value';
        cmp-ok @with, '==', 3, 'second .pull-one called three :with';

        $i.push-all: my @c;
        is-deeply @c, [1,0], '.push-all after a couple pull-ones';
        is-deeply bag(@with), bag("1 2","2 3","3 2","2 1","1 0"),
            ':with callbacks called minimum-ish number of times (:as, fragged)';
    }
}

subtest 'squish with [eqv] and objects' => {
    plan 4;
    my @array = ({:a<1>}, {:a<1>}, {:b<1>});
    my $with  = &[eqv];
    is-deeply @array.squish(:$with),    ({:a<1>}, {:b<1>}).Seq, 'method form';
    is-deeply squish(@array,:$with),    ({:a<1>}, {:b<1>}).Seq, 'sub form';
    is-deeply @array .= squish(:$with), [{:a<1>}, {:b<1>}],
        'meta-assign form (return)';
    is-deeply @array, [{:a<1>}, {:b<1>}], 'meta-assign form (result)';
}

# https://github.com/Raku/old-issue-tracker/issues/3357
{
    my $a = <a b b c>; $a .= squish;
    is-deeply $a, <a b c>.Seq, '.= squish in sink context works on $foo';
    my @a = <a b b c>;
    @a .= squish;
    is-deeply @a, [<a b c>], '.= squish in sink context works on @foo';
}

{
    my @a := (1, 2);
    is-deeply ((3,3,1), @a, @a).squish, ((3, 3, 1), (1, 2)).Seq,
        ".squish doesn't flatten";
}

# https://github.com/Raku/old-issue-tracker/issues/4630
{
    is-deeply <a a b b c c>.squish, <a b c>.Seq, 'do we squish at all?';
    is-deeply <a A b B c>.squish(:as{.lc}), <a b c>.Seq,
        'do we squish at all with :as?';
}

# vim: expandtab shiftwidth=4
