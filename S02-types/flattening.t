use v6.c;

use Test;

plan 46;

{
    my @array = 11 .. 15;

    is(@array.elems,     5, 'array has 5 elements');
    is(@array[0],       11, 'first value is 11');
    is(@array[*-1],     15, 'last value is 15');
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
    is(@a.elems, 2, 'Array literal not flattened');
    push @a, {};
    is(@a.elems, 3, 'Hash literal not flattened');
    my @foo;
    push @a, @foo;
    is(@a.elems, 4, 'Array not flattened');
    my %foo;
    push @a, %foo;
    is(@a.elems, 5, 'Hash not flattened');

    append @a, @foo;
    is(@a.elems, 5, 'Array flattened by append');
    my %foo;
    append @a, %foo;
    is(@a.elems, 5, 'Hash flattened by append');

    @a.push: |@foo;
    is(@a.elems, 5, '|Array flattened');
    @a.push: |%foo;
    is(@a.elems, 5, '|Hash flattened');

    @a.append: @foo;
    is(@a.elems, 5, 'Array flattened by .append');
    @a.append: %foo;
    is(@a.elems, 5, 'Hash flattened by .append');
}

# RT #112362
{
    my @a = <a b c d e f>;
    is @a[$[3, 4], 0,], 'c a', '$[] in array slice numifies (1)';
    is @a[$[3, 4]],     'c',    '$[] in array slice numifies (2)';

    my %h = a => 1, b => 2, 'a b' => 3;
    is %h{<a b>}, '1 2', 'hash slicing sanity';
    is %h{$[<a b>]}, '3', 'hash slicing stringifies []';
}

{
    my $a = [ a => 1, b => 2, c => 3 ];
    my $h = { a => 1, b => 2, c => 3 };

    my @a-a = @$a;
    my @h-a = %$a;

    my @a-h = @$h;
    my @h-h = %$h;

    is-deeply +@a-a, 3, '@ sigil flattening of itemized array';
    is-deeply +@h-a, 3, '% sigil flattening of itemized array';
    is-deeply +@a-h, 3, '@ sigil flattening of itemized hash';
    is-deeply +@h-h, 3, '% sigil flattening of itemized hash';
}

# RT #126172
{
    my @a1 = 1,2,3; my @b1; @b1.push:   @a1,;
    my @a2 = 1,2,3; my @b2; @b2.push:   @a2;
    my @a3 = 1,2,3; my @b3; @b3.append: @a3,;
    my @a4 = 1,2,3; my @b4; @b4.append: @a4;

    is-deeply @b1, [[1, 2, 3],], 'method push does not flatten an array arg (1)';
    is-deeply @b2, [[1, 2, 3],], 'method push does not flatten an array arg (2)';
    is-deeply @b3,  [1, 2, 3],   'method append does flatten an array arg (1)';
    is-deeply @b4,  [1, 2, 3],   'method append does flatten an array arg (2)';
}

# vim: ft=perl6
