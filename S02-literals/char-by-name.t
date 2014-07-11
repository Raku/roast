use v6;

use Test;

plan 10;

# XXX [TODO] more tests in other Unicode charset.

# L<S02/Unicode codepoints>

is "\c[LEFT CORNER BRACKET]", "「", '\c[LEFT CORNER BRACKET]';
is "\c[RIGHT WHITE CORNER BRACKET]", "』", '\c[RIGHT WHITE CORNER BRACKET]';
is "\c[FULLWIDTH RIGHT PARENTHESIS]", "）", '\c[FULLWIDTH RIGHT PARENTHESIS]';
is "\c[LEFT DOUBLE ANGLE BRACKET]", "《", '\c[LEFT DOUBLE ANGLE BRACKET]';

is("\c[LINE FEED (LF)]", "\c10", '\c[LINE FEED (LF)] works');
#?rakudo skip '\c[LINE FEED] not valid'
#?niecza skip 'Unrecognized character name LINE FEED'
is("\c[LINE FEED]", "\c10", '\c[LINE FEED] works');
#?rakudo skip '\c[LF] not valid'
is("\c[LF]", "\c10", '\c[LF] works');

# L<S02/Unicode codepoints/"Multiple codepoints constituting a single character">
is "\c[LATIN CAPITAL LETTER A, LATIN CAPITAL LETTER B]", 'AB', 'two letters in \c[]';
is "\c[LATIN CAPITAL LETTER A, COMBINING GRAVE ACCENT]", "\x[0041,0300]", 'letter and combining char in \c[]';

ok "\c[LATIN SMALL LETTER A WITH DIAERESIS,COMBINING CEDILLA]" ~~ /\w/,
   'RT 64918 (some strings throw "Malformed UTF-8 string" errors';

# vim: ft=perl6
