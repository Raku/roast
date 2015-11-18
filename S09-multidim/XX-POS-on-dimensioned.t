use v6;
use Test;

plan 29;

my @arr := Array.new(:shape(2;2));

nok @arr.EXISTS-POS(0, 0), '0;0 does not exist before assignment';
nok @arr.EXISTS-POS(0, 1), '0;1 does not exist before assignment';
nok @arr.EXISTS-POS(1, 0), '1;0 does not exist before assignment';
nok @arr.EXISTS-POS(1, 1), '0;1 does not exist before assignment';

@arr.AT-POS(0, 0) = 'a';
@arr.AT-POS(0, 1) = 'b';
is @arr.AT-POS(0, 0), 'a', 'Can store to array with multi-dim AT-POS as l-value (1)';
is @arr.AT-POS(0, 1), 'b', 'Can store to array with multi-dim AT-POS as l-value (2)';

dies-ok { @arr.AT-POS(2, 0) }, 'Access out of bounds dies (1)';
dies-ok { @arr.AT-POS(0, 2) }, 'Access out of bounds dies (2)';

@arr.ASSIGN-POS(1, 0, 'c');
@arr.ASSIGN-POS(1, 1, 'd');
is @arr.AT-POS(1, 0), 'c', 'Can store to array with multi-dim ASSIGN-POS (1)';
is @arr.AT-POS(1, 1), 'd', 'Can store to array with multi-dim ASSIGN-POS (2)';

throws-like { @arr.ASSIGN-POS(0, 'e') }, X::NotEnoughDimensions,
    operation => 'assign to', got-dimensions => 1, needed-dimensions => 2;
dies-ok { @arr.ASSIGN-POS(2, 0, 'a') }, 'Assign out of bounds dies (1)';
dies-ok { @arr.ASSIGN-POS(0, 2, 'a') }, 'Assign out of bounds dies (2)';

ok @arr.EXISTS-POS(0, 0), '0;0 exists';
ok @arr.EXISTS-POS(0, 1), '0;1 exists';
ok @arr.EXISTS-POS(1, 0), '1;0 exists';
ok @arr.EXISTS-POS(1, 1), '1;1 exists';
nok @arr.EXISTS-POS(1, 2), '1;2 does not exist';
nok @arr.EXISTS-POS(2, 1), '1;2 does not exist';
ok @arr.EXISTS-POS(0), '0 exists';
ok @arr.EXISTS-POS(1), '1 exists';
nok @arr.EXISTS-POS(2), '2 does not exist';

@arr.DELETE-POS(1, 1);
nok @arr.EXISTS-POS(1, 1), '1;1 ceaess to exist after deletion';
is @arr.shape, (2;2), 'deletion does not change shape, however';

throws-like { @arr.DELETE-POS(0) }, X::NotEnoughDimensions,
    operation => 'delete from', got-dimensions => 1, needed-dimensions => 2;
dies-ok { @arr.DELETE-POS(2, 0) }, 'Delete out of bounds dies (1)';
dies-ok { @arr.DELETE-POS(0, 2) }, 'Delete out of bounds dies (2)';

@arr.BIND-POS(1, 0, 'x');
is @arr.AT-POS(1, 0), 'x', 'Can bind to array element with multi-dim BIND-POS';
dies-ok { @arr.ASSIGN-POS(1, 0, 'e') }, 'BIND-POS really bound and replaced container';
