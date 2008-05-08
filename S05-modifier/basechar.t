use v6;
use Test;

plan 8;

=begin description

Testing the C<:basechar> regex modifier - more tests are always welcome

TODO: need some tests for chars with multiple markings.

=end description

#L<S05/Modifiers/"The :b">

#?pugs 999 skip feature
ok(!'ä' ~~ m/a/,  'No basechar: a doesnt match ä');
ok('ä' ~~ m:b/a/, 'Basechar: a matches ä');
ok('a' ~~ m:b/ä/, 'Basechar: ä matches a');
ok('à' ~~ m:b/a/, 'Basechar: a matches à');
ok('á' ~~ m:b/a/, 'Basechar: a matches á');
ok('â' ~~ m:b/a/, 'Basechar: a matches â');
ok('å' ~~ m:b/a/, 'Basechar: a matches å');
ok('ƌ' ~~ m:b/d/, 'Basechar: d matches ƌ');

# vim: syn=perl6 sw=4 ts=4 expandtab
