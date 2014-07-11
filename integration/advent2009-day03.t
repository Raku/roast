# http://perl6advent.wordpress.com/2009/12/03/day-3-static-types-and-multi-subs/

use v6;
use Test;
plan 6;

my Int $days = 24;

my Str $phrase = "Hello World";
my Num $pi = 3.141e0;
my Rat $other_pi = 22/7;

multi sub identify(Int $x) {
    return "$x is an integer.";
}

multi sub identify(Str $x) {
    return qq<"$x" is a string.>;
}

multi sub identify(Int $x, Str $y) {
    return "You have an integer $x, and a string \"$y\".";
}

multi sub identify(Str $x, Int $y) {
    return "You have a string \"$x\", and an integer $y.";
}

multi sub identify(Int $x, Int $y) {
    return "You have two integers $x and $y.";
}

multi sub identify(Str $x, Str $y) {
    return "You have two strings \"$x\" and \"$y\".";
}

is identify(42), "42 is an integer.", 'MMD with one Int';
is identify("This rules!"), '"This rules!" is a string.', 'MMD with one Str';
is identify(42, "This rules!"), 'You have an integer 42, and a string "This rules!".' , "MMD with Int and Str";
is identify("This rules!", 42), 'You have a string "This rules!", and an integer 42.' , "MMD with Int and Str";
is identify("This rules!", "I agree!"), "You have two strings \"This rules!\" and \"I agree!\".", 'Str, Str';
is identify(42, 24), "You have two integers 42 and 24.";
