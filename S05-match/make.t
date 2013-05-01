use v6;
use Test;

plan 3;

# should be: L<S05/Bracket rationalization/"An B<explicit> reduction using the C<make> function">
# L<S05/Bracket rationalization/reduction using the>

# L<S05/Match objects/"Fortunately, when you just want to return a different">

"blah foo blah" ~~ / foo                 # Match 'foo'
                      { make 'bar' }     # But pretend we matched 'bar'
                    /;
ok($/, 'matched');
is($(), 'bar');
is $/.ast, 'bar', '$/.ast';

# vim: ft=perl6
