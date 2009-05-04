use v6;
use Test;
plan 5;

# L<S05/C<:keepall>/"if :keepall is in effect">

ok 'ab foo' ~~ m:keepall/<.ident>/, 'basic match with :keepall';
ok $<.ident>, '<.ident> capture is available';
is ~$<.ident>, 'ab', '... with the right content';

ok 'ab foo' ~~ m :s :keepall /<ident> <.ident>/,
        'basic match with :keepall :s';
is ~$<.ws>, ' ', ':s-implied <.ws> capture available under :keepall';

# vim: ft=perl6
