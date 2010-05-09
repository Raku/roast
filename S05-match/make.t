use v6;
use Test;

plan 5;

# should be: L<S05/Bracket rationalization/"An B<explicit> reduction using the C<make> function">
# L<S05/Bracket rationalization/reduction using the>

"4" ~~ / (\d) { make $0.sqrt } Remainder /;
nok($/);
is($/.ast , 2);

# L<S05/Match objects/"Fortunately, when you just want to return a different">

"blah foo blah" ~~ / foo                 # Match 'foo'
                      { make 'bar' }     # But pretend we matched 'bar'
                    /;
ok($/);
is($(), 'bar');
is $/.ast, 'bar', '$/.ast';

# vim: ft=perl6
