use v6;

use Test;

# L<S04/Control Exceptions>

# Test primarily aimed at Niecza

plan 1;

#?rakudo.parrot skip 'RT #122325 - assignment to $x fails, expected Any but got Mu'
{
    sub foo($x = last) { $x }

    my $i = 0;
    for 1,2,3 { $i++; foo(); }

    is $i, 1, 'control operator last can be used in an inferior context';
}

# vim: ft=perl6
