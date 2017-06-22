use v6;

use Test;

plan 24;

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

# vim: ft=perl6
