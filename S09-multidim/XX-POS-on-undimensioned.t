use v6;
use Test;

plan 51;

# The multi-dimensional forms of *-POS should, on undimensioned data
# structures, just dig into them, doing nested access.

# Two dimensions
my @a = [1, 2], [3, 4];
is @a.AT-POS(0, 0), 1, 'AT-POS with many indices digs into nested arrays';
is @a.AT-POS(0, 1), 2, 'AT-POS with many indices digs into nested arrays';
is @a.AT-POS(1, 0), 3, 'AT-POS with many indices digs into nested arrays';
is @a.AT-POS(1, 1), 4, 'AT-POS with many indices digs into nested arrays';
isa-ok @a.AT-POS(-1, 0), Failure;
isa-ok @a.AT-POS(-1, 1), Failure;
isa-ok @a.AT-POS(1,- 1), Failure;

ok @a.EXISTS-POS(0, 0), 'EXISTS-POS with many indices digs into nested arrays';
ok @a.EXISTS-POS(1, 1), 'EXISTS-POS with many indices digs into nested arrays';
nok @a.EXISTS-POS(2, 0), 'EXISTS-POS with many indices digs into nested arrays';
nok @a.EXISTS-POS(0, 2), 'EXISTS-POS with many indices digs into nested arrays';
nok @a.EXISTS-POS(-1,0), 'EXISTS-POS with many indices digs into nested arrays';
nok @a.EXISTS-POS(-1,1), 'EXISTS-POS with many indices digs into nested arrays';
nok @a.EXISTS-POS(1,-1), 'EXISTS-POS with many indices digs into nested arrays';

@a.ASSIGN-POS(0, 0, 5);
@a.ASSIGN-POS(0, 1, 6);
@a.ASSIGN-POS(1, 0, 7);
@a.ASSIGN-POS(1, 1, 8);
@a.ASSIGN-POS(1, 2, 9);
dies-ok { @a.ASSIGN-POS(-1, 0, 42) }, 'negative index dies on assignment';
dies-ok { @a.ASSIGN-POS(-1, 1, 42) }, 'negative index dies on assignment';
dies-ok { @a.ASSIGN-POS(0, -1, 42) }, 'negative index dies on assignment';
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

# Three dimensions
@a = [[1,2],[3,4]], [[5,6],[7,8]];
is @a.AT-POS(0,0,0), 1, 'AT-POS with many indices digs into nested arrays';
is @a.AT-POS(0,0,1), 2, 'AT-POS with many indices digs into nested arrays';
is @a.AT-POS(0,1,0), 3, 'AT-POS with many indices digs into nested arrays';
is @a.AT-POS(0,1,1), 4, 'AT-POS with many indices digs into nested arrays';
isa-ok @a.AT-POS(-1,0,0), Failure;
isa-ok @a.AT-POS(-1,1,0), Failure;
isa-ok @a.AT-POS(1,-1,0), Failure;
isa-ok @a.AT-POS(1,1,-1), Failure;

ok @a.EXISTS-POS(0,0,0), 'EXISTS-POS with many indices digs into nested arrays';
ok @a.EXISTS-POS(0,0,1), 'EXISTS-POS with many indices digs into nested arrays';
nok @a.EXISTS-POS(0,0,2), 'EXISTS-POS with many indices digs into nested arrays';
nok @a.EXISTS-POS(0,2,0), 'EXISTS-POS with many indices digs into nested arrays';
nok @a.EXISTS-POS(2,0,0), 'EXISTS-POS with many indices digs into nested arrays';
nok @a.EXISTS-POS(0,0,-1), 'EXISTS-POS with many indices digs into nested arrays';
nok @a.EXISTS-POS(0,-1,0), 'EXISTS-POS with many indices digs into nested arrays';
nok @a.EXISTS-POS(-1,0,0), 'EXISTS-POS with many indices digs into nested arrays';

@a.ASSIGN-POS(0, 0, 0, 5);
@a.ASSIGN-POS(0, 1, 0, 6);
@a.ASSIGN-POS(1, 0, 0, 7);
@a.ASSIGN-POS(1, 1, 0, 8);
dies-ok { @a.ASSIGN-POS(-1, 0, 42) }, 'negative index dies on assignment';
dies-ok { @a.ASSIGN-POS(-1, 1, 42) }, 'negative index dies on assignment';
dies-ok { @a.ASSIGN-POS(0, -1, 42) }, 'negative index dies on assignment';
is @a[0][0][0], 5, 'ASSIGN-POS with many indices digs into nested arrays';
is @a[0][1][0], 6, 'ASSIGN-POS with many indices digs into nested arrays';
is @a[1][0][0], 7, 'ASSIGN-POS with many indices digs into nested arrays';
is @a[1][1][0], 8, 'ASSIGN-POS with many indices digs into nested arrays';

@a.DELETE-POS(1,1,0);
nok @a[1][1][0]:exists, 'DELETE-POS with many indices digs into nested arrays';

@a.BIND-POS(0,0,0,42);
is @a.AT-POS(0,0,0), 42, 'BIND-POS with many indices digs into nested arrays';
dies-ok { @a.ASSIGN-POS(0,0,0,69) }, 'BIND-POS with many indices really binds';

# vim: expandtab shiftwidth=4
