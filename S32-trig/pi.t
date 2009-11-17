use v6;
use Test;
plan 2;

=begin description

Tests for pi function.

=end description

# See also: L<"http://theory.cs.iitm.ernet.in/~arvindn/pi/"> :)
my $PI = 3.14159265358979323846264338327950288419716939937510e0;

# -- pi
is_approx(pi, $PI, "pi()");
is_approx(pi + 3, $PI + 3, "'pi() + 3' may drop its parentheses before +3");

# vim: ft=perl6
