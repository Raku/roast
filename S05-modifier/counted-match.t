use v6;
use Test;

=begin pod

This file was originally derived from the perl5 CPAN module Perl6::Rules,
version 0.3 (12 Apr 2004), file t/counted.t.

=end pod

plan 22;

my $data = "f fo foo fooo foooo fooooo foooooo";

# :nth(N)...

{
    nok $data.match(/fo+/, :nth(0)), 'No match nth(0)';

    my $match = $data.match(/fo+/, :nth(1));
    ok $match, 'Match :nth(1)';
    is ~$match, 'fo', 'Matched value for :nth(1)';

    $match = $data.match(/fo+/, :nth(2));
    ok $match, 'Match :nth(2)';
    is ~$match, 'foo', 'Matched value for :nth(2)';

    $match = $data.match(/fo+/, :nth(3));
    ok $match, 'Match :nth(3)';
    is ~$match, 'fooo', 'Matched value for :nth(3)';

    $match = $data.match(/fo+/, :nth(6));
    ok $match, 'Match :nth(6)';
    is ~$match, 'foooooo', 'Matched value for :nth(6)';

    nok $data.match(/fo+/, :nth(7)), 'No match nth(7)';
}

# :nth($N)...

# for (1..6) -> $N {
#     ok($data ~~ m:nth($N)/fo+/, "Match nth(\$N) for \$N == $N" );
#     is($/, 'f'~'o' x $N, "Matched value for $N" );
# }
# 

# more interesting variations of :nth(...)
#?rakudo skip 'hangs'
#?niecza skip 'hangs'
{
    my @match = $data.match(/fo+/, :nth(2, 3)).list;
    is +@match, 2, 'nth(list) is ok';
    is @match, <foo fooo>, 'nth(list) matched correctly';

    @match = $data.match(/fo+/, :nth(2..4)).list;
    is +@match, 3, 'nth(Range) is ok';
    is @match, <foo fooo foooo>, 'nth(Range) matched correctly';

    @match = $data.match(/fo+/, :nth(2, 4 ... *)).list;
    is +@match, 3, 'nth(infinite series) is ok';
    is @match, <foo foooo foooooo>, 'nth(infinite series) matched correctly';
}

#?niecza skip 'Excess arguments to CORE Cool.match'
{
    is 'abecidofug'.match(/<[aeiou]>./, :nth(1,3,5), :x(2)).join('|'),
        'ab|id', ':x and :nth';

    nok 'abecidofug'.match(/<[aeiou]>./, :nth(1,3,5,7,9), :x(6)).join('|'),
        ':x and :nth (not matching)';

    is 'abcdefg'.match(/.*/, :nth(2,4,6,7), :x(2..3), :overlap).join('|'),
        'bcdefg|defg|fg', ':x and :nth and :overlap';

    nok 'abcdefg'.match(/.+/, :nth(2,4,6,7), :x(6..8), :overlap).join('|'),
        ':x and :nth and :overlap (not matching)'
}

# test that non-monotonic items in :nth lists are ignored
#?niecza todo
{
    is 'abacadaeaf'.match(/a./, :nth(2, 1, 4)).join(', '),
        'ac, ae', 'non-monotonic items in :nth are ignored';
}

# RT 77408
{
    dies_ok { "a" ~~ m:nth(Mu)/a/ }, ':nth does not accept Mu param';
}

done;

# vim: ft=perl6
