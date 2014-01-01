use v6;
use Test;

plan 3;

# RT #115134: [BUG] BEGIN { EVAL "..." } Confuses Rakudo
# The bug is triggered by the closing brace being directly
# followed by a newline and the next statement.
eval_lives_ok(q[BEGIN { EVAL '0' }
0], 'EVAL in BEGIN { ... } followed by newline works');

eval_lives_ok(q[BEGIN { EVAL '0' };
0], 'EVAL in BEGIN { ... } followed by semicolon and newline works');

eval_lives_ok(q[BEGIN { EVAL '0' };0], 'EVAL in BEGIN { ... } followed by semicolon works');

