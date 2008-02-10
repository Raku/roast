use v6-alpha;

use Test;

plan 1;

class Foo1 { };
my $foo = Foo1.new();
ok($foo, 'instantiated a class');
