use v6;
use Test;

plan 18;

# cmp on scalar values
{
    is 5 cmp 6, Order::Increase, "cmp on int (1)";
    is 5 cmp 5, Order::Same,  "cmp on int (2)";
    is 6 cmp 5, Order::Decrease,  "cmp on int (3)";

    is "a" cmp "b", Order::Increase, "cmp on characters (1)";
    is "b" cmp "a", Order::Decrease,  "cmp on characters (2)";
    is "a" cmp "a", Order::Same,  "cmp on characters (3)";
}

# cmp on variables
{
    my Int $a = 11;
    my Int $b = 10;

    is $a cmp $b, Order::Decrease,  "cmp on Int variables (1)";
    --$a;
    is $a cmp $b, Order::Same,  "cmp on Int variables (2)";
    --$a;
    is $a cmp $b, Order::Increase, "cmp on Int variables (3)";

    my Str $c = "aaa";
    my Str $d = "bbb";

    is $c cmp $d, Order::Increase, "cmp on Str variables (1)";
    $c = "bbb";
    is $c cmp $d, Order::Same,  "cmp on Str variables (2)";
    $c = "ccc";
    is $c cmp $d, Order::Decrease,  "cmp on Str variables (3)";
}

# cmp on Pair
{
    is (:a<5> cmp :a<5>), Order::Same,  "cmp on Pair (1)";
    is (:a<5> cmp :b<5>), Order::Increase, "cmp on Pair (2)";
    is (:b<5> cmp :a<5>), Order::Decrease,  "cmp on Pair (3)";
    is (:a<6> cmp :a<5>), Order::Decrease,  "cmp on Pair (4)";
    is (:a<5> cmp :a<6>), Order::Increase, "cmp on Pair (5)";

    my $cmp5 = { :$^q cmp :q<5> };
    is $cmp5(5), Order::Same, "cmp on Pair from local variable"
}

# vim: ft=perl6
