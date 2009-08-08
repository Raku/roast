use v6;
use Test;
plan 13;

sub not_ok($cond,$desc) {
    if $cond {
        ok 0, $desc;
    } else {
        ok 1, $desc;
    }
}

# L<S03/Loose unary precedence>

not_ok(not 1,     "not 1 is false");
not_ok(not -1,    "not -1 is false");
not_ok(!(not 0),  "!not 0 is false");
not_ok(not sub{}, 'not sub{} is false');
not_ok(not "x",   'not "x" is false');

my $a = 1; not_ok(not $a,    'not $not_var is false');
my $b = 0; not_ok(!(not $b), 'not $false_var is not false');

ok( not(not 42), "not(not 42) is true");
ok(!not(not  0), "not(not  0) is true");

is(not Bool::True, Bool::False, "'Bool::True' is not 'Bool::False'");
is(not Bool::True, False,       "'Bool::True' is not 'False'");
is(not True, False,             "'True' is not 'False'");
is(not True, Bool::False,       "'True' is not 'Bool::False'");

# vim: ft=perl6
