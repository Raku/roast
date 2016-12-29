use v6;
use Test;
plan 162;

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
throws-like q['0o678'.Int], X::Str::Numeric,
    'conversion from string to number fails because of trailing characters (1)';
throws-like q['3e4d5'.Int], X::Str::Numeric,
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

# Special values
is((1.9e3).Int, 1900, "int 1.9e3 is 1900");

# RT #65132
throws-like 'int 3.14', X::Syntax::Confused,
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

# Test issue fixed by https://github.com/rakudo/rakudo/commit/84b7ebdf42
subtest 'smartmatching :U numeric against :D numeric does not throw' => {
    plan 15;
    for 42, τ, .5 -> $what {
        is (Numeric ~~ $what), False, "Numeric:U ~~ $what ($what.^name())";
        is (Int     ~~ $what), False, "Int:U     ~~ $what ($what.^name())";
        is (UInt    ~~ $what), False, "UInt:U    ~~ $what ($what.^name())";
        is (Num     ~~ $what), False, "Num:U     ~~ $what ($what.^name())";
        is (Rat     ~~ $what), False, "Rat:U     ~~ $what ($what.^name())";
    }
}

{ # coverage; 2016-10-05
    my UInt $u;
    is $u.defined, Bool::False, 'undefined UInt is undefined';
    cmp-ok $u, '~~', UInt, 'UInt var smartmatches True against UInt';
    is $u.HOW.^name, 'Perl6::Metamodel::SubsetHOW', 'UInt is a subset';
    throws-like { UInt.new }, Exception,
        'attempting to instantiate UInt throws';

    is ($u = 42), 42, 'Can store a positive Int in UInt';
    is ($u = 0),  0,  'Can store a zero in UInt';
    throws-like { $u = -42 }, X::TypeCheck::Assignment,
        'UInt rejects negative numbers';
    throws-like { $u = "foo" }, X::TypeCheck::Assignment,
        'UInt rejects other types';

    is ($u = Nil), UInt,  'Can assign Nil to UInt';
    my $u2 is default(72);
    is $u2, 72, 'is default() trait works on brand new UInt';
    is ($u2 = 1337), 1337, 'is default()ed UInt can take values';
    is ($u2 = Nil),  72,
        'Nil assigned to is default()ed UInt gives default values';
}

subtest 'Int.new' => { # coverage; 2016-10-05
    plan 8;

    isnt 2.WHERE, Int.new(2).WHERE,
        'returns a new object (not a cached constant)';

   for '42', 42e0, 420/10, 42, ^42, (|^42,), [|^42] -> $n {
        is-deeply Int.new($n), 42,
           "Can use $n.^name() to construct an Int from";
    }
}

{ # coverage; 2016-10-05
    my int $i0 = 0;
    my int $i1 = 1;
    my int $i2 = 2;
    my int $i3 = 3;
    my int $i5 = 5;
    my int $i6 = 6;
    my int $i8 = 8;
    my int $iL = 2**62;
    my int $iu;

    is-deeply 42.narrow,  42,  'Int.narrow gives Int';

    is-deeply $i2 ** $i3, $i8, 'int ** int returns int';
    is-deeply $iu ** $i3, $i0, '0 (uninitialized int) ** int returns 0';
    is-deeply $i8 ** $iu, $i1, 'int ** 0 (uninitialized int) returns 1';

    is-deeply $i2 * $i3,  $i6, 'int * int returns int';
    is-deeply $iu * $i3,  $i0, '0 (uninitialized int) * int returns 0';
    is-deeply $i8 * $iu,  $i0, 'int * 0 (uninitialized int) returns 0';

    is-deeply $i5 div $i2, $i2, 'int(5) div int(2) returns int(2)';
    is-deeply $i8 div $i3, $i2, 'int(8) div int(3) returns int(2)';
    is-deeply $i0 div $i2, $i0, '0 div int returns 0';
    is-deeply $iu div $i2, $i0, '0 (uninitialized int) div int returns 0';
    throws-like { $i5 div $i0 }, Exception, 'int div 0 throws';
    throws-like { $i5 div $iu }, Exception, 'int div 0 (uninit. int) throws';

    is-deeply $i5 % $i2, $i1, 'int(5) % int(2) returns int(1)';
    is-deeply $i8 % $i2, $i0, 'int(8) % int(2) returns int(0)';
    is-deeply $i0 % $i2, $i0, '0 % int returns 0';
    is-deeply $iu % $i2, $i0, '0 (uninitialized int) div int returns 0';

    is-deeply $i3 lcm $i2, $i6, 'int(3) lcm int(2) returns int(6)';
    is-deeply $i3 lcm $i2, $i6, 'int(3) lcm int(2) returns int(6)';
    is-deeply $i8 lcm $i8, $i8, 'int(8) lcm int(8) returns int(8)';
    is-deeply $i0 lcm $i8, $i0, 'int(0) lcm int(8) returns int(0)';
    is-deeply $iu lcm $i8, $i0, 'int(uninitialized) lcm int(8) returns int(0)';

    is-deeply $i3 gcd $i2, $i1, 'int(3) gcd int(2) returns int(1)';
    is-deeply $i8 gcd $i2, $i2, 'int(8) gcd int(2) returns int(2)';
    is-deeply $i8 gcd $i0, $i8, 'int(8) gcd int(0) returns int(8)';
    is-deeply $i0 gcd $i8, $i8, 'int(0) gcd int(8) returns int(8)';
    is-deeply $i0 gcd $i0, $i0, 'int(0) gcd int(0) returns int(0)';
    is-deeply $iu gcd $i0, $i0, 'int(uninitialized) gcd int(0) returns int(0)';

    is-deeply $i8 === $i8, Bool::True,  'int === int (True)';
    is-deeply $i8 === $i2, Bool::False, 'int === int (False)';
    is-deeply $iu === $i0, Bool::True, 'int (uninit.) === int(0) (True)';

    is-deeply $iu.chr, "\x[0]", 'int(uninit.) .chr works';
    is-deeply $i0.chr, "\x[0]", 'int(0) .chr works';
    is-deeply $i8.chr, "\x[8]", 'int(8) .chr works';
}

{ # coverage; 2016-10-06
    is-deeply expmod(10, 3, 11), 10, 'expmod with Ints (1)';
    is-deeply expmod(10, 0, 11), 1,  'expmod with Ints (2)';
    is-deeply expmod("10", 0e0, 110/10), 1, 'expmod with other types';

    is-deeply lsb(0b01011), 0, 'lsb (1)';
    is-deeply lsb(0b01000), 3, 'lsb (2)';
    is-deeply msb(0b01011), 3, 'msb (1)';
    is-deeply msb(0b00010), 1, 'msb (2)';

    is-deeply lsb(0), Nil, 'lsb 0';
    is-deeply msb(0), Nil, 'msb 0';
}

ok Int ~~ UInt, "accept undefined Int";
# vim: ft=perl6
