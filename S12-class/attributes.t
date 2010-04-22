use v6;

use Test;

plan 19;

# L<S12/Methods/"For a call on your own private method">

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


class ManyTest {
    has ($a, $b);
    has ($.c, $.d);
    has ($!e, $!f);
    method t1 {
        $a + $b
    }
    method t2 {
        $!a + $!b
    }
    method t3 {
        $!e + $!f
    }
}

my $m = ManyTest.new(a => 1, b => 2, c => 3, d => 4, e => 5, f => 6);
is($m.c, 3, 'list attribute declaration of publics works');
is($m.d, 4, 'list attribute declaration of publics works');
is($m.t1, 3, 'list attribute declaration of alias works');
is($m.t2, 3, 'list attribute declaration of alias works');
is($m.t3, 11, 'list attribute declaration of privates works');


class Foo {
    has %.bar is rw;
    method set_bar {
        %.bar<a> = 'baz';
    }
}
my $foo = Foo.new;
#?rakudo todo "Somehow this is Hash and not Hash at the same time?"
isa_ok($foo.bar, Hash,    'hash attribute initialized');
$foo.set_bar();
is($foo.bar<a>, 'baz',    'hash attribute initialized/works');
my %s = $foo.bar;
is(%s<a>, 'baz',          'hash attribute initialized/works');
$foo.bar<b> = 'wob';
is($foo.bar<b>, 'wob',    'hash attribute initialized/works');

class Bar {
    has @.bar is rw;
    method set_bar {
        @.bar[0] = 100;
        @.bar[1] = 200;
    }
}
my $bar = Bar.new;
isa_ok($bar.bar.WHAT, Array, 'array attribute initialized');
$bar.set_bar();
is($bar.bar[0], 100,       'array attribute initialized/works');
is($bar.bar[1], 200,       'array attribute initialized/works');
my @t = $bar.bar;
is(@t[0], 100,             'array attribute initialized/works');
is(@t[1], 200,             'array attribute initialized/works');
$bar.bar[2] = 300;
is($bar.bar[2], 300,       'array attribute initialized/works');

# vim: ft=perl6
