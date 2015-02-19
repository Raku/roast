use v6;
use Test;

plan 31;

# Int
{
    is  0.base(8),  '0',        '0.base(something)';
    # RT #112872
    is  0.base(2),  '0',        '0.base(2)';
    is 42.base(10), '42',       '42.base(10)';
    is 42.base(16), '2A',       '42.base(16)';
    is 42.base(2) , '101010',   '42.base(2)';
    is 35.base(36), 'Z',        '35.base(36)';
    is 36.base(36), '10',       '36.base(36)';
    is (-12).base(16), '-C',    '(-12).base(16)';
    is 121.base(11,3), '100.000', 'Integer digits are 0s';
    is 121.base(11,0), '100',   'Integer with 0 digits fraction leaves off radix point';
}

# Rat
# RT 112900
#?niecza skip "Rat.base NYI"
{
    is (1/10000000000).base(3),
       '0.0000000000000000000010',   # is the trailing zero correct?
       '(1/10000000000).base(3) (RT 112900)';
    is (3.25).base(16), '3.4',  '(3.25).base(16)';
    is (10.5).base(2), '1010.1', '(10.5).base(2)';
    is (-3.5).base(16), '-3.8', '(-3.5).base(16)';
    is (1/3).base(10,40), '0.3333333333333333333333333333333333333333', 'repeating fraction can go 40 digits';
    is (2/3).base(10,40), '0.6666666666666666666666666666666666666667', 'repeating fraction can round at 40 digits';
    is (1/2).base(3,40), '0.1111111111111111111111111111111111111112', 'repeating base 3 fraction can round at 40 digits';
    is :8<773320.123>.base(8,0), '773320',   'Rat with 0 digits fraction leaves off radix point';
    is 16.0.base(16,3), '10.000', 'explicit digits are produced even if 0';
    is 16.5.base(16,3), '10.800', 'explicit digits are produced even if some are 0';
}

# base-repeating
{
    is (1/65535).base-repeating(10).Str, '0.0 0001525902189669642175936522468909742885481040665293354695963988708323796444647898069733730067902647440299076829175249866483558403906309605554283970397497520408941786831464103150988021667811093308918898298619058518348973830777447165636682688639658197909514', '1/65536 repeats with 256 char cycle';
    is (1/7).base-repeating(10).Str, '0. 142857', '1/7 repeats with 6 char cycle';
    is 3.1416.base-repeating(36).Str, '3.5 3IHMIRZRPEGH1SA4YBV5TFLY1HWW0X6E63SUVG6OJCQ9K7U0CFWBAFBKSKI799UL2XR4NYM8EQUAPOTPZ6YWLNO8ZHC5J2D0MT58P4384DLDB022NDVQJXGRF17JN', '3.1416 repeats in base 36';
}

# Num
{
    is 16.99999e0.base(16,3), '11.000', 'rounding works on fractional part';
    is 16.99999e0.base(16,0), '11', 'rounding works on integer part';
    is 16.999e0.base(16,3), '10.FFC', 'rounding works on 16.999e0.base(16,3)';
    is 16.999e0.base(16,9), '10.FFBE76C8B', 'rounding works on 16.999e0.base(16,9)';
    is pi.base(10,4), '3.1416', 'pi rounds to 4 place';
    is (6.02214129e23 / 10 ** 23).base(3,0), '20', 'Num with 0 digits fraction leaves off radix point';
    is 16e0.base(16,3), '10.000', 'explicit digits are produced even if 0';
    is 16.5e0.base(16,3), '10.800', 'explicit digits are produced even if some are 0';
}
