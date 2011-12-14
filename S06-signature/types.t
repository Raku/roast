use v6;
use Test;

plan 6;

sub f($x) returns Int { return $x };

ok &f.returns === Int, 'sub f returns Int can be queried for its return value';
ok &f.of === Int, 'sub f returns Int can be queried for its return value (.of)';

lives_ok { f(3) },      'type check allows good return';
dies_ok  { f('m') },    'type check forbids bad return';

sub g($x) returns  Int { $x };

lives_ok { g(3) },      'type check allows good implicit return';
#?rakudo todo 'type check on return value'
dies_ok  { g('m') },    'type check forbids bad  implicitreturn';

# vim: ft=perl6
