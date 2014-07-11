use v6;

use Test;

plan 4;

# L<S04/"Conditional statements"/Conditional statement modifiers work as in Perl 5>

# test simple the ``until'' statement modifier
{
    my $a=0;
    $a += 1 until $a >= 10;
    is($a, 10, "post until");
}

# test the ``until'' statement modifier
{
    my ($a, $b);
    $a=0; $b=0;
    $a += $b += 1 until $b >= 10;
    is($a, 55, "post until");
}

{
    my @a = ('a', 'b', 'a');
    my $a = 'b';
    $a ~= ', ' ~ shift @a until !+@a;
    is($a, "b, a, b, a", "post until");
}

{
    my @a = 'a'..'e';
    my $a = 0;
    $a++ until shift(@a) eq 'c';
    is($a, 2, "post until");
}

# vim: ft=perl6
