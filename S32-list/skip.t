use v6;

use Test;

plan 25;

=begin description

This test tests the C<skip> builtin.

=end description

{
    my $list = <a b b c d e b b e b b f b>;
    is $list.skip.List, <b b c d e b b e b b f b>,  "List.skip works";
    my @array = <a b b c d e b b e b b f b>;
    is @array.skip.List, <b b c d e b b e b b f b>, "Array.skip works";
    my $scalar = 42;
    is $scalar.skip.List, (),                       "Scalar.skip works";
    my $range = ^10;
    is $range.skip.List, (1,2,3,4,5,6,7,8,9),       "Range.skip works";
    my $inf = ^Inf;
    is $inf.skip[0], 1,                "Range.skip works on lazy list";
} #5


{
    my $list = <a b b c d e b b e b b f b>;
    is $list.skip(5).List, <e b b e b b f b>,       "List.skip(5) works";
    my @array = <a b b c d e b b e b b f b>;
    is @array.skip(5).List, <e b b e b b f b>,      "Array.skip(5) works";
    my $scalar = 42;
    is $scalar.skip(5).List, (),                    "Scalar.skip(5) works";
    my $range = ^10;
    is $range.skip(5).List, (5,6,7,8,9),            "Range.skip(5) works";
    my $inf = ^Inf;
    is $inf.skip(5)[0], 5,             "Range.skip(5) works on lazy list";
} #5

{
    for 0, -1 {
        my $list = <a b b c d e b b e>;
        is $list.skip($_).List, <a b b c d e b b e>,    "List.skip($_) works";
        my @array = <a b b c d e b b e>;
        is @array.skip($_).List, <a b b c d e b b e>,   "Array.skip($_) works";
        my $scalar = 42;
        is $scalar.skip($_).List, (42,),                "Scalar.skip($_) works";
        my $range = ^10;
        is $range.skip($_).List, (0,1,2,3,4,5,6,7,8,9), "Range.skip($_) works";
    }
} #8

{
    my $list = <a b c>;
    is $list.skip(5).List, (),  "List.skip works if too short";
    my @array = <a b c>;
    is @array.skip(5).List, (), "Array.skip works if too short";
    my $range = ^3;
    is $range.skip(5).List, (), "Range.skip works if too short";
} #3

{
    my $list = ();
    is $list.skip(5).List, (),  "List.skip works if empty";
    my @array;
    is @array.skip(5).List, (), "Array.skip works if empty";
    my $range = ^0;
    is $range.skip(5).List, (), "Range.skip works if empty";
} #3

# RT #132109
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

# vim: ft=perl6
