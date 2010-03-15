use v6;
use Test;
plan 6;

# L<S32::Numeric/Numeric/"Numeric provides some constants">

=begin pod

=head1 DESCRIPTION

Basic tests for builtin Num::pi

=end pod


# See also: L<"http://theory.cs.iitm.ernet.in/~arvindn/pi/"> :)
my $PI = 3.14159265358979323846264338327950288419716939937510e0;

#?rakudo 6 skip 'module Num not implemented (and the spec has changed)'
is_approx(Num::pi, $PI, "Num::pi");

is_approx(eval("use Num :constants; pi"), $PI, 
                        "pi imported by use Num :constants");  

is_approx(eval("use Num :constants; 3 + pi()"), $PI+3, "
                        3+pi(), as a sub");

is_approx(eval("use Num :constants; pi() + 3"), $PI+3,
                        "pi()+3, as a sub");

is_approx(eval("use Num :constants; 3 + pi"),   $PI+3, 
                        "3+pi, as a bareword");

is_approx(eval("use Num :constants; pi + 3"),   $PI+3, 
                        "pi+3, as a bareword");

# vim: ft=perl6
