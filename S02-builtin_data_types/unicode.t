use v6;

use Test;
plan 44;

#L<S02/"Built-In Data Types"/".bytes, .codes or .graphs">

# LATIN CAPITAL LETTER A, COMBINING GRAVE ACCENT
my Str $u = "\x[0041,0300]";
ok $u does utf8, 'can specify Str is utf8';
is $u.bytes, 3, 'combining À is three bytes as utf8';
is $u.codes, 2, 'combining À is two codes';
is $u.graphs, 1, 'combining À is one graph';
is "foo\r\nbar".codes, 8, 'CRLF is 2 codes';
is "foo\r\nbar".graphs, 7, 'CRLF is 1 graph';

# Speculation, .chars is unspecced, also use Bytes etc.
is $u.chars, 1, '.chars defaults to .graphs';

#?pugs 10 todo ''
use_ok 'Bytes', 'use bytes works';
is $u.chars, 3, '.chars as bytes';
use_ok 'Codes', 'use codes works';
is $u.chars, 2, '.chars as codes';
use_ok 'Graphs', 'use graphs works';
is $u.chars, 1, '.chars as graphs';
ok $u does utf16, 'can specify Str is utf16';
is $u.bytes, 4, '.bytes in utf16';
ok $u does utf32, 'can specify Str is utf32';
is $u.bytes, 8, '.bytes in utf32';

#L<S02/"Built-In Data Types"/"coerce to the proper units">
    $u = "\x[41,
            E1,
            41, 0300,
            41, 0302, 0323,
            E0]";

# $u does utf8 etc. is conjectural(?)
$u does utf8;
#?pugs 9 todo ''
is eval('substr $u, 3.as(Bytes),  1.as(Bytes)'),  "\x[41]",             'substr with Bytes as units - utf8';
is eval('substr $u, 3.as(Codes),  1.as(Codes)'),  "\x[0300]",           'substr with Codes as units - utf8';
is eval('substr $u, 4.as(Graphs), 1.as(Graphs)'), "\x[E0]",             'substr with Graphs as units - utf8';
is eval('substr $u, 3.as(Graphs), 1.as(Codes)'),  "\x[41]",             'substr with Graphs and Codes as units 1 - utf8';
is eval('substr $u, 4.as(Codes),  1.as(Graphs)'), "\x[41, 0302, 0323]", 'substr with Graphs and Codes as units 2 - utf8';
is eval('substr $u, 4.as(Bytes),  1.as(Codes)'),  "\x[0300]",           'substr with Bytes and Codes as units 1 - utf8';
is eval('substr $u, 1.as(Codes),  2.as(Bytes)'),  "\x[E1]",             'substr with Bytes and Codes as units 2 - utf8';
is eval('substr $u, 3.as(Bytes),  1.as(Graphs)'), "\x[41, 0300]",       'substr with Bytes and Graphs as units 1 - utf8';
is eval('substr $u, 3.as(Graphs), 1.as(Bytes)'),  "\x[41]",             'substr with Bytes and Graphs as units 2 - utf8';

$u does utf16;
#?pugs 9 todo ''
is eval('substr $u, 4.as(Bytes),  2.as(Bytes)'),  "\x[41]",             'substr with Bytes as units - utf16';
is eval('substr $u, 3.as(Codes),  1.as(Codes)'),  "\x[0300]",           'substr with Codes as units - utf16';
is eval('substr $u, 4.as(Graphs), 1.as(Graphs)'), "\x[E0]",             'substr with Graphs as units - utf16';
is eval('substr $u, 3.as(Graphs), 1.as(Codes)'),  "\x[41]",             'substr with Graphs and Codes as units 1 - utf16';
is eval('substr $u, 4.as(Codes),  1.as(Graphs)'), "\x[41, 0302, 0323]", 'substr with Graphs and Codes as units 2 - utf16';
is eval('substr $u, 6.as(Bytes),  1.as(Codes)'),  "\x[0300]",           'substr with Bytes and Codes as units 1 - utf16';
is eval('substr $u, 1.as(Codes),  2.as(Bytes)'),  "\x[E1]",             'substr with Bytes and Codes as units 2 - utf16';
is eval('substr $u, 4.as(Bytes),  1.as(Graphs)'), "\x[41, 0300]",       'substr with Bytes and Graphs as units 1 - utf16';
is eval('substr $u, 3.as(Graphs), 2.as(Bytes)'),  "\x[41]",             'substr with Bytes and Graphs as units 2 - utf16';

$u does utf32;
#?pugs 9 todo ''
is eval('substr $u, 8.as(Bytes),  4.as(Bytes)'),  "\x[41]",             'substr with Bytes as units - utf32';
is eval('substr $u, 3.as(Codes),  1.as(Codes)'),  "\x[0300]",           'substr with Codes as units - utf32';
is eval('substr $u, 4.as(Graphs), 1.as(Graphs)'), "\x[E0]",             'substr with Graphs as units - utf32';
is eval('substr $u, 3.as(Graphs), 1.as(Codes)'),  "\x[41]",             'substr with Graphs and Codes as units 1 - utf32';
is eval('substr $u, 4.as(Codes),  1.as(Graphs)'), "\x[41, 0302, 0323]", 'substr with Graphs and Codes as units 2 - utf32';
is eval('substr $u, 12.as(Bytes), 1.as(Codes)'),  "\x[0300]",           'substr with Bytes and Codes as units 1 - utf32';
is eval('substr $u, 1.as(Codes),  4.as(Bytes)'),  "\x[E1]",             'substr with Bytes and Codes as units 2 - utf32';
is eval('substr $u, 8.as(Bytes),  1.as(Graphs)'), "\x[41, 0300]",       'substr with Bytes and Graphs as units 1 - utf32';
is eval('substr $u, 3.as(Graphs), 4.as(Bytes)'),  "\x[41]",             'substr with Bytes and Graphs as units 2 - utf32';
