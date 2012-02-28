use v6;

use Test;

plan 5;

# L<S04/"Conditional statements"/Conditional statement modifiers work as in Perl 5>

# simple while modifier test
{
    my $a = 0;
    $a += 1 while $a < 10;
    is($a, 10, "post simple while modifier");
}

# simple while modifier test
{
    my $a;
    $a += 1 while $a < 10;
    is($a, 10, "post simple while modifier");
}

# test the ``while'' statement modifier
{
    my $a = 0;
    my $b = 0;
    $a += $b += 1 while $b < 10;
    is($a, 55, "post while");
}

#?pugs skip 'Cannot shift scalar'
{
    my @a = 'b'..'d';
    my $a = 'a';
    $a ~= ', ' ~ shift @a while @a;
    is($a, "a, b, c, d", "post while");
}

#?pugs skip 'Cannot shift scalar'
{
    my @a = 'a'..'e';
    my $a = 0;
    ++$a while shift(@a) ne 'd';
    is($a, 3, "post while");
}

# vim: ft=perl6
