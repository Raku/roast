use v6;

use Test;

plan 10;

# L<S06/"Multidimensional argument list binding">

sub get_multidim_arglist (**@AoA) { @AoA }

{
    my @array1 = <a b c>;
    my @array2 = <d e f>;

    my @AoA = get_multidim_arglist(@array1; @array2);
    is +@AoA,          2, "basic multidim arglist binding (1)";
    is ~@AoA[0], "a b c", "basic multidim arglist binding (2)";
    is ~@AoA[1], "d e f", "basic multidim arglist binding (3)";
}

{
    my @array1 = <a b c>;

    my @AoA = get_multidim_arglist(@array1);
    is +@AoA,          1, "multidim arglist binding with only one array (1)";
    is ~@AoA[0], "a b c", "multidim arglist binding with only one array (2)";
}

multi sub multi_get_multidim_arglist(**@AoA) { @AoA }
multi sub multi_get_multidim_arglist(Int $a) { $a }

#?rakudo skip 'multi sub multidim arglist broken'
{
    my @a1 = <a b c>;
    my @a2 = <d e f>;

    my @AoA = multi_get_multidim_arglist(@a1; @a2);
    is +@AoA,          2, "multi sub with multidim arglist binding (1)";
    is  @AoA[0], "a b c", "multi sub with multidim arglist binding (2)";
    is  @AoA[1], "d e f", "multi sub with multidim arglist binding (3)";
}

#?rakudo skip 'multi sub multidim arglist broken'
{
    my @a1 = <a b c>;

    my @AoA = multi_get_multidim_arglist(@a1);
    is +@AoA,          1, "multi sub with multidim arglist binding for only one array (1)";
    is  @AoA[0], "a b c", "multi sub with multidim arglist binding for only one array (2)";
}

# vim: ft=perl6
