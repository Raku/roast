use v6;
use Test;

#?DOES 2
sub check($str, $expected_type, $expected_number, $desc?) {
    my $result = +$str;
    my $description = $desc // $str;
    is $result.WHAT.gist, $expected_type.gist, "$description (type)";
    ok $result == $expected_number, "$description (value)"
        or diag(
              "got:      $result\n"
            ~ "expected: $expected_number"
        );
}

#?DOES 1
sub f($str) {
    ok !(+$str).defined, "+$str fails";
}

f     '';
check '123',        Int,    123;
check '1_2_3',      Int,    123;
check '+123',       Int,    123;
check '-123',       Int,   -123;
f     'a+123';
f     '123foo';
f     '123+';
f     '1__2';
f     '123_';

check '0b111',      Int,      7;
check '0b1_1_1',    Int,      7;
check '+0b111',     Int,      7;
check '-0b111',     Int,     -7;
f     '0b112';
f     '0b';
f     '0b_1';
check '0o77',       Int,     63;
check '+0o77',      Int,     63;
check '-0o77',      Int,    -63;
f     '0o8';
check '0d123',      Int,    123;
check '-0d123',     Int,    123;
f     '0da';
check '0x123',      Int,    291;
check '-0x123',     Int,   -291;
check '0xa0',       Int,    160;
check '-0xA0',      Int,   -160;
f     '0xag';
f     '0xaf-';

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

check '123.',       Rat,    123;
check '123.0',      Rat,    123;
check '-123.0',     Rat,    123;
check '+123.0',     Rat,    123;
check '+1_2_3.0_0', Rat,    123;
check '-:10<4_2.3_5>', Rat, 42.35;
check '-:8<4_2.3_5>',  Rat, 34.453125;


check '123e0',      Num,    123;
check '-123e0',     Num,   -123;
check '+123e0',     Num,    123;
check '+123.0e0',   Num,    123;
check '+123.0_1e2', Num,  12301;
check '+123.0_1e0_2', Num,  12301;
check '123e-0',     Num,    123;
check '-123e+0',    Num,   -123;
check '123E0',      Num,    123;
check '1_2_3E0_0',  Num,    123;
check '-123E0',     Num,   -123;
check '+123E0',     Num,    123;
check '123E-0',     Num,    123;
check '-123E+0',    Num,   -123;
check '-123E+0_1',  Num,  -1230;
check '1230E-1',    Num,    123;
check '-12E+1',     Num,   -120;
f      '120e';
f      '120e2_';

# TODO: Nums with radix


check  '1+2i',                  Complex,        1+2i;
check  '-1-2i',                 Complex,       -1-2i;
check  '-1-2\i',                Complex,       -1-2i;
check  '-1.0-2.0\i',            Complex,       -1-2i;
check  '-1.0e0-2.0e0\i',        Complex,       -1-2i;
check  '-1.0e0_0-2.0e0_0\i',    Complex,       -1-2i;
check  '3+Inf\i',               Complex,     3+Inf\i;
check  'Inf+2e2i',              Complex,    Inf+200i;
f      '3+Infi';
f      '3+3i+4i';
f      '3+3+4i';

# TODO: Complex with radix

done;

# vim: ft=perl6 
