use Test;
plan *;

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


done_testing;
