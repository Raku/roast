use v6;

use Test;

#L<S06/"Macros">

plan 2;

#RT #115506
#?rakudo.jvm todo "?"
eval_lives_ok
    'macro pathological { AST.new }; pathological();',
    "macro returning AST.new doesn't blow up";

#RT #115504
#?rakudo.jvm todo "?"
{
    try EVAL 'macro ma { die 1 }; ma';
    is $!, 1, "die-ing inside a macro dies normally.";
}

# vim: ft=perl6
