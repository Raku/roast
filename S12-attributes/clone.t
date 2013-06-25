use v6;

use Test;

plan 34;

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
    my class ArrTest {
        has @.array;
    }

    # hash
    my class HshTest {
        has %.hash;
    }

    # when cloning with new versions of attributes, it should not update the original
    my $a1 = ArrTest.new(:array<a b>);
    my $a2 = $a1.clone(:array<c d>);
    #?rakudo todo "clone currently messes up original"
    is_deeply $a1.array, ['a', 'b'], 'original object has its original array';
    is_deeply $a2.array, ['c', 'd'], 'cloned object has the newly-provided array';

    my $b1 = HshTest.new(hash=>{'a' => 'b'});
    my $b2 = $b1.clone(hash=>{'c' => 'd'});
    #?rakudo todo "clone currently messes up original"
    is_deeply $b1.hash, {'a' => 'b'}, 'original object has its original hash';
    is_deeply $b2.hash, {'c' => 'd'}, 'cloned object has the newly-provided hash';

    # when cloning without new versions of attributes, it should not deep-copy the array/hash
    my $a3 = ArrTest.new(:array<a b>);
    my $a4 = $a3.clone;
    is_deeply $a3.array, ['a', 'b'], 'original array attr sanity test';
    is_deeply $a4.array, ['a', 'b'], 'cloned array attr sanity test';
    #?pugs emit # can't modify constant...
    push $a3.array, 'c';
    #?pugs 2 skip "need previous statement"
    is_deeply $a3.array, ['a', 'b', 'c'], 'array on original is updated';
    is_deeply $a4.array, ['a', 'b', 'c'], 'array on copy is updated';

    my $b3 = HshTest.new(hash=>{'a' => 'b'});
    my $b4 = $b3.clone;
    is_deeply $b3.hash, {'a' => 'b'}, 'original hash attr sanity test';
    is_deeply $b4.hash, {'a' => 'b'}, 'cloned hash attr sanity test';
    $b3.hash{'c'} = 'd';
    is_deeply $b3.hash, {'a' => 'b', 'c' => 'd'}, 'hash on original is updated';
    is_deeply $b4.hash, {'a' => 'b', 'c' => 'd'}, 'hash on copy is updated';
}

# test cloning of custom class objects
{
    my class LeObject { 
        has $.identifier; 
        has @.arr; 
        has %.hsh; 
    }

    my class LeContainer { has LeObject $.obj; }

    my $cont = LeContainer.new(obj=>LeObject.new(identifier=>'1234', :arr<a b c>, :hsh{'x'=>'y'}));
    my $cont_clone_diff = $cont.clone(obj=>LeObject.new(identifier=>'4567', :arr<d e f>, :hsh{'z'=>'a'}));
    my $cont_clone_same = $cont.clone;

    # cont_clone_diff should contain a new value, altering its contained values should not alter the original
    is_deeply $cont_clone_diff.obj.arr, ['d', 'e', 'f'], 'cloned object sanity';
    is_deeply $cont.obj.arr, ['a', 'b', 'c'], 'original object is untouched';

    # change the cloned objects contained object, the original should be intact afterwards
    #?pugs emit # can't modify constant item
    $cont_clone_diff.obj.arr = 'g', 'h', 'i';
    #?pugs 2 skip "need previous statement"
    is_deeply $cont_clone_diff.obj.arr, ['g', 'h', 'i'], 'cloned object sanity';
    is_deeply $cont.obj.arr, ['a', 'b', 'c'], 'original object is untouched';

    # change attributes on contained object should change clones if a new object was not assigned
    is_deeply $cont_clone_same.obj.arr, ['a', 'b', 'c'], 'cloned object has identical value';
    is_deeply $cont.obj.arr, ['a', 'b', 'c'], 'original object sanity test';
   
    #?pugs emit # can't modify constant item
    $cont.obj.arr = 'j', 'k', 'l';
    #?pugs 2 skip "need previous statement"
    is_deeply $cont_clone_same.obj.arr, ['j', 'k', 'l'], 'cloned object has new value';
    is_deeply $cont.obj.arr, ['j', 'k', 'l'], 'original object has new value';
}

# vim: ft=perl6
