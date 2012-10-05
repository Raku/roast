use v6;
use Test;

plan 3;

# RT #115134: [BUG] BEGIN { eval "..." } Confuses Rakudo
# The bug is triggered by the closing brace being directly
# followed by a newline and the next statement.
#?rakudo todo 'RT #115134'
eval_lives_ok(q[BEGIN { eval '0' }
0], 'eval in BEGIN { ... } followed by newline works');

eval_lives_ok(q[BEGIN { eval '0' };
0], 'eval in BEGIN { ... } followed by semicolon and newline works');

eval_lives_ok(q[BEGIN { eval '0' };0], 'eval in BEGIN { ... } followed by semicolon works');

