use v6-alpha;
use Test;
plan 3;

# L<S29/"List"/"=item map">

my @foo = [1, 2, 3].map:{ [100+$_, 200+$_] };
# @foo should be: [ [101,201], [102,202], [103,203] ]
# It is:          [  101,201,   102,202,   103,203  ]
# (At least I *think* Pugs' current behaviour is wrong. If it isn't, but I am
# -- how do I construct an AoA then?)
is +@foo,    3,         "map should't flatten our arrayref (1)";
is +@foo[0], 2,         "map should't flatten our arrayref (2)";
is ~@foo[0], "101 201", "map should't flatten our arrayref (3)";
