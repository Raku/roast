use v6;
use Test;

plan 80;

# Object array
{
    my @arr := Array.new(:shape(2;2));
    
    is @arr.shape, (2;2), 'shape is set on array';
    is @arr.elems, 2, 'elems is size of first dimensions';
    
    ok @arr.eager === @arr, 'eager is identity on a shaped array';
    lives-ok { @arr.sink }, 'sink lives on a shaped array';
    is @arr.is-lazy, False, 'shaped array knows it is not lazy';
    
    throws-like { @arr.push(1) }, X::IllegalOnFixedDimensionArray, operation => 'push';
    throws-like { @arr.append(1) }, X::IllegalOnFixedDimensionArray, operation => 'append';
    throws-like { @arr.pop() }, X::IllegalOnFixedDimensionArray, operation => 'pop';
    throws-like { @arr.unshift(1) }, X::IllegalOnFixedDimensionArray, operation => 'unshift';
    throws-like { @arr.prepend(1) }, X::IllegalOnFixedDimensionArray, operation => 'prepend';
    throws-like { @arr.shift() }, X::IllegalOnFixedDimensionArray, operation => 'shift';
    throws-like { @arr.splice(1) }, X::IllegalOnFixedDimensionArray, operation => 'splice';
    throws-like { @arr.reverse }, X::IllegalOnFixedDimensionArray, operation => 'reverse';
    throws-like { @arr.rotate(1) }, X::IllegalOnFixedDimensionArray, operation => 'rotate';
    
    @arr[0;0] = 'a';
    @arr[0;1] = 'b';
    @arr[1;0] = 'c';
    @arr[1;1] = 'd';
    is @arr.keys, ((0,0), (0, 1), (1, 0), (1, 1)), '.keys on 2-dim gives list of lists of indices';
    is @arr.values, <a b c d>, '.values on 2x2 array gives 4 leaf values';
    is @arr.kv, ((0, 0), 'a', (0, 1), 'b', (1, 0), 'c', (1, 1), 'd'),
        '.kv on a 2x2 array gives list with indice pairs and values interwoven';
    is @arr.pairs, ((0, 0) => 'a', (0, 1) => 'b', (1, 0) => 'c', (1, 1) => 'd'),
        '.pairs on a 2x2 array gives list of pairs mapping indice lists to values';
    is @arr.antipairs, ('a' => (0, 0), 'b' => (0, 1), 'c' => (1, 0), 'd' => (1, 1)),
        '.antipairs on a 2x2 array gives list of pairs mapping values to indice lists';
    
    is Array.new(:shape(4)).keys, (0, 1, 2, 3), '.keys on 1-dim gives list of indices';
    
    my $iter = @arr.iterator;
    is $iter.pull-one, 'a', '.iterator gives iterator walking leaves (1)';
    is $iter.pull-one, 'b', '.iterator gives iterator walking leaves (2)';
    is $iter.pull-one, 'c', '.iterator gives iterator walking leaves (3)';
    is $iter.pull-one, 'd', '.iterator gives iterator walking leaves (4)';
    ok $iter.pull-one =:= IterationEnd, '.iterator gives iterator walking leaves (5)';
    
    is @arr.flat, <a b c d>, '.flat gives the leaves';
    
    is @arr.combinations, <a b c d>.combinations, '.combinations is over leaves';
    is @arr.permutations, <a b c d>.permutations, '.permutations is over leaves';
    ok 'a' le @arr.pick le 'd', '.pick is over leaves (1)';
    is @arr.pick(*).sort, <a b c d>, '.pick is over leaves (2)';
    ok 'a' le @arr.roll le 'd', '.roll is over leaves';
    is @arr.rotor(2 => -1), <a b c d>.rotor(2 => -1), '.rotor is over leaves';
    is @arr.join(','), 'a,b,c,d', '.join is over leaves';
    is @arr.map(* x 2), <aa bb cc dd>, '.map is over leaves';
    is @arr.sort, <a b c d>, '.sort is over leaves';
    is @arr.Slip, <a b c d>.Slip, '.Slip is over leaves';
    
    is @arr.gist, '[[a b] [c d]]', '.gist represents structure';
    is @arr.perl, 'Array.new(:shape(2, 2), ["a", "b"], ["c", "d"])',
        '.perl retains structure';

    my @one-dim := Array.new(:shape(4));
    @one-dim = 1..4;
    is @one-dim.reverse, [4,3,2,1], 'can reverse a 1-dim fixed size array';
    is @one-dim.rotate(-1), [4,1,2,3], 'can rotate a 1-dim fixed size array';
}

# Native array
{
    my @arr := array[int].new(:shape(2;2));
    
    is @arr.shape, (2;2), 'shape is set on array (native)';
    is @arr.elems, 2, 'elems is size of first dimensions (native)';
    
    ok @arr.eager === @arr, 'eager is identity on a shaped array (native)';
    lives-ok { @arr.sink }, 'sink lives on a shaped array (native)';
    is @arr.is-lazy, False, 'shaped array knows it is not lazy (native)';
    
    throws-like { @arr.push(1) }, X::IllegalOnFixedDimensionArray, operation => 'push';
    throws-like { @arr.append(1) }, X::IllegalOnFixedDimensionArray, operation => 'append';
    throws-like { @arr.pop() }, X::IllegalOnFixedDimensionArray, operation => 'pop';
    throws-like { @arr.unshift(1) }, X::IllegalOnFixedDimensionArray, operation => 'unshift';
    throws-like { @arr.prepend(1) }, X::IllegalOnFixedDimensionArray, operation => 'prepend';
    throws-like { @arr.shift() }, X::IllegalOnFixedDimensionArray, operation => 'shift';
    throws-like { @arr.splice(1) }, X::IllegalOnFixedDimensionArray, operation => 'splice';
    throws-like { @arr.reverse }, X::IllegalOnFixedDimensionArray, operation => 'reverse';
    throws-like { @arr.rotate(1) }, X::IllegalOnFixedDimensionArray, operation => 'rotate';
    
    @arr[0;0] = 42;
    @arr[0;1] = 43;
    @arr[1;0] = 44;
    @arr[1;1] = 45;
    is @arr.keys, ((0,0), (0, 1), (1, 0), (1, 1)),
        '.keys on 2-dim gives list of lists of indices (native)';
    is @arr.values, (42, 43, 44, 45), '.values on 2x2 array gives 4 leaf values (native)';
    is @arr.kv, ((0, 0), 42, (0, 1), 43, (1, 0), 44, (1, 1), 45),
        '.kv on a 2x2 array gives list with indice pairs and values interwoven (native)';
    is @arr.pairs, ((0, 0) => 42, (0, 1) => 43, (1, 0) => 44, (1, 1) => 45),
        '.pairs on a 2x2 array gives list of pairs mapping indice lists to values (native)';
    is @arr.antipairs, (42 => (0, 0), 43 => (0, 1), 44 => (1, 0), 45 => (1, 1)),
        '.antipairs on a 2x2 array gives list of pairs mapping values to indice lists (native)';
    
    is array[int].new(:shape(4)).keys, (0, 1, 2, 3), '.keys on 1-dim gives list of indices (native)';
    
    my $iter = @arr.iterator;
    is $iter.pull-one, 42, '.iterator gives iterator walking leaves (native) (1)';
    is $iter.pull-one, 43, '.iterator gives iterator walking leaves (native) (2)';
    is $iter.pull-one, 44, '.iterator gives iterator walking leaves (native) (3)';
    is $iter.pull-one, 45, '.iterator gives iterator walking leaves (native) (4)';
    ok $iter.pull-one =:= IterationEnd, '.iterator gives iterator walking leaves (native) (5)';
    
    is @arr.flat, (42, 43, 44, 45), '.flat gives the leaves (native)';
    
    is @arr.combinations, (42, 43, 44, 45).combinations, '.combinations is over leaves (native)';
    is @arr.permutations, (42, 43, 44, 45).permutations, '.permutations is over leaves (native)';
    ok 42 <= @arr.pick <= 45, '.pick is over leaves (native) (1)';
    is @arr.pick(*).sort, (42, 43, 44, 45), '.pick is over leaves (native) (2)';
    ok 42 <= @arr.roll <= 45, '.roll is over leaves (native)';
    is @arr.rotor(2 => -1), (42, 43, 44, 45).rotor(2 => -1), '.rotor is over leaves (native)';
    is @arr.join(','), '42,43,44,45', '.join is over leaves (native)';
    is @arr.map(* + 2), (44,45,46,47), '.map is over leaves (native)';
    is @arr.sort(-*), (45,44,43,42), '.sort is over leaves (native)';
    is @arr.Slip, (42, 43, 44, 45).Slip, '.Slip is over leaves (native)';

    is @arr.gist, '[[42 43] [44 45]]', '.gist represents structure (native)';
    is @arr.perl, 'array[int].new(:shape(2, 2), [42, 43], [44, 45])',
        '.perl retains structure (native)';
}

{
    my @a[5] = ^5;
    @a = @a.rotate;
    is @a, "1 2 3 4 0", 'can we assign after a .rotate?';
    @a = @a.reverse;
    is @a, "0 4 3 2 1", 'can we assign after a .reverse?';
}
