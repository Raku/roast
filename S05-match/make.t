use v6;
use Test;

plan 9;

# should be: L<S05/Bracket rationalization/"An B<explicit> reduction using the C<make> function">
# L<S05/Bracket rationalization/reduction using the>

# L<S05/Match objects/"Fortunately, when you just want to return a different">

# https://github.com/Raku/old-issue-tracker/issues/1901
"blah foo blah" ~~ / foo                 # Match 'foo'
                      { make 'bar' }     # But pretend we matched 'bar'
                    /;
ok($/, 'matched');
is $/.ast, 'bar', '$/.ast';

{
    temp $/;
    "" ~~ /^/;
    cmp-ok $/.made, '===', Nil, 'unmade Match returns Nil from .made';
    cmp-ok $/.ast,  '===', Nil, 'unmade Match returns Nil from .ast';

    $/.make: Any;
    cmp-ok $/.made, '===', Any, 'can get made type objects from .made (1)';
    cmp-ok $/.ast,  '===', Any, 'can get made type objects from .ast  (1)';

    my class FooBar {}
    $/.make: FooBar;
    cmp-ok $/.made, '===', FooBar, 'can get made type objects from .made (2)';
    cmp-ok $/.ast,  '===', FooBar, 'can get made type objects from .ast  (2)';
}

# https://github.com/rakudo/rakudo/issues/2057
{
    lives-ok { "" ~~ /{ (make 0 for 0) }/ for ^100 },
      'check that we did not regress';
}

# vim: expandtab shiftwidth=4
