use v6;

use Test;

plan 6;
#L<S03/Comparison semantics/The <=> operator>

my %h = ("a" => 1, "b" => 2);
ok(%h{"a"} < %h{"b"}, 'comparing hash values');
ok(%h{"a"} <= %h{"b"}, 'comparing hash values');
#?pugs skip 'Order::Less'
is(%h{"a"} <=> %h{"b"}, Order::Less, 'comparing hash values');

my @a = (1, 2);
ok(@a[0] < @a[1], 'comparing array values');
ok(@a[0] <= @a[1], 'comparing array values');
#?pugs skip 'Order::Less'
is(@a[0] <=> @a[1], Order::Less, 'comparing array values');

# vim: ft=perl6
