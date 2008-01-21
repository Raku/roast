use v6-alpha;
use Test;
plan 5;

# L<S29/"List"/"=item map">

# Note: int is only an example, say and all other builtins which default to $_
# don't work, either.
is ~((1,2,3).map:{ int $_ }), "1 2 3", "dependency for following test (1)";
$_ = 4; is .int, 4,                   "dependency for following test (2)";
is ~((1,2,3).map:{ .int }),    "1 2 3", 'int() should default to $_ inside map, too';

# This works...
is ~(({1},{2},{3}).map:{ $_; $_() }), "1 2 3", 'lone $_ in map should work (1)';
is ~(({1},{2},{3}).map:{ $_() }),     "1 2 3", 'lone $_ in map should work (2)';
