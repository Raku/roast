use v6;
use Test;

plan 36;

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
throws-like { @arr.plan(1) }, X::IllegalOnFixedDimensionArray, operation => 'plan';
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
ok 'a' le @arr.pick le 'd', '.roll is over leaves';
is @arr.rotor(2 => -1), <a b c d>.rotor(2 => -1), '.rotor is over leaves';
is @arr.join(','), 'a,b,c,d', '.join is over leaves';

is @arr.gist, '[[a b] [c d]]', '.gist represents structure';
is @arr.perl, 'Array.new(:shape(2, 2), ["a", "b"], ["c", "d"])',
    '.perl retains structure';
