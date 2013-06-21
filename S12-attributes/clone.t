use v6;

use Test;

plan 18;

# L<S12/Cloning/You can clone an object, changing some of the attributes:>
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
is($val2, 42, '... cloned object has proper attr value');

# Test to cover RT#62828, which exposed a bad interaction between while loops
# and cloning.
#?pugs skip "Cannot 'shift' scalar"
{
    class A {
        has $.b;
    };
    while shift [A.new( :b(0) )] -> $a {
        is($a.b, 0, 'sanity before clone');
        my $x = $a.clone( :b($a.b + 1) );
        is($a.b, 0, 'clone did not change value in original object');
        is($x.b, 1, 'however, in the clone it was changed');
        last;
    }
}

# RT 88254
#?pugs todo
#?niecza todo "Exception: Representation P6cursor does not support cloning"
{
    my ($p, $q);
    $p = 'a' ~~ /$<foo>='a'/;
    
    # previously it was timeout on Rakudo
    lives_ok { $q = $p.clone }, 'Match object can be cloned';
    
    is ~$q{'foo'}, 'a', 'cloned Match object retained named capture value';
}

# test cloning of array and hash attributes
{
    # array
    class A {
        has @.array;
    }
    my $a1 = A.new(:array<a b>);
    my $a2 = $a1.clone(:array<c d>);
    is_deeply $a1.array, ['a', 'b'], 'original object has its original array';
    is_deeply $a2.array, ['c', 'd'], 'cloned object has the newly-provided array';

    # hash
    class B {
        has %.hash;
    }
    my $b1 = B.new(hash=>{'a' => 'b'});
    my $b2 = $b1.clone(hash=>{'c' => 'd'});
    is_deeply $b1.hash, {'a' => 'b'}, 'original object has its original hash';
    is_deeply $b2.hash, {'c' => 'd'}, 'cloned object has the newly-provided hash';
}

# vim: ft=perl6
