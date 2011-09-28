use v6;
use Test;

plan 18;

# cmp on scalar values
{
    is 5 cmp 6, -1, "cmp on int (1)";
    is 5 cmp 5, 0,  "cmp on int (2)";
    is 6 cmp 5, 1,  "cmp on int (3)";

    is "a" cmp "b", -1, "cmp on characters (1)";
    is "b" cmp "a", 1,  "cmp on characters (2)";
    is "a" cmp "a", 0,  "cmp on characters (3)";
}

# cmp on variables
{
    my Int $a = 11;
    my Int $b = 10;

    is $a cmp $b, 1,  "cmp on Int variables (1)";
    --$a;
    is $a cmp $b, 0,  "cmp on Int variables (2)";
    --$a;
    is $a cmp $b, -1, "cmp on Int variables (3)";

    my Str $c = "aaa";
    my Str $d = "bbb";

    is $c cmp $d, -1, "cmp on Str variables (1)";
    $c = "bbb";
    is $c cmp $d, 0,  "cmp on Str variables (2)";
    $c = "ccc";
    is $c cmp $d, 1,  "cmp on Str variables (3)";
}

# cmp on Pair
#?niecza skip 'Cannot use value like Pair as a number'
{
    is (:a<5> cmp :a<5>), 0,  "cmp on Pair (1)";
    is (:a<5> cmp :b<5>), -1, "cmp on Pair (2)";
    is (:b<5> cmp :a<5>), 1,  "cmp on Pair (3)";
    is (:a<6> cmp :a<5>), 1,  "cmp on Pair (4)";
    is (:a<5> cmp :a<6>), -1, "cmp on Pair (5)";

    my $cmp5 = { :$^q cmp :q<5> };
    is $cmp5(5), 0, "cmp on Pair from local variable"
}

# vim: ft=perl6
