use v6;

use Test;

# L<S12/Classes/"Perl 6 supports multiple inheritance, anonymous classes">
plan 18;

# Create and instantiate empty class; check .WHAT works and stringifies to
# empty string.
my $c1 = class { };
my $t1 = $c1.new();
ok(defined($t1),     'instantiated the class');
ok($t1 ~~ $c1,       'isa check works');
#?rakudo todo 'Anonymous class stringification (?) RT #125045'
#?niecza todo
is($c1.WHAT().gist, '()',  '.WHAT.gist stringifies to ()');

# Anonymous classes with methods.
my $c2 = class { method foo { 42 }; method bar { 28 } };
my $t2 = $c2.new();
is($t2.foo, 42,      'can call methods on anonymous classes');
is($t2.bar, 28,      'can call methods on anonymous classes');

# Anonymous classes with attributes.
my $c3 = class { has $.x };
my $t3 = $c3.new(x => 42);
is($t3.x, 42,        'anonymous classes can have attributes');

{
    my $class;
    lives-ok { $class = class { method meth() { return 42 } }} ,
    "anonymous class creation";

    my $a;
    ok ($a = $class.new), "instantiation of anonymous class";
    is $a.meth, 42, "calling a method on an instance of an anonymous class (1)";

    # And the same w/o using a $class variable:
    is (class { method meth() { return 42 } }).new.meth, 42,
    "calling a method on an instance of an anonymous class (2)";
}

# Anonymous classes can inherit from named classes.
{
    class TestParent { method foo { 42 } }
    my $x = class :: is TestParent { }
    ok($x ~~ TestParent, 'anonymous class isa TestParent');
    is($x.foo, 42,       'inherited method from TestParent');
}

# RT #64888
{
    sub rt64888 {
        (
         class {
             method Stringy() { 'RT #64888' }
             method Numeric() { 64888 }
         }
        ).new
    }
    my $i1;
    my $i2;

    lives-ok { $i1 = rt64888() }, 'can get anonymous class instance once';
    lives-ok { $i2 = rt64888() }, 'can get anonymous class instance twice';

    #?niecza todo
    is ~$i1, 'RT #64888', 'anonymous class stringified works';
    is +$i1, 64888, 'anonymous class numified works';
}

# RT #80024
throws-like q[anon class C { }; C.WHAT; ], X::Undeclared::Symbols,
    'anon class is actually anon';

# RT 114716
{
    ok (class {}) !=== (class {}), 'anonymous classes are distinct';
}

# vim: ft=perl6
