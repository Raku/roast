use v6;
use Test;

plan 8;

sub f($x) returns Int { return $x };

ok &f.returns === Int, 'sub f returns Int can be queried for its return value';
ok &f.of === Int, 'sub f returns Int can be queried for its return value (.of)';

lives_ok { f(3) },      'type check allows good return';
dies_ok  { f('m') },    'type check forbids bad return';

sub g($x) returns  Int { $x };

lives_ok { g(3)   },    'type check allows good implicit return';
dies_ok  { g('m') },    'type check forbids bad  implicitreturn';

#RT #77158
{
    ok :(Int).perl eq ':(Int)',
        "RT #77158 Doing .perl on an :(Int)";
    ok :(Array of Int).perl eq ':(Array[Int])',
        "RT #77158 Doing .perl on an :(Array of Int)";
}

# vim: ft=perl6
