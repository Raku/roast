use v6;

use Test;

plan 4;

class Counter {
    has $!x;
    method init { $!x = 41 }
    method get { $!x }
    method inc { $!x++ }
}

my $c = Counter.new();
try {
    $c.x
}
ok($!, 'no public accessor for private attribute');
$c.init();
is($c.get(), 41, 'can assign and get from within the class');
$c.inc();
is($c.get(), 42, 'can auto-increment an attribute');


class WithAlias {
    has $x;
    method set($a) { $x = $a }
    method get { $!x }
}

my $wa = WithAlias.new();
$wa.set(99);
is($wa.get, 99, 'has with no twigil creates alias');
