use v6;

use Test;

plan 19;

# Undeterminate Math results
# see L<"http://mathworld.wolfram.com/Indeterminate.html">
# L<S02/"Infinity and C<NaN>" /Perl 6 by default makes standard IEEE floating point concepts visible>

is 0 * Inf  , NaN, "0 * Inf";
is Inf / Inf, NaN, "Inf / Inf";
is Inf - Inf, NaN, "Inf - Inf";
# if we say that 0**0 and Inf**0 both give 1 (sse below), then for which
# number or limit whould $number ** 0 be different from 1? so maybe just say
# that NaN ** 0 == 1?
#?rakudo skip 'unspecced and inconsistent'
is NaN ** 0,  NaN, "NaN ** 0";

is 0**0     , 1, "0**0 is 1, _not_ NaN";
is Inf**0   , 1, "Inf**0 is 1, _not_ NaN";

#?niecza todo
ok NaN ~~ NaN, 'NaN is a NaN';
nok 4 ~~ NaN, '4 is not a NaN';
nok 4.Num ~~ NaN, "4.Num is not a NaN";

isa_ok NaN + 1i, Complex, "NaN + 1i is a Complex number";
#?niecza todo
ok NaN + 1i ~~ NaN, "NaN + 1i ~~ NaN";
#?niecza todo
ok NaN ~~ NaN + 1i, "NaN ~~ NaN + 1i";

isa_ok (NaN)i, Complex, "(NaN)i is a Complex number";
#?niecza todo
ok (NaN)i ~~ NaN, "(NaN)i ~~ NaN";
#?niecza todo
ok NaN ~~ (NaN)i, "NaN ~~ (NaN)i";

#?niecza todo
ok (NaN)i ~~ NaN + 1i, "(NaN)i ~~ NaN + 1i";
#?niecza todo
ok NaN + 1i ~~ (NaN)i, "NaN + 1i ~~ (NaN)i";

#?niecza todo
ok truncate(NaN) ~~ NaN, 'truncate(NaN) ~~ NaN';

#?rakudo skip 'RT 83446'
#?niecza skip 'Nominal type check failed for scalar store; got Num, needed Int or subtype'
ok (my Int $rt83446 = NaN) ~~ NaN, 'NaN fits in Int';

# vim: ft=perl6
