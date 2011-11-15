use v6;
use Test;
plan 15;

# L<S32::Numeric/Numeric/"=item lcm">

=begin pod

Basic tests for the lcm operator

=end pod

is 10 lcm 5, 10, "The lcm of 10 and 5 is 10";
isa_ok 10 lcm 5, Int, "The lcm of 10 and 5 is an Int";
is -432 lcm 63, 3024, "The lcm of -432 and 63 is 3024";
is 4342 lcm 65536, 142278656, "The lcm of 4342 and 65536 is 142278656";
isa_ok 4342 lcm 65536, Int, "The lcm of 4342 and 65536 is an Int";

is ([lcm] 1..3), 6, '[lcm] Range works';

{
    is 10.1 lcm 5.3, 10, "lcm converts Rats to Ints correctly";
    isa_ok 10.1 lcm 5.3, Int, "and the result is an Int";
    is 10.1e0 lcm 5.3e0, 10, "lcm converts Nums to Ints correctly";
    isa_ok 10.1e0 lcm 5.3e0, Int, "and the result is an Int";
}

{
    is 123123123123123123123123123 lcm 3, 123123123123123123123123123, "lcm handles big Int and small Int";
    is 123123123123123123123123123 lcm 2, 246246246246246246246246246, "lcm handles big Int and small Int";
    is 3 lcm 123123123123123123123123123, 123123123123123123123123123, "lcm handles small Int and big Int";
    is 7 lcm 123123123123123123123123123, 861861861861861861861861861, "lcm handles small Int and big Int";
    is 123123123123123123123123123123 lcm 123123123123123123123123123, 
       123246369492615738861985108107984861738615492369246123, "lcm handles big Int and big Int";
}

done;
# vim: ft=perl6
