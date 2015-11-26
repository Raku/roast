use v6;

use Test;

plan 24;

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

# vim: ft=perl6
