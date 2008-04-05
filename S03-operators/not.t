use v6-alpha;
use Test;
plan 10;

# L<S03/Loose unary precedence>

is(not 1,     False, "not 1 is false");
is(not -1,    False, "not -1 is false");
is(!(not 0),  False, "!not 0 is false");
is(not sub{}, False, 'not sub{} is false');
is(not "x",   False, 'not "x" is false');

my $a = 1; is(not $a,    False, 'not $not_var is false');
my $b = 0; is(!(not $b), False, 'not $false_var is not false');

is( not(not 42), True, "not(not 42) is true");
is(!not(not  0), True, "not(not  0) is true");

is(not True, False, "bare 'True' is not false");
