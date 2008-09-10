use v6;

use Test;

plan 9;

# XXX [TODO] more tests in other Unicode charset.

# L<S02/Literals/interpolate Unicode "by name" using "\c"
#   and "square brackets">

is "\c[LEFT CORNER BRACKET]", "「", '\c[LEFT CORNER BRACKET]';
is "\c[RIGHT WHITE CORNER BRACKET]", "』", '\c[RIGHT WHITE CORNER BRACKET]';
is "\c[FULLWIDTH RIGHT PARENTHESIS]", "）", '\c[FULLWIDTH RIGHT PARENTHESIS]';
is "\c[LEFT DOUBLE ANGLE BRACKET]", "《", '\c[LEFT DOUBLE ANGLE BRACKET]';

#?pugs 3 todo 'Character literals with \c$number'
is("\c[LINE FEED (LF)]", "\c10", '\c[LINE FEED (LF)] works');
is("\c[LINE FEED]", "\c10", '\c[LINE FEED] works');
is("\c[LF]", "\c10", '\c[LF] works');

# L<S02/Literals/"Multiple codepoints constituting a single character">
#?pugs 2 todo 'List of characters in \c[...]'
is "\c[LATIN CAPITAL LETTER A, LATIN CAPITAL LETTER B]", 'AB', 'two letters in \c[]';
is "\c[LATIN CAPITAL LETTER A, COMBINING GRAVE ACCENT]", "\x[0041,0300]", 'letter and combining char in \c[]';
