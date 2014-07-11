use v6;

use Test;

=begin pod

The zip() builtin and operator tests

=end pod

# L<S03/"Traversing arrays in parallel">
# L<S32::Containers/Container/"=item zip">

plan 10;

{
    my @a = (0, 2, 4);
    my @b = (1, 3, 5);

    my @e = (0 .. 5);

    #?niecza skip 'Slicel lists are NYI'
    is(~zip(@a; @b), ~@e, "simple zip");
    is(~(@a Z @b), ~@e, "also with Z char");
};

{
    my @a = (0, 3);
    my @b = (1, 4);
    my @c = (2, 5);

    my @e = (0 .. 5);

    #?niecza skip 'Slicel lists are NYI'
    is(~zip(@a; @b; @c), ~@e, "zip of 3 arrays");
    is(~(@a Z @b Z @c), ~@e, "also with Z char");
};

{
    my @a = (0, 2);
    my @b = (1, 3, 5);
    my @e = (0, 1, 2, 3);

    is (@a Z @b), @e, "zip uses length of shortest";
}

#?rakudo skip 'lvalue zip'
#?niecza skip 'Unable to resolve method LISTSTORE in class List'
{
    my @a;
    my @b;

    (@a Z @b) = (1, 2, 3, 4);
    is(@a, [1, 3], "first half of two zipped arrays as lvalues");
    is(@b, [2, 4], "second half of the lvalue zip");
}

{
    my @a = (1..3, 5) Z (6..8, 10);
    is @a.join(', '), "1, 6, 2, 7, 3, 8, 5, 10", 'infix:<Z> imposes list context';
}

# mix arrays and ranges
is ('a'..'c' Z 1, 2, 3).join(','), 'a,1,b,2,c,3',
    'can mix arrays and ranges for infix:<Z>';

is ("a".."c" Z "?", "a".."b").join('|'), 'a|?|b|a|c|b',
    'can mix arrays and ranges for infix:<Z>';

# vim: ft=perl6
