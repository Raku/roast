use v6;

use Test;

plan 6;
#L<S03/Comparison semantics/The <=> operator>

my %h = ("a" => 1, "b" => 2);
ok(%h{"a"} < %h{"b"}, 'comparing hash values');
ok(%h{"a"} <= %h{"b"}, 'comparing hash values');
#?niecza todo
is(%h{"a"} <=> %h{"b"}, Order::Increase, 'comparing hash values');

my @a = (1, 2);
ok(@a[0] < @a[1], 'comparing array values');
ok(@a[0] <= @a[1], 'comparing array values');
#?niecza todo
is(@a[0] <=> @a[1], Order::Increase, 'comparing array values');

# vim: ft=perl6
