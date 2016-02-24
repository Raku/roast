use v6.c;
use Test;

plan 31;

my @arr := Array.new(:shape(2;2));

nok @arr[0;1]:exists, '0;0 does not exist before assignment (:exists)';
nok @arr[0;1]:exists, '0;1 does not exist before assignment (:exists)';
nok @arr[1;0]:exists, '1;0 does not exist before assignment (:exists)';
nok @arr[1;1]:exists, '0;1 does not exist before assignment (:exists)';

@arr[0;0] = 'a';
@arr[0;1] = 'b';
@arr[1;0] = 'c';
@arr[1;1] = 'd';
is @arr[0;0], 'a', 'Can store to multi-dim array with indexer (1)';
is @arr[0;1], 'b', 'Can store to multi-dim array with indexer (2)';
is @arr[1;0], 'c', 'Can store to multi-dim array with indexer (3)';
is @arr[1;1], 'd', 'Can store to multi-dim array with indexer (4)';

dies-ok { @arr[2;0] }, 'Access out of bounds with indexer dies (1)';
dies-ok { @arr[0;2] }, 'Access out of bounds with indexer dies (2)';

throws-like { @arr[0] = 'e' }, X::NotEnoughDimensions,
    operation => 'assign to', got-dimensions => 1, needed-dimensions => 2;
dies-ok { @arr[2;0] = 'a' }, 'Assign out of bounds with indexer dies (1)';
dies-ok { @arr[0;2] = 'a' }, 'Assign out of bounds with indexer dies (2)';

ok @arr[0;1]:exists, '0;0 exists (:exists)';
ok @arr[0;1]:exists, '0;1 exists (:exists)';
ok @arr[1;0]:exists, '1;0 exists (:exists)';
ok @arr[1;1]:exists, '0;1 exists (:exists)';
nok @arr[1;2]:exists, '1;2 does not exist (:exists)';
nok @arr[2;1]:exists, '2;1 does not exist (:exists)';
ok @arr[0]:exists, '0 exists (:exists)';
ok @arr[1]:exists, '1 exists (:exists)';
nok @arr[2]:exists, '2 does not exist (:exists)';

@arr[1;1]:delete;
nok @arr[1;1]:exists, '1;1 ceaess to exist after deletion (:delete)';
is @arr.shape, (2;2), 'deletion does not change shape, however (:delete)';

throws-like { @arr[0]:delete }, X::NotEnoughDimensions,
    operation => 'delete from', got-dimensions => 1, needed-dimensions => 2;
dies-ok { @arr[2;0]:delete }, 'Delete out of bounds dies (:delete) (1)';
dies-ok { @arr[0;2]:delete }, 'Delete out of bounds dies (:delete) (2)';

@arr[0;1] := 42;
is @arr[0;1], 42, 'Can bind with := to multi-dim array';
dies-ok { @arr[0;1] = 100 }, 'Really bound an Int, so cannot assign';
dies-ok { @arr[2;0] := 1 }, 'Bind out of bounds dies (1)';
dies-ok { @arr[0;2] := 1 }, 'Bind out of bounds dies (2)';
