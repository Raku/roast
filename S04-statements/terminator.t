use v6;

use Test;

plan 9;

# L<S04/"Statement parsing"/"statement termination">

# the 'empty statement' case responsible for the creation of this test file
eval_lives_ok(';', 'empty statement');

eval_lives_ok('my $x = 2', 'simple statement no semi');
eval_lives_ok('my $x =
9', 'simple statement on two lines no semi');
eval_lives_ok('my $x = 2;', 'simple statement with semi');
eval_lives_ok('{my $x = 2}', 'end of closure terminator');
eval_lives_ok('{my $x =
2;}', 'double terminator');
eval_lives_ok(';my $x = 2;{my $x = 2;;};', 'extra terminators');

eval_dies_ok('{my $x = 2;', 'open closure');
eval_dies_ok('my $x = ', 'incomplete expression');
