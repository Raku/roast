use v6;

use Test;

=begin desc

Closure over parameters of outer subs, as per
# L<S04/The Relationship of Blocks and Declarations/"Every block is a
# closure">
# L<S06/Dynamically scoped subroutines>

=end desc 

plan 4;

sub factorial (Int $n) {
    my sub facti (Int $acc, Int $i) {
        return $acc if $i > $n;
        facti($acc * $i, $i + 1);
    }
    facti(1, 1);
} ;

is factorial(0), 1, "closing over params of outer subs (0)";
is factorial(1), 1, "closing over params of outer subs (1)";
#?pugs 2 todo
is factorial(2), 2, "closing over params of outer subs (2)";
is factorial(3), 6, "closing over params of outer subs (3)";

# vim: ft=perl6
