use Test;

plan 57;

=begin description

This test tests the C<tail> builtin.

=end description

{
    my $list = <a b b c d e b b e b b f b>;
    is-deeply $list.tail, "b", 'List.tail works';

    my @array = <a b b c d e b b e b b f b>;
    is-deeply @array.tail(5), <e b b f b>,  'Array.tail(N) works';
    is-deeply tail(5, @array), <e b b f b>, 'tail(N,Array) works';

    my $scalar = 42;
    is-deeply $scalar.tail, 42, 'Scalar.tail works';

    my $range = ^10;
    is-deeply $range.tail, 9, 'Range.tail works';

    throws-like { ^Inf .tail }, X::Cannot::Lazy,
      :action<tail>,
      'Range.tail on lazy list does not work';
}

{
    my $list = <a b b c d e b b e b b f b>;
    is-deeply $list.tail(5),   <e b b f b>, 'List.tail(5) works';
    is-deeply tail(5,$list),       ($list,), 'tail(5,$List) works';
    is-deeply tail(5,$list<>), <e b b f b>, 'tail(5,List) works';

    my @array = <a b b c d e b b e b b f b>;
    is-deeply @array.tail(5), <e b b f b>, 'Array.tail(5) works';
    is-deeply tail(5,@array), <e b b f b>, 'tail(5,Array) works';

    my $scalar = 42;
    is-deeply $scalar.tail(5), (42,), 'Scalar.tail(5) works';
    is-deeply tail(5,$scalar), (42,), 'tail(5,Scalar) works';

    my $range = ^10;
    is-deeply $range.tail(5),   (5,6,7,8,9), 'Range.tail(5) works';
    is-deeply tail(5,$range),     ($range,), 'tail(5,$Range) works';
    is-deeply tail(5,$range<>), (5,6,7,8,9), 'tail(5,Range) works';

    throws-like { ^Inf .tail(5) }, X::Cannot::Lazy,
      :action<tail>,
      'Range.tail(5) on lazy list does not work';
}

{
    for 0, -1 {
        my $list = <a b b c d e b b e b b f b>;
        is-deeply $list.tail($_), (), "List.tail($_) works";
        is-deeply tail($_,$list), (), "tail($_,List) works";

        my @array = <a b b c d e b b e b b f b>;
        is-deeply @array.tail($_), (), "Array.tail($_) works";
        is-deeply tail($_,@array), (), "tail($_,Array) works";

        my $scalar = 42;
        is-deeply $scalar.tail($_), (), "Scalar.tail($_) works";
        is-deeply tail($_,$scalar), (), "tail($_,Scalar) works";

        my $range = ^10;
        is-deeply $range.tail($_), (), "Range.tail($_) works";
        is-deeply tail($_,$range), (), "tail($_,Range) works";
    }
}

{
    my $list = <a b c>;
    is-deeply $list.tail(5),    <a b c>,  'List.tail(N) works if too short';
    is-deeply tail(5,$list), (<a b c>,), 'tail(N,$List) works if too short';
    is-deeply tail(5,$list<>),  <a b c>, 'tail(N,List) works if too short';

    my @array = <a b c>;
    is-deeply @array.tail(5), <a b c>, 'Array.tail(N) works if too short';
    is-deeply tail(5,@array), <a b c>, 'tail(N,Array) works if too short';

    my $range = ^3;
    is-deeply $range.tail(5),   (0,1,2), 'Range.tail(N) works if too short';
    is-deeply tail(5,$range), ($range,), 'tail(N,$Range) works if too short';
    is-deeply tail(5,$range<>), (0,1,2), 'tail(N,Range) works if too short';
}

{
    my $list = ();
    is-deeply $list.tail,         Nil,  'List.tail works if empty';
    is-deeply $list.tail(5),       (),  'List.tail(N) works if empty';
    is-deeply tail(5,$list), ($list,),  'tail(N,$List) works if empty';
    is-deeply tail(5,$list<>),     (),  'tail(N,List) works if empty';

    my @array;
    is-deeply @array.tail,   Nil, 'Array.tail works if empty';
    is-deeply @array.tail(5), (), 'Array.tail(N) works if empty';
    is-deeply tail(5,@array), (), 'tail(N,Array) works if empty';

    my $range = ^0;
    is-deeply $range.tail,          Nil, 'Range.tail works if empty';
    is-deeply $range.tail(5),        (), 'Range.tail(N) works if empty';
    is-deeply tail(5,$range), ($range,), 'tail(N,$Range) works if empty';
    is-deeply tail(5,$range<>),      (), 'tail(N,Range) works if empty';
}

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
