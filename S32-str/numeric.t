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
    my $num = 0; # defined
    try { $num = +$str }
    ok !$num.defined, "+$str fails";
}

check '',           Int,      0;
check '123',        Int,    123;
check ' 123',       Int,    123;
check '0000123',    Int,    123;
check '1_2_3',      Int,    123;
check '+123',       Int,    123;
check '-123',       Int,   -123;
check '3433683820292512484657849089281', Int, 3**64;
#?niecza 6 todo 'Failure'
#?rakudo emit # Str.Numeric non-numeric fail
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
#?niecza 3 todo 'Failure'
f     '0b112';
f     '0b';
f     '0b_1';
check '0o77',       Int,     63;
check '+0o77',      Int,     63;
check '-0o77',      Int,    -63;
#?niecza todo 'Failure'
f     '0o8';
check '0d123',      Int,    123;
check '-0d123',     Int,    -123;
#?niecza todo 'Failure'
f     '0da';
check '0x123',      Int,    291;
check '-0x123',     Int,   -291;
check '0xa0',       Int,    160;
check '-0xA0',      Int,   -160;
#?niecza 2 todo 'Failure'
f     '0xag';
f     '0xaf-';

{
    check ':10<42>',    Int,     42;
    check '-:10<42>',   Int,    -42;
    check '-:1_0<4_2>', Int,    -42;
    check ':36<aZ>',    Int,    395;
    check ':2<11>',     Int,      3;
    #?niecza 6 todo 'Failure'
    f     ':2<2>';
    #?rakudo skip 'NYI'
    f     ':37<8>';
    f     ':10<8_>';
    f     ':10<_8>';
    f     ':18<>';
    f     ':10<8';
}

#?niecza todo 'Failure'
f     '123.';
check '123.0',      Rat,    123;
check '-123.0',     Rat,    -123;
check '+123.0',     Rat,    123;
check '+1_2_3.0_0', Rat,    123;
check '3/2',        Rat,    1.5;
check '+3/2',       Rat,    1.5;
check '-3/2',       Rat,    -1.5;
#?niecza 5 todo 'Failure'
f     '-3/-2';
f     '3/-2';
f     '+3/-2';
f     '3.0/2';
f     '3/2.0';

#?rakudo skip ":radix<>"
{
    check '-:10<4_2.3_5>', Rat, -42.35;
    check '-:8<4_2.3_5>',  Rat, -34.453125;

# from S02-literals/radix.t
#?niecza 12 todo 'Failure'
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
#?niecza 2 todo 'Failure'
f      '120e';
f      '120e2_';

# TODO: Nums with radix

is +"Inf",  'Inf',  'Inf';
is +"+Inf", 'Inf',  '+Inf';
is +"-Inf", '-Inf', '-Inf';
is +"NaN",  'NaN',  'NaN';

#?rakudo skip "complex Str.Numeric"
{
    check  '1+2i',                  Complex,        1+2i;
    check  '-1-2i',                 Complex,       -1-2i;
    check  '-1-2\i',                Complex,       -1-2i;
    check  '-1.0-2.0\i',            Complex,       -1-2i;
    check  '-1.0e0-2.0e0\i',        Complex,       -1-2i;
    check  '-1.0e0_0-2.0e0_0\i',    Complex,       -1-2i;
    check  '3+Inf\i',               Complex,     3+Inf\i;
    check  'Inf+2e2i',              Complex,    Inf+200i;
#?niecza 3 todo 'Failure'
    f      '3+Infi';
    f      '3+3i+4i';
    f      '3+3+4i';
}

# TODO: Complex with radix

# RT #100778
{
    is +Str.new, 0, 'RT #100778'
}

done;

# vim: ft=perl6 
