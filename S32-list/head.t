use Test;

plan 60;

=begin description

This test tests the C<head> builtin.

=end description

{
    my $list = <a b b c d e b b e b b f b>;
    is-deeply $list.head, "a", 'List.head works';

    my @array = <a b b c d e b b e b b f b>;
    is-deeply @array.head, "a", 'Array.head works';

    my $scalar = 42;
    is-deeply $scalar.head, 42, 'Scalar.head works';

    my $range = ^10;
    is-deeply $range.head, 0, 'Range.head works';

    my $inf = ^Inf;
    is-deeply $inf.head, 0, 'Range.head works on lazy list';
}

{
    my $list = <a b b c d e b b e b b f b>;
    is-deeply $list.head(5),   <a b b c d>, 'List.head(5) works';
    is-deeply head(5,$list),      ($list,), 'head(5,$List) works';
    is-deeply head(5,$list<>), <a b b c d>, 'head(5,List) works';

    my @array = <a b b c d e b b e b b f b>;
    is-deeply @array.head(5), <a b b c d>, 'Array.head(5) works';
    is-deeply head(5,@array), <a b b c d>, 'head(5,Array) works';

    my $scalar = 42;
    is-deeply $scalar.head(5), (42,), 'Scalar.head(5) works';
    is-deeply head(5,$scalar), (42,), 'head(5,Scalar) works';

    my $range = ^10;
    is-deeply $range.head(5),   (0,1,2,3,4), 'Range.head(5) works';
    is-deeply head(5,$range),     ($range,), 'head(5,$Range) works';
    is-deeply head(5,$range<>), (0,1,2,3,4), 'head(5,Range) works';

    my $inf = ^Inf;
    is-deeply $inf.head(5),   (0,1,2,3,4), 'Range.head(5) works on lazy list';
    is-deeply head(5,$inf),       ($inf,), 'head(5,$Range) works on lazy list';
    is-deeply head(5,$inf<>), (0,1,2,3,4), 'head(5,Range) works on lazy list';
}

{
    for 0, -1 {
        my $list = <a b b c d e b b e b b f b>;
        is-deeply $list.head($_),   (), "List.head($_) works";
        is-deeply head($_,$list),   (), "head($_,\$List) works";
        is-deeply head($_,$list<>), (), "head($_,List) works";

        my @array = <a b b c d e b b e b b f b>;
        is-deeply @array.head($_), (),  "Array.head($_) works";
        is-deeply head($_,@array), (),  "head($_,Array) works";

        my $scalar = 42;
        is-deeply $scalar.head($_), (), "Scalar.head($_) works";
        is-deeply head($_,$scalar), (), "head($_,Scalar) works";

        my $range = ^10;
        is-deeply $range.head($_),   (), "Range.head($_) works";
        is-deeply head($_,$range),   (), "head($_,\$Range) works";
        is-deeply head($_,$range<>), (), "head($_,Range) works";
    }
}

{
    my $list = <a b c>;
    is-deeply $list.head(5),   <a b c>, 'List.head(N) works if too short';
    is-deeply head(5,$list),  ($list,), 'head(N,$List) works if too short';
    is-deeply head(5,$list<>), <a b c>, 'head(N,$List) works if too short';

    my @array = <a b c>;
    is-deeply @array.head(5), <a b c>, 'Array.head(N) works if too short';
    is-deeply head(5,@array), <a b c>, 'head(N,Array) works if too short';

    my $range = ^3;
    is-deeply $range.head(5),   (0,1,2), 'Range.head(N) works if too short';
    is-deeply head(5,$range), ($range,), 'head(N,$Range) works if too short';
    is-deeply head(5,$range<>), (0,1,2), 'head(N,Range) works if too short';
}

{
    my $list = ();
    is-deeply $list.head,         Nil, 'List.head works if empty';
    is-deeply $list.head(5),       (), 'List.head(N) works if empty';
    is-deeply head(5,$list), ($list,), 'head(N,$List) works if empty';
    is-deeply head(5,$list<>),     (), 'head(N,List) works if empty';

    my @array;
    is-deeply @array.head,   Nil, 'Array.head works if empty';
    is-deeply @array.head(5), (), 'Array.head(N) works if empty';
    is-deeply head(5,@array), (), 'head(N,Array) works if empty';

    my $range = ^0;
    is-deeply $range.head,          Nil, 'Range.head works if empty';
    is-deeply $range.head(5),        (), 'Range.head(N) works if empty';
    is-deeply head(5,$range), ($range,), 'head(N,$Range) works if empty';
    is-deeply head(5,$range<>),      (), 'head(N,Range) works if empty';
}

# https://github.com/Raku/old-issue-tracker/issues/5867
is-deeply (4,5,6).head(-999999999999999999999999999), (),
    '.head works correctly with large negative Ints';

{ # https://github.com/rakudo/rakudo/commit/74c8f0442b
    lives-ok {
        is <a b c>.head(1/2), '', 'head with Rat index coerces it to Int and retrieves correct result';
    }, 'Rat is coerced to Int when used as index';
}

# vim: expandtab shiftwidth=4
