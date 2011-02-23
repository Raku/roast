use v6;

use Test;

plan 33;

{
    my @array = 11 .. 15;

    is(@array.elems,     5, 'array has 5 elements');
    is(@array[0],       11, 'first value is 11');
    is(@array[*-1],     15, 'last value is 15');
    # 3[0] etc. should *not* work, but (3,)[0] should.
    # That's similar as with the .kv issue we've had: 3.kv should fail, but
    # (3,).kv should work.
}

{
    my @array = [ 11 .. 15 ];

    is(@array[0].elems,  5, 'arrayref has 5 elements');
    is(@array[0][0],    11, 'first element in arrayref is 11');

    is(@array[0][*-1],  15, 'last element in arrayref is 15');
}

{
    my @array = [ 11 .. 15 ], [ 21 .. 25 ], [ 31 .. 35 ];

    is(@array[0].elems,  5, 'first arrayref has 5 elements');
    is(@array[1].elems,  5, 'second arrayref has 5 elements');
    is(@array[0][0],    11, 'first element in first arrayref is 11');
    is(@array[0][*-1],  15, 'last element in first arrayref is 15');
    is(@array[1][0],    21, 'first element in second arrayref is 21');
    is(@array[1][*-1],  25, 'last element in second arrayref is 25');
    is(@array[*-1][0],  31, 'first element in last arrayref is 31');
    is(@array[*-1][*-1], 35, 'last element in last arrayref is 35');
}

{
    my %hash = (k1 => [ 11 .. 15 ]);

    is(%hash<k1>.elems,  5, 'k1 has 5 elements');
    is(%hash<k1>[0],    11, 'first element in k1 is 11');
    is(%hash<k1>[*-1],  15, 'last element in k1 is 15');
    nok(%hash<12>.defined,  'nothing at key "12"');
}

{
    my %hash = (k1 => [ 11 .. 15 ], k2 => [ 21 .. 25 ]);

    is(%hash<k1>.elems,  5, 'k1 has 5 elements');
    is(%hash<k2>.elems,  5, 'k2 has 5 elements');
    is(%hash<k1>[0],    11, 'first element in k1 is 11');
    is(%hash<k1>[*-1],  15, 'last element in k1 is 15');
    is(%hash<k2>[0],    21, 'first element in k1 is 21');
    is(%hash<k2>[*-1],  25, 'last element in k1 is 25');
    nok(%hash<12>.defined, 'nothing at key "12"');
    nok(%hash<22>.defined, 'nothing at key "22"');
}

{
    my @a;
    push @a, 1;
    is(@a.elems, 1, 'Simple push works');
    push @a, [];
    is(@a.elems, 2, 'Arrayref literal not flattened');
    push @a, {};
    is(@a.elems, 3, 'Hashref literal not flattened');
    my @foo;
    push @a, \@foo;
    is(@a.elems, 4, 'Arrayref not flattened');
    my %foo;
    push @a, \%foo;
    is(@a.elems, 5, 'Hashref not flattened');
    push @a, @foo;
    is(@a.elems, 5, 'Array flattened');
    push @a, %foo;
    is(@a.elems, 5, 'Hash flattened');
}

# vim: ft=perl6
