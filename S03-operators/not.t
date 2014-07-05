use v6;
use Test;
plan 22;

# L<S03/Loose unary precedence>

nok(not 1,     "not 1 is false");
nok(not -1,    "not -1 is false");
nok(!(not 0),  "!not 0 is false");
nok(not sub{}, 'not sub{} is false');
nok(not "x",   'not "x" is false');

my $a = 1; nok(not $a,    'not $not_var is false');
my $b = 0; nok(!(not $b), 'not $false_var is not false');

#?rakudo todo 'RT #65556'
is (not($b) + 1), ((not $b) + 1), 'not($b) is (not $b)';

ok( not(not 42), "not(not 42) is true");
ok(!not(not  0), "not(not  0) is false");

is(not Bool::True, Bool::False, "'Bool::True' is not 'Bool::False'");
isa_ok(not Bool::True, Bool,    "'not Bool::True' is a Bool");
is(not Bool::True, False,       "'Bool::True' is not 'False'");
is(not True, False,             "'True' is not 'False'");
isa_ok(not True, Bool,          "'not True' is a Bool");
is(not True, Bool::False,       "'True' is not 'Bool::False'");

is(not Bool::False, Bool::True, "'Bool::False' is not 'Bool::True'");
isa_ok(not Bool::False, Bool,   "'not Bool::False' is a Bool");
is(not Bool::False, True,       "'Bool::False' is not 'True'");
is(not False, True,             "'False' is not 'True'");
isa_ok(not False, Bool,         "'not False' is a Bool");
is(not False, Bool::True,       "'False' is not 'Bool::True'");

done;

# vim: ft=perl6
