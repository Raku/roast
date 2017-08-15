use v6;
use Test;

plan 36;

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

# RT #116256
{
    ok("ü" ~~ /:ignoremark 'u'/, 'Ignoremark with subrule');
}

# RT #130465
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
# vim: syn=perl6 sw=4 ts=4 expandtab
