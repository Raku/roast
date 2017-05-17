use v6;
use lib <t/spec/packages>;
use Test;
use Test::Util;

plan 18;

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

# https://irclog.perlgeek.de/perl6-dev/2017-05-16#i_14593021
subtest '$limit does not pad result with Nils' => {
    plan 6*3 + 4*2;
    for Str.^lookup('words'), Cool.^lookup('words'), &words -> &WORDS {
        my $d = ('(Str.words)', '(Cool.words)', '(&words)')[$++];

        is-eqv WORDS('',     0), (      ).Seq, "empty string,  0  limit $d";
        is-eqv WORDS('',    10), (      ).Seq, "empty string,  1  limit $d";
        is-eqv WORDS('foo', 0 ), (      ).Seq, "1 word (Str),  0  limit $d";
        is-eqv WORDS('foo', 10), ('foo',).Seq, "1 word (Str),  10 limit $d";
        is-eqv WORDS('foo bar', 4), ('foo', 'bar').Seq,
            "2 words (Str), 4 limit $d";
        is-eqv WORDS('foo bar', 1), ('foo',).Seq,
            "2 words (Str), 1 limit $d";

        $++ and do { # can't do these with Str.words candidate
            is-eqv WORDS(1234, 0 ), (       ).Seq, "1 word (Cool), 0  limit $d";
            is-eqv WORDS(1234, 10), ('1234',).Seq, "1 word (Cool), 10 limit $d";
            is-eqv WORDS('foo bar' ~~ /.+/, 4), ('foo', 'bar').Seq,
                "2 words (Cool), 4 limit $d";
            is-eqv WORDS('foo bar' ~~ /.+/, 1), ('foo',).Seq,
                "2 words (Cool), 1 limit $d";
        }
    }
}

# vim: ft=perl6
