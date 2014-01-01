use v6;

use Test;
plan 16;

#L<S02/"Methods on Arrays"/".bytes, .codes or .graphs">

# LATIN CAPITAL LETTER A, COMBINING GRAVE ACCENT
my Str $u = "\x[0041,0300]";
is $u.codes, 2, 'combining À is two codes';
is $u.graphs, 1, 'combining À is one graph';
is "foo\r\nbar".codes, 8, 'CRLF is 2 codes';
is "foo\r\nbar".graphs, 7, 'CRLF is 1 graph';

# Speculation, .chars is unspecced, also use Bytes etc.
is $u.chars, 1, '.chars defaults to .graphs';

# RT #65170
#?pugs todo
{
    my $rt65170;

    $rt65170 = "\c[LATIN CAPITAL LETTER A WITH DOT ABOVE, COMBINING DOT BELOW]";
    is $rt65170.chars, 1, '.chars defaults to .graphs (2)';
    $rt65170 = "\c[LATIN CAPITAL LETTER A, COMBINING DOT ABOVE, COMBINING DOT BELOW]";
    is $rt65170.chars, 1, '.chars defaults to .graphs (3)';
}

#L<S02/"Units of Position Arguments"/"coerce to the proper units">
    $u = "\x[41,
            E1,
            41, 0300,
            41, 0302, 0323,
            E0]";

#?pugs 9 todo ''
is EVAL('substr $u, 3.as(Bytes),  1.as(Bytes)'),  "\x[41]",             'substr with Bytes as units - utf8';
is EVAL('substr $u, 3.as(Codes),  1.as(Codes)'),  "\x[0300]",           'substr with Codes as units - utf8';
is EVAL('substr $u, 4.as(Graphs), 1.as(Graphs)'), "\x[E0]",             'substr with Graphs as units - utf8';
is EVAL('substr $u, 3.as(Graphs), 1.as(Codes)'),  "\x[41]",             'substr with Graphs and Codes as units 1 - utf8';
is EVAL('substr $u, 4.as(Codes),  1.as(Graphs)'), "\x[41, 0302, 0323]", 'substr with Graphs and Codes as units 2 - utf8';
is EVAL('substr $u, 4.as(Bytes),  1.as(Codes)'),  "\x[0300]",           'substr with Bytes and Codes as units 1 - utf8';
is EVAL('substr $u, 1.as(Codes),  2.as(Bytes)'),  "\x[E1]",             'substr with Bytes and Codes as units 2 - utf8';
is EVAL('substr $u, 3.as(Bytes),  1.as(Graphs)'), "\x[41, 0300]",       'substr with Bytes and Graphs as units 1 - utf8';
is EVAL('substr $u, 3.as(Graphs), 1.as(Bytes)'),  "\x[41]",             'substr with Bytes and Graphs as units 2 - utf8';


#vim: ft=perl6
