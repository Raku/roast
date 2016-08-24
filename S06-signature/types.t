use v6;
use Test;

plan 12;

sub f($x) returns Int { return $x };

ok &f.returns === Int, 'sub f returns Int can be queried for its return value';
ok &f.of === Int, 'sub f returns Int can be queried for its return value (.of)';

# RT #121426
ok &f ~~ Callable[Int], 'sub f ~~ Callable[Int]';

lives-ok { f(3) },      'type check allows good return';
dies-ok  { f('m') },    'type check forbids bad return';

sub g($x) returns  Int { $x };

lives-ok { g(3)   },    'type check allows good implicit return';
dies-ok  { g('m') },    'type check forbids bad implicit return';

# RT #77158
{
    ok :(Int).perl eq ':(Int $)',
        "RT #77158 Doing .perl on an :(Int)";
    ok :(Array of Int).perl eq ':(Array[Int] $)',
        "RT #77158 Doing .perl on an :(Array of Int)";
}

# RT #123789
{
    sub rt123789 (int $x) { say $x };
    throws-like { rt123789(Int) }, Exception,
        message => 'Cannot unbox a type object',
        'no segfault when calling a routine having a native parameter with a type object argument';
}

# RT #126124
{
    throws-like { sub f(Mu:D $a) {}; f(Int) }, Exception,
        message => 'Parameter \'$a\' requires an instance of type Mu, but a type object was passed.  Did you forget a .new?',
        'type shown in the exception message is the right one';
    throws-like { sub f(Mu:U $a) {}; f(123) }, Exception,
        message => 'Parameter \'$a\' requires an instance of type Mu, but a type object was passed.  Did you forget a .new?',
        'type shown in the exception message is the right one';
}

# vim: ft=perl6
