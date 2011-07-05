use v6;

use Test;

plan 3;

# A list of pairs seems to be a list of pairs but a list of a
# single pair seems to be a a list of the pair's .key, .value

my @p1 = (1=>'a');
my @p2 = 1=>'a', 1=>'b';
my @p3 = 1=>'a', 42;

sub catWhat (*@a) { [~] map -> $v { WHAT($v).gist }, @a; }

is catWhat(@p1), 'Pair()', 'array of single Pair holds a Pair';
is catWhat(@p2), 'Pair()Pair()', 'array of Pairs holds Pairs';
is catWhat(@p3), 'Pair()Int()', 'array of Pair and others holds a Pair';

# vim: ft=perl6
