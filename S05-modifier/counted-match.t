use v6;
use Test;

=begin pod

This file was originally derived from the perl5 CPAN module Perl6::Rules,
version 0.3 (12 Apr 2004), file t/counted.t.

=end pod

plan *;

my $data = "f fo foo fooo foooo fooooo foooooo";

# :nth(N)...

{
    nok $data.match(/fo+/, :nth(0)), 'No match nth(0)';

    my $match = $data.match(/fo+/, :nth(1));
    #?rakudo skip "Skipping less important test so that the iterator isn't consumed"
    ok $match, 'Match :nth(1)';
    is ~$match, 'fo', 'Matched value for :nth(1)';

    $match = $data.match(/fo+/, :nth(2));
    #?rakudo skip "Skipping less important test so that the iterator isn't consumed"
    ok $match, 'Match :nth(2)';
    is ~$match, 'foo', 'Matched value for :nth(2)';

    $match = $data.match(/fo+/, :nth(3));
    #?rakudo skip "Skipping less important test so that the iterator isn't consumed"
    ok $match, 'Match :nth(3)';
    is ~$match, 'fooo', 'Matched value for :nth(3)';

    $match = $data.match(/fo+/, :nth(6));
    #?rakudo skip "Skipping less important test so that the iterator isn't consumed"
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
    my @match = $data.match(/fo+/, :nth(2, 3));
    is +@match, 2, 'nth(list) is ok';
    is @match, <foo fooo>, 'nth(list) matched correctly';

    @match = $data.match(/fo+/, :nth(2 | 4));
    is +@match, 2, 'nth(junction) is ok';
    is @match, <foo foooo>, 'nth(junction) matched correctly';

    @match = $data.match(/fo+/, :nth(2..4));
    is +@match, 3, 'nth(Range) is ok';
    is @match, <foo fooo foooo>, 'nth(Range) matched correctly';

    @match = $data.match(/fo+/, :nth({ $_ !% 2 }));
    is +@match, 3, 'nth(code) is ok';
    is @match, <foo foooo foooooo>, 'nth(code) matched correctly';
}

done_testing;

# vim: ft=perl6
