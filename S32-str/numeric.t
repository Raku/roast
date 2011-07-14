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

check '123',        Int,    123;
check '+123',       Int,    123;
check '-123',       Int,   -123;
f     'a+123';
f     '123foo';
f     '123+';

check '0b111',      Int,      7;
check '+0b111',     Int,      7;
check '-0b111',     Int,     -7;
f     '0b112';
f     '0b';
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
check ':36<aZ>',    Int,    395;
check ':2<11>',     Int,      3;
f     ':2<2>';
f     ':37<8>';
f     ':18<>';
f     ':10<8';

check '123.',       Rat,    123;
check '123.0',      Rat,    123;
check '-123.0',     Rat,    123;
check '+123.0',     Rat,    123;

check '123e0',      Num,    123;
check '-123e0',     Num,   -123;
check '+123e0',     Num,    123;
check '123e-0',     Num,    123;
check '-123e+0',    Num,   -123;
check '123E0',      Num,    123;
check '-123E0',     Num,   -123;
check '+123E0',     Num,    123;
check '123E-0',     Num,    123;
check '-123E+0',    Num,   -123;
check '1230E-1',    Num,    123;
check '-12E+1',     Num,   -120;


done;

# vim: ft=perl6 
