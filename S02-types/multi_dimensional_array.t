use v6;
use Test;

=begin pod

Multi-Dimensional Arrays

=end pod

plan 58;

# multi-dimensional array
# L<S09/Multidimensional arrays/Perl 6 arrays are not restricted to being one-dimensional>

# real multi-dimensional arrays
#?rakudo skip 'multi-dim sized arrays NYI'
{
    my @md[2;2];
    @md[0;0] = 0;
    @md[0;1] = 2;
    @md[1;0] = 4;
    @md[1;1] = 6;
    is(@md[0;0], 0, 'accessing an array as [0;0] works (1)');
    is(@md[0;1], 2, 'accessing an array as [0;0] works (2)');
    is(@md[1;0], 4, 'accessing an array as [0;0] works (3)');
    is(@md[1;1], 6, 'accessing an array as [0;0] works (4)');
    dies_ok({@md[1;2] = 5}, 'setting a multi-d array beyond boundaries fails');

    is(@md.elems, 4, '.elems works on multidimensional array');
}

#?rakudo skip 'multi-dim sized arrays NYI'
{
    my @md[*;*;2];
    @md[0;0;0] = 'foo';
    @md[9;9;1] = 'bar';
    is(@md[0;0;0], 'foo', 'accessing a partially bounded array works (1)');
    is(@md[9;9;1], 'bar', 'accessing a partially bounded array works (2)');
    dies_ok({@md[0;0;2] = 9}, 'setting a partially bounded multi-d array beyond boundaries fails');

    is(@md.elems, 2, '.elems works on partially bounded multi-d array');
}

my $multi1 = [1, ['foo', 'bar', 'baz'], 5];
is(+$multi1, 3, 'the multi1 has 3 elements');
is($multi1[0], 1, 'got the right value at multi1 index 0');

{
    my $array = $multi1[1];
    is(+$array, 3, 'multi1[1] has 3 elements');
    is(+$multi1[1], 3, '+$multi1[1] works')
}

isa_ok($multi1[1], List);

# multi-dimensional array slices
# L<S09/"Subscript and slice notation"/index value to each slice>

is($multi1[1;0], 'foo', 'got the right value at multi1 index 1,0');
is($multi1[1;1], 'bar', 'got the right value at multi1 index 1,1');
is($multi1[1;2], 'baz', 'got the right value at multi1 index 1,2');

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
isa_ok($multi2[0], Parcel);

# slice

is($multi2[0;0], 1, 'got the right value at multi2 index 0,0');
is($multi2[0;1], 2, 'got the right value at multi2 index 0,1');
is($multi2[0;2], 3, 'got the right value at multi2 index 0,2');

# normal

is($multi2[0][0], 1, 'got the right value at multi2 index 0,0');
is($multi2[0][1], 2, 'got the right value at multi2 index 0,1');
is($multi2[0][2], 3, 'got the right value at multi2 index 0,2');


{
    my $array = $multi2[1];
    is(+$array, 3, 'multi2[1] has 3 elements');
    is(+$multi2[1], 3, '+$multi2[1] works');
}
isa_ok($multi2[1], List);

# slice

is($multi2[1;0], 4, 'got the right value at multi2 index 1,0');
is($multi2[1;1], 5, 'got the right value at multi2 index 1,1');
is($multi2[1;2], 6, 'got the right value at multi2 index 1,2');

# normal

is($multi2[1][0], 4, 'got the right value at multi2 index 1,0');
is($multi2[1][1], 5, 'got the right value at multi2 index 1,1');
is($multi2[1][2], 6, 'got the right value at multi2 index 1,2');

# explicit multi-slice

is($multi2[0,1;0], (1, 4), 'got the right values at multi2 index {0,1},0');
is($multi2[0,1;1], (2, 5), 'got the right values at multi2 index {0,1},1');
is($multi2[0,1;2], (3, 6), 'got the right values at multi2 index {0,1},2');

# whatever multi-slice

is($multi2[*;0], (1, 4), 'got the right values at multi2 index *,0');
is($multi2[*;1], (2, 5), 'got the right values at multi2 index *,1');
is($multi2[*;2], (3, 6), 'got the right values at multi2 index *,2');

my @multi3 =
    [
        [ <cats fuzzy-cats angry-cats> ],
        [ <dogs wrinkly-dogs growly-dogs> ],
        [ <squirrels squirrels angry-squirrels> ]
    ],
    [
        [ <cars SUVs tanks> ],
        [ <boats freighters aircraft-carriers> ],
        [ <planes satellites falcon-9s> ]
    ];

is @multi3[1; 0,1,2; 1], (<SUVs freighters satellites>), '[1 ; 0,1,2 ; 2]';
is @multi3[1; *;     1], (<SUVs freighters satellites>), '[1 ; * ; 2]';

is @multi3[0,1; 2; 2], (<angry-squirrels falcon-9s>), '[0,1 ; 2 ; 2]';
is @multi3[1; 0,2; 1], (<SUVs satellites>),           '[1 ; 0,2 ; 1]';
is @multi3[1; 2; 1,2], (<satellites falcon-9s>),      '[1 ; 2 ; 1,2]';
is @multi3[0,1; 0,2; 1,2], (<fuzzy-cats angry-cats squirrels angry-squirrels SUVs tanks satellites falcon-9s>), '[0,1 ; 0,2 ; 1,2]';

ok (@multi3[0;*;1] = <cute-cats cute-dogs cute-squirrels ignored-value>), 'can assign to multi-dim slice';
#?rakudo todo 'Multi-dimensional slice assignment'
is @multi3[0;*;1], (<cute-cats cute-dogs cute-squirrels>), 'overall assignment worked';
is @multi3[0;0;1], (<cute-cats>),      'assigned the right thing to [0;0;1]';
#?rakudo 2 todo 'Multi-dimensional slice assignment'
is @multi3[0;1;1], (<cute-dogs>),      'assigned the right thing to [0;1;1]';
is @multi3[0;2;1], (<cute-squirrels>), 'assigned the right thing to [0;2;1]';

# vim: ft=perl6
