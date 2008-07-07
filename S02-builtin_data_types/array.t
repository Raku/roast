use v6;

use Test;

plan 70;

#L<S02/Mutable types/Array>

# array of strings

my @array1 = ("foo", "bar", "baz");
isa_ok(@array1, Array);

is(+@array1, 3, 'the array1 has 3 elements');
is(@array1[0], 'foo', 'got the right value at array1 index 0');
is(@array1[1], 'bar', 'got the right value at array1 index 1');
is(@array1[2], 'baz', 'got the right value at array1 index 2');


#?rakudo skip ".[] instead of [] as postcircumfix"
is(@array1.[0], 'foo', 'got the right value at array1 index 0 using the . notation');


# array with strings, numbers and undef
my @array2 = ("test", 1, undef);
{
    isa_ok(@array2, Array);

    is(+@array2, 3, 'the array2 has 3 elements');
    is(@array2[0], 'test', 'got the right value at array2 index 0');
    is(@array2[1], 1,      'got the right value at array2 index 1');
    is(@array2[2], undef,  'got the right value at array2 index 2');
}

# combine 2 arrays
{
    my @array3 = (@array1, @array2);
    isa_ok(@array3, Array);

    is(+@array3, 6, 'the array3 has 6 elements'); 
    is(@array3[0], 'foo', 'got the right value at array3 index 0'); 
    is(@array3[1], 'bar', 'got the right value at array3 index 1'); 
    is(@array3[2], 'baz', 'got the right value at array3 index 2'); 
    is(@array3[3], 'test', 'got the right value at array3 index 3'); 
    is(@array3[4], 1,      'got the right value at array3 index 4'); 
    is(@array3[5], undef,  'got the right value at array3 index 5');
}

{
    # array slice
    my @array4 = @array2[2, 1, 0];
    isa_ok(@array4, Array);

    #?rakudo todo 'list assignment'
    is(+@array4, 3, 'the array4 has 3 elements');
    is(@array4[0], undef,  'got the right value at array4 index 0');
    #?rakudo 2 todo 'list assignment'
    is(@array4[1], 1,      'got the right value at array4 index 1');
    is(@array4[2], 'test', 'got the right value at array4 index 2');
}

#?rakudo todo 'array slices and list assignment'
{
    # create new array with 2 array slices
    my @array5 = ( @array2[2, 1, 0], @array1[2, 1, 0] );
    isa_ok(@array5, Array);

    is(+@array5, 6, 'the array5 has 6 elements');
    is(@array5[0], undef,  'got the right value at array5 index 0');
    is(@array5[1], 1,      'got the right value at array5 index 1');
    is(@array5[2], 'test', 'got the right value at array5 index 2');
    is(@array5[3], 'baz',  'got the right value at array5 index 3');
    is(@array5[4], 'bar',  'got the right value at array5 index 4');
    is(@array5[5], 'foo',  'got the right value at array5 index 5');
}

#?rakudo todo 'array slices and list assignment'
{
    # create an array slice with an array (in a variable)

    my @slice = (2, 0, 1);
    my @array6 = @array1[@slice];
    isa_ok(@array6, Array);

    is(+@array6, 3, 'the array6 has 3 elements'); 
    is(@array6[0], 'baz', 'got the right value at array6 index 0'); 
    is(@array6[1], 'foo', 'got the right value at array6 index 1'); 
    is(@array6[2], 'bar', 'got the right value at array6 index 2'); 
}

#?rakudo todo 'array slices and list assignment'
{
    # create an array slice with an array constructed with ()
    my @array7 = @array1[(2, 1, 0)];
    isa_ok(@array7, Array);

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
    isa_ok(@array9, Array);
    is(+@array9, 0, "new arrays are empty");

    my @array10 = (1, 2, 3,);
    is(+@array10, 3, "trailing commas make correct array"); 
}

#?pugs skip "multi-dim arrays not implemented"
#?rakudo skip "multi-dim arrays"
{
# declare a multidimension array
    eval_lives_ok('my @multidim[0..3; 0..1]', "multidimension array");
    my @array11 is shape(2,4);

    # XXX what should that test actually do?
    ok(eval('@array11[2,0] = 12'), "push the value to a multidimension array");
}
#?rakudo 999 skip "rest not properly fudged yet"
{
    # declare the array with data type
    my Int @array;
    lives_ok { @array[0] = 23 },                   "stuffing Ints in an Int array works";
    dies_ok  { @array[1] = $*ERR }, "stuffing IO in an Int array does not work";
}

#?rakudo 999 skip "no whatever star yet"
#?pugs 999 skip "no whatever star yet"
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

# This test may seem overly simplistic, but it was actually a bug in PIL2JS, so
# why not write a test for it so other backends can benefit of it, too? :)
{
  my @arr = (0, 1, 2, 3);
  @arr[0] = "new value";
  is @arr[0], "new value", "modifying of array contents (constants) works";
}

{
  my @arr;
  lives_ok { @arr[*-1] },  "readonly accessing [*-1] of an empty array is ok (1)";
  ok !(try { @arr[*-1] }), "readonly accessing [*-1] of an empty array is ok (2)";
  dies_ok { @arr[*-1] = 42 },      "assigning to [*-1] of an empty array is fatal";
  dies_ok { @arr[*-1] := 42 },     "binding [*-1] of an empty array is fatal";
}

{
  my @arr = (23);
  lives_ok { @arr[*-2] },  "readonly accessing [*-2] of an one-elem array is ok (1)";
  ok !(try { @arr[*-2] }), "readonly accessing [*-2] of an one-elem array is ok (2)";
  dies_ok { @arr[*-2] = 42 },      "assigning to [*-2] of an one-elem array is fatal";
  dies_ok { @arr[*-2] := 42 },     "binding [*-2] of an empty array is fatal";
}

{
  my @arr = <a normal array with nothing funny>;
  my $minus_one = -1;

  # XXX should that even parse? 
  dies_ok { @arr[-1] }, "readonly accessing [-1] of normal array is fatal";
  lives_ok { @arr[ $minus_one ] }, "indirectly accessing [-1] " ~
                                   "through a variable is ok";
  dies_ok { @arr[-1] = 42 }, "assigning to [-1] of a normal array is fatal";
  dies_ok { @arr[-1] := 42 }, "binding [-1] of a normal array is fatal";
}
