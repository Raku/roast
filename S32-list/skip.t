# By default, Test exports a "skip" sub, which interferes with the "skip"
# functionality we want to test here.  Hence the selective import here.
BEGIN my (&plan, &subtest, &is, &is-deeply, &throws-like) = do {
    use Test;
    (&plan, &subtest, &is, &is-deeply, &throws-like)
}

plan 55;

=begin description

This test tests the C<skip> builtin.

=end description

{
    my $list = <a b b c d e b b e b b f b>;
    is-deeply $list.skip, <b b c d e b b e b b f b>, 'List.skip works';

    my @array = <a b b c d e b b e b b f b>;
    is-deeply @array.skip, <b b c d e b b e b b f b>, 'Array.skip works';

    my $scalar = 42;
    is-deeply $scalar.skip, (), 'Scalar.skip works';

    my $range = ^10;
    is-deeply $range.skip, (1,2,3,4,5,6,7,8,9), 'Range.skip works';

    my $inf = ^Inf;
    is-deeply $inf.skip[0], 1, 'Range.skip works on lazy list';
}


{
    my $list = <a b b c d e b b e b b f b>;
    is-deeply $list.skip(5),   <e b b e b b f b>, 'List.skip(5) works';
    is-deeply skip(5,$list),                  (), 'skip(5,$List) works';
    is-deeply skip(5,$list<>), <e b b e b b f b>, 'skip(5,List) works';

    my @array = <a b b c d e b b e b b f b>;
    is-deeply @array.skip(5), <e b b e b b f b>, 'Array.skip(5) works';
    is-deeply skip(5,@array), <e b b e b b f b>, 'skip(5,Array) works';

    my $scalar = 42;
    is-deeply $scalar.skip(5), (), 'Scalar.skip(5) works';
    is-deeply skip(5,$scalar), (), 'skip(5,Scalar) works';

    my $range = ^10;
    is-deeply $range.skip(5),   (5,6,7,8,9), 'Range.skip(5) works';
    is-deeply skip(5,$range),            (), 'skip(5,$Range) works';
    is-deeply skip(5,$range<>), (5,6,7,8,9), 'skip(5,Range) works';

    my $inf = ^Inf;
    is-deeply $inf.skip(5)[0],   5, 'Range.skip(5) works on lazy list';
    is-deeply skip(5,$inf)[0], Nil, 'skip(5,$Range) works on lazy list';
    is-deeply skip(5,$inf<>)[0], 5, 'skip(5,$Range) works on lazy list';
}

{
    for 0, -1 {
        my $list = <a b b c d e b b e>;
        is-deeply $list.skip($_),   <a b b c d e b b e>, "List.skip($_) works";
        is-deeply skip($_,$list),              ($list,),"skip($_,\$List) works";
        is-deeply skip($_,$list<>), <a b b c d e b b e>, "skip($_,List) works";

        my @array = <a b b c d e b b e>;
        is-deeply @array.skip($_), <a b b c d e b b e>, "Array.skip($_) works";
        is-deeply skip($_,@array), <a b b c d e b b e>, "skip($_,Array) works";

        my $scalar = 42;
        is-deeply $scalar.skip($_), (42,), "Scalar.skip($_) works";
        is-deeply skip($_,$scalar), (42,), "skip($_,Scalar) works";

        my $range = ^10;
        is-deeply $range.skip($_),   (0,1,2,3,4,5,6,7,8,9), "Range.skip($_) works";
        is-deeply skip($_,$range),               ($range,), "skip($_,\$Range) works";
        is-deeply skip($_,$range<>), (0,1,2,3,4,5,6,7,8,9), "skip($_,Range) works";
    }
}

{
    my $list = <a b c>;
    is-deeply $list.skip(5),   (),  'List.skip works if too short';
    is-deeply skip(5,$list),   (),  'skip(N,$List) works if too short';
    is-deeply skip(5,$list<>), (),  'skip(N,List) works if too short';

    my @array = <a b c>;
    is-deeply @array.skip(5), (), 'Array.skip(N) works if too short';
    is-deeply skip(5,@array), (), 'skip(N,Array) works if too short';

    my $range = ^3;
    is-deeply $range.skip(5), (), 'Range.skip works if too short';
}

{
    my $list = ();
    is-deeply $list.skip(5),   (), 'List.skip(N) works if empty';
    is-deeply skip(5,$list),   (), 'skip(N,$List) works if empty';
    is-deeply skip(5,$list<>), (), 'skip(N,List) works if empty';

    my @array;
    is-deeply @array.skip(5), (), 'Array.skip(N) works if empty';
    is-deeply skip(5,@array), (), 'skip(N,Array) works if empty';

    my $range = ^0;
    is-deeply $range.skip(5),   (), 'Range.skip(N) works if empty';
    is-deeply skip(5,$range),   (), 'skip(N,$Range) works if empty';
    is-deeply skip(5,$range<>), (), 'skip(N,Range) works if empty';
}

# https://github.com/Raku/old-issue-tracker/issues/6529
subtest '.skip-all and .push-all on slipping slippy iterators' => {
    # Some implementations implemented specific iterators to be used
    # in certain cases, such as a .map() that returns a Slip. It was found
    # under certain conditions such iterators may contain a bug and miss
    # some elements. This subtest covers the discovered flaws.
    # The iterator names mentioned in test descriptions merely reflect
    # the names used in the implementation where the flaws were discovered
    # and not anything all implementations must name their iterators as.

    plan +my @tests =
        IterateOneWithoutPhasers => |*,
        IterateOneWithPhasers    => {NEXT $++; |$_},
        IterateTwoWithoutPhasers => -> $a, $b {|(|$a, |$b)},
        IterateMoreWithPhasers   => -> $a, $b {NEXT $++; |(|$a, |$b)};

    my class TimesIterator does Iterator {
        has $!times;
        method !SET-SELF (\times) { $!times := times; self }
        method new       (\times) { self.bless!SET-SELF: times }
        method pull-one {
            $_ < 3 and .return given $!times++;
            IterationEnd
        }
    };

    for @tests -> (:key($name), :value(&block)) {
        subtest $name => {
            plan 2;

            my $times = 0;
            .sink given (Seq.new(TimesIterator.new: $times), <a b c>)
                .map(&block).skip;
            is $times, 4, 'sink-all sinks all the values';

            given (<a b c>, <d e>).map(&block).skip {
                .elems; # reifies
                is .join, 'bcde', 'push-all pushes all the values';
            }
        }
    }
}

# https://github.com/Raku/old-issue-tracker/issues/6558
subtest 'Seq.skip does not leave original Seq consumable' => {
    plan 4;

    subtest 'uncached, .skip()' => {
        plan 2;
        my $s := (1..3).Seq;
        my $skipped := $s.skip;

        throws-like { @$s }, X::Seq::Consumed, 'original got consumed';
        is-deeply @$skipped, (2, 3), 'skipped has right content';
    }

    subtest 'uncached, .skip(n)' => {
        plan 2;
        my $s := (1..3).Seq;
        my $skipped := $s.skip: 2;

        throws-like { @$s }, X::Seq::Consumed, 'original got consumed';
        is-deeply @$skipped, (3,), 'skipped has right content';
    }

    subtest 'cached, .skip()' => {
        plan 2;
        my $s := (1..3).Seq;
        $s.cache;
        my $skipped := $s.skip;

        is-deeply @$s,       (1, 2, 3), 'original gives all values';
        is-deeply @$skipped, (2, 3),    'skipped has right content';
    }

    subtest 'cached, .skip(n)' => {
        plan 2;
        my $s := (1..3).Seq;
        $s.cache;
        my $skipped := $s.skip: 2;

        is-deeply @$s,       (1, 2, 3), 'original gives all values';
        is-deeply @$skipped, (3,),      'skipped has right content';
    }
}

# https://github.com/rakudo/rakudo/issues/1384
subtest 'Any:U.skip works with Callable' => {
    plan 3;
    is-deeply Any.skip(*-0),         ().Seq, '*-1';
    is-deeply Any.skip(*-1),     (Any,).Seq, '*-1';
    is-deeply Any.skip(*-99999), (Any,).Seq, '*-99999';
}

# vim: expandtab shiftwidth=4
