use v6;
use Test;

plan 2;

# L<S16/Input and Output/"As with print, it is a compiler error to use a
# bare say withoutarguments.">

eval_dies_ok('say', 'bare say is a compiler error');
eval_dies_ok('print', 'bare print is a compiler error');

# TODO: to test that 'say ()', 'say()' etc work
# we have to redirect their output
