use v6;

use Test;

=kwid 

Nested array tests; various interactions of arrayrefs, arrays, flattening and nesting.

=cut

plan 8;

{   
    my @a = (1,2,[3,4]);
    my $a = (1,2,[3,4]);
    my @b = [1,2,[3,4]];
    my $b = [1,2,[3,4]];
    my @c = (1,2,(3,4));
    my $c = (1,2,(3,4));
    my @d = [1,2,(3,4)];
    my $d = [1,2,(3,4)];

    is(+@a, 3, 'Array length, nested []');
    is(+$a, 3, 'Array object length, nested []');
    is(+@b, 1, 'Array length, nested [], outer []s');
    is(+$b, 3, 'Array object length, nested [], outer []s');

    is(+@c, 4, 'Array length, nested ()');
    is(+$c, 4, 'Array object length, nested ()');
    is(+@d, 1, 'Array length, nested (), outer []s');
    is(+$d, 4, 'Array object length, nested (), outer []s');
}
