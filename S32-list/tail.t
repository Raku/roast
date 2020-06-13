use v6;

use Test;

plan 29;

=begin description

This test tests the C<tail> builtin.

=end description

{
    my $list = <a b b c d e b b e b b f b>;
    is $list.tail.List, ("b",),  "List.tail works";
    my @array = <a b b c d e b b e b b f b>;
    is @array.tail(5).List, <e b b f b>, "Array.tail works";
    my $scalar = 42;
    is $scalar.tail.List, (42,),      "Scalar.tail works";
    my $range = ^10;
    is $range.tail.List, (9,), "Range.tail works";
    throws-like { ^Inf .tail }, X::Cannot::Lazy,
      :action<tail>,
      'Range.tail on lazy list does not work';
} #5

{
    my $list = <a b b c d e b b e b b f b>;
    is $list.tail(5).List, <e b b f b>,  "List.tail(5) works";
    my @array = <a b b c d e b b e b b f b>;
    is @array.tail(5).List, <e b b f b>, "Array.tail(5) works";
    my $scalar = 42;
    is $scalar.tail(5).List, (42,),      "Scalar.tail(5) works";
    my $range = ^10;
    is $range.tail(5).List, (5,6,7,8,9), "Range.tail(5) works";
    throws-like { ^Inf .tail(5) }, X::Cannot::Lazy,
      :action<tail>,
      'Range.tail(5) on lazy list does not work';
} #5

{
    for 0, -1 {
        my $list = <a b b c d e b b e b b f b>;
        is $list.tail($_).List, (),   "List.tail($_) works";
        my @array = <a b b c d e b b e b b f b>;
        is @array.tail($_).List, (),  "Array.tail($_) works";
        my $scalar = 42;
        is $scalar.tail($_).List, (), "Scalar.tail($_) works";
        my $range = ^10;
        is $range.tail($_).List, (),  "Range.tail($_) works";
    }
} #8

{
    my $list = <a b c>;
    is $list.tail(5).List, <a b c>,  "List.tail works if too short";
    my @array = <a b c>;
    is @array.tail(5).List, <a b c>, "Array.tail works if too short";
    my $range = ^3;
    is $range.tail(5).List, (0,1,2), "Range.tail works if too short";
} #3

{
    my $list = ();
    is $list.tail(5).List, (),  "List.tail works if empty";
    my @array;
    is @array.tail(5).List, (), "Array.tail works if empty";
    my $range = ^0;
    is $range.tail(5).List, (), "Range.tail works if empty";
} #3

subtest 'tail makes use .count-only when it is implemented' => {
    plan 4;

    my $pulled = 0;
    sub make-seq ($i = 0) {
        Seq.new: class :: does PredictiveIterator {
            has $!i;
            has $!pulled;
            method !SET-SELF (\pulled, $!i) { $!pulled := pulled; self    }
            method new       (\pulled, \i) { self.bless!SET-SELF: pulled, i }
            method pull-one {
                $!pulled++;
                ++$!i ≤ 10 ?? $!i !! IterationEnd
            }
            method skip-one { ++$!i ≤ 10 ?? True !! False }
            method count-only { 0 max 10 - $!i }
        }.new: $pulled, $i
    }

    is-deeply make-seq.tail, 10, 'correct tail value';
    is-deeply $pulled,        1, 'we called .pull-one just once';

    $pulled = 0;
    is-deeply make-seq(11).tail, Nil,
        'correct tail value (when Seq got no values)';

    # Spec note: it's not a mistake to pull one time when the .count-only is
    # zero; it's simply pointless. So you should aim for a 0 in this test,
    # but 1 will get you a pass as well.
    is-deeply $pulled, 0|1, 'we did not pull (or pulled just one';
}

# https://github.com/Raku/old-issue-tracker/issues/5867
is-deeply (4,5,6,7).tail(-2**100), (), 'can use ints over 64-bit in .tail';

# https://github.com/Raku/old-issue-tracker/issues/6646
is-deeply <a b c>.tail(2).tail, 'c', 'can .tail a .tail';

# https://github.com/rakudo/rakudo/issues/1429
subtest 'degenerate .tail works' => {
    plan 4;
    is-deeply <a b c>.tail(*+10), <a b c>.Seq, 'List (1)';
    is-deeply <a b c>.tail(*+0 ), <a b c>.Seq, 'List (2)';
    is-deeply      42.tail(*+10),      42.Seq, 'Int  (1)';
    is-deeply      42.tail(*+0 ),      42.Seq, 'Int  (2)';
}

# https://github.com/Raku/old-issue-tracker/issues/6354
is-deeply Seq.new(class :: does Iterator {
    has @!stuff = <a b c>;
    has Bool:D $!ended = False;
    method pull-one {
        $!ended and die;
        @!stuff and return @!stuff.shift;
        $!ended = True;
        IterationEnd
    } }.new), <a b c>.Seq, '.tail(Callable) does not violate Iterator protocol';

# vim: expandtab shiftwidth=4
