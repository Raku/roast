use v6;
use Test;

plan 3;

my $x = *-1;

lives_ok { $x.WHAT }, '(*-1).WHAT lives';
#?rakudo todo '*-1 should create a closure'
isa_ok $x, Code, '*-1 is of type Code';
#?rakudo skip '*-1 should create a closure'
ok $x.(5), 4, 'and we can execute that Code';


# vim: ft=perl6
