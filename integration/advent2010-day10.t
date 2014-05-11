# http://perl6advent.wordpress.com/2010/12/10/day-10-feed-operators/

use v6;
use Test;
plan 4;

my @random-nums = (1..100).pick(*);

my $odds-squared-expected = '1 9 25 49 81 121 169 225 289 361 441 529 625 729 841 961 1089 1225 1369 1521 1681 1849 2025 2209 2401 2601 2809 3025 3249 3481 3721 3969 4225 4489 4761 5041 5329 5625 5929 6241 6561 6889 7225 7569 7921 8281 8649 9025 9409 9801';

#?rakudo skip "RT121843"
{
    # advent example
    my @result;
    lives_ok {@result = EVAL q:to"END-CODE"}, 'compiles';
    my @odds-squares <== sort <== map { $_ ** 2 } <== grep { $_ % 2 } <== @random-nums;
    END-CODE
    is ~@result, $odds-squared-expected, 'left feed';
}

{
    # watered down - paramterised sortt
    my @odds-squared <== sort {$^a <=> $^b} <== map { $_ ** 2 } <== grep { $_ % 2 } <== @random-nums;
    is ~@odds-squared, $odds-squared-expected, 'left feed';
}

my @rakudo-people = <scott patrick carl moritz jonathan jerry stephen>;
@rakudo-people ==> grep { /at/ } ==> map { .tc } ==> my @who-it's-at;
is ~@who-it's-at, 'Patrick Jonathan', 'right feed';
