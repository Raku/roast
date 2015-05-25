use v6;
use Test;
plan 25;

# L<S09/Fixed-size arrays>

#?rakudo skip 'array shapes NYI RT #124502'
{
    my @arr[*];
    @arr[42] = "foo";
    is(+@arr, 43, 'my @arr[*] autoextends like my @arr');
}

#?rakudo skip 'array shapes NYI RT #124502'
{
    my @arr[7] = <a b c d e f g>;
    is(@arr, [<a b c d e f g>], 'my @arr[num] can hold num things');
    throws-like {push @arr, 'h'},
      Exception,  # XXX fix when this block is no longer skipped
      'adding past num items in my @arr[num] dies';
    throws-like {@arr[7]},
      Exception,  # XXX fix when this block is no longer skipped
      'accessing past num items in my @arr[num] dies';
}

#?rakudo skip 'array shapes NYI RT #124502'
{
    lives-ok { my @arr\    [7]},
      'array with fixed size with unspace');
    throws-like { EVAL 'my @arr.[8]' },
      Exception,  # XXX fix when this block is no longer skipped
      'array with dot form dies';
    throws-like { EVAL 'my @arr\    .[8]' },
      Exception,  # XXX fix when this block is no longer skipped
      'array with dot form and unspace dies';
}

# L<S09/Typed arrays>
{
    my @arr of Int = 1, 2, 3, 4, 5;
    is(@arr, <1 2 3 4 5>, 'my @arr of Type works');
    throws-like {push @arr, 's'},
      X::TypeCheck,
      'type constraints on my @arr of Type works (1)';
    throws-like {push @arr, 4.2},
      X::TypeCheck,
      'type constraints on my @arr of Type works (2)';
}
{
    my Int @arr = 1, 2, 3, 4, 5;
    is(@arr, <1 2 3 4 5>, 'my Type @arr works');
    throws-like {push @arr, 's'},
      X::TypeCheck,
      'type constraints on my Type @arr works (1)';
    throws-like {push @arr, 4.2},
      X::TypeCheck,
      'type constraints on my Type @arr works (2)';
}

#?rakudo skip 'array shapes NYI RT #124502'
{
    my @arr[5] of Int = <1 2 3 4 5>;
    is(@arr, <1 2 3 4 5>, 'my @arr[num] of Type works');

    throws-like {push @arr, 123},
      Exception,
      'boundary constraints on my @arr[num] of Type works';
    pop @arr; # remove the last item to ensure the next ones are type constraints
    throws-like {push @arr, 's'},
      Exception,
      'type constraints on my @arr[num] of Type works (1)';
    throws-like {push @arr, 4.2},
      Exception,
      'type constraints on my @arr[num] of Type works (2)';
}

{
    my int @arr = 1, 2, 3, 4, 5;
    is(@arr, <1 2 3 4 5>, 'my type @arr works');
    is push(@arr, 6), [1,2,3,4,5,6], 'push on native @arr works';
    #?rakudo 2 todo 'X::AdHoc "This type cannot unbox to a native integer" RT #125123'
    throws-like { EVAL 'push @arr, "s"' },
      X::TypeCheck,
      'type constraints on my type @arr works (1)';
    throws-like { EVAL 'push @arr, 4.2' },
      X::TypeCheck,
      'type constraints on my type @arr works (2)';
}

#?rakudo skip 'array shapes NYI RT #124502'
{
    my int @arr[5] = <1 2 3 4 5>;
    is(@arr, <1 2 3 4 5>, 'my Type @arr[num] works');

    throws-like {push @arr, 123},
      Exception,
      'boundary constraints on my Type @arr[num] works';
    pop @arr; # remove the last item to ensure the next ones are type constraints
    throws-like {push @arr, 's'},
      Exception,  # XXX fix when this block is no longer skipped
      'type constraints on my Type @arr[num] works (1)';
    throws-like {push @arr, 4.2},
      Exception,  # XXX fix when this block is no longer skipped
      'type constraints on my Type @arr[num]  works (2)';
}
