use v6;
use Test;

plan 20;

=begin description

Testing the C<:m> or C<:ignoremark> regex modifier - more tests are always welcome

TODO: need some tests for chars with multiple markings.

=end description

#L<S05/Modifiers/"The :m (or :ignoremark) modifier">

ok(!'ä' ~~ m/a/,  'No :ignoremark: a doesnt match ä');
ok('ä' ~~ m:m/a/, 'Ignoremark: a matches ä');
ok('a' ~~ m:m/ä/, 'Ignoremark: ä matches a');
ok('à' ~~ m:m/a/, 'Ignoremark: a matches à');
ok('á' ~~ m:m/a/, 'Ignoremark: a matches á');
ok('â' ~~ m:m/a/, 'Ignoremark: a matches â');
ok('å' ~~ m:m/a/, 'Ignoremark: a matches å');
ok('ƌ' !~~ m:m/d/, 'Ignoremark: d does not match ƌ, TOPBAR is not a mark');
ok('å' ~~ m:m/ä/, 'Both pattern and string may contain accents');
ok('a' ~~ m:m/ä/, 'Pattern may contain accents');
ok('ä' ~~ m:ignoremark/a/, 'Ignoremark: spelling out :ignoremark also works');

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
