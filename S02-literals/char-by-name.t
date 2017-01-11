use v6;

use Test;

plan 11;

# XXX [TODO] more tests in other Unicode charset.

# L<S02/Unicode codepoints>

is "\c[LEFT CORNER BRACKET]", "「", '\c[LEFT CORNER BRACKET]';
is "\c[RIGHT WHITE CORNER BRACKET]", "』", '\c[RIGHT WHITE CORNER BRACKET]';
is "\c[FULLWIDTH RIGHT PARENTHESIS]", "）", '\c[FULLWIDTH RIGHT PARENTHESIS]';
is "\c[LEFT DOUBLE ANGLE BRACKET]", "《", '\c[LEFT DOUBLE ANGLE BRACKET]';

#?niecza skip 'Unrecognized character name LINE FEED'
is("\c[LINE FEED]", "\c10", '\c[LINE FEED] works');
is("\c[LF]", "\c10", '\c[LF] works');

# L<S02/Unicode codepoints/"Multiple codepoints constituting a single character">
is "\c[LATIN CAPITAL LETTER A, LATIN CAPITAL LETTER B]", 'AB', 'two letters in \c[]';
is "\c[LATIN CAPITAL LETTER A, COMBINING GRAVE ACCENT]", "\x[0041,0300]", 'letter and combining char in \c[]';

ok "\c[LATIN SMALL LETTER A WITH DIAERESIS,COMBINING CEDILLA]" ~~ /\w/,
   'RT #64918 (some strings throw "Malformed UTF-8 string" errors';
#?rakudo skip 'RT #130542 \c[BELL] returns the U+0007 control code not U+1F514 BELL'
is "\c[BELL]", "🔔", '\c[BELL] returns 🔔, BELL symbol not the control character';
# vim: ft=perl6
