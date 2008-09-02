use v6;
use Test;
plan 13;

#?rakudo emit #
sub nok { @_ == 2 and ok @_[0], @_[1] }

# L<S03/Loose unary precedence>

nok(not 1,     "not 1 is false");
nok(not -1,    "not -1 is false");
nok(!(not 0),  "!not 0 is false");
nok(not sub{}, 'not sub{} is false');
nok(not "x",   'not "x" is false');

my $a = 1; nok(not $a,    'not $not_var is false');
my $b = 0; nok(!(not $b), 'not $false_var is not false');

ok( not(not 42), "not(not 42) is true");
ok(!not(not  0), "not(not  0) is true");

is(not Bool::True, Bool::False, "'Bool::True' is not 'Bool::False'");
is(not Bool::True, False,       "'Bool::True' is not 'False'");
is(not True, False,             "'True' is not 'False'");
is(not True, Bool::False,       "'True' is not 'Bool::False'");
