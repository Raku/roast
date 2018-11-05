use v6.d;
use lib $?FILE.IO.parent(2).add("packages");
use Test;
use Test::Util;
plan 4;

# RT #122423
is (42)[*/2], 42, 'Indexing half way into one element list';

# http://irclog.perlgeek.de/perl6/2015-01-23#i_9994456
fails-like ｢(my @)[*-1]｣, X::OutOfRange,
    'Out of range index returns a Failure object';

# RT #126503
fails-like ｢[4, 8, 15, 16, 23][* - 42]｣, X::OutOfRange;

# https://irclog.perlgeek.de/perl6-dev/2016-10-28#i_13482635
cmp-ok ()[0], '===', Nil, '()[0] gives Nil';
