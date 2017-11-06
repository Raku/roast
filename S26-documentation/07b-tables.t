use v6;
use Test;

plan 4;

# test for the two fatal table failures

# empty table should cause an exception
my $table1 = qq:to/HERE/;
=begin table
=end table
HERE

my $table2 = qq:to/HERE/;
=table

HERE

# consecutive row separators should cause an exception
my $table3 = qq:to/HERE/;
=table
1 | 2 | 3
=========
=========
4 | 5 | 6
HERE

# mixed vis and ws col separators should cause an exception
my $table4 = qq:to/HERE/;
=table
1 | 2 | 3
4  5  6
HERE

eval-dies-ok $table1;
eval-dies-ok $table2;
eval-dies-ok $table3;
eval-dies-ok $table4;
