use v6;
use Test;

=begin pod

This file was originally derived from the perl5 CPAN module Perl6::Rules,
version 0.3 (12 Apr 2004), file t/overlapping.t.

It probably needs a few syntax updates to remove p5isms

=end pod

plan 22;

# should be: L<S05/Modifiers/With the new C<:ov> (C<:overlap>) modifier,>
# L<S05/Modifiers/match at all possible character positions>

my $str = "abrAcadAbbra";

my @expected = (
    [ 0, 'abrAcadAbbra' ],
    [ 3,    'AcadAbbra' ],
    [ 5,      'adAbbra' ],
    [ 7,        'Abbra' ],
);

{
    for 1..2 -> $rep {
        ok($str ~~ m:i:overlap/ a (.+) a /, "Repeatable overlapping match ($rep)" );

        ok(@$/ == @expected, "Correct number of matches ($rep)" );
        my @expected_pos = @expected.map: { $_[0] };
        my @expected_str = @expected.map: { $_[1] };
        is $/.list.join('|'), @expected_str.join('|'), 'Got right submatches';
        is $/.list.map(*.from), @expected_pos, 'Got right position of submatches';
        is $/.list»[0].join('|'), @expected_str.map(*.substr(1,*-1)).join('|'), 'Got captures';
    }
}

ok(!( "abcdefgh" ~~ m:overlap/ a .+ a / ), 'Failed overlapping match');

{
    # $str eq abrAcadAbbra
    my @match = $str.match(/a .* a/, :ov).list;
    is +@match, 2, "Two matches found";
    is ~@match[0], "abrAcadAbbra", "First is abrAcadAbbra";
    is ~@match[1], "adAbbra", "Second is adAbbra";
}

{
    # $str eq abrAcadAbbra
    my @match = $str.match(/a .* a/, :overlap).list;
    is +@match, 2, "Two matches found";
    is ~@match[0], "abrAcadAbbra", "First is abrAcadAbbra";
    is ~@match[1], "adAbbra", "Second is adAbbra";
}

{
    my @match = "aababcabcd".match(/a .*/, :ov).list;
    is +@match, 4, "Four matches found";
    is ~@match[0], "aababcabcd", "First is aababcabcd";
    is ~@match[1], "ababcabcd", "Second is ababcabcd";
    is ~@match[2], "abcabcd", "Third is abcabcd";
    is ~@match[3], "abcd", "Last is abcd";
}

done;

# vim: ft=perl6
