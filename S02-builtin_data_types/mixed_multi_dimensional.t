use v6;

use Test;

plan 80;


=begin description

This tests some mixed multi-dimensional structures.

NOTE:
These tests don't go any more than two levels deep
(AoH, AoP) in most cases because I know these won't
work yet in Pugs. When we have this support, then
this test should be added too more.

Some deeper tests were already added.

=end description

# UNSPECCED
{ # Array of Pairs
    my @array;
    isa_ok(@array, Array);

    my $pair = ('key' => 'value');
    isa_ok($pair, Pair);

    @array[0] = $pair; # assign a variable
    is(+@array, 1, 'the array has one value in it');

    isa_ok(@array[0], Pair);
    #?rakudo skip "get_pmc_keyed() not implemented in class 'Perl6Pair'"
    is(@array[0]<key>, 'value', 'got the right pair value');

    @array[1] = ('key1' => 'value1'); # assign it inline
    is(+@array, 2, 'the array has two values in it');
    isa_ok(@array[1], Pair);

    #?rakudo skip "get_pmc_keyed() not implemented in class 'Perl6Pair'"
    is(@array[1]<key1>, 'value1', 'got the right pair value');
}

# UNSPECCED
{ # Array of Hashes
    my @array;
    isa_ok(@array, Array);

    my %hash = ('key', 'value', 'key1', 'value1');
    isa_ok(%hash, Hash);
    is(+%hash.keys, 2, 'our hash has two keys');

    @array[0] = %hash;
    is(+@array, 1, 'the array has one value in it');
    isa_ok(@array[0], Hash);
    is(@array[0]{"key"}, 'value', 'got the right value for key');
    is(@array[0]<key1>, 'value1', 'got the right value1 for key1');
}

{ # Array of Arrays
    # L<S09/Multidimensional arrays>
    my @array = (1, [2, 3], [4, 5], 6);
    isa_ok(@array, Array);

    is(+@array, 4, 'got 4 elements in the Array of Arrays');
    is(@array[0], 1, 'got the right first element');
    isa_ok(@array[1], Array);
    is(@array[1][0], 2, 'got the right second/first element');
    is(@array[1][1], 3, 'got the right second/second element');
    isa_ok(@array[2], Array);
    is(@array[2][0], 4, 'got the right third/first element');
    is(@array[2][1], 5, 'got the right third/second element');
    is(@array[3], 6, 'got the right fourth element');
}

# UNSPECCED
{ # Array of Subs
    my @array;
    isa_ok(@array, Array);

    @array[0] = sub { 1 };
    @array[1] = { 2 };
    @array[2] = -> { 3 };

    is(+@array, 3, 'got three elements in the Array');
    isa_ok(@array[0], Sub);
    isa_ok(@array[1], Block);
    isa_ok(@array[2], Block);

    is(@array[0](), 1, 'the first element (when executed) is 1');
    is(@array[1](), 2, 'the second element (when executed) is 2');
    is(@array[2](), 3, 'the third element (when executed) is 3');
}

# UNSPECCED
{ # Hash of Arrays
    my %hash;
    isa_ok(%hash, Hash);

    %hash<key> = [ 1, 2, 3 ];
    isa_ok(%hash<key>, Array);

    is(+%hash<key>, 3, 'it should have 3 values in it');
    is(%hash<key>[0], 1, 'got the right value');
    is(%hash<key>[1], 2, 'got the right value');
    is(%hash<key>[2], 3, 'got the right value');

    {
        my $array = %hash<key>;
        is(+$array, 3, 'it should have 3 values in it');
        is($array[0], 1, 'got the right value (when I pull the array out)');
        is($array[1], 2, 'got the right value (when I pull the array out)');
        is($array[2], 3, 'got the right value (when I pull the array out)');
    }

{
    %hash<key>.push(4);
    is(+%hash<key>, 4, 'it should now have 4 values in it');
    is(%hash<key>[3], 4, 'got the right value (which we just pushed onto the list)');
}

}


{ # Hash of Array-refs
  # UNSPECCED
    my %hash;
    isa_ok(%hash, Hash);

    my @array = ( 1, 2, 3 );
    isa_ok(@array, Array);

    %hash<key> = @array;
    isa_ok(%hash<key>, Array);

    is(+%hash<key>, 3, 'it should have 3 values in it');
    is(%hash<key>[0], 1, 'got the right value');
    is(%hash<key>[1], 2, 'got the right value');
    is(%hash<key>[2], 3, 'got the right value');

    {
        my @array = @( %hash<key> );
        is(+@array, 3, 'it should have 3 values in it');
        is(@array[0], 1, 'got the right value (when I pull the array out)');
        is(@array[1], 2, 'got the right value (when I pull the array out)');
        is(@array[2], 3, 'got the right value (when I pull the array out)');
    }

{
    %hash<key>.push(4);

    is(+%hash<key>, 4, 'it should now have 4 values in it');
    is(%hash<key>[3], 4, 'got the right value (which we just pushed onto the array)');
}

}

{ # Hashref survive addition to an array.
  my %h = <a 5 b 6>;
  my $hr = \%h;
  my $a0 = [ \%h ,'extra' ];
  my $a1 = [ \%h ];
  my $a2 = [ $hr ];
  #?rakudo todo 'nom regression'
  is($a0.elems,2,'hash references should not get decomposed');
  #?rakudo todo 'nom regression'
  is($a1.elems,1,'hash references should not get decomposed');
  is($a2.elems,1,'hash references should not get decomposed');
}

{ # nested, declared in one statement
    my $h = { a => [ 1,2,3 ] };
    isa_ok($h<a>.WHAT, Array, "array nested in hashref in one declaration");
}

#?rakudo 18 skip 'nom regression'
{ # structures deeper than 2 levels
    my @array;
    @array[0][0][0][0][0] = 5;
    isa_ok(@array, Array);
    isa_ok(@array[0], Array);
    isa_ok(@array[0][0], Array);
    isa_ok(@array[0][0][0], Array);
    isa_ok(@array[0][0][0][0], Array);
    is(@array[0][0][0][0][0], 5, "5 level deep arrays only structure");

    @array[1]<two>[0]<four>[0]<six> = 6;
    isa_ok(@array, Array);
    #?rakudo todo 'isa hash'
    isa_ok(@array[1], Hash);
    isa_ok(@array[1]<two>, Array);
    #?rakudo todo 'isa hash'
    isa_ok(@array[1]<two>[0], Hash);
    is(+@array[1]<two>[0], 1, "one key at level 4");
    isa_ok(@array[1]<two>[0]<four>, Array);
    #?rakudo todo 'isa hash'
    isa_ok(@array[1]<two>[0]<four>[0], Hash);
    is(@array[1]<two>[0]<four>[0]<six>, 6, "6 level deep mixed structure");


    @array[2]<two>[0]<f><other> = 5;
    #?rakudo todo 'isa hash'
    isa_ok(@array[1]<two>[0], Hash);
    #?pugs 3 todo 'bug'
    #?rakudo todo 'isa hash'
    isa_ok(@array[1]<two>[0]<f>, Hash);
    #?rakudo 2 todo 'unknown'
    is(+@array[1]<two>[0], 2, "two keys at level 4");
    is(@array[1]<two>[0]<f><other>, 5, "more keys at level 4");
}

# vim: ft=perl6
