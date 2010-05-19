# http://perl6advent.wordpress.com/2009/12/03/day-3-static-types-and-multi-subs/

use v6;
use Test;

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

# XXX these fail ATM
# is ( ( identify(42) ), "42 is an integer");
# is ( ( identify("This rules!") ), "");
# is ( ( identify(42, "This rules!") ), "");
# is ( ( identify("This rules!", 42) ), "");
# is ( ( identify("This rules!", "I agree!") ), "");
# is ( ( identify(42, 24) ), "");
