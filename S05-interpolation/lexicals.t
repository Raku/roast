use v6.c;
use Test;
plan 14;

my regex abc { abc }

ok 'foo abc def' ~~ / <&abc> /, '<&abc> does lexical lookup';
is ~$/, 'abc', 'matched the right part of the string';

nok $<abc>, '... and does not capture (2)';
nok $<&abc>, '... and does not capture (3)';

ok 'fooabcdef' ~~ / . <abc=&abc> . /, '<abc=&abc> captures lexical regex';

is ~$/, 'oabcd', 'correctly matched string';
is $<abc>, 'abc', 'correctly captured to $<abc>';

ok 'fooabcdef' ~~ / . <other=&abc> . /, '<other=&abc> captures lexical regex';

is ~$/, 'oabcd', 'correctly matched string';
is $<other>, 'abc', 'correctly captured to $<other>';

# RT #77152
{
    my regex foo($s) { $s };

    ok 'a' ~~ / <&foo('a')> /, '<&foo(...)> parses and passes args correctly (1)';
    nok 'a' ~~ / <&foo('b')> /, '<&foo(...)> parses and passes args correctly (2)';

    ok 'c' ~~ / <&foo: 'c'> /, '<&foo: ...> parses and passes args correctly (1)';
    nok 'c' ~~ / <&foo: 'd'> /, '<&foo: ...> parses and passes args correctly (2)';
}
