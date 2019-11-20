use v6;
use Test;
plan 190;

#?DOES 2
sub check($str, $expected_type, $expected_number, $desc?) {
    my $result = +$str;
    my $description = $desc // $str;
    is $result.WHAT.gist, $expected_type.gist, "$description (type)";
    is $result, $expected_number, "$description (value)";
}

#?DOES 1
sub f($str) {
    my $num = +$str;
    ok !$num.defined, "+{$str.perl} fails";
}

check '',           Int,      0;
check ' ',          Int,      0; # RT128543
check '   ',        Int,      0;
check '123',        Int,    123;
check ' 123',       Int,    123;
check '0000123',    Int,    123;
check '1_2_3',      Int,    123;
check '+123',       Int,    123;
check '-123',       Int,   -123;
check '3433683820292512484657849089281', Int, 3**64;
f     'a+123';
f     '123foo';
f     '123+';
f     '1__2';
f     '123_';
f     '123 and stuff';


check '0b111',      Int,      7;
check '0b1_1_1',    Int,      7;
check '+0b111',     Int,      7;
check '-0b111',     Int,     -7;
# the spec is silent about this one, but rakudo and niecza agree
check '0b_1',       Int,      1;
f     '0b112';
f     '0b';
check '0o77',       Int,     63;
check '+0o77',      Int,     63;
check '-0o77',      Int,    -63;
f     '0o8';
check '0d123',      Int,    123;
check '-0d123',     Int,    -123;
f     '0da';
check '0x123',      Int,    291;
check '-0x123',     Int,   -291;
check '0xa0',       Int,    160;
check '-0xA0',      Int,   -160;
f     '0xag';
f     '0xaf-';

{
    check ':10<42>',    Int,     42;
    check '-:10<42>',   Int,    -42;
    check '-:1_0<4_2>', Int,    -42;
    check ':36<aZ>',    Int,    395;
    check ':2<11>',     Int,      3;
    f     ':2<2>';
    f     ':37<8>';
    f     ':10<8_>';
    f     ':10<_8>';
    f     ':18<>';
    f     ':10<8';
}

f     '123.';
check '123.0',      Rat,    123;
check '-123.0',     Rat,    -123;
check '+123.0',     Rat,    123;
check '+1_2_3.0_0', Rat,    123;
check '3/2',        Rat,    1.5;
check '+3/2',       Rat,    1.5;
check '-3/2',       Rat,    -1.5;
#?rakudo 5 todo 'Unsure of what val() should accept'
f     '-3/-2';
f     '3/-2';
f     '+3/-2';
f     '3.0/2';
f     '3/2.0';

{
    check '-:10<4_2.3_5>', Rat, -42.35;
    check '-:8<4_2.3_5>',  Rat, -34.453125;

# from S02-literals/radix.t
    f ":2.4<01>";
    f ":10<12f>";
    f ":1b<10>";
    f ":10<>";
    f ":_2<01>";
    f ":2<_01>";
    f ":2<01_>";
    f ":_2_<_0_1_>_";
    f ":2<1.3>";
    f "0b1.1e10";
    f ":2<10dlk";
    f ":2lks01>";
}

check '123e0',      Num,    123;
check '-123e0',     Num,   -123;
check '−123e0',     Num,   -123; # U+2212 minus
check '+123e0',     Num,    123;
check '+123.0e0',   Num,    123;
check '+123.0_1e2', Num,  12301;
check '+123.0_1e0_2', Num,  12301;
check '123e-0',     Num,    123;
check '-123e+0',    Num,   -123;
check '−123e+0',    Num,   -123; # U+2212 minus
check '123E0',      Num,    123;
check '1_2_3E0_0',  Num,    123;
check '-123E0',     Num,   -123;
check '−123E0',     Num,   -123; # U+2212 minus
check '+123E0',     Num,    123;
check '123E-0',     Num,    123;
check '123E−0',     Num,    123; # U+2212 minus
check '-123E+0',    Num,   -123;
check '-123E+0_1',  Num,  -1230;
check '1230E-1',    Num,    123;
check '1230E−1',    Num,    123; # U+2212 minus
check '-12E+1',     Num,   -120;
check '−12E+1',     Num,   -120; # U+2212 minus
f      '120e';
f      '120e2_';

# TODO: Nums with radix

is +"Inf",  'Inf',  'Inf';
is +"+Inf", 'Inf',  '+Inf';
is +"-Inf", '-Inf', '-Inf';
is +"NaN",  'NaN',  'NaN';

{
    check  '1+2i',                  Complex,        1+2i;
    check  '-1-2i',                 Complex,       -1-2i;
    check  '-1-2\i',                Complex,       -1-2i;
    check  '-1.0-2.0\i',            Complex,       -1-2i;
    check  '-1.0e0-2.0e0\i',        Complex,       -1-2i;
    check  '-1.0e0_0-2.0e0_0\i',    Complex,       -1-2i;
    check  '3+Inf\i',               Complex,     3+Inf\i;
    check  'Inf+2e2i',              Complex,    Inf+200i;
    f      '3+3i+4i';
    f      '3+3+4i';
}

f      '3+Infi';

# TODO: Complex with radix

# RT #100778
{
    is +Str.new, 0, 'RT #100778'
}

# RT #128542
throws-like Q|"34\x[308]5".Int|, X::Str::Numeric,
    '.Int on strings with numerics with combining characters throws';

# RT #130450
{
    my $n;
    lives-ok { $n = 'a'.Int; 'notafailure' }, '"a".Int lives...';
    isa-ok $n, Failure, '"a".Int produces a failure';
    dies-ok { $n * 2 }, 'cannot do math with a Failure';
}

# https://github.com/rakudo/rakudo/pull/3289
fails-like { 'a'.UInt }, X::Str::Numeric,
    '"a".UInt produces a Failure';

subtest 'can handle − (U+2212) minus as regular minus' => {
    plan 4;
    is-deeply +'−42', -42, 'Int';
    is-deeply +'−42.72', -42.72, 'Rat';
    subtest 'Num (minus in...)' => {
        plan 3;
        is-deeply +'−42e0',   -42e0,   'base';
        is-deeply +'42e−10',   42e-10, 'exponent';
        is-deeply +'−42e−10', -42e-10, 'both base and exponent';
    }
    subtest 'Complex' => {
        plan 4;

        #?rakudo 2 skip 'cannot handle lone i yet'
        is-deeply +'−i',     -i, 'lone i';
        is-deeply +'−10i', -10i, 'number with i';

        subtest 'numberless i (minus in ...)' => {
            plan 3;

            #?rakudo 3 skip 'cannot handle lone i yet'
            is-deeply +'−10-i', -10-i, 'real';
            is-deeply +'10−i',   10-i, 'imaginary';
            is-deeply +'−10−i', -10-i, 'both real and imaginary';
        }

        subtest 'i with number (minus in ...)' => {
            plan 3;
            is-deeply +'−10-10i', -10-10i, 'real';
            is-deeply +'10−10i',   10-10i, 'imaginary';
            is-deeply +'−10−10i', -10-10i, 'both real and imaginary';
        }
    }
}

# vim: ft=perl6
