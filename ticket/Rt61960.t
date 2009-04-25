use v6;

use Test;
plan 2;

my ($x,$y)=<abcdefg fg>;
eval_lives_ok '$x ~~ / $y / and "match"', 'RT 61960 matching scalars should live';
is eval('$x ~~ / $y / and "match"'), 'match', 'RT 61960 matching scalars' ;

