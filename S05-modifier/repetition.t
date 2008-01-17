use v6-alpha;
use Test;

plan 2;

#L<S05/Modifiers/"If followed by an x, it means repetition.">

#?pugs skip_rest "Not yet implemented"

ok('abab' ~~ m:2x/ab/,  ':2x (repetition) modifier (1)');
ok('ab' !~~ m:2x/ab/, ':2x (repetition) modifier (1)');

