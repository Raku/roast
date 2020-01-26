use v6.d;
use lib $?FILE.IO.parent(2).add: 'packages';
use Test;
use Test::Util;

plan 63;

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
    fails-like ｢1.base: 10, -1｣, X::OutOfRange, "X::OutOfRange negative digits arg fails";
    fails-like ｢1.base: -1｣,     X::OutOfRange, "X::OutOfRange negative base fails";
}
# Int with Str argument
{
    is  0.base('8'),  '0',        '0.base(something)';
    # RT #112872
    is  0.base('2'),  '0',        '0.base(2)';
    is 42.base('10'), '42',       '42.base(10)';
    is 42.base('16'), '2A',       '42.base(16)';
    is 42.base('2') , '101010',   '42.base(2)';
    is 35.base('36'), 'Z',        '35.base(36)';
    is 36.base('36'), '10',       '36.base(36)';
    is (-12).base('16'), '-C',    '(-12).base(16)';
    is 121.base('11',3), '100.000', 'Integer digits are 0s';
    is 121.base('11',0), '100',   'Integer with 0 digits fraction leaves off radix point';
    fails-like ｢1.base: '10', -1｣, X::OutOfRange, "X::OutOfRange negative digits arg fails";
    fails-like ｢1.base: '-1'｣,     X::OutOfRange, "X::OutOfRange negative base fails";
}
# Rat
# RT #112900
{
    is (1/10000000000).base(3),
       '0.000000000000000000001',
       '(1/10000000000).base(3) (RT #112900)';
    is (3.25).base(16), '3.4',  '(3.25).base(16)';
    is (10.5).base(2), '1010.1', '(10.5).base(2)';
    is (-3.5).base(16), '-3.8', '(-3.5).base(16)';
    is (1/3).base(10,40), '0.3333333333333333333333333333333333333333', 'repeating fraction can go 40 digits';
    is (2/3).base(10,40), '0.6666666666666666666666666666666666666667', 'repeating fraction can round at 40 digits';
    is (1/2).base(3,40), '0.1111111111111111111111111111111111111112', 'repeating base 3 fraction can round at 40 digits';
    is :8<773320.123>.base(8,0), '773320',   'Rat with 0 digits fraction leaves off radix point';
    is 16.0.base(16,3), '10.000', 'explicit digits are produced even if 0';
    is 16.5.base(16,3), '10.800', 'explicit digits are produced even if some are 0';

    is (3/2).base(10, 1), "1.5", "(3/2).base(10, 1)";
    is (49/999).base(10, 1), "0.0", "(49/999).base(10, 1) rounds down integer";
    is (98/99).base(10, 1), "1.0", "(98/99).base(10, 1) rounds up integer";
    is (100/99).base(10, 1), "1.0", "(100/99).base(10, 1) rounds down integer";
    is (98/99).base(10, 0), "1", "(98/99).base(10, 0) rounds up integer (RT #126022)";
    is (100/99).base(10, 0), "1", "(100/99).base(10, 0) rounds down integer";
    is (.01).base(10, 0), "0", "(.01).base(10, 0) rounds down integer";

    is (1/100).base(10, *), "0.01", "decimal base with Whatever digits";
    is (1/128).base(10, *), "0.0078125", "longer number with Whatever digits";
    is (3/1024).base(16, *), "0.00C", "hex base with Whatever";

    fails-like ｢1.5.base: 10, -1｣, X::OutOfRange, "negative digits arg fails";
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

    fails-like ｢1.5e0.base: 10, -1｣, X::OutOfRange,
        "negative digits arg fails";
}

subtest 'all Reals can accept Whatever for second .base argument' => {
    my @reals = 255, 255e0, <255/1>, FatRat.new(255, 1),
        Duration.new(255), Instant.from-posix(245); # 10 extra TAI - UTC seconds

    plan +@reals;
    is-deeply .base(16, *), 'FF', .^name for @reals;
}

# RT#125819
{
    fails-like { 255.base: 16, -100 }, X::OutOfRange,
        'negative $digits arg throws';
    #?rakudo.jvm todo 'code does not die, RT#125819'
    throws-like {
        255.base(16, 9999999999999999999999999999999999999999999999999);
    }, Exception, :message{ .contains('repeat count').not },
    'huge digits arg does not throw weird error';
}

# RT#130753
# https://github.com/rakudo/rakudo/issues/2266
fails-like { 1.1.base(1) }, X::OutOfRange, "Throws like X::OutOfRange for base 1";

# RT #125818
throws-like 'Inf.base: 16', X::Numeric::CannotConvert,
    'Inf.base throws useful error';
throws-like 'NaN.base: 16', X::Numeric::CannotConvert,
    'NaN.base throws useful error';
