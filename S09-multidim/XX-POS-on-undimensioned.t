use v6.c;
use Test;

plan 16;

# The multi-dimensional forms of *-POS should, on undimensioned data
# structures, just dig into them, doing nested access.

my @a = [1, 2], [3, 4];
is @a.AT-POS(0, 0), 1, 'AT-POS with many indices digs into nested arrays';
is @a.AT-POS(0, 1), 2, 'AT-POS with many indices digs into nested arrays';
is @a.AT-POS(1, 0), 3, 'AT-POS with many indices digs into nested arrays';
is @a.AT-POS(1, 1), 4, 'AT-POS with many indices digs into nested arrays';

ok @a.EXISTS-POS(0, 0), 'EXISTS-POS with many indices digs into nested arrays';
ok @a.EXISTS-POS(1, 1), 'EXISTS-POS with many indices digs into nested arrays';
nok @a.EXISTS-POS(2, 0), 'EXISTS-POS with many indices digs into nested arrays';
nok @a.EXISTS-POS(0, 2), 'EXISTS-POS with many indices digs into nested arrays';

@a.ASSIGN-POS(0, 0, 5);
@a.ASSIGN-POS(0, 1, 6);
@a.ASSIGN-POS(1, 0, 7);
@a.ASSIGN-POS(1, 1, 8);
@a.ASSIGN-POS(1, 2, 9);
is @a[0][0], 5, 'ASSIGN-POS with many indices digs into nested arrays';
is @a[0][1], 6, 'ASSIGN-POS with many indices digs into nested arrays';
is @a[1][0], 7, 'ASSIGN-POS with many indices digs into nested arrays';
is @a[1][1], 8, 'ASSIGN-POS with many indices digs into nested arrays';
is @a[1][2], 9, 'ASSIGN-POS with many indices digs into nested arrays';

@a.DELETE-POS(1, 2);
nok @a[1][2]:exists, 'DELETE-POS with many indices digs into nested arrays';

@a.BIND-POS(0, 0, 42);
is @a.AT-POS(0, 0), 42, 'BIND-POS with many indices digs into nested arrays';
dies-ok { @a.ASSIGN-POS(0, 0, 69) }, 'BIND-POS with many indices really binds';
