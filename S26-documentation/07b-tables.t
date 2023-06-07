use Test;

plan 4;

# test for the three designed fatal table failures

# empty tables should cause an exception
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

eval-dies-ok $table1, "dies-ok, empty table";
eval-dies-ok $table2, "dies-ok, empty table";
eval-dies-ok $table3, "dies-ok, consecutive row separators";
eval-dies-ok $table4, "dies-ok, mixed ws and vis col separators";

# vim: expandtab shiftwidth=4
