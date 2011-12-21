use v6;

use Test;

plan 12;

# L<S32::Str/Str/=item words>

# words on Str
is "".words, (), 'words on empty string';
is "a".words, <a>, 'words on single character';
is "a bc d".words, <a bc d>, 'default matcher and limit';
is " a bc d ".words, <a bc d>, 'default matcher and limit (leading/trailing ws)';
is "a  bc  d".words, <a bc d>, 'words on string with double spaces';

is "a\tbc\td".words, <a bc d>, 'words on string with \t';
is "a\nbc\nd".words, <a bc d>, 'words on string with \n';

is "a\c[NO-BREAK SPACE]bc d".words, <a bc d>, 'words on string with (U+00A0 NO-BREAK SPACE)';
is "ä bc d".words, <ä bc d>, 'words on string with non-ASCII letter';

#?rakudo 2 skip 'graphemes not implemented'
#?niecza 2 skip 'charspec'
is "a\c[COMBINING DIAERESIS] bc d".words, ("ä", "bc", "d"), 'words on string with grapheme precomposed';
is( "a\c[COMBINING DOT ABOVE, COMBINING DOT BELOW] bc d".words,
    ("a\c[COMBINING DOT BELOW, COMBINING DOT ABOVE]", "bc", "d"),
    "words on string with grapheme without precomposed");

{
    my @list =  'split this string'.words;
    is @list.join('|'), 'split|this|string', 'Str.words';
}


# vim: ft=perl6
