use v6-alpha;
use Test;

plan 8;

=pod

Testing the C<:basechar> regex modifier - more tests are always welcome

TODO: need some tests for chars with multiple markings.

=cut

#L<S05/Modifiers/"The :b">

#?pugs skip_rest "not yet implemented"

ok(!'ä' ~~ m/a/,  'No basechar: a doesnt match ä');
ok('ä' ~~ m:b/a/, 'Basechar: a matches ä');
ok('a' ~~ m:b/ä/, 'Basechar: ä matches a');
ok('à' ~~ m:b/a/, 'Basechar: a matches à');
ok('á' ~~ m:b/a/, 'Basechar: a matches á');
ok('â' ~~ m:b/a/, 'Basechar: a matches â');
ok('å' ~~ m:b/a/, 'Basechar: a matches å');
ok('ƌ' ~~ m:b/d/, 'Basechar: d matches ƌ');
