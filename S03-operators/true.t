use v6;
use Test;
plan 10;

# L<S03/Loose unary precedence>

ok(true 1,     "true 1 is true");
ok(true -1,    "true -1 is true");
ok(!(true 0),  "!true 0 is true");
ok(true sub{}, 'true sub{} is true');
ok(true "x",   'true "x" is true');

my $a = 1; ok(true $a,    'true $true_var is true');
my $b = 0; ok(!(true $b), 'true $false_var is not true');

ok( true(true 42), "true(true 42) is true");
ok(!true(true  0), "true(true  0) is false");

ok(true True, "bare 'True' is true");
