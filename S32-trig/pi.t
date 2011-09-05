use v6;
use Test;
plan 3;

=begin description

Tests for pi function.

=end description

# See also: L<"http://theory.cs.iitm.ernet.in/~arvindn/pi/"> :)
my $PI = 3.141592653589e0;

# -- pi
is_approx(pi, $PI, "pi (using constant)");
is_approx(pi, atan(1)*4, "pi checked by atan(1)*4");
is_approx(pi + 3, $PI + 3, "'pi + 3' = PI +3");

# vim: ft=perl6
