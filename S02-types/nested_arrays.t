use v6.c;

use Test;

# L<S02/Mutable types/Array>

=begin description

Nested array tests; various interactions of arrayrefs, arrays, flattening and nesting.

=end description

plan 10;

{   # UNSPECCED
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
    is(+@b, 3, 'Array length, nested [], outer []s');
    is(+$b, 3, 'Array object length, nested [], outer []s');

    is(+@c, 3, 'Array length, nested ()');
    is(+$c, 3, 'Array object length, nested ()');
    is(+@d, 3, 'Array length, nested (), outer []s');
    is(+$d, 3, 'Array object length, nested (), outer []s');
}

# RT #98954
{
    my @a = [1], [2], [3];
    my @b = map { @a[1 - $_][0] }, 0 .. 3;
    isa-ok @b[3], Failure, 'Out of range index returns Failure object';
    throws-like '@b[3].sink', X::OutOfRange,
        what => 'Index', got => -2, range => '0..^Inf',
        'Failure object contains X::OutOfRange exception';
}

# vim: ft=perl6
