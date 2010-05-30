# http://perl6advent.wordpress.com/2009/12/13/day-13-junctions/

use v6;
use Test;

plan 10;

my @a = 1,2,3;
my @b = 1,2,3;
my @c = 0,4;

my $in  = 3;
my $out = 0;

ok ($in == any(3, 5, 7)), '$var == any(3,5,7)';
nok ($out == any(3, 5, 7)), '$var == any(3,5,7)';
ok ($in == 3|5|7), '$var == 3|5|7';
nok ($out == 3|5|7), '$var == 3|5|7';
ok ($out == none(3,5,7)), '$var == none(3,5,7)';
nok ($in == none(3,5,7)), '$var == none(3,5,7)';

# TODO - add tests for junctions and smartmatching with first, second, third
#  regexes

ok (any(@a) == $in), 'any(@list) == $var';
ok (all(@a) > 0), 'all(@list) > 0';
ok (all(@a) == any(@b)), 'all(@a) == any(@b)';
nok (all(@c) == any(@b)), 'all(@a) == any(@b)';
