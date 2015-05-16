use v6;
use Test;
plan 107;

# L<S32::Numeric/Real/=item truncate>
# truncate and .Int are synonynms.
# Possibly more tests for truncate should be added here, too.

=begin pod

Basic tests for the int() builtin

=end pod

# basic sanity:
is(-0, 0, '-0 is the same as 0 - hey, they are integers ;-)');

isa-ok( EVAL(1.perl), Int, 'EVAL 1.perl is Int' );
is( EVAL(1.perl), 1, 'EVAL 1.perl is 1' );
isa-ok( EVAL((-12).perl), Int, 'EVAL -12.perl is Int' );
is( EVAL((-12).perl), -12, 'EVAL -12.perl is -12' );
isa-ok( EVAL(0.perl), Int, 'EVAL 0.perl is Int' );
is( EVAL(0.perl), 0, 'EVAL 0.perl is 0' );
isa-ok( EVAL((-0).perl), Int, 'EVAL -0.perl is Int' );
is( EVAL((-0).perl), -0, 'EVAL -0.perl is 0' );

is((-1).Int, -1, "(-1).Int is -1");
is(0.Int, 0, "0.Int is 0");
is(1.Int, 1, "1.Int is 1");
is(3.14159265.Int, 3, "3.14159265.Int is 3");
is((-3.14159265).Int, -3, "(-3.14159265).Int is -3");

is(0.999.Int,   0, "0.999.Int is 0");
is(0.51.Int,    0, "0.51.Int is 0");
is(0.5.Int,     0, "0.5.Int is 0");
is(0.49.Int,    0, "0.49.Int is 0");
is(0.1.Int,     0, "0.1.Int is 0");
isa-ok(0.1.Int, Int, '0.1.Int returns an Int');

is((-0.999).Int, 0, "(-0.999).Int is 0");
is((-0.51).Int,  0, "(-0.51).Int is 0");
is((-0.5).Int,   0, "(-0.5).Int is 0");
is((-0.49).Int,  0, "(-0.49).Int is 0");
is((-0.1).Int,   0, "(-0.1).Int is 0");
isa-ok((-0.1).Int, Int, 'int(-0.1) returns an Int');

is(1.999.Int, 1, "int(1.999) is 1");
is(1.51.Int,  1, "int(1.51) is 1");
is(1.5.Int,   1, "int(1.5) is 1");
is(1.49.Int,  1, "int(1.49) is 1");
is(1.1.Int,   1, "int(1.1) is 1");

is((-1.999).Int, -1, "int(-1.999) is -1");
is((-1.51).Int, -1, "int(-1.51) is -1");
is((-1.5).Int, -1, "int(-1.5) is -1");
is((-1.49).Int, -1, "int(-1.49) is -1");
is((-1.1).Int, -1, "int(-1.1) is -1");

is(1.999.Num.Int, 1, "int(1.999.Num) is 1");
is(1.1.Num.Int,   1, "int(1.1.Num) is 1");

is((-1.999).Num.Int, -1, "int(-1.999.Num) is -1");
is((-1.1).Num.Int, -1, "int(-1.1.Num) is -1");

nok ?0, "?0 is false";
isa-ok ?0, Bool, "?0 is Bool";
ok ?1, "?1 is true";
isa-ok ?1, Bool, "?1 is Bool";
ok ?42, "?42 is true";
isa-ok ?42, Bool, "?42 is Bool";

nok 0.Bool, "0.Bool is false";
isa-ok 0.Bool, Bool, "0.Bool is Bool";
ok 1.Bool, "1.Bool is true";
isa-ok 1.Bool, Bool, "1.Bool is Bool";
ok 42.Bool, "42.Bool is true";
isa-ok 42.Bool, Bool, "42.Bool is Bool";

is('-1.999'.Int, -1, "int('-1.999') is -1");
#?niecza 3 skip "0x, 0d, and 0o NYI"
is('0x123'.Int, 0x123, "int('0x123') is 0x123");
is('0d456'.Int, 0d456, "int('0d456') is 0d456");
throws_like q['0o678'.Int], X::Str::Numeric,
    'conversion from string to number fails because of trailing characters (1)';
throws_like q['3e4d5'.Int], X::Str::Numeric,
    'conversion from string to number fails because of trailing characters (2)';

#?DOES 24
{
    sub __int( $s ) {
        my $pos = $s.index('.');
        if defined($pos) { return substr($s, 0, $pos); }
        return $s;
    };

    # Check the defaulting to $_

    for 0, 0.0, 1, 50, 60.0, 99.99, 0.4, 0.6, -1, -50, -60.0, -99.99 {
        my $int = __int($_.Num);
        is(.Int, $int, "integral value for $_ is $int");
        isa-ok(.Int, Int);
    }
}

#?DOES 1
# Special values
is((1.9e3).Int, 1900, "int 1.9e3 is 1900");
#?rakudo 3 todo 'Inf and NaN NYI for Int RT #124818'
is((Inf).Int,    Inf, "int Inf is Inf");
is((-Inf).Int,  -Inf, "int -Inf is -Inf");
is((NaN).Int,    NaN, "int NaN is NaN");

# RT #65132
throws_like 'int 3.14', X::Syntax::Confused,
    'dies: int 3.14 (prefix:int is gone)';

is 0.lsb,        Nil, "0.lsb is Nil";
is 1.lsb,        0,   "1.lsb is 0";
is 2.lsb,        1,   "2.lsb is 1";
is 256.lsb,      8,   "256.lsb is 8";
is (-1).lsb,     0,   "(-1).lsb is 0";       # 1111 1111
is (-2).lsb,     1,   "(-2).lsb is 1";       # 1111 1110
is (-126).lsb,   1,   "(-126).lsb is 1";     # 1000 0010
is (-127).lsb,   0,   "(-127).lsb is 0";     # 1000 0001
is (-128).lsb,   7,   "(-128).lsb is 7";     # 1000 0000
is (-32768).lsb, 15,  "(-32768).lsb is 15";

is 0.msb,        Nil, "0.msb is Nil";
is 1.msb,        0,   "1.msb is 0";
is 2.msb,        1,   "2.msb is 1";
is 256.msb,      8,   "256.msb is 8";
is (-1).msb,     0,   "(-1).msb is 0";       # 1111 1111
is (-2).msb,     1,   "(-2).msb is 1";       # 1111 1110
is (-126).msb,   7,   "(-126).msb is 7";     # 1000 0010
is (-127).msb,   7,   "(-127).msb is 7";     # 1000 0001
is (-128).msb,   7,   "(-128).msb is 7";     # 1000 0000
is (-129).msb,   8,   "(-129).msb is 8";
is (-32768).msb, 15,  "(-32768).msb is 15";

# vim: ft=perl6
