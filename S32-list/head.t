use v6;

use Test;

plan 27;

=begin description

This test tests the C<head> builtin.

=end description

{
    my $list = <a b b c d e b b e b b f b>;
    is $list.head.List, ("a",),  "List.head works";
    my @array = <a b b c d e b b e b b f b>;
    is @array.head.List, ("a",), "Array.head works";
    my $scalar = 42;
    is $scalar.head.List, (42,),      "Scalar.head works";
    my $range = ^10;
    is $range.head.List, (0,),        "Range.head works";
    my $inf = ^Inf;
    is $inf.head.List, (0,),          "Range.head works on lazy list";
} #5

{
    my $list = <a b b c d e b b e b b f b>;
    is $list.head(5).List, <a b b c d>,  "List.head(5) works";
    my @array = <a b b c d e b b e b b f b>;
    is @array.head(5).List, <a b b c d>, "Array.head(5) works";
    my $scalar = 42;
    is $scalar.head(5).List, (42,),      "Scalar.head(5) works";
    my $range = ^10;
    is $range.head(5).List, (0,1,2,3,4), "Range.head(5) works";
    my $inf = ^Inf;
    is $inf.head(5).List, (0,1,2,3,4),   "Range.head(5) works on lazy list";
} #5

{
    for 0, -1 {
        my $list = <a b b c d e b b e b b f b>;
        is $list.head($_).List, (),   "List.head($_) works";
        my @array = <a b b c d e b b e b b f b>;
        is @array.head($_).List, (),  "Array.head($_) works";
        my $scalar = 42;
        is $scalar.head($_).List, (), "Scalar.head($_) works";
        my $range = ^10;
        is $range.head($_).List, (),  "Range.head($_) works";
    }
} #8

{
    my $list = <a b c>;
    is $list.head(5).List, <a b c>,  "List.head works if too short";
    my @array = <a b c>;
    is @array.head(5).List, <a b c>, "Array.head works if too short";
    my $range = ^3;
    is $range.head(5).List, (0,1,2), "Range.head works if too short";
} #3

{
    my $list = ();
    is $list.head(5).List, (),  "List.head works if empty";
    my @array;
    is @array.head(5).List, (), "Array.head works if empty";
    my $range = ^0;
    is $range.head(5).List, (), "Range.head works if empty";
} #3

# https://github.com/Raku/old-issue-tracker/issues/5867
is-deeply (4,5,6).head(-999999999999999999999999999), (),
    '.head works correctly with large negative Ints';

{ # https://github.com/rakudo/rakudo/commit/74c8f0442b
    lives-ok {
        is <a b c>.head(1/2), '', 'head with Rat index coerces it to Int and retrieves correct result';
    }, 'Rat is coerced to Int when used as index';
}

# vim: expandtab shiftwidth=4
