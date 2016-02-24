use v6.c;
use Test;
plan 7;

# test relation between attributes and inheritance

class A {
    has $.a;
}

class B is A {
    method accessor {
        return $.a
    }
}

my $o;
lives-ok {$o = B.new(a => 'blubb') }, 'Can initialize inherited attribute';
is $o.accessor, 'blubb',              'accessor can use inherited attribute';

class Artie61500 {
    has $!p = 61500;
}
throws-like 'class Artay61500 is Artie61500 { method bomb { return $!p } }',
    X::Attribute::Undeclared,
    'Compile error for subclass to access private attribute of parent';

class Parent {
    has $!priv = 23;
    method get { $!priv };
    has $.public is rw;
    method report() { $!public }
}

class Child is Parent {
    has $!priv = 42;
    has $.public is rw;
}

is Child.new().Parent::get(), 23,
   'private attributes do not leak from child to parent class (1)';

is Child.new().get(), 23,
   'private attributes do not leak from child to parent class (2)';

my $child = Child.new();
$child.public = 5;
nok $child.report.defined,
    'If parent and child have an attribute of the same name, they do not share storage location';

# RT #61500
{
    throws-like q{
        class RT61500_A { has $!foo = 7 };
        class RT61500_B is RT61500_A { method x { say $!foo } };
        RT61500_B.new.x
    },
        X::Attribute::Undeclared,
        'rt 61500';
}

# vim: ft=perl6
