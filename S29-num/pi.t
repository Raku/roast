use v6-alpha;
use Test;
plan 6;

# L<S29/Num/"Num provides a number of constants">

#?rakudo skip 'Cannot parse pod'
{
=head1 DESCRIPTION

Basic tests for builtin Num::pi

=cut
}

# See also: L<"http://theory.cs.iitm.ernet.in/~arvindn/pi/"> :)
my $PI = 3.14159265358979323846264338327950288419716939937510;

is_approx((eval("Num::pi "), $PI), 
                        "Num::pi");

is_approx((eval("use Num :constants; pi"), $PI), 
                        "pi imported by use Num :constants");  

is_approx((eval("use Num :constants; 3 + pi()"), $PI+3), "
                        3+pi(), as a sub");

is_approx((eval("use Num :constants; pi() + 3"), $PI+3),
                        "pi()+3, as a sub");

is_approx((eval("use Num :constants; 3 + pi"),   $PI+3), 
                        "3+pi, as a bareword");

is_approx((eval("use Num :constants; pi + 3"),   $PI+3), 
                        "pi+3, as a bareword");
