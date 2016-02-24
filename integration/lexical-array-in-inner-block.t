use v6.c;

use Test;

plan 2;

sub f($n)
{
    my $a = [$n];

    {
        is($a[0], $n, "Testing for a lexical variable inside a block.")
    }
}

my $n;
for 2..3 -> $n {
    # TEST*2
    f($n);
}




# vim: ft=perl6
