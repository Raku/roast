# http://perl6advent.wordpress.com/2011/12/22/day-22-operator-overloading-revisited/
use v6;
use Test;
plan 2;

{
    sub infix:<mean>($a, $b) { ($a + $b) / 2 };
    is (10 mean 4 * 5), 15, 'default precedence';
}

{
    sub infix:<mean>($a, $b) is tighter(&infix:<*>) { ($a + $b) / 2 };
    is (10 mean 4 * 5), 35, 'tighter precedence';
}
