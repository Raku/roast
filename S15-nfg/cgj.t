# for background, see http://irclog.perlgeek.de/perl6/2015-06-08#i_10716770 through 16:44 UTC

# non-normative references:
# http://unicode.org/faq/char_combmark.html#14
# http://unicode.org/faq/char_combmark.html#15
# http://unicode.org/faq/char_combmark.html#16
# http://unicode.org/faq/char_combmark.html#17
# http://unicode.org/faq/char_combmark.html#18

# normative reference
# http://www.unicode.org/versions/Unicode7.0.0/ch23.pdf (pages numbered 805-807)

use Test;

plan 8;

my $control-str = 'o';

is $control-str.chars, 1, "Correct value of .chars for '$control-str' (no combining characters)";

my @non-cgj-combiners = (
    "o\c[COMBINING DOT ABOVE]",
    "o\c[COMBINING DOT BELOW]",
    "o\c[COMBINING DOT ABOVE]\c[COMBINING DOT BELOW]",
);

for @non-cgj-combiners -> $test-str {
    is $test-str.chars, 1, "Correct value of .chars for '$test-str' (combining characters, but not CGJ)";
}

my @cgj-first-combiner = (
    "o\c[COMBINING GRAPHEME JOINER]",
    "o\c[COMBINING DOT ABOVE]\c[COMBINING GRAPHEME JOINER]",
    "o\c[COMBINING GRAPHEME JOINER]\c[COMBINING DOT BELOW]",
    "o\c[COMBINING DOT ABOVE]\c[COMBINING GRAPHEME JOINER]\c[COMBINING DOT BELOW]",
);

for @cgj-first-combiner -> $test-str {
    is $test-str.chars, 1, "Correct value of .chars for '$test-str' (combining characters, including CGJ)";
}
