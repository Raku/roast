use v6.d;
use Test;
plan 5;

# L<S32::Numeric/=item polymod>

is 86400.polymod(60),       (0,1440),  '86400 60';
is 86400.polymod(60,60),    (0,0,24),  '86400 60 60';
is 86400.polymod(60,60,24), (0,0,0,1), '86400 60 60 24';

is 1234567890.polymod(10 xx *), (0,9,8,7,6,5,4,3,2,1), '1234567890 10 xx *';

#RT #128176
subtest '.polymod with a lazy list does not lose divisors when list runs out', {
    plan 3;
    is-deeply 42    .polymod(lazy 2, 3),
              42    .polymod(     2, 3), 'last mod is non-zero (Int)';
    is-deeply 42.Rat.polymod(lazy 2, 3),
              42.Rat.polymod(     2, 3), 'last mod is non-zero (Rat)';
    is-deeply 12    .polymod(14 xx *),
                    (12,),               'last mod is zero';
}
