use v6;
use Test;

plan 138;

# L<S02/General radices/":10<42>">
is( :10<0>,   0, 'got the correct int value from decimal 0' );
is( :10<1>,   1, 'got the correct int value from decimal 1' );
is( :10<2>, 0d2, 'got the correct int value from decimal 2' );
is( :10<3>, 0d3, 'got the correct int value from decimal 3' );

# the answer to everything
is(     42,   0d42, '42 and 0d42 are the same'      );
is( :10<42>,    42, ':10<42> and 42 are the same'   );
is( :10<42>,  0d42, ':10<42> and 0d42 are the same' );

# L<S02/Conversion functions/"Think of these as setting the default radix">
# setting the default radix

{
    is(:10('01110') ,  0d1110, ":10('01110') is default decimal");
    is(:10('0b1110'), 0b1110, ":10('0b1110') overrides default decimal");
    is(:10('0x20'),   0x20, ":10('0x20') overrides default decimal");
    is(:10('0o377'),  0o377, ":10('0o255') overrides default decimal");
    is(:10('0d37'),   0d37, ":10('0d37') overrides default decimal");

    # RT #107756
    throws_like { :10(42) },
      X::Numeric::Confused,
      :what(42),
      ':10() really wants a string, not a number';
}

# L<S29/Conversions/"prefix:<:16>">
# L<S02/General radices/":16<DEAD_BEEF>">

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

# L<S02/Conversion functions/"interpret leading 0b or 0d as hex digits">
is(:16('0b1110'), 0xB1110, ":16('0b1110') uses b as hex digit"  );
is(:16('0d37'),   0x0D37,  ":16('0d37') uses d as hex digit"     );

# L<S02/Conversion functions/"Think of these as setting the default radix">
{
    is :16('0d10'),      0xd10, ':16("0d..") is hex, not decimal';
    is(:16('0fff'),      0xfff, ":16('0fff') defaults to hexadecimal");
    is(:16('0x20'),      0x20, ":16('0x20') stays hexadecimal");
    is(:16('0o377'),    0o377, ":16('0o255') converts from octal");
}

# L<S02/Exponentials/"which will be interpreted as they would outside the string">
# It seems odd that the numbers on the inside on the <> would be a mix of
# bases. Maybe I've misread the paragraph -- brian
{
    is_approx(:16<dead_beef> * 16**8, :16<dead_beef*16**8>,
        'Powers outside same as powers inside');

    is_approx(:16<dead_beef> * 16**0, :16<dead_beef*16**0>,
        'Zero powers inside');

    #?rakudo.moar skip "RT #123862 - negative radix"
    #?rakudo.jvm skip "RT #123862 - negative radix"
    is_approx(:16<dead_beef> * 16**-1, :16<dead_beef*16**-1>,
        'Negative powers inside');    
}

# L<S02/General radices/"Any radix may include a fractional part">

is_approx(:16<dead_beef.face>,  0xDEAD_BEEF + 0xFACE / 65536.0, 'Fractional base 16 works' );


# L<S02/General radices/":8<177777>">
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

# L<S02/Conversion functions/"Think of these as setting the default radix">
# setting the default radix

#?rakudo todo "Some question of what this form should actually do"
#?niecza todo ":radix() NYI"
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


# L<S02/Conversion functions/"Think of these as setting the default radix">
# setting the default radix

{
    is(:2('0b1110'),  0d14, ':2<0b1110> stays binary');
    is(:2('0x20'),    0d32, ':2<0x20> converts from hexadecimal');
    is(:2('0o377'),  0d255, ':2<0o255> converts from octal');
    is(:2('0d37'),    0d37, ':2<0d37> converts from decimal');
}

# L<S02/Exponentials/"not clear whether the exponentiator should be 10 or the radix">
throws_like { EVAL '0b1.1e10' },
  X::Syntax::Confused,
  'Ambiguous, illegal syntax doesn\'t work';

# L<S02/Exponentials/"and this makes it explicit">
# probably don't need a test, but I'll write tests for any example :)
is( :2<1.1> *  2 ** 10,                  1536, 'binary number to power of 2'  );
is( :2<1.1> * :2<10> ** :2<10>,             6, 'multiplication and exponentiation' );

# L<S02/Exponentials/"So we write those as">
# these should be the same values as the previous tests
{
    is( :2<1.1*2**10>,                   1536, 'Power of two in <> works');
    #?rakudo todo "Really?!"
    #?niecza skip "WTF?"
    is( 2«1.1*:2<10>**:2<10>»,    6, 'Powers of two in <<>> works');
}

# Tests for the :x[ <list> ] notations
# L<S02/General radices/"Alternately you can use a list of values">
#?niecza skip ":radix[] NYI"
{
    is( :60[12,34,56],     12 * 3600 + 34 * 60 + 56, 'List of numbers works' );
    is( :100[3,'.',14,16],     3.1416,         'Decimal point in list works' );

    is :100[10,10],      1010, "Adverbial form of base 100 integer works";
    is :100[10,'.',10], 10.10, "Adverbial form of base 100 fraction works";

    my $a = '2'; my $b = '.';
    is :10[1, +$a, $b, ++$a * 2, 0], 12.6, "List of expressions works";

    # Representation-stressing large radix.  Do two tests in one here
    # so both 32-bit and 64-bit machines are likely to fail uniformly.
    #?rakudo todo "This needs an RT"
    is :18446744073709551616[1,1] ~ " " ~ :4294967296[1,1], "18446744073709551617 4294967297", "32bit and 64bit large radix literals work";
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
throws_like { 2.e123 },
  X::Method::NotFound,
  "2.e123 parses as method call";
throws_like { 2.foo  },
  X::Method::NotFound,
  "2.foo  parses as method call";

is  +'00123', 123, "Leading zeroes stringify correctly";

throws_like { EVAL ':2<2>' },
  Exception,
  ':2<2> is illegal';
throws_like { EVAL ':10<3a>' },
  Exception,
  ':10<3a> is illegal';
throws_like { EVAL ':0<0>' },
  X::Syntax::Number::RadixOutOfRange,
  ':0<...> is illegal';

for 2..36 {
    is EVAL(":{$_}<11>"), $_ + 1, "Adverbial form of base $_ works";
}

# vim: ft=perl6
