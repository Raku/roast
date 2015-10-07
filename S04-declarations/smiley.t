use v6;
use Test;

plan 12;

my Int:_ $a;       is $a, Int, 'Int:_ without initializer';
my Int:_ $b = Int; is $b, Int, 'Int:_ with initializer (type object)';
my Int:_ $c = 42;  is $c,  42, 'Int:_ with initializer (instance)';

throws-like 'my Int:D $d;',
    X::Syntax::Variable::MissingInitializer,
    type => 'Int:D',
    'Int:D without initializer throws';
my Int:D $e =  42; is $e,  42, 'Int:D with initializer';
throws-like 'my Int:D $i = Int',
    X::TypeCheck,
    'Int:D with wrong initializer';

my Int:U $g;       ok $g ~~ Int, 'Int:U without initializer';
my Int:U $h = Int; ok $h ~~ Int, 'Int:U with initializer';
throws-like 'my Int:U $i = 42',
    X::TypeCheck,
    'Int:U with wrong initializer';

my Int:D $j = 256;

MY::<$j> = 111;
is $j, 111, 'instance assignment to Int:D via MY:: pseudo package works';

try MY::<$j> = Int;
is $j, 111, 'typeobject assignment to Int:D via MY:: pseudo package fails';

try $j = Int;
is $j, 111, 'typeobject assignment to Int:D fails';

# vim: ft=perl6
