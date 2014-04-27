# http://perl6advent.wordpress.com/2012/12/16/day-16-operator-precedence/
use v6;
use Test;
plan 11;

my $a = 5;
my $b = 6;

is $a + $b, 11;      # 11 (numeric addition)
is $a * $b, 30;      # 30 (numeric multiplication)

is $a ~ $b, 56;      # "56" (string concatenation)
is $a x $b, "555555";      # "555555" (string repetition)

is $a || $b, 5;     # 5 (boolean disjunction)
is $a && $b, 6;     # 6 (boolean conjunction)

is 2 * 3 + 1, 7;      # 7, because (2 * 3) + 1
is 1 + 2 * 3, 7;      # 7, because 1 + (2 * 3), not 9

my $x = 7;
my $y = 11;
my $z = 18;

is $x ** 2 + 3 * $x - 5, (($x ** 2) + (3 * $x)) - 5;

is $x = $y = $z, 18;
is $y, 18;

