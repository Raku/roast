# http://perl6advent.wordpress.com/2010/12/06/the-x-and-z-metaoperators/
use v6;

use Test;

plan 12;

is_deeply [(1, 2) X, (10, 11)], [(1, 10), (1, 11), (2, 10), (2, 11)], 'infix:<X>';
is_deeply [(1, 2) X+ (10, 11)], [11, 12, 12, 13], 'X+';
is_deeply [(1, 2) X~ (10, 11)], ["110", "111", "210", "211"], 'X~';
is_deeply [(1, 2) X== (1, 1)],  [Bool::True, Bool::True, Bool::False, Bool::False], 'X==';
is_deeply [(1, 2) Z, (3, 4)],   [(1, 3), (2, 4)], 'Z,';
is_deeply [(1, 2) Z+ (3, 4)],   [4, 6], 'Z+';
is_deeply [(1, 2) Z== (1, 1)],  [Bool::True, Bool::False], 'Z==';
# Z mentioned as being 'buggy' in 2010.12
is_deeply [(1, 2) Z (3, 4)],   [(1, 3), (2, 4)], 'infix:<Z>';

my @keys = <a b c>;
my @values = 10, 20, 30;
my %hash = @keys Z=> @values;
is_deeply %hash, {a => 10, b=> 20, c => 30}, 'Z=>';

my @a = (2, 4, 6);
my @b = (5, 10, 15);
my @c = (3, 5, 7);

my @Z-ab = gather for @a Z @b -> $a, $b { take [$a, $b] }
is_deeply @Z-ab, [[2, 5], [4, 10], [6, 15]], '@a Z @b';

my @Z-abc = gather for @a Z @b Z @c -> $a, $b, $c { take [$a, $b, $c] }
is_deeply @Z-abc, [[2, 5, 3], [4, 10, 5], [6, 15, 7]], '@a Z @b Z @c';

# just do a three sided dice
my @d3 = 1 ... 3;
my @scores = (@d3 X+ @d3) X+ @d3;

is_deeply @scores, [3, 4, 5, 4, 5, 6, 5, 6, 7, 4,
		    5, 6, 5, 6, 7, 6, 7, 8, 5, 6,
		    7, 6, 7, 8, 7, 8, 9], 'dice totals';

