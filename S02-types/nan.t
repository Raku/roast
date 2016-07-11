use v6;

use Test;

plan 23;

# Undeterminate Math results
# see L<"http://mathworld.wolfram.com/Indeterminate.html">
# L<S02/"Infinity and C<NaN>" /Perl 6 by default makes standard IEEE floating point concepts visible>

is 0 * Inf  , NaN, "0 * Inf";
is Inf / Inf, NaN, "Inf / Inf";
is Inf - Inf, NaN, "Inf - Inf";
# RT #124450
is NaN ** 0,  1, "NaN ** 0";

is 0**0     , 1, "0**0 is 1, _not_ NaN";
is Inf**0   , 1, "Inf**0 is 1, _not_ NaN";

ok NaN ~~ NaN, 'NaN is a NaN';
nok 4 ~~ NaN, '4 is not a NaN';
nok 4.Num ~~ NaN, "4.Num is not a NaN";

isa-ok NaN + 1i, Complex, "NaN + 1i is a Complex number";
ok NaN + 1i ~~ NaN, "NaN + 1i ~~ NaN";
ok NaN ~~ NaN + 1i, "NaN ~~ NaN + 1i";

isa-ok (NaN)i, Complex, "(NaN)i is a Complex number";
ok (NaN)i ~~ NaN, "(NaN)i ~~ NaN";
ok NaN ~~ (NaN)i, "NaN ~~ (NaN)i";

ok (NaN)i ~~ NaN + 1i, "(NaN)i ~~ NaN + 1i";
ok NaN + 1i ~~ (NaN)i, "NaN + 1i ~~ (NaN)i";

ok truncate(NaN) ~~ NaN, 'truncate(NaN) ~~ NaN';

#?rakudo skip 'RT #83446'
#?niecza skip 'Nominal type check failed for scalar store; got Num, needed Int or subtype'
ok (my Int $rt83446 = NaN) ~~ NaN, 'NaN fits in Int';

#RT #103500
is NaN.perl, 'NaN', 'NaN perlification ok';

#RT #83622
ok NaN===NaN, "NaN value identity";

{
    #RT #126990
    throws-like { my Int $x = NaN }, X::TypeCheck::Assignment,
        message => /'expected Int but got Num (NaN)'/,
    "trying to assign NaN to Int gives a helpful error";

    my Num $x = NaN;
    is $x, NaN, 'assigning NaN to Num works without errors';
}


# vim: ft=perl6
