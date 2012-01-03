use v6;
use Test;

plan 22;

isa_ok 1, Int, '1 produces a Int';
ok 1 ~~ Numeric, '1 is Numeric';
ok 1 ~~ Real, '1 is Real';

isa_ok 1.Num, Num, '1.Num produces a Int';
ok 1.Num ~~ Numeric, '1.Num is Numeric';
ok 1.Num ~~ Real, '1.Num is Real';

# L<S02/Rational literals/Rational literals are indicated>

is_approx 1/2, 0.5, '1/2 Rat literal';
isa_ok 1/2, Rat, '1/2 produces a Rat';
ok 1/2 ~~ Numeric, '1/2 is Numeric';
ok 1/2 ~~ Real, '1/2 is Real';
isa_ok 0x01/0x02, Rat, 'same with hexadecimal numbers';

ok 0x01/0x02 / (0x01/0x02) == 1, 'same with hexadecimal numbers';

# L<S02/Complex literals/Complex literals are similarly indicated>

isa_ok 1+1i, Complex, '1+1i is a Complex literal';
ok 1+1i ~~ Numeric, '1+1i is Numeric';
nok 1+1i ~~ Real, '1+1i is not Real';

# RT #74640
is_approx 3.14159265358979323846264338327950288419716939937510e0,
          3.141592, 'very long Num literals';

# RT #73236
{
    eval_lives_ok '0.' ~ '0' x 19,
        'parsing 0.000... with 19 decimal places lives';

    eval_lives_ok '0.' ~ '0' x 20,
        'parsing 0.000... with 20 decimal places lives';

    eval_lives_ok '0.' ~ '0' x 63,
        'parsing 0.000... with 63 decimal places lives';

    eval_lives_ok '0.' ~ '0' x 66,
        'parsing 0.000... with 66 decimal places lives';

    eval_lives_ok '0.' ~ '0' x 1024,
        'parsing 0.000... with 1024 decimal places lives';
}

# RT #70600
#?niecza todo 'exactly rounded Str->Num without FatRat'
ok 0e999999999999999 == 0, '0e999999999999 equals zero';

done;

# vim: ft=perl6 sw=4 ts=4 expandtab
