use v6;
use Test;

is (1 andthen 2), 2, 'andthen basics';
is (1 andthen 2 andthen 3), 3, 'andthen chained';
is (0 andthen 1), 1, 'definedness, not truthness';
ok Any === (1 andthen Any), 'first undefined value (1)';
ok Any === (Any andthen 2), 'first undefined value (2)';
my $tracker = 0;
nok (Int andthen ($tracker = 1)), 'sanity';
nok $tracker, 'andthen thunks';

my $ = 'some arg' andthen -> $x { is $x, 'some arg', 'andthen passes on arguments' };


done;
