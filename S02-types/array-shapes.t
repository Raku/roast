use v6;
use Test;
plan(*);

# L<S09/Fixed-size arrays>

{
    my @arr[*];
    @arr[42] = "foo";
    is(+@arr, 43, 'my @arr[*] autoextends like my @arr');
}

{
    my @arr[7] = <a b c d e f g>;
    is(@arr, [<a b c d e f g>], 'my @arr[num] can hold num things');
    dies_ok({push @arr, 'h'}, 'adding past num items in my @arr[num] dies');
    dies_ok({@arr[7]}, 'accessing past num items in my @arr[num] dies');
}

{
    lives_ok({ my @arr\    [7]}, 'array with fixed size with unspace');
    eval_dies_ok('my @arr.[8]', 'array with dot form dies');
    eval_dies_ok('my @arr\    .[8]', 'array with dot form and unspace dies');
}

# L<S09/Typed arrays>

{
    my @arr of Int = 1, 2, 3, 4, 5;
    is(@arr, <1 2 3 4 5>, 'my @arr of Type works');
    #?rakudo 2 todo "parametrization issues"
    dies_ok({push @arr, 's'}, 'type constraints on my @arr of Type works (1)');
    dies_ok({push @arr, 4.2}, 'type constraints on my @arr of Type works (2)');
}

{
    my @arr[5] of Int = <1 2 3 4 5>;
    is(@arr, <1 2 3 4 5>, 'my @arr[num] of Type works');

    dies_ok({push @arr, 123}, 'boundary constraints on my @arr[num] of Type works');
    pop @arr; # remove the last item to ensure the next ones are type constraints
    dies_ok({push @arr, 's'}, 'type constraints on my @arr[num] of Type works (1)');
    dies_ok({push @arr, 4.2}, 'type constraints on my @arr[num] of Type works (2)');
}

{
    my int @arr = 1, 2, 3, 4, 5;
    is(@arr, <1 2 3 4 5>, 'my Type @arr works');
    dies_ok({push @arr, 's'}, 'type constraints on my Type @arr works (1)');
    dies_ok({push @arr, 4.2}, 'type constraints on my Type @arr works (2)');
}

{
    my int @arr[5] = <1 2 3 4 5>;
    is(@arr, <1 2 3 4 5>, 'my Type @arr[num] works');

    dies_ok({push @arr, 123}, 'boundary constraints on my Type @arr[num] works');
    pop @arr; # remove the last item to ensure the next ones are type constraints
    dies_ok({push @arr, 's'}, 'type constraints on my Type @arr[num] works (1)');
    dies_ok({push @arr, 4.2}, 'type constraints on my Type @arr[num]  works (2)');
}
