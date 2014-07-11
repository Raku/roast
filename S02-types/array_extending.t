use v6;

use Test;

plan 21;

# L<S09/Autovivification/In Perl 6 these read-only operations are indeed non-destructive:>
{
    # Compare with Perl 5:
    #   $ perl -we '
    #     my @array = qw<a b c>;
    #     my $foo = $array[100];
    #     print exists $array[30] ? "exists" : "does not exist"
    #   '
    #   does not exist
    my @array = <a b c d>;
    is +@array, 4, "basic sanity";
    my $foo = @array[20];
    # We've only *accessed* @array[20], but we haven't assigned anything to it, so
    # @array shouldn't change. But currently, @array *is* automatically extended,
    # i.e. @array is ("a", "b", "c", "d", Mu, Mu, ...). This is wrong.
    is +@array, 4,
      "accessing a not existing array element should not automatically extend the array";
}

{
    my @array = <a b c d>;
    @array[20] = 42;
    # Now, we did assign @array[20], so @array should get automatically extended.
    # @array should be ("a", "b", "c", "d", Mu, Mu, ..., 42).
    is +@array, 21,
      "creating an array element should automatically extend the array (1)";
    # And, of course, @array[20]:exists has to be true -- we've just assigned
    # @array[20].
    #?niecza skip 'Unable to resolve method exists in class Array'
    ok @array[20]:exists,
      "creating an array element should automatically extend the array (2)";
}

{
    my @array   = <a b c d>;
    my $defined = defined @array[100];

    ok !$defined,
        'defined @array[$index_out_of_bounds] should be false';
    is +@array, 4,
        'defined @array[$index_out_of_bounds] should not have altered @array';
}

{
    my @array   = <a b c d>;
    my $defined;
    try { $defined = defined @array[*-5]; }

    ok !$defined,
        'defined @array[$negative_index_out_of_bounds] should be false';
    is +@array, 4,
        'defined @array[$negative_index_out_of_bounds] should not have altered @array';
}

#?niecza skip 'Unable to resolve method exists in class Array'
{
    my @array  = <a b c d>;
    my $exists = @array[100]:exists;

    ok !$exists,
        '@array[$index_out_of_bounds]:exists should be false';
    is +@array, 4,
        '@array[$index_out_of_bounds]:exists should not have altered @array';
}
    
#?niecza skip 'Unable to resolve method exists in class Array'
{
    my @array  = <a b c d>;
    my $exists = @array[-5]:exists;

    ok !$exists,
        '@array[$negative_index_out_of_bounds]:exists should be false';
    is +@array, 4,
        '@array[$negative_index_out_of_bounds]:exists should not have altered @array';
}

{
    my @a;
    @a[2] = 6;
    is +@a, 3, '@a[2] = 6 ensures that @a has three items';
    nok @a[0].defined, '... and the first is not defined';
    nok @a[1].defined, '... and the second is not defined';
    is @a[2], 6,       '... and  the third is 6';
}

# RT #62948
{
    my @a;
    @a[2] = 'b';
    my @b = @a;
    is +@b, 3, 'really a degenerative case of assigning list to array';
    @b = (6, @a);
    is +@b, 4, 'assigning list with extended array to an array';
    my $s = @a.join(':');
    is $s, '::b', 'join on extended array';
    my $n = + @a.grep({ $_ eq 'b'});
    is $n, 1, 'grep on extended array';
    @a[1] = 'c'; # cmp doesn't handle Mu cmp Mu yet
    #?niecza todo 'min on list with undefined el ignores it'
    is @a.min(), 'b', 'min on list with undefined el ignores it';
}

# vim: ft=perl6
