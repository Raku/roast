use v6;
use Test;

plan 189;

# L<S02/Literals/":10<42>">

is( :10<0>,   0, 'got the correct int value from decimal 0' );
is( :10<1>,   1, 'got the correct int value from decimal 1' );
is( :10<2>, 0d2, 'got the correct int value from decimal 2' );
is( :10<3>, 0d3, 'got the correct int value from decimal 3' );

# the answer to everything
is(     42,   0d42, '42 and 0d42 are the same'      );
is( :10<42>,    42, ':10<42> and 42 are the same'   );
is( :10<42>,  0d42, ':10<42> and 0d42 are the same' );

# L<S02/Literals/"Think of these as setting the default radix">
# setting the default radix

{
    is(:10('01110') ,  0d1110, ":10('01110') is default decimal");
#?pugs 4 todo "unimpl"
    is(:10('0b1110'), 0b1110, ":10('0b1110') overrides default decimal");
    is(:10('0x20'),   0x20, ":10('0x20') overrides default decimal");
    is(:10('0o377'),  0o377, ":10('0o255') overrides default decimal");
    is(:10('0d37'),   0d37, ":10('0d37') overrides default decimal");
}


# L<S29/Conversions/"prefix:<:16>">
# L<S02/Literals/":16<DEAD_BEEF>">

# 0 - 9 is the same int
is(:16<0>, 0, 'got the correct int value from hex 0');
is(:16<1>, 1, 'got the correct int value from hex 1');
is(:16<2>, 2, 'got the correct int value from hex 2');
is(:16<3>, 3, 'got the correct int value from hex 3');
is(:16<4>, 4, 'got the correct int value from hex 4');
is(:16<5>, 5, 'got the correct int value from hex 5');
is(:16<6>, 6, 'got the correct int value from hex 6');
is(:16<7>, 7, 'got the correct int value from hex 7');
is(:16<8>, 8, 'got the correct int value from hex 8');
is(:16<9>, 9, 'got the correct int value from hex 9');

# check uppercase vals
is(:16<A>, 10, 'got the correct int value from hex A');
is(:16<B>, 11, 'got the correct int value from hex B');
is(:16<C>, 12, 'got the correct int value from hex C');
is(:16<D>, 13, 'got the correct int value from hex D');
is(:16<E>, 14, 'got the correct int value from hex E');
is(:16<F>, 15, 'got the correct int value from hex F');

# check lowercase vals
is(:16<a>, 10, 'got the correct int value from hex a');
is(:16<b>, 11, 'got the correct int value from hex b');
is(:16<c>, 12, 'got the correct int value from hex c');
is(:16<d>, 13, 'got the correct int value from hex d');
is(:16<e>, 14, 'got the correct int value from hex e');
is(:16<f>, 15, 'got the correct int value from hex f');

# check 2 digit numbers
is(:16<10>, 16, 'got the correct int value from hex 10');
is(:16<20>, 32, 'got the correct int value from hex 20');
is(:16<30>, 48, 'got the correct int value from hex 30');
is(:16<40>, 64, 'got the correct int value from hex 40');
is(:16<50>, 80, 'got the correct int value from hex 50');

# check 3 digit numbers
is(:16<100>, 256, 'got the correct int value from hex 100');

# check some weird versions
is(:16<FF>, 255, 'got the correct int value from hex FF');
is(:16<fF>, 255, 'got the correct int value from (mixed case) hex fF');

# some random mad up hex strings (these values are checked against perl5)
is :16<2_F_A_C_E_D>,  0x2FACED, 'got the correct int value from hex 2_F_A_C_E_D';

# L<S02/Literals/"interpret leading 0b or 0d as hex digits">
is(:16('0b1110'), 0xB1110, ":16('0b1110') uses b as hex digit"  );
is(:16('0d37'),   0x0D37,  ":16('0d37') uses d as hex digit"     );

# L<S02/Literals/"Think of these as setting the default radix">
{
    is(:16('0fff'),      0xfff, ":16('0fff') defaults to hexadecimal");
#?pugs 2 todo 'feature'
    is(:16('0x20'),      0x20, ":16('0x20') stays hexadecimal");
    is(:16('0o377'),    0o377, ":16('0o255') converts from octal");
}

# L<S02/Literals/"which will be interpreted as they would outside the string">
# It seems odd that the numbers on the inside on the <> would be a mix of
# bases. Maybe I've misread the paragraph -- brian
#?pugs todo 'feature'
{
    is(:16<dead_beef> * 16**8, :16<dead_beef*16**8>,
        'Powers outside same as powers inside');
}


# L<S02/Literals/"Any radix may include a fractional part">

is(:16<dead_beef.face>,  0xDEAD_BEEF + 0xFACE / 65536.0, 'Fractional base 16 works' );


# L<S02/Literals/":8<177777>">
# L<S29/Conversions/"prefix:<:8>">

# 0 - 7 is the same int
is(:8<0>, 0, 'got the correct int value from oct 0');
is(:8<1>, 1, 'got the correct int value from oct 1');
is(:8<2>, 2, 'got the correct int value from oct 2');
is(:8<3>, 3, 'got the correct int value from oct 3');
is(:8<4>, 4, 'got the correct int value from oct 4');
is(:8<5>, 5, 'got the correct int value from oct 5');
is(:8<6>, 6, 'got the correct int value from oct 6');
is(:8<7>, 7, 'got the correct int value from oct 7');

# check 2 digit numbers
is(:8<10>,  8, 'got the correct int value from oct 10');
is(:8<20>, 16, 'got the correct int value from oct 20');
is(:8<30>, 24, 'got the correct int value from oct 30');
is(:8<40>, 32, 'got the correct int value from oct 40');
is(:8<50>, 40, 'got the correct int value from oct 50');

# check 3 digit numbers
is(:8<100>, 64, 'got the correct int value from oct 100');

# check some weird versions
is(:8<77>,      63, 'got the correct int value from oct 77');
is(:8<377>,     255, 'got the correct int value from oct 377');
is(:8<400>,     256, 'got the correct int value from oct 400');
is(:8<177777>, 65535, 'got the correct int value from oct 177777');
is(:8<200000>, 65536, 'got the correct int value from oct 200000');

# L<S02/Literals/"Think of these as setting the default radix">
# setting the default radix

#?pugs todo 'feature'
{
    is(:8('0b1110'),  0o14, ':8(0b1110) converts from decimal');
    is(:8('0x20'),    0o32, ':8(0x20) converts from decimal');
    is(:8('0o377'),  0o255, ':8(0o255) stays decimal');
    is(:8('0d37'),    0o37, ':8(0d37) converts from decimal');
}


# L<S29/Conversions/"prefix:<:2>">

is(:2<0>,     0, 'got the correct int value from bin 0');
is(:2<1>,     1, 'got the correct int value from bin 1');
is(:2<10>,    2, 'got the correct int value from bin 10');
is(:2<1010>, 10, 'got the correct int value from bin 1010');

is(
    :2<11111111111111111111111111111111>,
    0xFFFFFFFF,
    'got the correct int value from bin 11111111111111111111111111111111');


# L<S02/Literals/"Think of these as setting the default radix">
# setting the default radix

#?pugs todo 'feature'
{
    is(:2('0b1110'),  0d14, ':2<0b1110> stays binary');
    is(:2('0x20'),    0d32, ':2<0x20> converts from hexadecimal');
    is(:2('0o377'),  0d255, ':2<0o255> converts from octal');
    is(:2('0d37'),    0d37, ':2<0d37> converts from decimal');
}

# L<S02/Literals/"not clear whether the exponentiator should be 10 or the radix">
eval_dies_ok '0b1.1e10', 'Ambiguous, illegal syntax doesn\'t work';

# L<S02/Literals/"and this makes it explicit">
# probably don't need a test, but I'll write tests for any example :)
is( :2<1.1> *  2 ** 10,                  1536, 'binary number to power of 2'  );
is( :2<1.1> * 10 ** 10,        15_000_000_000, 'binary number to power of 10' );
is( :2<1.1> * :2<10> ** :2<10>,             6, 'multiplication and exponentiation' );

# L<S02/Literals/"So we write those as">
# these should be the same values as the previous tests
#?pugs todo 'feature'
{
    is( :2<1.1*2**10>,                   1536, 'Power of two in <> works');
    is( :2<1.1*10**10>,        15_000_000_000, 'Power of ten in <> works');
    is( eval('2«1.1*:2<10>**:2<10>»'),    6, 'Powers of two in <<>> works');
}

# Tests for the :x[ <list> ] notations
# L<S02/Literals/"Alternately you can use a list of digits in decimal">
{
    is( :60[12,34,56],     12 * 3600 + 34 * 60 + 56, 'List of numbers works' );
    is( :100[3,'.',14,16],     3.1416,         'Decimal point in list works' );

    is :100[10,10],      1010, "Adverbial form of base 100 integer works";
    is :100[10,'.',10], 10.10, "Adverbial form of base 100 fraction works";
}

# tests for the _valid_ string interpretations of radix notations
{
    is +"1234.567", 1234.567, "standard decimal (radix 10) fractions";
    is +"1.234e3", 1234, "basic exponential form works (1)";
    is +"1.234E3", 1234, "basic exponential form works (2)";
}

{
    is +":2<0101>", 5, "radix 2 notation works";
    is +":32<2q>", 90, "radix 32 notation works";
    is +":100<1e>", 114, "high order radix (limited alphabet) works";
    is +":1_0<14_56>", 1456, "underscore separators works";
    is +":10<123.456>", 123.456, "base 10 decimal notation works";
    is +":2<1.111>", 1.875, "base 2 decimal notation works";

    for 2..36 {
        is +":{$_}<11>", $_ + 1, "stringified form of base $_ works";
    }
}

# tests for _invalid_ string interpretations of radix notations
{
    is +":2.4<01>", 0, "fractional radix parsefail works";
    is +":10<12f>", 0, "invalid alphabet parsefail works";
    is +":1b<10>", 0, "invalid radix alphabet parsefail works";
    is +":10<>", 0, "missing radix conversion number parsefail works";
    is +":_2<01>", 0, "underscore separator misuse parsefail works (1)";
    is +":2<_01>", 0, "underscore separator misuse parsefail works (2)";
    is +":2<01_>", 0, "underscore separator misuse parsefail works (3)";
    is +":_2_<_0_1_>_", 0, "underscore separator misuse parsefail works (4)";
    is +":2<1.3>", 0, "invalid radix conversion alphabet parsefail works";
    is +"0b1.1e10", 1, "0b1.1e10 parses as 0b1";
    is +":2<10dlk", 0, "missing closing angle bracket";
    is +":2lks01>", 0, "completely invalid radix notation";
}

# What follows are tests that were moved here from t/syntax/numbers/misc.t
# feel free to merge them inline into the other tests

# Ambiguity tests, see thread "Ambiguity of parsing numbers with
# underscores/methods" on p6l started by Ingo Blechschmidt:
# L<"http://www.nntp.perl.org/group/perl.perl6.language/22769">
# Answer from Luke:
#   I think we should go with the method call semantics in all of the ambiguous
#   forms, mostly because "no such method: Int::e5" is clearer than silently
#   succeeding and the error coming up somewhere else.
dies_ok { 2.e123 },    "2.e123 parses as method call";
dies_ok { 2.foo  },    "2.foo  parses as method call";

is  +'00123', 123, "Leading zeroes stringify correctly";

eval_dies_ok ':2<2>',   ':2<2> is illegal';
eval_dies_ok ':10<3a>', ':10<3a> is illegal';

for 2..36 {
    is eval(":{$_}<11>"), $_ + 1, "Adverbial form of base $_ works";
}

# vim: ft=perl6
