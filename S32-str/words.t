use v6;

use Test;

plan 11;

# L<S32::Str/Str/=item words>

# words on Str
is "".words, (), 'words on empty string';
is "a bc d".words, <a bc d>, 'default matcher and limit';
is " a bc d ".words, <a bc d>, 'default matcher and limit (leading/trailing ws)';
is "a  bc  d".words, <a bc d>, 'words on string with double spaces';

is "a\tbc\td".words, <a bc d>, 'words on string with \t';
is "a\nbc\nd".words, <a bc d>, 'words on string with \n';

is "a\c[NO-BREAK SPACE]bc d".words, <a bc d>, 'words on string with (U+00A0 NO-BREAK SPACE)';
is "ä bc d".words, <ä bc d>, 'words on string with non-ASCII letter';

#?rakudo 2 todo 'graphemes not implemented'
is "a\c[COMBINING DIAERESIS] bc d".words, ("ä", "bc", "d"), 'words on string with grapheme precomposed';
is( "a\c[COMBINING DOT ABOVE, COMBINING DOT BELOW] bc d",
    ("a\c[COMBINING DOT BELOW, COMBINING DOT ABOVE]", "bc", "d"),
    "words on string with grapheme without precomposed");

{
    my @list =  'split this string'.words;
    is @list.join('|'), 'split|this|string', 'Str.words';
}

