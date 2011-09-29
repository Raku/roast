use v6;
use Test;
plan 15;

# L<S03/Loose unary precedence>

ok(so 1,     "so 1 is true");
ok(so -1,    "so -1 is true");
ok(not so 0,  "not so 0 is true");
ok(so sub{}, 'so sub{} is true');
ok(so "x",   'so "x" is true');

my $a = 1; ok(so $a,    'so $true_var is true');
my $b = 0; ok(!(so $b), 'so $false_var is not true');

ok( so(so 42), "so(so 42) is true");
ok(not so(so 0), "so(so 0) is false");

ok(so Bool::True, "'Bool::True' is true");
#?niecza todo
ok Bool.so === False, 'Bool.so returns false';
ok(so True, "'True' is true");

#?rakudo todo 'check test and rakudo'
is (so($b) + 1), ((so $b) + 1), 'so($b) is (so $b)';

ok (so my $x = 5), 'so + declaration';
is $x, 5, 'assignment after so worked';

# vim: ft=perl6
