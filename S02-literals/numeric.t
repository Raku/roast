use v6;
use Test;

plan 52;

isa-ok 1, Int, '1 produces a Int';
ok 1 ~~ Numeric, '1 is Numeric';
ok 1 ~~ Real, '1 is Real';

isa-ok 1.Num, Num, '1.Num produces a Int';
ok 1.Num ~~ Numeric, '1.Num is Numeric';
ok 1.Num ~~ Real, '1.Num is Real';

# L<S02/Rational literals/Rational literals are indicated>

is_approx <1/2>, 0.5, '<1/2> Rat literal';
isa-ok <1/2>, Rat, '<1/2> produces a Rat';
ok <1/2> ~~ Numeric, '<1/2> is Numeric';
ok <1/2> ~~ Real, '<1/2> is Real';
isa-ok <0x01/0x02>, Rat, 'same with hexadecimal numbers';

ok <1/-3>.WHAT === Str, 'negative allowed only on numerator';
ok <-1/-3>.WHAT === Str, 'negative allowed only on numerator';

isa-ok <-1/3>, Rat, 'negative Rat literal';
ok <-1/3> * -3 == 1, 'negative Rat literal';

#?rakudo.jvm todo 'fails with "Attempt to divide by zero using div" on JVM RT #124559'
ok <0x01/0x03> / (0x01/0x03) == 1, 'Rat works with hexadecimal numbers';
ok <:13<01>/:13<07>> / (1/7) == 1, 'Rat works with colon radix numbers';
ok <:12<1a>/:12<7b>> / (:12<1a> / :12<7b>) == 1, 'Rat works with colon radix numbers';

# L<S02/Complex literals/Complex literals are similarly indicated>

isa-ok  <1+1i>, Complex,  '<1+1i> is a Complex literal';
isa-ok <+2+2i>, Complex, '<+2+2i> is a Complex literal';
isa-ok <-3+3i>, Complex, '<-3+3i> is a Complex literal';
isa-ok <+4-4i>, Complex, '<+4-4i> is a Complex literal';
isa-ok <-5-5i>, Complex, '<-5-5i> is a Complex literal';

ok <1+1i> ~~ Numeric, '1+1i is Numeric';
nok <1+1i> ~~ Real, '1+1i is not Real';
ok  <1*1i> ~~ Str, '1*1i is a Str';

is  <3+2i>,  3 + 2i,  '<3+2i> produces correct value';
is <+3+2i>, +3 + 2i, '<+3+2i> produces correct value';
is <-3+2i>, -3 + 2i, '<-3+2i> produces correct value';
is <+3-2i>, +3 - 2i, '<+3-2i> produces correct value';
is <-3-2i>, -3 - 2i, '<-3-2i> produces correct value';

is  <3.1+2.9i>,  3.1 + 2.9i,  '<3.1+2.9i> produces correct value';
is <+3.2+2.8i>, +3.2 + 2.8i, '+<3.2+2.8i> produces correct value';
is <-3.3+2.7i>, -3.3 + 2.7i, '-<3.3+2.7i> produces correct value';
is <+3.4-2.6i>, +3.4 - 2.6i, '+<3.4-2.6i> produces correct value';
is <-3.5-2.5i>, -3.5 - 2.5i, '-<3.5-2.5i> produces correct value';

is  <+3.1e10+2.9e10i>,    3.1e10  +  2.9e10i,  '<3.1e10+2.9e10i> produces correct value';
is  <+3.1e+11+2.9e+11i>,  3.1e11  +  2.9e11i,  '<+3.1e+11+2.9e+11i> produces correct value';
is  <-3.1e+12-2.9e+12i>, -3.1e+12 + -2.9e+12i, '<-3.1e+12-2.9e+12i> produces correct value';
is_approx  <-3.1e-23-2.9e-23i>.re, -3.1e-23, '<-3.1e-23-2.9e-23i> produces correct real value';
is_approx  <-3.1e-23-2.9e-23i>.im, -2.9e-23, '<-3.1e-23-2.9e-23i> produces correct imaginary value';
is_approx   <3.1e-99+2.9e-99i>.re,  3.1e-99, '<3.1e-99+2.9e-99i> produces correct real value';
is_approx   <3.1e-99+2.9e-99i>.im,  2.9e-99, '<3.1e-99+2.9e-99i> produces correct imaginary value';

is  <NaN+Inf\i>,   NaN + Inf\i, 'NaN+Inf\i> produces correct value';
is  <NaN-Inf\i>,   NaN - Inf\i, 'NaN-Inf\i> produces correct value';

# RT #74640
is_approx 3.14159265358979323846264338327950288419716939937510e0,
          3.141592, 'very long Num literals';

# RT #73236
{
    eval-lives-ok '0.' ~ '0' x 19,
        'parsing 0.000... with 19 decimal places lives';

    eval-lives-ok '0.' ~ '0' x 20,
        'parsing 0.000... with 20 decimal places lives';

    eval-lives-ok '0.' ~ '0' x 63,
        'parsing 0.000... with 63 decimal places lives';

    eval-lives-ok '0.' ~ '0' x 66,
        'parsing 0.000... with 66 decimal places lives';

    eval-lives-ok '0.' ~ '0' x 1024,
        'parsing 0.000... with 1024 decimal places lives';
}

# RT #70600
#?niecza todo 'exactly rounded Str->Num without FatRat'
ok 0e999999999999999 == 0, '0e999999999999 equals zero';

# vim: ft=perl6 sw=4 ts=4 expandtab
