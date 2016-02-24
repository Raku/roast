use v6.c;
use Test;

plan 3;

# RT #115134: [BUG] BEGIN { EVAL "..." } Confuses Rakudo
# The bug is triggered by the closing brace being directly
# followed by a newline and the next statement.
eval-lives-ok(q[BEGIN { EVAL '0' }
0], 'EVAL in BEGIN { ... } followed by newline works');

eval-lives-ok(q[BEGIN { EVAL '0' };
0], 'EVAL in BEGIN { ... } followed by semicolon and newline works');

eval-lives-ok(q[BEGIN { EVAL '0' };0], 'EVAL in BEGIN { ... } followed by semicolon works');

