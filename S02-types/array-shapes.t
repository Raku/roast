use v6;
use Test;
plan 25;

# L<S09/Fixed-size arrays>

#?rakudo skip 'array shapes NYI'
{
    my @arr[*];
    @arr[42] = "foo";
    is(+@arr, 43, 'my @arr[*] autoextends like my @arr');
}

#?rakudo skip 'array shapes NYI'
{
{
    my @arr[7] = <a b c d e f g>;
    is(@arr, [<a b c d e f g>], 'my @arr[num] can hold num things');
    throws_like {push @arr, 'h'},
      Exception,  # XXX fix when this block is no longer skipped
      'adding past num items in my @arr[num] dies';
    throws_like {@arr[7]},
      Exception,  # XXX fix when this block is no longer skipped
      'accessing past num items in my @arr[num] dies';
}

#?rakudo skip 'array shapes NYI'
{
{
    lives_ok { my @arr\    [7]},
      'array with fixed size with unspace');
    throws_like { EVAL 'my @arr.[8]' },
      Exception,  # XXX fix when this block is no longer skipped
      'array with dot form dies';
    throws_like { EVAL 'my @arr\    .[8]' },
      Exception,  # XXX fix when this block is no longer skipped
      'array with dot form and unspace dies';
}

# L<S09/Typed arrays>
{
    my @arr of Int = 1, 2, 3, 4, 5;
    is(@arr, <1 2 3 4 5>, 'my @arr of Type works');
    throws_like {push @arr, 's'},
      X::TypeCheck,
      'type constraints on my @arr of Type works (1)';
    throws_like {push @arr, 4.2},
      X::TypeCheck,
      'type constraints on my @arr of Type works (2)';
}
{
    my Int @arr = 1, 2, 3, 4, 5;
    is(@arr, <1 2 3 4 5>, 'my Type @arr works');
    throws_like {push @arr, 's'},
      X::TypeCheck,
      'type constraints on my Type @arr works (1)';
    throws_like {push @arr, 4.2},
      X::TypeCheck,
      'type constraints on my Type @arr works (2)';
}

#?rakudo skip 'array shapes NYI'
{
    my @arr[5] of Int = <1 2 3 4 5>;
    is(@arr, <1 2 3 4 5>, 'my @arr[num] of Type works');

    throws_like {push @arr, 123},
      Exception,
      'boundary constraints on my @arr[num] of Type works';
    pop @arr; # remove the last item to ensure the next ones are type constraints
    throws_like {push @arr, 's'},
      Exception,
      'type constraints on my @arr[num] of Type works (1)';
    throws_like {push @arr, 4.2},
      Exception,
      'type constraints on my @arr[num] of Type works (2)';
}

#?rakudo skip 'native arrays NYI'
{
    my int @arr = 1, 2, 3, 4, 5;
    is(@arr, <1 2 3 4 5>, 'my type @arr works');
    is_deeply push( @arr, 6), [1,2,3,4,5,6], 'push on native @arr works');
    throws_like {push @arr, 's'},
      X::TypeCheck,
      'type constraints on my type @arr works (1)';
    throws_like {push @arr, 4.2},
      X::TypeCheck,
      'type constraints on my type @arr works (2)';
}

#?rakudo skip 'array shapes NYI'
{
    my int @arr[5] = <1 2 3 4 5>;
    is(@arr, <1 2 3 4 5>, 'my Type @arr[num] works');

    throws_like {push @arr, 123},
      Exception,
      'boundary constraints on my Type @arr[num] works';
    pop @arr; # remove the last item to ensure the next ones are type constraints
    throws_like {push @arr, 's'},
      Exception,  # XXX fix when this block is no longer skipped
      'type constraints on my Type @arr[num] works (1)';
    throws_like {push @arr, 4.2},
      Exception,  # XXX fix when this block is no longer skipped
      'type constraints on my Type @arr[num]  works (2)';
}
