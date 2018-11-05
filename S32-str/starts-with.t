use v6.d;

use Test;

plan 9;

# L<S32::Str/Str/=item starts-with>

my $s = "foobar";
is-deeply $s.starts-with("foo"),     True, "'foobar' starts with 'foo'";
is-deeply $s.starts-with("foobar"),  True, "'foobar' starts with 'foobar'";
is-deeply $s.starts-with("goo"),     False, "'foobar' doesn't start with 'goo'";
is-deeply $s.starts-with("foobarx"), False, "'foobar' doesn't start with 'foobarx'";

my $i = 342;
is-deeply $i.starts-with(34),   True,  "342 starts with 34";
is-deeply $i.starts-with(342),  True,  "342 starts with 342";
is-deeply $i.starts-with(43),   False, "342 doesn't start with 43";
is-deeply $i.starts-with(3428), False, "342 doesn't start with 3428";

try { 42.starts-with: Str }; pass "Cool.starts-with with wrong args does not hang";

# vim: ft=perl6
