use v6;
use Test;

plan 2;

#L<S05/Modifiers/"If followed by an x, it means repetition.">

#?pugs emit skip_rest("Not yet implemented");

ok('abab' ~~ m:2x/ab/,  ':2x (repetition) modifier (1)');
ok('ab' !~~ m:2x/ab/, ':2x (repetition) modifier (1)');

# vim: syn=perl6 sw=4 ts=4 expandtab
