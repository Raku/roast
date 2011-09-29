use v6;
use Test;
plan 6;

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

done;
# vim: ft=perl6
