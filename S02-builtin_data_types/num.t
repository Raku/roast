use v6;

use Test;

#L<S02/Built-In Data Types/Perl intrinsically supports big integers>

plan 47;
{
    my $a = 1; "$a";
    isa_ok($a, 'Int');
    is($a, "1", '1 stringification works');
}

{
    my $a = -1; "$a";
    isa_ok($a, 'Int');
    is($a, "-1", '-1 stringification works');
}

#L<S02/Built-In Data Types/Rat supports arbitrary precision rational arithmetic>
{
    my $a = 1.0; "$a";
    #?rakudo todo "no Rat yet"
    isa_ok($a, 'Rat');
    is($a, "1", '1.0 stringification works');
}

{
    my $a = -1.0; "$a";
    #?rakudo todo "no Rat yet"
    isa_ok($a, 'Rat');
    is($a, "-1", '-1 stringification works');
}

{
    my $a = 0.1; "$a";
    #?rakudo todo "no Rat yet"
    isa_ok($a, 'Rat');
    is($a, "0.1", '0.1 stringification works');
}

{
    my $a = -0.1; "$a";
    #?rakudo todo "no Rat yet"
    isa_ok($a, 'Rat');
    is($a, "-0.1", '-0.1 stringification works');
}

{
    my $a = 10.01; "$a";
    #?rakudo todo "no Rat yet"
    isa_ok($a, 'Rat');
    is($a, "10.01", '10.01 stringification works');
}

{
    my $a = 1e3; "$a";
    #?rakudo todo "no Rat yet"
    isa_ok($a, 'Rat');
    is($a, "1000", '1e3 stringification works');
}

{
    my $a = 10.01e3; "$a";
    #?rakudo todo "no Rat yet"
    isa_ok($a, 'Rat');
    is($a, "10010", '10.01e3 stringification works');
}

#L<S02/Built-In Data Types/Perl intrinsically supports big integers>

{
    my $a = 0b100; "$a";
    isa_ok($a, 'Int');
    is($a, "4", '0b100 (binary) stringification works');
}

{
    my $a = 0x100; "$a";
    isa_ok($a, 'Int');
    is($a, "256", '0x100 (hex) stringification works');
}

{
    my $a = 0o100; "$a";
    isa_ok($a, 'Int');
    is($a, "64", '0o100 (octal) stringification works');
}

{
    my $a = 1; "$a"; 
    is($a + 1, 2, 'basic addition works');
}

{
    my $a = -1; "$a";
    ok($a + 1 == 0, 'basic addition with negative numbers works'); # parsing bug
}
#L<S02/Built-In Data Types/Rat supports arbitrary precision rational arithmetic>

{
    my $a = 80000.0000000000000000000000000;
    #?rakudo todo "no Rat yet"
    isa_ok($a, 'Rat');
    ok($a == 80000.0, 'trailing zeros compare correctly');
}

{
    my $a = 1.0000000000000000000000000000000000000000000000000000000000000000000e1;
    #?rakudo todo "no Rat yet"
    isa_ok($a, 'Rat');
    ok($a == 10.0, 'trailing zeros compare correctly');
}

#L<S02/Built-In Data Types/Num may support arbitrary-precision floating-point>

{
    my $a = "1.01";
    isa_ok(+$a, "Num");
    is(+$a, 1.01, "1.01 numifies to 1.01");
}

{
    my $a = "0d01.01";
    isa_ok(+$a, "Num");
    #?rakudo todo "correct numification"
    is(+$a, 1.01, "0d01.01 numifies to 1.01");
}

#L<S02/Built-In Data Types/Perl intrinsically supports big integers>

{
    my $a = "1.01";
    isa_ok(int($a), "Int");
    is(int($a), 1, "1.01 intifies to 1");
}

#L<S02/Built-In Data Types/Num may support arbitrary-precision floating-point>

{
    my $a = "0d0101";
    isa_ok(+$a, "Num");
    is(+$a, 101, "0d0101 numifies to 101");
}

{
    my $a = 2 ** 65; # over the 64 bit limit too
    is($a, 36893488147419103232, "we have bignums, not weeny floats");
}

is(42_000,     42000,    'underscores allowed (and ignored) in numeric literals');
is(42_127_000, 42127000, 'multiple underscores ok');
is(42.0_1,     42.01,    'underscores in fraction ok');
is(4_2.01,     42.01,    'underscores in whole part ok');

eval_dies_ok('4_2._0_1', 'single underscores are not ok directly after the dot');
is(4_2.0_1, 42.01,  'single underscores are ok');

is 0_1, 1, "0_1 is parsed as 0d1";
is +^1, -2, '+^1 == -2 as promised';
