use Test;

plan 60;

=begin description

Testing the C<:m> or C<:ignoremark> regex modifier - more tests are always welcome

TODO: need some tests for chars with multiple markings.

=end description

#L<S05/Modifiers/"The :m (or :ignoremark) modifier">
my @a =
    ('ä', 'a', '', True),
    ('a', 'ä', '', True),
    ('à', 'a', '', True),
    ('á', 'a', '', True),
    ('â', 'a', '', True),
    ('å', 'a', '', True),
    ('ƌ', 'd', 'TOPBAR is not a mark', False),
    ( 'å', 'ä', 'Both pattern and string may contain accents', True),
    ('a', 'ä', 'Pattern may contain accents', True)
;
sub get-string ($Haystack, $needle, $expected, $str) {
    “so('$Haystack' ~~ /:m $needle /), $expected — Ignoremark: $Haystack { $expected ?? ‘matches’ !! “doesn't match” } {$needle}{ $str ?? " — $str" !! "" }”;
}
for @a -> $i {
    my $str = “so('$i[0]' ~~ m:m/ {$i[1]} /), $i[3] — Ignoremark: $i[0] { $i[3] ?? ‘matches’ !! “doesn't match” } {$i[1]}{ $i[2] ?? " — $i[2]" !! "" }”;
    my $Haystack = $i[0];
    my $needle   = $i[1];
    my $expected = $i[3];
    is( so($Haystack ~~ /:m $needle /), $expected, get-string($Haystack, $needle, $expected, $i[2]));
    next if $expected == False;
    # Make sure uppercasing causes it not to match
    $Haystack = $Haystack.uc;
    is( so($Haystack ~~ /:m $needle /), !$expected, get-string($Haystack, $needle, !$expected, $i[2]));
    $Haystack = $i[0];
    $needle = $needle.uc;
    is( so($Haystack ~~ /:m $needle /), !$expected, get-string($Haystack, $needle, !$expected, $i[2]));
}

ok( 'ä'  ~~ m:ignoremark/a/, 'Ignoremark: spelling out :ignoremark also works');
ok( 'ä'  ~~ /:ignoremark a/, 'Ignoremark: spelling out :ignoremark also works');

is('fooäàaáâåbar' ~~ m:m/a+ b/,    'äàaáâåb',  'Ignoremark: a+ b');
is('fooäàaáâåbar' ~~ m:m/<[ab]>+/, 'äàaáâåba', 'Ignoremark with character class');
is('fooäàaáâåbar' ~~ m:m/<-[a]>+/, 'foo',      'Ignoremark with negated character class');

is('fooäàaáâåbar' ~~ m:m/<[a..b]>+/, 'äàaáâåba', 'Ignoremark with range in character class');

# https://github.com/rakudo/rakudo/issues/3815
ok('' ~~ m:m/''/, ':m can match empty string regex to the empty string');

# https://github.com/Raku/old-issue-tracker/issues/3017
{
    ok("ü" ~~ /:ignoremark 'u'/, 'Ignoremark with subrule');
}

# https://github.com/Raku/old-issue-tracker/issues/5956
{
    ok qq["\c[COMBINING TILDE]"] ~~ / ^ :ignoremark '"'/,
        'Ignoremark on quoted double-quote';
    ok qq["\c[COMBINING TILDE]"] ~~ / ^ :ignoremark \"/,
        'Ignoremark on backslashed double-quote';
}
#
# Ensure that synthetics also properly can match the base character
is "\c[LATIN SMALL LETTER J WITH CARON, COMBINING DOT BELOW]" ~~ /:m:i j /, 'ǰ̣', "Synthetics with decomposable base characters properly work with ignoremark";
ok qq{"\c[ZERO WIDTH JOINER]a"} ~~ / (:ignoremark ^ '"' ) /, "Synthetics properly can be matched with ignoremark";
is “{"\c[ARABIC NUMBER SIGN]" x 3}a” ~~ /:m a/, “{"\c[ARABIC NUMBER SIGN]" x 3}a”, "Igoremark supports Prepend";
my Int:D $val = 0;
for ^ 10 {
    my Str:D $str =  "\c[arabic number sign]" x $_ ~ 'a';
    $val++ if "\c[arabic number sign]" x $_ ~ 'a' ~~ /:m a/ eq $str;
}
ok $val == 10, "Ignoremark supports 0..9 prepend marks";
is "\c[ARABIC NUMBER SIGN]" ~~ /:m "\c[ARABIC NUMBER SIGN]" /, "\c[ARABIC NUMBER SIGN]", "Ignoremark can match degenerate Prepend";
is "\c[SYRIAC ABBREVIATION MARK, ARABIC NUMBER SIGN]" ~~ /:m "\c[SYRIAC ABBREVIATION MARK]" /, "\c[SYRIAC ABBREVIATION MARK, ARABIC NUMBER SIGN]", "Ignoremark matches the first codepoint for all Prepend degenerates";
nok "\c[SYRIAC ABBREVIATION MARK, ARABIC NUMBER SIGN]" ~~ /:m "\c[ARABIC NUMBER SIGN]" /, "Ignoremark does not match the second codepoint for all Prepend degenerates";
nok "\c[SYRIAC ABBREVIATION MARK, COMBINING CARON]" ~~ /:m "\c[COMBINING CARON]" /, "Ignoremark doesn't match second codepoint for Prepend+Extend degenerate";
is "\c[SYRIAC ABBREVIATION MARK, COMBINING CARON]" ~~ /:m "\c[SYRIAC ABBREVIATION MARK]" /, "\c[SYRIAC ABBREVIATION MARK, COMBINING CARON]", "Ignoremark matches the first codepoint for all Prepend+Extend degenerates";

# https://github.com/rakudo/rakudo/issues/2961
{
    is "a\x[300]" ~~ / :ignoremark <[ a b c ]> /, 'à', 'charclass ok';
}

# https://github.com/rakudo/rakudo/issues/2962
{
    is "a\x[300]" ~~ / :ignoremark <[ a \n ]> /, 'à', 'charclass with a newline escape matches a marked character';
    is "a\x[300]" ~~ / :ignoremark <[ a \r\n ]> /, 'à', 'charclass with carriage return and newline escapes matches a marked character';
    is "a\x[300]" ~~ / :ignoremark [ \n | <[ a ]> ] /, 'à', 'charclass after an alternation branch matches a marked character';
    is "a\x[300]" ~~ / :ignoremark [ <[ a ]> | \n ] /, 'à', 'charclass before an alternation branch matches a marked character';
    nok "x" ~~ / :ignoremark <[ a \n ]> /, 'charclass with a newline escape still rejects other characters';
    is "a" ~~ / :ignoremark <[ \x[E0] ]> /, 'a', 'hex escape in a charclass ignores its mark';
    is "a\x[300]" ~~ / :ignoremark <[ a \x[300] ]> /, 'à', 'charclass entry formed by a base character and combining escape matches a marked character';
    is "a\x[300]" ~~ / :ignoremark [ \n | <[ b a ]> ] /, 'à', 'charclass in an alternation matches on its second entry';
    nok "a\x[300]" ~~ / :ignoremark <-[ a \x[300] ]> /, 'negated charclass entry formed by a base character and combining escape rejects a marked character';
    is "b\x[300]" ~~ / :ignoremark <-[ a \x[300] ]> /, "b\x[300]", 'negated charclass entry formed by a base character and combining escape accepts another marked character';
    is "A\x[300]" ~~ / :i:m <[ \x[61] ]> /, 'À', 'hex escape in a charclass ignores case and mark together';
    is "a" ~~ / :i:m <[ \x[C0] ]> /, 'a', 'hex escape with a mark in a charclass matches the bare base character under ignorecase and ignoremark';
    is "b\x[300]" ~~ / :ignoremark [ \n | <-[ a ]> ] /, "b\x[300]", 'negated charclass in an alternation accepts another marked character';
    is "\n" ~~ / :ignoremark <[ \x[D]\x[A] \x[A] ]> /, "\n", 'folded entries that would form one grapheme stay separate entries';
    is "\r" ~~ / :ignoremark <[ \x[D]\x[A] \x[A] ]> /, "\r", 'a folded carriage return newline entry matches a carriage return';
}

# vim: expandtab shiftwidth=4
