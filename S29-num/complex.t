use v6;

use Test;

plan 129;

=begin pod

Basic tests functions specific to complex numbers.

L<S29/Num/"=item cis">

=end pod

my $pi = 3.141592653589793238;

{
    is_approx(cis(0),        1 + 0i,       "cis(0)     == 1");
    is_approx(cis($pi),      -1 + 0i,      "cis(pi)    == -1");
    is_approx(cis($pi / 2),  1i,           "cis(pi/2)  == i");
    #?rakudo todo "complex approx"
    is_approx(cis(3*$pi / 2),1i,           "cis(3pi/2) == i");
}

# L<S29/Num/"=item cis">
# L<S29/Num/"=item unpolar">
#
# Test that 1.unpor == cis

#?rakudo skip "pointy sub parsing"
#?DOES 120
{
    for 1..20 -> $i {
        my $angle = 2 * $pi * $i / 20;
        is_approx(cis($i), 1.unpolar($i), "cis(x) == 1.unpolar(x) No $i");
    }

    # L<S29/Num/"=item unpolar">
    # L<S29/Num/"=item abs">
    #
    # Test that unpolar() doesn't change the absolute value

    my $counter = 1;
    for 1..10 -> $abs {
        for 1..10 -> $a {
            my $angle = 2 * $pi * $i / 10;
            is_approx(abs($abs.unpolar($angle)), $abs 
                    "unpolar doesn't change the absolute value (No $counter)");
            $counter++;
        }
    }
}

#?rakudo skip "promote Int to Num"
#?DOES 5
{
    # L<S29/Num/"=item unpolar">
    #
    # Basic tests for unpolar()

    is_approx(4.unpolar(0),         4,     "4.unpolar(0)    == 4");
    is_approx(4.unpolar($pi/4),     2 + 2i,"4.unpolar(pi/4) == 2+2i");
    is_approx(4.unpolar($pi/2),     4i,    "4.unpolar(pi/2) == 4i");
    is_approx(4.unpolar(3*$pi/4),   -2 +2i,"4.unpolar(pi/4) == -2+2i");
    is_approx(4.unpolar($pi),       -4,    "4.unpolar(pi)   == -4");
}
