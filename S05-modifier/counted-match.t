use v6;
use Test;

=begin pod

This file was originally derived from the Perl CPAN module Perl6::Rules,
version 0.3 (12 Apr 2004), file t/counted.t.

=end pod

plan 28;

my $data = "f fo foo fooo foooo fooooo foooooo";

# :nth(N)...

{

    # https://github.com/Raku/old-issue-tracker/issues/4475
    
    throws-like '$data.match(/fo+/, :nth(0))', Exception, message => rx/nth/;
    throws-like '$data.match(/fo+/, :nth(-1))', Exception, message => rx/nth/;
    throws-like '$data.match(/fo+/, :nth(-2))', Exception, message => rx/nth/;

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
{
    my @match = $data.match(/fo+/, :nth(2, 3)).list;
    is +@match, 2, 'nth(list) is ok';
    is @match, <foo fooo>, 'nth(list) matched correctly';

    @match = $data.match(/fo+/, :nth(2..4)).list;
    is +@match, 3, 'nth(Range) is ok';
    is @match, <foo fooo foooo>, 'nth(Range) matched correctly';

    @match = $data.match(/fo+/, :nth(2..Inf)).list;
    is +@match, 5, 'nth(infinite range) is ok';
    is @match, <foo fooo foooo fooooo foooooo>, 'nth(infinite range) matched correctly';
}

{
    my @match = $data.match(/fo+/, :nth(2, 4 ... *)).list;
    is +@match, 3, 'nth(infinite series) is ok';
    is @match, <foo foooo foooooo>, 'nth(infinite sequence) matched correctly';
}

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
{
    throws-like '"abacadaeaf".match(/a./, :nth(2, 1, 4)).join', Exception,
        'non-monotonic items in :nth throw';
    throws-like '"abacadaeaf".match(/a./, :nth(2, -1, 4)).join', Exception,
        'negative non-monotonic items throw';
    throws-like '"abacadaeaf".match(/a./, :nth(2, 0, 4)).join', Exception,
        'zero non-monotonic items throw';
}

# https://github.com/Raku/old-issue-tracker/issues/2091
subtest ':nth accepts Junctions' => {
    plan 7;
    is-deeply "aa" ~~ m:nth(1|2)/a/, True,  'all nths exist (&any)';
    is-deeply "aa" ~~ m:nth(1^2)/a/, False, 'all nths exist (&one)';
    is-deeply "aa" ~~ m:nth(1&4)/a/, False, 'some nths exist (&all)';
    is-deeply "aa" ~~ m:nth(1|4)/a/, True,  'some nths exist (&any)';

    "abc" ~~ m:nth(1|3)/./;
    ok $/ ~~ Junction, 'result is a Junction';
    ok $/ eq 'a', 'Junction has one of the alternatives';
    ok $/ eq 'c', 'Junction has second of the alternatives';
}

# vim: expandtab shiftwidth=4
