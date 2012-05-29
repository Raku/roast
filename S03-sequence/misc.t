use v6;
use Test;


# L<S03/List infix precedence/constraints implied by the signature of the function>
#?niecza skip 'Nominal type check failed in binding Int $n in f; got Str, needed Int'
#?rakudo skip 'type check failed (bogus test?)'
{
    sub f (Int $n) { $n > 3 ?? 'liftoff!' !! $n + 1 }
    is (1, &f ... *).join(' '), '1 2 3 liftoff!', 'sequence terminated by signature mismatch';
}

# L<S03/List infix precedence/'the list on the left is C<Nil>'>

# XXX This is surely the wrong way to test this, but I don't know
#     the right way.
#?niecza skip 'Need something on the LHS'
is (() ... *)[^3].perl, '((), (), ())', 'Nil sequence';

# L<S03/List infix precedence/interleave unrelated sequences>
# multiple return values

is (1, 1, { $^a + 1, $^b * 2 } ... *).flat.[^12].join(' '), '1 1 2 2 3 4 4 8 5 16 6 32', 'sequence of two interleaved sequences';
is (1, 1, 1, { $^a + 1, $^b * 2, $^c - 1 } ... *).flat.[^18].join(' '), '1 1 1 2 2 0 3 4 -1 4 8 -2 5 16 -3 6 32 -4', 'sequence of three interleaved sequences';
is (1, { $^n + 1 xx $^n + 1 } ... *)[^10].join(' '), '1 2 2 3 3 3 4 4 4 4', 'sequence with list-returning block';
#?rakudo 2 todo 'NYI'
is ('a', 'b', { $^a ~ 'x', $^a ~ $^b, $^b ~ 'y' } ... *)[^11].join(' '), 'a b ax ab by abx abby byy abbyx abbybyy byyy', 'sequence with arity < number of return values';
is ('a', 'b', 'c', { $^x ~ 'x', $^y ~ 'y' ~ $^z ~ 'z' } ... *)[^9].join(' '), 'a b c ax bycz cx axybyczz byczx cxyaxybyczzz', 'sequence with arity > number of return values';

# L<S03/List infix precedence/it will be taken as a yada>

eval_dies_ok '(1, 2, ... 3)[2]', 'yada operator not confused for sequence operator';    #OK apparent sequence operator

# L<S03/List infix precedence/and another function to continue the list>
# chained sequence

#?rakudo 8 skip 'chained sequence NYI'
is (1 ... 5 ... 10).join(' '),
    '1 2 3 4 5 6 7 8 9 10',
    'simple chained finite arithmetic sequence';
#?niecza skip 'Slicel lists are NYI'
is infix:<...>(1; 5; 10).join(' '),
    '1 2 3 4 5 6 7 8 9 10',
    "simple chained finite arithmetic sequence (with 'infix:<...>')";
is (1 ... 5, 10 ... 25, 50 ... 150).join(' '),
    '1 2 3 4 5 10 15 20 25 50 75 100 125 150',
    'chained finite arithmetic sequence';
is (1 ... 4, 8, 16 ... 64, 63, 62 ... 58).join(' '),
    '1 2 3 4 8 16 32 64 63 62 61 60 59 58',
    'chained finite numeric sequence';
#?niecza skip 'Slicel lists are NYI'
is infix:<...>(1;   4, 8, 16;   64, 63, 62;   58).join(' '),
    '1 2 3 4 8 16 32 64 63 62 61 60 59 58',
    "chained finite numeric sequence (with 'infix:<...>')";
is (1/4, 1/2, 1 ... 8, 9 ... *)[^10].join(' '),
    '0.25 0.5 1 2 4 8 9 10 11 12',
    'chained infinite numeric sequence';
#?niecza skip 'Slicel lists are NYI'
is infix:<...>(1/4, 1/2, 1;   8, 9;   *).join(' '),
    '1/4 1/2 1 2 4 8 9 10 11 12',
    "chained infinite numeric sequence (with 'infix:<...>')";
is (1, 4, 7 ... 16, 16 ... *)[^8].join(' '),
    '1 4 7 10 13 16 16 16',
    'chained eventually constant numeric sequence';
    
# The following is now an infinite sequence...
# is (0, 2 ... 7, 9 ... 14).join(' '),
#     '0 2 4 6 7 9 11 13',
#     'chained arithmetic sequence with unreached limits';

# Mixed ...^ and ... -- should that work?
# is (0, 2 ...^ 8, 11 ... 17, 18 ...^ 21).join(' '),
#     '0 2 4 6 11 14 17 18 19 20',
#     'chained arithmetic sequence with exclusion';

#?niecza skip 'Cannot use value like Block as a number'
#?rakudo skip 'chained sequences NYI'
is (1, *+1  ... { $_ < 5 }, 5, *+10  ... { $_ < 35 }, 35, *+100 ... { $_ < 400 }).join(' '),
    '1 2 3 4 5 15 25 35 135 235 335',
    'simple chained sequence with closures';
#?niecza skip 'Unable to resolve method chars in class Block'
#?rakudo skip 'chained sequences NYI'
is (1, { $^n*2 + 1 } ... 31, *+5 ... { $^n**2 < 2000 }, 'a', *~'z' ... { $_.chars < 6 }).join(' '), 
    '1 3 7 15 31 36 41 a az azz azzz azzzz',
    'chained sequence with closures';

# The following is now an infinite sequence...
# is (1, 2 ... 0, 1 ... 3).join(' '),
#     '0 1 2 3',
#     'chained sequence with an empty subsequence';

{
    my @rt80574 := -> { 'zero', 'one' } ... *;
    #?rakudo todo 'RT 80574'
    is @rt80574[0], 'zero', 'Generator output is flattened';
}

done;

# vim: ft=perl6
