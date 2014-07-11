use v6;
use Test;
plan 4;

# L<S32::Numeric/Numeric/"Numeric provides some constants">

=begin pod

=head1 DESCRIPTION

Basic tests for builtin Num::pi

=end pod


# See also: L<"http://theory.cs.iitm.ernet.in/~arvindn/pi/"> :)
my $PI = 3.141592e0;

is_approx(EVAL("pi"), $PI, "pi imported by default");

eval_dies_ok("3 + pi()", "pi() is not a sub");

is_approx(EVAL("3 + pi"), $PI+3, "3+pi, as a bareword");

is_approx(EVAL("pi + 3"), $PI+3, "pi+3, as a bareword");

# vim: ft=perl6
