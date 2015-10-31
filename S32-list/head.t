use v6;

use Test;

plan 19;

=begin description

This test tests the C<head> builtin.

=end description

{
    my $list = <a b b c d e b b e b b f b>;
    is $list.head(5).List, <a b b c d>,  "List.head works";
    my @array = <a b b c d e b b e b b f b>;
    is @array.head(5).List, <a b b c d>, "Array.head works";
    my $scalar = 42;
    is $scalar.head(5).List, (42,),      "Scalar.head works";
    my $range = ^10;
    is $range.head(5).List, (0,1,2,3,4), "Range.head works";
    my $inf = ^Inf;
    is $inf.head(5).List, (0,1,2,3,4),   "Range.head works on lazy list also";
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

# vim: ft=perl6
