use v6;

use Test;

#L<S06/"Macros">

plan 1;

#RT #115506
eval_lives_ok
    'macro pathological { AST.new }; pathological();',
    "macro returning AST.new doesn't blow up";

# vim: ft=perl6
