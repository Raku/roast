use v6;
use Test;
plan 8;

# L<S32::Numeric/Numeric/"Numeric provides some constants">

=begin pod

=head1 DESCRIPTION

Basic tests for builtin Num::pi and Num::tau

=end pod


# See also: L<"http://theory.cs.iitm.ernet.in/~arvindn/pi/"> :)
my $PI = 3.141592e0;

is_approx(EVAL("pi"), $PI, "pi imported by default");

throws-like "3 + pi()", X::Undeclared, "pi() is not a sub";

is_approx(EVAL("3 + pi"), $PI+3, "3+pi, as a bareword");

is_approx(EVAL("pi + 3"), $PI+3, "pi+3, as a bareword");

is_approx(π, $PI, "unicode π as a bareword");

# Tau, see also: L<"http://tauday.com/tau-digits">
is(EVAL("tau"), EVAL("2 * pi"), "pi = tau / 2");

throws-like "3 + tau()", X::Undeclared, "tau() is not a sub";

is_approx(τ, 2*$PI, "unicode τ as a bareword");

# vim: ft=perl6
