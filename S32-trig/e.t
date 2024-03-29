use Test;
plan 5;

=begin description

Basic tests for trigonometric functions.

=end description

# See also: L<"http://en.wikipedia.org/wiki/E_%28mathematical_constant%29"> :)
my $e = e;

is(e      , $e,    "e, as a value");
throws-like 'e()', X::Undeclared, "e(), dies as a sub";
is(1 + e,   $e+1, "1+e, as a value");
is(e + 1,   $e+1, "e+1, as a value");
is(1 + e +0, $e+1, "1 + e +0, as a value");

# vim: expandtab shiftwidth=4
