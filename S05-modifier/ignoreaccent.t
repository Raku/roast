use v6;
use Test;

plan 10;

=begin description

Testing the C<:m> or C<:ignoremark> regex modifier - more tests are always welcome

TODO: need some tests for chars with multiple markings.
TODO: need some tests for combined :ignoremark and :sigspace modifiers

=end description

#L<S05/Modifiers/"The :a">

#?pugs 999 skip feature
ok(!'ä' ~~ m/a/,  'No :ignoreaccent: a doesnt match ä');
ok('ä' ~~ m:m/a/, 'Ignoreaccent: a matches ä');
ok('a' ~~ m:m/ä/, 'Ignoreaccent: ä matches a');
ok('à' ~~ m:m/a/, 'Ignoreaccent: a matches à');
ok('á' ~~ m:m/a/, 'Ignoreaccent: a matches á');
ok('â' ~~ m:m/a/, 'Ignoreaccent: a matches â');
ok('å' ~~ m:m/a/, 'Ignoreaccent: a matches å');
ok('ƌ' ~~ m:m/d/, 'Ignoreaccent: d matches ƌ');
ok('å' ~~ m:m/ä/, 'Both pattern and string may contain accents');
ok('a' ~~ m:m/ä/, 'Pattern may contain accents');

# vim: syn=perl6 sw=4 ts=4 expandtab
