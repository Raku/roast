use v6;

use Test;

plan 17;

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

#?rakudo.jvm 2 todo 'NFG on JVM RT #124739'
is "a\c[COMBINING DIAERESIS] bc d".words, ("ä", "bc", "d"), 'words on string with grapheme precomposed';
is( "a\c[COMBINING DOT ABOVE, COMBINING DOT BELOW] bc d".words,
    ("a\c[COMBINING DOT BELOW, COMBINING DOT ABOVE]", "bc", "d"),
    "words on string with grapheme without precomposed");

{
    my @list =  'split this string'.words;
    is @list.join('|'), 'split|this|string', 'Str.words';
}

# RT #120517
{
    my $RT120517 = "FOO";
    is qq:ww/$RT120517 "BAR BAZ"/.perl, qq:ww/FOO "BAR BAZ"/.perl, "interpolated variable .perl's like a literal"
}

{
    my $str = "foo bar baz";

    # Test that sub form of words works at all
    my @first-words = try words($str);
    is +@first-words, 3, 'words($str)';

    # Test sub form of words with * and Inf args; RT #125626
    my @words = try words($str, Inf);
    is +@words, 3, 'words($str, Inf)';

    my @other-words = try words($str, *);
    is +@other-words, 3, 'words($str, *)';
}

# https://github.com/rakudo/rakudo/commit/742573724c
dies-ok { 42.words: |<bunch of incorrect args> },
    'no infinite loop when given wrong args to Cool.words';

# vim: ft=perl6
