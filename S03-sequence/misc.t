use v6.c;
use Test;
plan 30;

is ("fom" ... /foo/), "fom fon foo", "can use regex for endpoint without it being confused for closure";

# L<S03/List infix precedence/constraints implied by the signature of the function>
#?niecza skip 'Nominal type check failed in binding Int $n in f; got Str, needed Int'
{
    sub f (Int $n) { $n > 3 ?? 'liftoff!' !! $n + 1 }
    is (1, &f ... Str)[^5].join(' '), '1 2 3 4 liftoff!',
        'sequence stops when type of endpoint matches';
    throws-like { sink (1, &f ... *)[^8].join(' ') },
        X::TypeCheck::Binding,
        'sequence terminated by signature mismatch';
}

# L<S03/List infix precedence/'the list on the left is C<Nil>'>

throws-like {(() ... *)[0]}, X::Cannot::Empty, 'Nil sequence';

# L<S03/List infix precedence/interleave unrelated sequences>
# multiple return values

is (1, 1, { slip $^a + 1, $^b * 2 } ... *).[^12].join(' '), '1 1 2 2 3 4 4 8 5 16 6 32', 'sequence of two interleaved sequences';
is (1, 1, 1, { slip $^a + 1, $^b * 2, $^c - 1 } ... *).[^18].join(' '), '1 1 1 2 2 0 3 4 -1 4 8 -2 5 16 -3 6 32 -4', 'sequence of three interleaved sequences';
is (1, { |($^n + 1 xx $^n + 1) } ... *)[^10].join(' '), '1 2 2 3 3 3 4 4 4 4', 'sequence with list-returning block';
#RT #80574
is ('a', 'b', { slip $^a ~ 'x', $^a ~ $^b, $^b ~ 'y' } ... *)[^11].join(' '), 'a b ax ab by abx abby byy abbyx abbybyy byyy', 'sequence with arity < number of return values';
#RT #80574
is ('a', 'b', 'c', { slip $^x ~ 'x', $^y ~ 'y' ~ $^z ~ 'z' } ... *)[^9].join(' '), 'a b c ax bycz cx axybyczz byczx cxyaxybyczzz', 'sequence with arity > number of return values';

# L<S03/List infix precedence/it will be taken as a yada>

throws-like '(1, 2, ... 3)[2]', Exception, 'yada operator not confused for sequence operator';    #OK apparent sequence operator

# L<S03/List infix precedence/and another function to continue the list>
# chained sequence

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
is infix:<...>(1/4, 1/2, 1;   8, 9;   *)[^10].join(' '),
    '0.25 0.5 1 2 4 8 9 10 11 12',
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
is (1, *+1  ... { $_ >= 4 }, 5, *+10  ... { $_ >= 24 }, 35, *+100 ... { $_ > 400 }).join(' '),
    '1 2 3 4 5 15 25 35 135 235 335 435',
    'chained sequence with closures (1)';
#?niecza skip 'Unable to resolve method chars in class Block'
is (1, { $^n*2 + 1 } ... 31, *+5 ... { $^n**2 > 2000 }, 'a', *~'z' ... { $_.chars >= 5 }).join(' '),
    '1 3 7 15 31 36 41 46 a az azz azzz azzzz',
    'chained sequence with closures (2)';

#RT #123329
{
    is (1, *+1 ... { $_ == 9 }, 10, *+10 ... { $_ == 90 }, 100, *+100 ... { $_ == 900 }).join(' '),
        '1 2 3 4 5 6 7 8 9 10 20 30 40 50 60 70 80 90 100 200 300 400 500 600 700 800 900',
        'cained sequence with limit function';
    is (1, 2 ... 4, 6 ... 10, 12).join(' '),
        '1 2 3 4 6 8 10 12',
        'chained sequence with more than one value after last infix:<...>';
}

# The following is now an infinite sequence...
# is (1, 2 ... 0, 1 ... 3).join(' '),
#     '0 1 2 3',
#     'chained sequence with an empty subsequence';
#RT #80574'
{
    my @rt80574 = -> { slip 'zero', 'one' } ... *;
    is @rt80574[0], 'zero', '0-ary generator output can be slipped from the start';
}

# RT #116348
{
    is (10, 8 ... 2|3).join(' '), '10 8 6 4 2', 'sequence with RHS junction I';
    is (11, 9 ... 2|3).join(' '), '11 9 7 5 3', 'sequence with RHS junction II';
    sub postfix:<!!>($x) { [*] $x, $x - 2 ... 2|3 };
    is (4!!, 5!!).join(' '), "8 15", 'sequence with RHS junction III';
}

# RT #1233303
{
    throws-like { (1, 2, 5 ... 10)[0] }, X::Sequence::Deduction, from => '1,2,5'
}

# RT #112288
{
    throws-like { (1, 2, 6 ... *)[5] }, X::Sequence::Deduction, from => '1,2,6',
        'non-deducible sequence ending in * throws X::Sequence::Deduction (1)';
    throws-like { ~(1, 2, 6 ... *)[5] }, X::Sequence::Deduction, from => '1,2,6',
        'non-deducible sequence ending in * throws X::Sequence::Deduction (2)';
}

# RT #126060
{
    sub identity-matrix($n) {
        [$[1, |(0 xx $n-1)], *.rotate(-1).list ... *[*-1] == 1]
    }
    # note the first element is not produced, but passed verbatim
    is identity-matrix(5).perl, [[1,0,0,0,0], (0,1,0,0,0), (0,0,1,0,0), (0,0,0,1,0), (0,0,0,0,1)].raku, "code endpoint protects item";
}

# vim: ft=perl6
