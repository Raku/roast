use v6;
use Test;

=begin pod

Multi-Dimensional Arrays

=end pod

plan 31;

# multi-dimensional array

my $multi1 = [1, ['foo', 'bar', 'baz'], 5];
is(+$multi1, 3, 'the multi1 has 3 elements');
is($multi1[0], 1, 'got the right value at multi1 index 0');

{
    my $array = $multi1[1];
    is(+$array, 3, 'multi1[1] has 3 elements');
    is(+$multi1[1], 3, '+$multi1[1] works')
}

isa_ok($multi1[1], 'List');

# multi-dimensional array slices 
# L<S09/"Subscript and slice notation"/index value to each slice>

#?pugs 3 todo 'multi-dimensional indexing'
is(eval('$multi1[1;0]'), 'foo', 'got the right value at multi1 index 1,0');
is(eval('$multi1[1;1]'), 'bar', 'got the right value at multi1 index 1,1');
is(eval('$multi1[1;2]'), 'baz', 'got the right value at multi1 index 1,2');

# and the normal syntax

is($multi1[1][0], 'foo', 'got the right value at multi1 index 1,0');
is($multi1[1][1], 'bar', 'got the right value at multi1 index 1,1');
is($multi1[1][2], 'baz', 'got the right value at multi1 index 1,2');

is($multi1[2], 5, 'got the right value at multi1 index 2');

# multi-dimensional array constructed from 2 array refs

my $array_ref1 = (1, 2, 3);
my $array_ref2 = [4, 5, 6];

my $multi2 = [ $array_ref1, $array_ref2 ];
is(+$multi2, 2, 'the multi2 has 2 elements');

{
    my $array = $multi2[0];
    is(+$array, 3, 'multi2[0] has 3 elements');
    is(+$multi2[0], 3, '+$multi2[0] works');
}
isa_ok($multi2[0], 'List');

# slice

#?pugs 3 todo ''
is(eval('$multi2[0;0]'), 1, 'got the right value at multi2 index 0,0');
is(eval('$multi2[0;1]'), 2, 'got the right value at multi2 index 0,1');
is(eval('$multi2[0;2]'), 3, 'got the right value at multi2 index 0,2');

# normal 

is($multi2[0][0], 1, 'got the right value at multi2 index 0,0');
is($multi2[0][1], 2, 'got the right value at multi2 index 0,1');
is($multi2[0][2], 3, 'got the right value at multi2 index 0,2');


{
    my $array = $multi2[1];
    is(+$array, 3, 'multi2[1] has 3 elements');
    is(+$multi2[1], 3, '+$multi2[1] works');
}
isa_ok($multi2[1], 'List');

# slice 

#?pugs 3 todo ''
is(eval('$multi2[1;0]'), 4, 'got the right value at multi2 index 1,0');
is(eval('$multi2[1;1]'), 5, 'got the right value at multi2 index 1,1');
is(eval('$multi2[1;2]'), 6, 'got the right value at multi2 index 1,2');

# normal

is($multi2[1][0], 4, 'got the right value at multi2 index 1,0');
is($multi2[1][1], 5, 'got the right value at multi2 index 1,1');
is($multi2[1][2], 6, 'got the right value at multi2 index 1,2');
