use v6;
use Test;
plan 5;

# L<S32::Numeric/Numeric/"=item gcd">

=begin pod

Basic tests for the gcd operator

=end pod

is 10 gcd 5, 5, "The gcd of 10 and 5 is 5";
isa_ok 10 gcd 5, Int, "The gcd of 10 and 5 is an Int";
is -432 gcd 63, 9, "The gcd of -432 and 63 is 9";
is 4342 gcd 65536, 2, "The gcd of 4342 and 65536 is 2";
isa_ok 4342 gcd 65536, Int, "The gcd of 4342 and 65536 is an Int";

done;
# vim: ft=perl6
