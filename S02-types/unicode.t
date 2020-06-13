use v6;

use Test;
plan 5;

#L<S02/"Methods on Arrays"/".bytes, .codes">

# LATIN CAPITAL LETTER C, COMBINING DOT BELOW
my Str $u = "\x[0043,0323]";
is $u.codes, 2, 'combining \x[0042,0323] is two codes';
is "foo\r\nbar".codes, 8, 'CRLF is 2 codes';

# https://github.com/Raku/old-issue-tracker/issues/3841
#?rakudo.jvm todo "NFG on JVM"
is $u.chars, 1, '.chars defaults to NFG';

# https://github.com/Raku/old-issue-tracker/issues/953
# https://github.com/Raku/old-issue-tracker/issues/3842
#?rakudo.jvm todo "NFG on JVM"
{
    my $rt65170;

    $rt65170 = "\c[LATIN CAPITAL LETTER A WITH DOT ABOVE, COMBINING DOT BELOW]";
    is $rt65170.chars, 1, '.chars defaults to NFG (2)';
    $rt65170 = "\c[LATIN CAPITAL LETTER A, COMBINING DOT ABOVE, COMBINING DOT BELOW]";
    is $rt65170.chars, 1, '.chars defaults to NFG (3)';
}

# vim: expandtab shiftwidth=4
