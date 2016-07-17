use v6;
use Test;
plan 9;

# L<S32::Numeric/=item polymod>

is 86400.polymod(60),       (0,1440),  '86400 60';
is 86400.polymod(60,60),    (0,0,24),  '86400 60 60';
is 86400.polymod(60,60,24), (0,0,0,1), '86400 60 60 24';

is 1234567890.polymod(10 xx *), (0,9,8,7,6,5,4,3,2,1), '1234567890 10 xx *';

#RT #128176
subtest '.polymod with a lazy list does not lose divisors when list runs out', {
    is-deeply 42    .polymod(lazy 2, 3),
              42    .polymod(     2, 3), 'last mod is non-zero (Int)';
    is-deeply 42.Rat.polymod(lazy 2, 3),
              42.Rat.polymod(     2, 3), 'last mod is non-zero (Rat)';
    is-deeply 12    .polymod(lazy 14, ),
                    (12,),               'last mod is zero';
}

#RT #128646
{
    throws-like { 1.polymod: 0           }, X::Numeric::DivideByZero,
        gist => /^ [<!after 'CORE.setting.'> . ]+ $/,
    'Int.polymod with zero divisor does not reference guts in error';

    throws-like { 1.Rat.polymod: 0       }, X::Numeric::DivideByZero,
        gist => /^ [<!after 'CORE.setting.'> . ]+ $/,
    'Real.polymod with zero divisor does not reference guts in error';

    throws-like { 1.polymod: lazy 0,     }, X::Numeric::DivideByZero,
        gist => /^ [<!after 'CORE.setting.'> . ]+ $/,
    'Int.polymod with [lazy] zero divisor does not reference guts in error';

    throws-like { 1.Rat.polymod: lazy 0, }, X::Numeric::DivideByZero,
        gist => /^ [<!after 'CORE.setting.'> . ]+ $/,
    'Real.polymod with [lazy] zero divisor does not reference guts in error';
}
