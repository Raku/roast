use v6;
use Test;

plan 6;

#L<S05/Unchanged syntactic features/"While the syntax of | does not change">

my $str = 'a' x 7;

ok $str ~~ m:g/a|aa|aaaa/, 'basic sanity with |';
is ~$/, 'aaaa', 'Longest alternative wins 1';

ok $str ~~ m:g/a|aa|aaaa/, 'Second match still works';
is ~$/, 'aa',   'Longest alternative wins 2';

ok $str ~~ m:g/a|aa|aaaa/, 'Third match still works';
is ~$/, 'a',    'Only one alternative left';

# vim: ft=perl6
