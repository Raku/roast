use v6;
use Test;

plan 12;

#L<S05/Modifiers/"If followed by an x, it means repetition.">

#?pugs emit skip_rest("Not yet implemented");

#?rakudo todo ':2x'
ok('abab' ~~ m:2x/ab/,  ':2x (repetition) modifier (+)');
nok('ab'  ~~ m:2x/ab/, ':2x (repetition) modifier (-)');

#?rakudo todo ':x(2)'
ok('abab' ~~ m:x(2)/ab/, ':2x (repetition) modifier (+)');
nok('ab'  ~~ m:x(2)/ab/, ':2x (repetition) modifier (-)');

{
    ok 'ababc'.match(rx/ab/, :x(2)), ':x(2) with .match method (+)';
    nok  'abc'.match(rx/ab/, :x(2)), ':x(2) with .match method (-)';

    ok 'ababc'.match(rx/./, :x(3)), ':x(3) with .match method (bool)';
    is 'ababc'.match(rx/./, :x(3)).join('|'), 'a|b|a', ':x(3) with .match method (result)';
}

{
    ok 'abacad'.match(rx/a./, :x(1..3)), ':x(Range)';
    nok 'abcabc'.match(rx/a./, :x(3..4)), ':x(Range) > number of matches';
    is 'abacadae'.match(rx/a./, :x(1..3)).join('|'), 'ab|ac|ad', ':x(Range) (upper bound)';
    is 'abacad'.match(rx/a./, :x(2..5)).join('|'), 'ab|ac|ad', ':x(Range) (takes as much as it can)';
}

# vim: syn=perl6 sw=4 ts=4 expandtab
