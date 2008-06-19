use v6;
use Test;

plan 21;

#L<S05/Unchanged syntactic features/"While the syntax of | does not change">

my $str = 'a' x 7;

ok $str ~~ m:g/a|aa|aaaa/, 'basic sanity with |';
is ~$/, 'aaaa', 'Longest alternative wins 1';

ok $str ~~ m:g/a|aa|aaaa/, 'Second match still works';
is ~$/, 'aa',   'Longest alternative wins 2';

ok $str ~~ m:g/a|aa|aaaa/, 'Third match still works';
is ~$/, 'a',    'Only one alternative left';

ok $str !~~ m:g/a|aa|aaaa/, 'No fourth match';

# now test with different order in the regex - it shouldn't matter at all

ok $str ~~ m:g/aa|a|aaaa/, 'basic sanity with |, different order';
is ~$/, 'aaaa', 'Longest alternative wins 1, different order';

ok $str ~~ m:g/aa|a|aaaa/, 'Second match still works, different order';
is ~$/, 'aa',   'Longest alternative wins 2, different order';

ok $str ~~ m:g/aa|a|aaaa/, 'Third match still works, different order';
is ~$/, 'a',    'Only one alternative left, different order';

ok $str !~~ m:g/aa|a|aaaa/, 'No fourth match, different order';

{
    my @list = <a aa aaaa>;
    ok $str ~~ m:g/ @list /, 'basic sanity with interpolated arrays';
    is ~$/, 'aaaa', 'Longest alternative wins 1';

    ok $str ~~ m:g/ @list /, 'Second match still works';
    is ~$/, 'aa',   'Longest alternative wins 2';

    ok $str ~~ m:g/ @list /, 'Third match still works';
    is ~$/, 'a',    'Only one alternative left';

    ok $str !~~ m:g/ @list /, 'No fourth match';
}


# vim: ft=perl6
