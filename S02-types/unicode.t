use v6;

use Test;
plan 7;

#L<S02/"Methods on Arrays"/".bytes, .codes or .graphs">

# LATIN CAPITAL LETTER C, COMBINING DOT BELOW
my Str $u = "\x[0043,0323]";
is $u.codes, 2, 'combining \x[0042,0323] is two codes';
#?rakudo skip 'graphs NYI'
is $u.graphs, 1, 'combining À is one graph';
is "foo\r\nbar".codes, 8, 'CRLF is 2 codes';
#?rakudo skip 'graphs NYI'
is "foo\r\nbar".graphs, 7, 'CRLF is 1 graph';

#?rakudo.jvm todo "NFG on JVM"
is $u.chars, 1, '.chars defaults to .graphs';

# RT #65170
#?rakudo.jvm todo "NFG on JVM"
{
    my $rt65170;

    $rt65170 = "\c[LATIN CAPITAL LETTER A WITH DOT ABOVE, COMBINING DOT BELOW]";
    is $rt65170.chars, 1, '.chars defaults to .graphs (2)';
    $rt65170 = "\c[LATIN CAPITAL LETTER A, COMBINING DOT ABOVE, COMBINING DOT BELOW]";
    is $rt65170.chars, 1, '.chars defaults to .graphs (3)';
}

#vim: ft=perl6
