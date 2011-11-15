use v6;
use Test;
plan 16;

# L<S32::Numeric/Numeric/"=item gcd">

=begin pod

Basic tests for the gcd operator

=end pod

is 10 gcd 5, 5, "The gcd of 10 and 5 is 5";
isa_ok 10 gcd 5, Int, "The gcd of 10 and 5 is an Int";
is -432 gcd 63, 9, "The gcd of -432 and 63 is 9";
is 4342 gcd 65536, 2, "The gcd of 4342 and 65536 is 2";
isa_ok 4342 gcd 65536, Int, "The gcd of 4342 and 65536 is an Int";

is ([gcd] 25..26), 1, '[gcd] Range works';
{
    my @a = 50, 70, 100, 2005;
    is ([gcd] @a), 5, '[gcd] array works';
}

{
    is 10.1 gcd 5.3, 5, "gcd converts Rats to Ints correctly";
    isa_ok 10.1 gcd 5.3, Int, "and the result is an Int";
    is 10.1e0 gcd 5.3e0, 5, "gcd converts Nums to Ints correctly";
    isa_ok 10.1e0 gcd 5.3e0, Int, "and the result is an Int";
}

{
    is 123123123123123123123123123 gcd 3, 3, "gcd handles big Int and small Int";
    is 123123123123123123123123123 gcd 2, 1, "gcd handles big Int and small Int";
    is 3 gcd 123123123123123123123123123, 3, "gcd handles small Int and big Int";
    is 7 gcd 123123123123123123123123123, 1, "gcd handles small Int and big Int";
    is 123123123123123123123123123123 gcd 123123123123123123123123123, 123, "gcd handles big Int and big Int";
}

done;
# vim: ft=perl6
