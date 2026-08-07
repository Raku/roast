use Test;

plan 89;

isa-ok 1, Int, '1 produces a Int';
does-ok 1, Numeric, '1 does Numeric';
does-ok 1, Real, '1 does Real';

isa-ok 1.Num, Num, '1.Num produces a Num';
does-ok 1.Num, Numeric, '1.Num does Numeric';
does-ok 1.Num, Real, '1.Num does Real';

# L<S02/Rational literals/Rational literals are indicated>

is-approx <1/2>, 0.5, '<1/2> Rat literal';
isa-ok <1/2>, Rat, '<1/2> produces a Rat';
does-ok <1/2>, Numeric, '<1/2> does Numeric';
does-ok <1/2>, Real, '<1/2> does Real';
isa-ok <0x01/0x02>, Rat, 'same with hexadecimal numbers';

#?rakudo 2 todo "Unsure of what's acceptable for val()"
ok <1/-3>.WHAT === Str, 'negative allowed only on numerator';
ok <-1/-3>.WHAT === Str, 'negative allowed only on numerator';

isa-ok <-1/3>, Rat, 'negative Rat literal';
ok <-1/3> * -3 == 1, 'negative Rat literal';

# https://github.com/Raku/old-issue-tracker/issues/3875
is <0x01/0x03>, (0x01/0x03), 'Rat works with hexadecimal numbers';
is <0b01/0b10>, (0b01/0b10), 'Rat works with binary numbers';
#?rakudo 2 todo 'Adverbial numbers in Rat literals not supported'
is <:13<01>/:13<07>>, (1/7), 'Rat works with colon radix numbers';
is <:12<1a>/:12<7b>>, (:12<1a> / :12<7b>), 'Rat works with colon radix numbers';

# L<S02/Complex literals/Complex literals are similarly indicated>

isa-ok  <1+1i>, Complex,  '<1+1i> is a Complex literal';
isa-ok <+2+2i>, Complex, '<+2+2i> is a Complex literal';
isa-ok <-3+3i>, Complex, '<-3+3i> is a Complex literal';
isa-ok <+4-4i>, Complex, '<+4-4i> is a Complex literal';
isa-ok <-5-5i>, Complex, '<-5-5i> is a Complex literal';

does-ok <1+1i>, Numeric, '1+1i does Numeric';
nok <1+1i>.does(Real), '1+1i doesn\'t do Real';
isa-ok  <1*1i>, Str, '1*1i is a Str';

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
is-approx  <-3.1e-23-2.9e-23i>.re, -3.1e-23, '<-3.1e-23-2.9e-23i> produces correct real value';
is-approx  <-3.1e-23-2.9e-23i>.im, -2.9e-23, '<-3.1e-23-2.9e-23i> produces correct imaginary value';
is-approx   <3.1e-99+2.9e-99i>.re,  3.1e-99, '<3.1e-99+2.9e-99i> produces correct real value';
is-approx   <3.1e-99+2.9e-99i>.im,  2.9e-99, '<3.1e-99+2.9e-99i> produces correct imaginary value';

is  <NaN+Inf\i>,   NaN + Inf\i, '<NaN+Inf\i> produces correct value';
is  <NaN-Inf\i>,   NaN - Inf\i, '<NaN-Inf\i> produces correct value';

# https://github.com/Raku/old-issue-tracker/issues/5759
{
    isa-ok <0--Inf\i>, Str, '0--Inf\i is a Str';
    isa-ok <0++Inf\i>, Str, '0++Inf\i is a Str';
    isa-ok <0+-Inf\i>, Str, '0+-Inf\i is a Str';
    isa-ok <0-+Inf\i>, Str, '0-+Inf\i is a Str';

    isa-ok <--Inf-1i>, Str, '--Inf-1i is a Str';
    isa-ok <++Inf-1i>, Str, '++Inf-1i is a Str';
    isa-ok <+-Inf-1i>, Str, '+-Inf-1i is a Str';
    isa-ok <-+Inf-1i>, Str, '-+Inf-1i is a Str';
}

# https://github.com/Raku/old-issue-tracker/issues/1721
is-approx 3.14159265358979323846264338327950288419716939937510e0,
          3.141592, 'very long Num literals';

# https://github.com/Raku/old-issue-tracker/issues/1566
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

# https://github.com/Raku/old-issue-tracker/issues/1403
ok 0e999999999999999 == 0, '0e999999999999 equals zero';

# We are not afraid of unicode
{
    #?rakudo.js skip 'unsupported unicode stuff'
    is ۵۵, 55, "We can handle Unicode digits";
    #?rakudo.jvm 3 skip 'bogus term'
    #?rakudo.js 3 skip 'unsupported unicode stuff'
    is ⅷ , 8, "We can handle Unicode non-digit numerics";
    is ⅔, 2/3, "We can handle vulgar fractions";
    is 𒑡  × 𒑒, 2/3, "We can multiply cuneiform :-)";
    #?rakudo.jvm skip 'Prefix - requires an argument, but no valid term found'
    #?rakudo.js skip 'unsupported unicode stuff'
    ok -𝑒 ** −π\i ≅ 1, "We can write 1 in funny ways too";
    is ∞, Inf, "yeah, we do that too...";
}


# https://github.com/rakudo/rakudo/issues/2094
subtest '#2094 prefix as post fix works on number literals' => {
   plan 6;
   cmp-ok 42.:<->,      '==', -42, 'use negation as postfix';
   cmp-ok 42.:<~>,     '===', "42", 'use ~ as postfix';
   cmp-ok 42.:«~»,     '===', "42", 'use « » to wrap the prefix';
   cmp-ok 42.:<<~>>,   '===', "42", 'use << >> to wrap the prefix';
   cmp-ok 42.:["~"],   '===', "42", 'use [" "] to wrap the prefix';
   cmp-ok 42.:<<'~'>>, '===', "42", "use <<' '>> to wrap the prefix";
}

# https://github.com/rakudo/rakudo/issues/3694
#?rakudo.jvm skip 'uniprop NYI'
#?DOES 1
{
  subtest "check simple non-ascii numerification" => {

    for (^0x0FFF).grep({
        .uniprop eq 'Nd' and .unival == 1|2|3
    }).batch(3)>>.chr>>.join -> $string {
        is-deeply $string.Numeric, 123, "is '$string'.Numeric ok?";
        is-deeply $string.Int,     123, "is '$string'.Int ok?";
    }

    done-testing;
  }
}

{
    is-deeply (-1234567890).Str(:superscript), '⁻¹²³⁴⁵⁶⁷⁸⁹⁰', 'Int superscript';
    is-deeply (-1234567890).Str(:subscript),   '₋₁₂₃₄₅₆₇₈₉₀', 'Int subscript';
}

# C99 hexadecimal floating point literals - rakudo/rakudo#6524
{
    isa-ok 0x1.8p+1, Num, 'hexfloat literal produces a Num';
    is-deeply 0x1.8p+1,  3e0,    'hexfloat with fraction';
    is-deeply 0x1p-2,    0.25e0, 'hexfloat without fraction, negative exponent';
    is-deeply 0x.8p+1,   1e0,    'hexfloat without integer part';
    is-deeply 0x1.8P4,   24e0,   'capital P exponent without sign';
    is-deeply -0x1.8p+1, -3e0,   'negated hexfloat';
    is-deeply 0x1.999999999999ap-4, 0.1e0, 'full-precision mantissa';
    is-deeply 0xde_ad.be_efp+0, 0xdead.beefp0, 'underscores in mantissa';
    is-deeply 0x1p+1_0, 1024e0, 'underscore in exponent';
    is-deeply 0x1.fffffffffffffp+1023, 1.7976931348623157e308, 'largest double';
    is-deeply 0x1p-1022, 2.2250738585072014e-308, 'smallest normal';
    is-deeply 0x1p-1074, 5e-324, 'smallest subnormal';
    is-deeply 0x1.8p-1074, 1e-323, 'subnormal tie rounds to even';
    is-deeply 0x1p+9999, Inf, 'exponent overflow gives Inf';
    is-deeply 0x1p-9999, 0e0, 'exponent underflow gives 0';
    ok (-0x0p+0) === -0e0, 'negative zero survives';

    # unchanged behaviors
    is-deeply 0x1.abs, 1, 'method call on hex integer literal still works';
    throws-like '0x1.8', Exception,
        'hexfloat without binary exponent is still an error';
}

# vim: expandtab shiftwidth=4
