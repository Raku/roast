use v6;
use Test;

plan 4;

# should be: L<S05/Bracket rationalization/"An B<explicit> reduction using the C<make> function">
# L<S05/Bracket rationalization/reduction using the>

# L<S05/Match objects/"Fortunately, when you just want to return a different">

"blah foo blah" ~~ / foo                 # Match 'foo'
                      { make 'bar' }     # But pretend we matched 'bar'
                    /;
ok($/, 'matched');
is($(), 'bar');
is $/.ast, 'bar', '$/.ast';

# RT #76276
{
    "foo" ~~ /foo/;
    is "What kind of $()l am I?", 'What kind of fool am I?', '$() falls back to $/.Str when nothing was made';
}

# vim: ft=perl6
