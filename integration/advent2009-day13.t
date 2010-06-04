# http://perl6advent.wordpress.com/2009/12/13/day-13-junctions/

use v6;
use Test;

plan 16;

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

ok ( (any(1, 2, 3) + 2).perl , any(3, 4, 5) , 'Junction + Int gives Junction');

ok 'testing' ~~ /t/ & /s/ & /g/ , "'testing' ~~ /t/ & /s/ & /g/";
nok 'testing' ~~ /x/ & /s/ & /g/ , "'testing' ~~ /x/ & /s/ & /g/";
ok 'testing' ~~ /t/ | /s/ | /g/ , "'testing' ~~ /t/ | /s/ | /g/";
ok 'testing' ~~ /x/ | /s/ | /g/ , "'testing' ~~ /x/ | /s/ | /z/";
nok 'testing' ~~ /x/ | /y/ | /z/ , "'testing' ~~ /x/ | /y/ | /z/";

ok (any(@a) == $in), 'any(@list) == $var';
ok (all(@a) > 0), 'all(@list) > 0';
ok (all(@a) == any(@b)), 'all(@a) == any(@b)';
nok (all(@c) == any(@b)), 'all(@a) == any(@b)';
