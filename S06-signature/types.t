use v6;
use Test;

plan 6;

sub f returns Int ($x) { return $x };

ok &f.returns === Int, 'sub f returns Int can be queried for its return value';
ok &f.of === Int, 'sub f returns Int can be queried for its return value (.of)';

lives_ok { f(3) },      'type check allows good return';
dies_ok  { f('m') },    'type check forbids bad return';

sub g returns  Int ($x) { $x };

lives_ok { g(3) },      'type check allows good implicit return';
#?rakudo todo 'type checks on implicit return'
dies_ok  { g('m') },    'type check forbids bad  implicitreturn';

# vim: ft=perl6
