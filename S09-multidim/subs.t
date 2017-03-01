use v6.c;
use Test;

plan 44;

# Object array
{
    my @arr := Array.new(:shape(2;2));

    is elems(@arr), 2, 'elems is size of first dimensions';
    
    ok (eager @arr) === @arr, 'eager is identity on a shaped array';
    lives-ok { sink @arr }, 'sink lives on a shaped array';
    
    throws-like { push @arr, 1 }, X::IllegalOnFixedDimensionArray, operation => 'push';
    throws-like { append @arr, 1 }, X::IllegalOnFixedDimensionArray, operation => 'append';
    throws-like { pop @arr }, X::IllegalOnFixedDimensionArray, operation => 'pop';
    throws-like { unshift @arr, 1 }, X::IllegalOnFixedDimensionArray, operation => 'unshift';
    throws-like { prepend @arr, 1 }, X::IllegalOnFixedDimensionArray, operation => 'prepend';
    throws-like { shift @arr }, X::IllegalOnFixedDimensionArray, operation => 'shift';
    throws-like { splice @arr, 1 }, X::IllegalOnFixedDimensionArray, operation => 'splice';
    throws-like { reverse @arr }, X::IllegalOnFixedDimensionArray, operation => 'reverse';
    throws-like { rotate @arr, 1 }, X::IllegalOnFixedDimensionArray, operation => 'rotate';
    
    @arr[0;0] = 'a';
    @arr[0;1] = 'b';
    @arr[1;0] = 'c';
    @arr[1;1] = 'd';
    is keys(@arr), ((0,0), (0, 1), (1, 0), (1, 1)), '.keys on 2-dim gives list of lists of indices';
    is values(@arr), <a b c d>, '.values on 2x2 array gives 4 leaf values';
    is kv(@arr), ((0, 0), 'a', (0, 1), 'b', (1, 0), 'c', (1, 1), 'd'),
        '.kv on a 2x2 array gives list with indice pairs and values interwoven';
    is pairs(@arr), ((0, 0) => 'a', (0, 1) => 'b', (1, 0) => 'c', (1, 1) => 'd'),
        '.pairs on a 2x2 array gives list of pairs mapping indice lists to values';
    
    is keys(Array.new(:shape(4))), (0, 1, 2, 3), '.keys on 1-dim gives list of indices';
    
    is flat(@arr), <a b c d>, '.flat gives the leaves';
    is join(',', @arr), 'a,b,c,d', '.join is over leaves';
    is map(* x 2, @arr), <aa bb cc dd>, '.map is over leaves';
    is sort(@arr), <a b c d>, '.sort is over leaves';

    my @one-dim := Array.new(:shape(4));
    @one-dim = 1..4;
    is reverse(@one-dim), [4,3,2,1], 'can reverse a 1-dim fixed size array';
    is rotate(@one-dim, -1), [4,1,2,3], 'can rotate a 1-dim fixed size array';
}

# Native array
{
    my @arr := array[int].new(:shape(2;2));
    
    is elems(@arr), 2, 'elems is size of first dimensions (native)';
    
    ok (eager @arr) === @arr, 'eager is identity on a shaped array (native)';
    lives-ok { sink @arr }, 'sink lives on a shaped array (native)';
    
    throws-like { push @arr, 1 }, X::IllegalOnFixedDimensionArray, operation => 'push';
    throws-like { append @arr, 1 }, X::IllegalOnFixedDimensionArray, operation => 'append';
    throws-like { pop @arr }, X::IllegalOnFixedDimensionArray, operation => 'pop';
    throws-like { unshift @arr, 1 }, X::IllegalOnFixedDimensionArray, operation => 'unshift';
    throws-like { prepend @arr, 1 }, X::IllegalOnFixedDimensionArray, operation => 'prepend';
    throws-like { shift @arr }, X::IllegalOnFixedDimensionArray, operation => 'shift';
    throws-like { splice @arr, 1 }, X::IllegalOnFixedDimensionArray, operation => 'splice';
    throws-like { reverse @arr }, X::IllegalOnFixedDimensionArray, operation => 'reverse';
    throws-like { rotate @arr, 1 }, X::IllegalOnFixedDimensionArray, operation => 'rotate';

    @arr[0;0] = 42;
    @arr[0;1] = 43;
    @arr[1;0] = 44;
    @arr[1;1] = 45;
    is keys(@arr), ((0,0), (0, 1), (1, 0), (1, 1)),
        '.keys on 2-dim gives list of lists of indices (native)';
    is values(@arr), (42, 43, 44, 45), '.values on 2x2 array gives 4 leaf values (native)';
    is kv(@arr), ((0, 0), 42, (0, 1), 43, (1, 0), 44, (1, 1), 45),
        '.kv on a 2x2 array gives list with indice pairs and values interwoven (native)';
    is pairs(@arr), ((0, 0) => 42, (0, 1) => 43, (1, 0) => 44, (1, 1) => 45),
        '.pairs on a 2x2 array gives list of pairs mapping indice lists to values (native)';
    
    is keys(array[int].new(:shape(4))), (0, 1, 2, 3), '.keys on 1-dim gives list of indices (native)';

    is flat(@arr), (42, 43, 44, 45), '.flat gives the leaves (native)';
    is join(',', @arr), '42,43,44,45', '.join is over leaves (native)';
    is map(* + 2, @arr), (44,45,46,47), '.map is over leaves (native)';
    is sort(-*, @arr), (45,44,43,42), '.sort is over leaves (native)';
}
