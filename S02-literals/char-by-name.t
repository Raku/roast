use v6;

use Test;

plan 11;

# XXX [TODO] more tests in other Unicode charset.

# L<S02/Unicode codepoints>

is "\c[LEFT CORNER BRACKET]", "「", '\c[LEFT CORNER BRACKET]';
is "\c[RIGHT WHITE CORNER BRACKET]", "』", '\c[RIGHT WHITE CORNER BRACKET]';
is "\c[FULLWIDTH RIGHT PARENTHESIS]", "）", '\c[FULLWIDTH RIGHT PARENTHESIS]';
is "\c[LEFT DOUBLE ANGLE BRACKET]", "《", '\c[LEFT DOUBLE ANGLE BRACKET]';

is("\c[LINE FEED]", "\c10", '\c[LINE FEED] works');
is("\c[LF]", "\c10", '\c[LF] works');

# L<S02/Unicode codepoints/"Multiple codepoints constituting a single character">
is "\c[LATIN CAPITAL LETTER A, LATIN CAPITAL LETTER B]", 'AB', 'two letters in \c[]';
is "\c[LATIN CAPITAL LETTER A, COMBINING GRAVE ACCENT]", "\x[0041,0300]", 'letter and combining char in \c[]';

ok "\c[LATIN SMALL LETTER A WITH DIAERESIS,COMBINING CEDILLA]" ~~ /\w/,
   'RT #64918 (some strings throw "Malformed UTF-8 string" errors';
#?rakudo.jvm todo "RT #130542 BELL resolves to U+0007"
is "\c[BELL]", "🔔", '\c[BELL] returns 🔔, BELL symbol not the control character'; # RT #130542

#?rakudo.jvm skip "rakudo.jvm does not yet support Emoji Sequences"
is "\c[woman gesturing OK]".ords, (0x1F646, 0x200D, 0x2640, 0xFE0F), "\\c[woman gesturing OK] works. Emoji ZWJ sequences";
# vim: ft=perl6
