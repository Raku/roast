use v6;
use Test;

plan 4;

# L<S05/Bracket rationalization/"An explicit reduction using the make function sets the result object for this match:">

"4" ~~ / (\d) { make $0.sqrt } Remainder /;
ok($/);
is($( $/ ), 2);

# L<S05/Match objects/"Fortunately, when you just want to return a different result object">

"blah foo blah" ~~ / foo                 # Match 'foo'
                      { make 'bar' }     # But pretend we matched 'bar'
                    /;
ok($/);
is($(), 'bar');
