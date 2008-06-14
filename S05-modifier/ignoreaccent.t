use v6;
use Test;

plan 8;

=begin description

Testing the C<:a> or C<:ignoreaccent> regex modifier - more tests are always welcome

TODO: need some tests for chars with multiple markings.

=end description

#L<S05/Modifiers/"The :a">

#?pugs 999 skip feature
ok(!'ä' ~~ m/a/,  'No :ignoreaccent: a doesnt match ä');
ok('ä' ~~ m:a/a/, 'Basechar: a matches ä');
ok('a' ~~ m:a/ä/, 'Basechar: ä matches a');
ok('à' ~~ m:a/a/, 'Basechar: a matches à');
ok('á' ~~ m:a/a/, 'Basechar: a matches á');
ok('â' ~~ m:a/a/, 'Basechar: a matches â');
ok('å' ~~ m:a/a/, 'Basechar: a matches å');
ok('ƌ' ~~ m:a/d/, 'Basechar: d matches ƌ');

# vim: syn=perl6 sw=4 ts=4 expandtab
