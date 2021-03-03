use v6;
use Test;
use lib $?FILE.IO.parent(2).add: 'packages/Test-Helpers';
use Test::Util;

plan 107;

#L<S02/Mutable types/Array>

{
    my $i = 0;
    $i++ for 1, 2, 3;
    is $i, 3, 'for 1, 2, 3 does three iterations';
}


{
    my $i = 0;
    $i++ for flat 0, (1, 2, 3).item;
    is $i, 2, 'for 0, (1, 2, 3).item does two iteraions';

    $i = 0;
    $i++ for flat 0, $(1, 2, 3);
    is $i, 2, 'for flat 0, $(1, 2, 3) does two iterations';
}

{
    my $i = 0;
    $i++ for flat 0, $[1, 2, 3];
    is $i, 2, 'for flat 0, $[1, 2, 3] does two iterations';
}

# uninitialized array variables should work too...
{
    my @a;
    is EVAL(@a.raku).elems, 0, '@a.raku on uninitialized variable';
}

# array of strings

my @array1 = ("foo", "bar", "baz");
isa-ok(@array1, Array);

is(+@array1, 3, 'the array1 has 3 elements');
is(@array1[0], 'foo', 'got the right value at array1 index 0');
is(@array1[1], 'bar', 'got the right value at array1 index 1');
is(@array1[2], 'baz', 'got the right value at array1 index 2');


is(@array1.[0], 'foo', 'got the right value at array1 index 0 using the . notation');


# array with strings, numbers and undef
my @array2 = ("test", 1, Mu);

{
    isa-ok(@array2, Array);

    is(+@array2, 3, 'the array2 has 3 elements');
    is(@array2[0], 'test', 'got the right value at array2 index 0');
    is(@array2[1], 1,      'got the right value at array2 index 1');
    ok(!@array2[2].defined,  'got the right value at array2 index 2');
}

# combine 2 arrays
{
    my @array3 = flat @array1, @array2;
    isa-ok(@array3, Array);

    is(+@array3, 6, 'the array3 has 6 elements');
    is(@array3[0], 'foo', 'got the right value at array3 index 0');
    is(@array3[1], 'bar', 'got the right value at array3 index 1');
    is(@array3[2], 'baz', 'got the right value at array3 index 2');
    is(@array3[3], 'test', 'got the right value at array3 index 3');
    is(@array3[4], 1,      'got the right value at array3 index 4');
    ok(!@array3[5].defined,'got the right value at array3 index 5');
}

{
    # array slice
    my @array4 = @array2[2, 1, 0];
    isa-ok(@array4, Array);

    is(+@array4, 3, 'the array4 has 3 elements');
    ok(!defined(@array4[0]), 'got the right value at array4 index 0');
    is(@array4[1], 1,      'got the right value at array4 index 1');
    is(@array4[2], 'test', 'got the right value at array4 index 2');
}

{
    # create new array with 2 array slices
    my @array5 = flat @array2[2, 1, 0], @array1[2, 1, 0];
    isa-ok(@array5, Array);

    is(+@array5, 6, 'the array5 has 6 elements');
    ok(!defined(@array5[0]),  'got the right value at array5 index 0');
    is(@array5[1], 1,      'got the right value at array5 index 1');
    is(@array5[2], 'test', 'got the right value at array5 index 2');
    is(@array5[3], 'baz',  'got the right value at array5 index 3');
    is(@array5[4], 'bar',  'got the right value at array5 index 4');
    is(@array5[5], 'foo',  'got the right value at array5 index 5');
}

{
    # create an array slice with an array (in a variable)

    my @slice = (2, 0, 1);
    my @array6 = @array1[@slice];
    isa-ok(@array6, Array);

    is(+@array6, 3, 'the array6 has 3 elements');
    is(@array6[0], 'baz', 'got the right value at array6 index 0');
    is(@array6[1], 'foo', 'got the right value at array6 index 1');
    is(@array6[2], 'bar', 'got the right value at array6 index 2');
}

{
    # create an array slice with an array constructed with ()
    my @array7 = @array1[(2, 1, 0)];
    isa-ok(@array7, Array);

    is(+@array7, 3, 'the array7 has 3 elements');
    is(@array7[0], 'baz', 'got the right value at array7 index 0');
    is(@array7[1], 'bar', 'got the right value at array7 index 1');
    is(@array7[2], 'foo', 'got the right value at array7 index 2');
}

{
    # odd slices
    my $result1 = (1, 2, 3, 4)[1];
    is($result1, 2, 'got the right value from the slice');

    my $result2 = [1, 2, 3, 4][2];
    is($result2, 3, 'got the right value from the slice');
}

# swap two elements test moved to t/op/assign.t

# empty arrays
{
    my @array9;
    isa-ok(@array9, Array);
    is(+@array9, 0, "new arrays are empty");

    my @array10 = (1, 2, 3,);
    is(+@array10, 3, "trailing commas make correct array");
}

# https://github.com/Raku/old-issue-tracker/issues/3830
#?rakudo skip "multi-dim arrays NYI"
{
# declare a multidimension array
    throws-like { EVAL 'my @multidim[0..3; 0..1]' },
      Exception, # XXX fix when block no longer skipped
      "multidimension array";
    my @array11 is shape(2,4);

    # XXX what should that test actually do?
    ok EVAL('@array11[2;0] = 12'), "push the value to a multidimension array";
}

{
    # declare the array with data type
    my Int @array;
    lives-ok { @array[0] = 23 },
      "stuffing Ints in an Int array works";
    throws-like { @array[1] = $*ERR },
      X::TypeCheck::Assignment,
      "stuffing IO in an Int array does not work";
}

{
    my @array12 = ('a', 'b', 'c', 'e');

    # indexing from the end
    is @array12[*-1],'e', "indexing from the end [*-1]";

    # end index range
    is ~@array12[*-4 .. *-2], 'a b c', "end indices [*-4 .. *-2]";

    # end index as lvalue
    @array12[*-1]   = 'd';
    is @array12[*-1], 'd', "assigns to the correct end slice index";
    is ~@array12,'a b c d', "assignment to end index correctly alters the array";
}

{
    my @array13 = ('a', 'b', 'c', 'd');
    # end index range as lvalue
    @array13[*-4 .. *-1]   = ('d', 'c', 'b', 'a'); # ('a'..'d').reverse
    is ~@array13, 'd c b a', "end range as lvalue";

    #hat trick
    my @array14 = ('a', 'b', 'c', 'd');
    my @b = 0..3;
    ((@b[*-3,*-2,*-1,*-4] = @array14)= @array14[*-1,*-2,*-3,*-4]);

    is ~@b,
        'a d c b',
        "hat trick:
        assign to a end-indexed slice array from array
        lvalue in assignment is then lvalue to end-indexed slice as rvalue";
}

# https://github.com/Raku/old-issue-tracker/issues/1964
{
    is ~<a b>.[^*], 'a b', 'Infinite range subscript as rvalues clip to existing elems';
    is ~<a b>.[lazy ^10], 'a b', 'Lazy range subscript as rvalues clip to existing elems';
}

# This test may seem overly simplistic, but it was actually a bug in PIL2JS, so
# why not write a test for it so other backends can benefit of it, too? :)
{
  my @arr = (0, 1, 2, 3);
  @arr[0] = "new value";
  is @arr[0], "new value", "modifying of array contents (constants) works";
}

{
  my @arr;
  # test that @arr[+-1] produces a Failure, which is thrown when a method
  # other than .defined is called on it.
  lives-ok { @arr[*-1].defined }, "readonly accessing [*-1] of an empty array is not fatal";

  # https://github.com/Raku/old-issue-tracker/issues/2681
  throws-like { @arr[*-1].flurb },
    X::OutOfRange,
    "readonly accessing [*-1] of an empty array throws X::OutOfRange";
  throws-like { @arr[*-1] = 42 },
    X::OutOfRange,
    "assigning to [*-1] of an empty array throws X::OutOfRange";
  throws-like { @arr[*-1] := 42 },
    X::Bind::Slice,
    "binding [*-1] of an empty array throws X::Bind::Slice";
}

{
  my @arr = (23);
  ok !(try { @arr[*-2] }), "readonly accessing [*-2] of an one-elem array is not fatal";
  throws-like { @arr[*-2] },
    X::OutOfRange,
    "readonly accessing [*-2] of an one-elem array throws X::OutOfRange";
  throws-like { @arr[*-2] = 42 },
    X::OutOfRange,
    "assigning to [*-2] of an one-elem array throws X::OutOfRange";
  throws-like { @arr[*-2] := 42 },
    X::Bind::Slice,
    "binding [*-2] of an one-elem array throws X::Bind::Slice";
}

{
  my @arr = <a normal array with nothing funny>;
  my $minus_one = -1;

  throws-like '@arr[-2]',
    X::Obsolete,
    message => /^ 'Unsupported use of a negative -2 subscript to index from the end'/,
    "readonly accessing [-2] of normal array throws X::Obsolete and is fatal";
  throws-like { @arr[ $minus_one ] },
    X::OutOfRange,
    "indirectly accessing [-1] through a variable throws X::OutOfRange";
  throws-like { @arr[$minus_one] = 42 },
    X::OutOfRange,
    "assigning to [-1] of a normal array throws X::OutOfRange";
  #?rakudo todo 'bind_pos NYI'
  throws-like { @arr[$minus_one] := 42 },
    X::Subscript::Negative,
    "binding [-1] of a normal array throws X::Subscript::Negative";
}

# https://github.com/Raku/old-issue-tracker/issues/1574
{
    is [][].elems, 0, '[][] returns empty list/array';
}

# https://github.com/Raku/old-issue-tracker/issues/282
# https://github.com/Raku/old-issue-tracker/issues/227
# by current group understanding of #perl6, postcircumfix:<[ ]> is actually
# defined in Any, so that .[0] is the identity operation for non-Positional
# types
{
    is 1[0], 1, '.[0] is identity operation for scalars (Int)';
    is 'abc'[0], 'abc', '.[0] is identity operation for scalars (Str)';
    nok 'abc'[1].defined, '.[1] on a scalar is not defined';
    isa-ok 1[1],  Failure, 'indexing a scalar with other than 0 returns a Failure';
    throws-like-any { Mu.[0] },
      [X::Multi::NoMatch, X::TypeCheck::Binding::Parameter],
      'but Mu has no .[]';
}

# https://github.com/Raku/old-issue-tracker/issues/2034
{
    my @a = <1 2 3>;
    is @a[*], <1 2 3> , 'using * to access all array elements works';
    is @a[], <1 2 3>, 'using [] to listify all array elements works';

    my $a = (1,2,3);
    is ($a[] X~ 'a'), '1a 2a 3a', 'using [] decontainerizes';
}

# https://github.com/Raku/old-issue-tracker/issues/1591
{
    my @a = <1 2 3>;
    isa-ok +@a, Int, "Numifying an Array yields an Int";
}

# https://github.com/Raku/old-issue-tracker/issues/1786
{
    my @a = 0, 1, 2;
    for @a {
        $_++ if $_;
    }
    is ~@a, '0 2 3', "modifier form of 'if' within 'for' loop works";

    my @b = 0, 1, 2;
    for @b {
        if $_ {
            $_++;
        }
    }
    is ~@b, '0 2 3', "non-modifier form of 'if' within 'for' loop also works"
}

# https://github.com/Raku/old-issue-tracker/issues/2454
# Array.hash used to eat up the array in some early version of rakudo/nom
{
    my @a = a => 1, b => 2;
    my %h = @a.hash;
    is %h.elems, 2, 'Array.hash created a sensible hash';
    is @a.elems, 2, '... and did not consume itself in the process';
}

# https://github.com/Raku/old-issue-tracker/issues/2261
{
    my @a = <a b c>;
    @a[0 ..^ *-1] >>~=>> "x";
    is @a.join(','), 'ax,bx,c', '0..^ *-1 works as an array index';
}

{
    is Array(1,2,3).WHAT.gist, '(Array)', 'Array(...) makes an Array';
    ok Array(1,2,3) eqv [1,2,3],          'Array(1,2,3) makes correct array';
}

# https://github.com/Raku/old-issue-tracker/issues/520
#?rakudo todo "regression to AdHoc exception"
{
    throws-like { EVAL 'my @a = 1..*; @a[Inf] = "dog"' },
      X::Item,
      index => Inf, aggregate => Array;
    throws-like { EVAL 'my @a = 1..*; @a[NaN] = "cat"' },
      X::Item,
      index => NaN, aggregate => Array;
}

{
    my Str $foo;
    my @bar = $foo;
    my $res;
    lives-ok { $res = ~@bar },
      '~@bar containing a Str type object lives';
    is $res, "", '~@bar containing a Str type object gives empty string';
}

{
    my @a = ^10;
    is @a.sum, 45, 'simple integer sum in array works';
    my @b;
    @b[9] = 10;
    is @b.sum, 10, 'handle sparse arrays correctly';
}

# https://github.com/Raku/old-issue-tracker/issues/5269
{
    my %foo;
    %foo<bar>[*-0] = 42;

    is-deeply %foo<bar>, [42],
        '[*-0] index references correct element when autovivifying';
}

# https://github.com/rakudo/rakudo/commit/51b0aba8e8
subtest 'flat propagates .is-lazy' => {
    plan 4;
    is-deeply (42 xx *).flat.is-lazy, True,  'method, True';
    is-deeply (42 xx 1).flat.is-lazy, False, 'method, False';

    is-deeply flat(42 xx *) .is-lazy, True,  'sub, True';
    is-deeply flat(42 xx 1) .is-lazy, False, 'sub, False';
}

subtest '.gist shows only first 100 els' => {
    plan 5;
    sub make-gist ($a, $extras?) {
        "[$a" ~ (" $extras" with $extras) ~ ']'
    }

    is  [<1 2 3>].gist, '[1 2 3]', 'gist gives useful value';
    is-deeply [1..100] .gist, make-gist([1..100]       ), '100 els';
    is-deeply [1..101] .gist, make-gist([1..100], '...'), '101 els';
    is-deeply [1..102] .gist, make-gist([1..100], '...'), '102 els';
    is-deeply [1..1000].gist, make-gist([1..100], '...'), '1000 els';
}

# https://github.com/rakudo/rakudo/pull/1053
subtest 'reification of zen and whatever slices' => {
    plan 2;
    #?rakudo.jvm skip 'code works as expected (does not die) if run standalone; R#1571'
    lives-ok { my $s = (gather die)[]  }, 'zen slice does not reify';
    my $s = (gather pass 'whatever slice does reify')[*];
}

# https://github.com/rakudo/rakudo/issues/1832
subtest 'no funny business in assignment' => {
    plan 9;
    my package R1832 { our @bar = 42, |0 };
    is @::R1832::('bar')[^1], 42, 'can reference values in an `our` var';

    my $a1-marker = 0;
    my @a1 = |(gather { $a1-marker++ }), 1, |(lazy gather { $a1-marker++ });
    is $a1-marker, 1, 'we reified only non-lazy parts on assignment';
    @a1.eager;
    is $a1-marker, 2, 'eagerizing the array, we reified the rest of the parts';

    my @a2; for ^5 { push @a2, my @o = Empty, $_ };
    is-deeply @a2, [[0], [1], [2], [3], [4]], 'pushed values get updated';

    my @a3 is default(42) = 1, |2, Nil, 3;
    is-deeply @a3, [1, 2, 42, 3], 'is default work on Arrays';

    is-deeply ( my @a4 = 1, |2), [1, 2], 'can use return value of assignment (1)';
    is-deeply (+my @a5 = 1, |2), 2,      'can use return value of assignment (2)';
    is-deeply (my @a6 is default(42) = 1, Nil, |2), [1, 42, 2],
        'can use return value of assignment (3)';

    # https://github.com/rakudo/rakudo/issues/1843
    my @res;
    sub init() { my @a = 1, (init() unless $++); @res.push: @a; 42 };
    init();
    is-deeply @res, [[1], [1, 42]], 'works fine when re-entrant';
}

{
    is Array.of.^name, 'Mu', 'does Array type object return proper type';
    is Array.new.of.^name, 'Mu', 'does Array object return proper type';
}

# vim: expandtab shiftwidth=4
