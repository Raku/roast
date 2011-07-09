use v6;

use Test;

plan 12;

# L<S12/Construction and Initialization/You can clone an object, changing some of the attributes:>
class Foo { 
    has $.attr; 
    method set_attr ($attr) { $.attr = $attr; }
    method get_attr () { $.attr }
}

my $a = Foo.new(:attr(13));
isa_ok($a, Foo);
is($a.get_attr(), 13, '... got the right attr value');

my $c = $a.clone();
isa_ok($c, Foo);
is($c.get_attr(), 13, '... cloned object retained attr value');

my $val;
lives_ok {
    $val = $c === $a;
}, "... cloned object isn't identity equal to the original object";
ok($val.defined && !$val, "... cloned object isn't identity equal to the original object");

my $d;
lives_ok {
    $d = $a.clone(attr => 42)
}, '... cloning with supplying a new attribute value';

my $val2;
lives_ok {
   $val2 = $d.get_attr()
}, '... getting attr from cloned value';
#?rakudo todo 'nom regression'
is($val2, 42, '... cloned object has proper attr value');

# Test to cover RT#62828, which exposed a bad interaction between while loops
# and cloning.
{
    class A {
        has $.b;
    };
    while shift [A.new( :b(0) )] -> $a {
        is($a.b, 0, 'sanity before clone');
        my $x = $a.clone( :b($a.b + 1) );
        is($a.b, 0, 'clone did not change value in original object');
        #?rakudo todo 'nom regression'
        is($x.b, 1, 'however, in the clone it was changed');
        last;
    }
}

# vim: ft=perl6
