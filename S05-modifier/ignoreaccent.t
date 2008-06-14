use v6;
use Test;

plan 10;

=begin description

Testing the C<:a> or C<:ignoreaccent> regex modifier - more tests are always welcome

TODO: need some tests for chars with multiple markings.
TODO: need some tests for combined :ignoreaccent and :sigspace modifiers

=end description

#L<S05/Modifiers/"The :a">

#?pugs 999 skip feature
ok(!'ä' ~~ m/a/,  'No :ignoreaccent: a doesnt match ä');
ok('ä' ~~ m:a/a/, 'Ignoreaccent: a matches ä');
ok('a' ~~ m:a/ä/, 'Ignoreaccent: ä matches a');
ok('à' ~~ m:a/a/, 'Ignoreaccent: a matches à');
ok('á' ~~ m:a/a/, 'Ignoreaccent: a matches á');
ok('â' ~~ m:a/a/, 'Ignoreaccent: a matches â');
ok('å' ~~ m:a/a/, 'Ignoreaccent: a matches å');
ok('ƌ' ~~ m:a/d/, 'Ignoreaccent: d matches ƌ');
ok('å' ~~ m:a/ä/, 'Both pattern and string may contain accents');
ok('a' ~~ m:a/ä/, 'Pattern may contain accents');

# vim: syn=perl6 sw=4 ts=4 expandtab
