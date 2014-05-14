# http://perl6advent.wordpress.com/2010/12/12/day-12-%E2%80%93-smart-matching/
use v6;
use Test;

plan 13;

is_deeply [1, 2, 4 ... 32], [1, 2, 4, 8, 16, 32], 'sequence';
is_deeply [1, 2, 4 ... * > 10], [1, 2, 4, 8, 16], 'sequence';

my @results;
for 17, 50, 100 -> $age {
   my $result = '';
   given $age {
       when 100    { $result = "congratulations!"      }
       when * < 18 { $result = "You're not of age yet" }
   };
   @results.push: $result;
}

is_deeply @results, ["You're not of age yet", '', "congratulations!"], 'given/when'; 

sub smart-match-medley($foo) {
    [
    # is it of type Str?
    str => $foo ~~ Str,

    # is it equal to 6?
    'six' => try {$foo ~~ 6} || False,

    # or is it "bar"?
    bar => $foo ~~ "bar",

    # does it match some pattern?
    match => $foo ~~ / \w+ '-' \d+ / ?? True !! False,

    # Is it between 15 and 25?
    '15..25' => $foo ~~ (15..25),

    # call a closure
    closure => try {$foo ~~ -> $x { 5 < $x < 25 }}  || False,

    # is it an array of 6 elems in which every odd element is 1?
    arr => $foo ~~ [1, *, 1, *, 1, *],
    ]
}

is_deeply smart-match-medley("6"), [str => True, six => True, bar => False, match => False, '15..25' => False, closure => True, arr => False];
is_deeply smart-match-medley(6), [str => False, six => True, bar => False, match => False, '15..25' => False, closure => True, arr => False];
is_deeply smart-match-medley(3), [str => False, six => False, bar => False, match => False, '15..25' => False, closure => False, arr => False];
is_deeply smart-match-medley(9), [str => False, six => False, bar => False, match => False, '15..25' => False, closure => True, arr => False];
is_deeply smart-match-medley('bar'), [str => True, six => False, bar => True, match => False, '15..25' => False, closure => False, arr => False];
is_deeply smart-match-medley('bar-42'), [str => True, six => False, bar => False, match => True, '15..25' => False, closure => False, arr => False];
is_deeply smart-match-medley([1,10, 1,20, 1,30]), [str => False, six => True, bar => False, match => False, '15..25' => False, closure => True, arr => True];
is_deeply smart-match-medley([1,10, 1,20, 2,30]), [str => False, six => True, bar => False, match => False, '15..25' => False, closure => True, arr => False];

class Point {
    has $.x;
    has $.y;
    method ACCEPTS(Positional $p2) {
        return $.x == $p2[0] and $.y == $p2[1]
    }
}

my $a = Point.new(x => 7, y => 9);
is_deeply ([3, 5] ~~ $a), Bool::False, 'accepts';
is_deeply ((7, 9) ~~ $a), Bool::True, 'accepts';
