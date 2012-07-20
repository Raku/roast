use v6;
use Test;

plan 10;

=begin description

Testing the C<:m> or C<:ignoremark> regex modifier - more tests are always welcome

TODO: need some tests for chars with multiple markings.
TODO: need some tests for combined :ignoremark and :sigspace modifiers

=end description

#L<S05/Modifiers/"The :m (or :ignoremark) modifier">

#?pugs 999 skip feature
ok(!'ä' ~~ m/a/,  'No :ignoremark: a doesnt match ä');
ok('ä' ~~ m:m/a/, 'Ignoremark: a matches ä');
ok('a' ~~ m:m/ä/, 'Ignoremark: ä matches a');
ok('à' ~~ m:m/a/, 'Ignoremark: a matches à');
ok('á' ~~ m:m/a/, 'Ignoremark: a matches á');
ok('â' ~~ m:m/a/, 'Ignoremark: a matches â');
ok('å' ~~ m:m/a/, 'Ignoremark: a matches å');
ok('ƌ' ~~ m:m/d/, 'Ignoremark: d matches ƌ');
ok('å' ~~ m:m/ä/, 'Both pattern and string may contain accents');
ok('a' ~~ m:m/ä/, 'Pattern may contain accents');

# vim: syn=perl6 sw=4 ts=4 expandtab
