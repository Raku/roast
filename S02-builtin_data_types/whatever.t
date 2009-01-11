use v6;
use Test;

plan 3;

my $x = *-1;

lives_ok { $x.WHAT }, '(*-1).WHAT lives';
#?rakudo 2 skip 'Whatever star'
isa_ok $x, Code, '*-1 is of type Code';
ok $x.(5), 4, 'and we can execute that Code';


# vim: ft=perl6
