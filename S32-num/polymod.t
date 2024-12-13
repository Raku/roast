use Test;

plan 11;

# L<S32::Numeric/=item polymod>

is 86400.polymod(60),       (0,1440),  '86400 60';
is 86400.polymod(60,60),    (0,0,24),  '86400 60 60';
is 86400.polymod(60,60,24), (0,0,0,1), '86400 60 60 24';

is   1234567890.polymod(10 xx *), (0,9,8,7,6,5,4,3,2,1), '  1234567890 10 xx *';
is 0x1234567890.polymod(16 xx *), (0,9,8,7,6,5,4,3,2,1), '0x1234567890 16 xx *';
is 0x1234567890.polymod(16 xx 5), (0,9,8,7,6,74565),     '0x1234567890 16 xx 5';

# https://github.com/Raku/old-issue-tracker/issues/5327
subtest '.polymod with a lazy list does not lose divisors when list runs out', {
    plan 3;
    is-deeply 42    .polymod(lazy 2, 3),
              42    .polymod(     2, 3), 'last mod is non-zero (Int)';
    is-deeply 42.Rat.polymod(lazy 2, 3),
              42.Rat.polymod(     2, 3), 'last mod is non-zero (Rat)';
    is-deeply 12    .polymod(14 xx *),
                    (12,),               'last mod is zero';
}

# https://github.com/rakudo/rakudo/issues/4523
{
    is-deeply 100.polymod(    1 xx *), (100,), 'modulo 1 stops (1)';
    is-deeply 100.polymod(10, 1 xx *), (0,10), 'modulo 1 stops (2)';
}

is 10e0.polymod(1.5), (1,6), 'polymod on non-integers';

# https://github.com/rakudo/rakudo/issues/5726 (Digest and others)
is-deeply 1234567.polymod(256 xx 7), (135, 214, 18, 0, 0, 0, 0, 0),
  'fixed length produces right number of values, even with zeroes';

# vim: expandtab shiftwidth=4
