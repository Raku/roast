use Test;
plan *;

my regex abc { abc }

ok 'foo abc def' ~~ / <&abc> /, '<&abc> does lexical lookup';
is ~$/, 'abc', 'matched the right part of the string';

is $/.keys.elems, 0, '... and does not capture (1)';
nok $<abc>, '... and does not capture (2)';
nok $<&abc>, '... and does not capture (3)';

done_testing;
