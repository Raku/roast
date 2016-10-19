use v6;

use Test;

#L<S02/The C<Num> and C<Rat> Types/Perl 6 intrinsically supports big integers>

plan 88;

isa-ok( EVAL(1.Num.perl), Num, 'EVAL 1.Num.perl is Num' );
is-approx( EVAL(1.Num.perl), 1, 'EVAL 1.Num.perl is 1' );
isa-ok( EVAL(0.Num.perl), Num, 'EVAL 0.Num.perl is Num' );
is-approx( EVAL(0.Num.perl), 0, 'EVAL 0.Num.perl is 0' );
isa-ok( EVAL((-1).Num.perl), Num, 'EVAL -1.Num.perl is Num' );
is-approx( EVAL((-1).Num.perl), -1, 'EVAL -1.Num.perl is -1' );
isa-ok( EVAL(1.1.Num.perl), Num, 'EVAL 1.1.Num.perl is Num' );
is-approx( EVAL(1.1.perl), 1.1, 'EVAL 1.1.Num.perl is 1.1' );
isa-ok( EVAL((-1.1).Num.perl), Num, 'EVAL -1.1.Num.perl is Num' );
is-approx( EVAL((-1.1).perl), -1.1, 'EVAL -1.1.Num.perl is -1.1' );
isa-ok( EVAL(1e100.Num.perl), Num, 'EVAL 1e100.Num.perl is Num' );
is-approx( EVAL(1e100.Num.perl), 1e100, 'EVAL 1e100.Num.perl is 1' );

{
    my $a = 1; "$a";
    isa-ok($a, Int);
    is($a, "1", '1 stringification works');
}

{
    my $a = -1; "$a";
    isa-ok($a, Int);
    is($a, "-1", '-1 stringification works');
}

#L<S02/The C<Num> and C<Rat> Types/Rat supports extended precision rational arithmetic>
{
    my $a = 1 / 1;
    isa-ok($a, Rat);
    is(~$a, "1", '1/1 stringification works');
}

{
    my $a = -1.0;
    isa-ok($a, Rat);
    is($a, "-1", '-1 stringification works');
}

{
    my $a = 0.1;
    isa-ok($a, Rat);
    is($a, "0.1", '0.1 stringification works');
}

{
    my $a = -0.1; "$a";
    isa-ok($a, Rat);
    is($a, "-0.1", '-0.1 stringification works');
}

{
    my $a = 10.01; "$a";
    isa-ok($a, Rat);
    is($a, "10.01", '10.01 stringification works');
}

{
    my $a = -1.0e0;
    isa-ok($a, Num);
    is($a, "-1", '-1 stringification works');
}

{
    my $a = 0.1e0;
    isa-ok($a, Num);
    is($a, "0.1", '0.1 stringification works');
}

{
    my $a = -0.1e0; "$a";
    isa-ok($a, Num);
    is($a, "-0.1", '-0.1 stringification works');
}

{
    my $a = 10.01e0; "$a";
    isa-ok($a, Num);
    is($a, "10.01", '10.01 stringification works');
}

{
    my $a = 1e3; "$a";
    ok $a ~~ Num, '1e3 conforms to Num';
    is($a, "1000", '1e3 stringification works');
}

{
    my $a = 10.01e3; "$a";
    isa-ok($a, Num);
    is($a, "10010", '10.01e3 stringification works');
}

#L<S02/The C<Num> and C<Rat> Types/Perl 6 intrinsically supports big integers>

{
    my $a = 0b100; "$a";
    isa-ok($a, Int);
    is($a, "4", '0b100 (binary) stringification works');
}

{
    my $a = 0x100; "$a";
    isa-ok($a, Int);
    is($a, "256", '0x100 (hex) stringification works');
}

{
    my $a = 0o100; "$a";
    isa-ok($a, Int);
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
#L<S02/The C<Num> and C<Rat> Types/Rat supports extended precision rational arithmetic>

isa-ok(1 / 1, Rat);

{
    my $a = 80000.0000000000000000000000000;
    isa-ok($a, Rat);
    ok($a == 80000.0, 'trailing zeros compare correctly');
}

{
    my $a = 1.0000000000000000000000000000000000000000000000000000000000000000000e1;
    isa-ok($a, Num);
    ok($a == 10.0, 'trailing zeros compare correctly');
}

#L<S02/The C<Num> and C<Rat> Types/Perl 6 intrinsically supports big integers>
{
    my $a = "1.01";
    isa-ok($a.Int, Int);
    is($a.Int, 1, "1.01 intifies to 1");
}

#L<S02/The C<Num> and C<Rat> Types/may be bound to an arbitrary>
{
    my $a = "0d0101";
    isa-ok(+$a, Int);
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

throws-like { EVAL '4_2._0_1' },
  X::Method::NotFound,
  'single underscores are not ok directly after the dot';
is(4_2.0_1, 42.01,  'single underscores are ok');

is 0_1, 1, "0_1 is parsed as 0d1";
is +^1, -2, '+^1 == -2 as promised';

# RT #73238
ok 0xFFFFFFFFFFFFFFFF > 1, '0xFFFFFFFFFFFFFFFF is not -1';

# RT #122593
ok Num === Num, 'Num === Num should be truthy, and not die';

{ # coverage; 2016-10-14
    is-deeply Num.Range, -∞..∞, 'Num:U.Range gives -Inf to Inf range';

    subtest 'Num.new coerces types that can .Num' => {
        plan 6;

        is-deeply Num.new(42e0),  42e0, 'Num';
        is-deeply Num.new(42/1),  42e0, 'Rat';
        is-deeply Num.new(42),    42e0, 'Int';
        is-deeply Num.new(42+0i), 42e0, 'Complex';
        is-deeply Num.new("42"),  42e0, 'Str';

        throws-like { Num.new: class {} }, Exception,
            'class that cannot .Num';
    }

    subtest '++Num' => {
        plan 8;

        my $v1 = 4e0;
        is-deeply ++$v1, 5e0, 'return value (:D)';
        is-deeply   $v1, 5e0, 'new value (:D)';

        my Num $v2;
        is-deeply ++$v2, 1e0, 'return value (:U)';
        is-deeply   $v2, 1e0, 'new value (:U)';

        my num $v3 = 4e0;
        is-deeply ++$v3, (my num $=5e0), 'return value (native)';
        is-deeply   $v3, (my num $=5e0), 'new value (native)';

        my num $v4;
        cmp-ok ++$v4, '===', NaN, 'return value (uninit. native)';
        cmp-ok   $v4, '===', NaN, 'new value (uninit. native)';
    }

    subtest '--Num' => {
        plan 8;

        my $v1 = 4e0;
        is-deeply --$v1, 3e0, 'return value (:D)';
        is-deeply   $v1, 3e0, 'new value (:D)';

        my Num $v2;
        is-deeply --$v2, -1e0, 'return value (:U)';
        is-deeply   $v2, -1e0, 'new value (:U)';

        my num $v3 = 4e0;
        is-deeply --$v3, (my num $ = 3e0), 'return value (native)';
        is-deeply   $v3, (my num $ = 3e0), 'new value (native)';

        my num $v4;
        cmp-ok --$v4, '===', NaN, 'return value (uninit. native)';
        cmp-ok   $v4, '===', NaN, 'new value (uninit. native)';
    }

    subtest 'Num++' => {
        plan 4;
        my Num $v1;
        is-deeply $v1++, 0e0, 'return value';
        is-deeply $v1,   1e0, 'new value';

        my num $v2;
        cmp-ok $v2++, '===', NaN, 'return value (uninit. native)';
        cmp-ok $v2,   '===', NaN, 'new value (uninit. native)';
    }

    subtest 'Num--' => {
        plan 6;

        my Num $v1;
        is-deeply $v1--,  0e0, 'return value (:U)';
        is-deeply $v1,   -1e0, 'new value (:U)';

        my num $v2 = 4e0;
        is-deeply $v2--, (my num $ = 4e0), 'return value (native)';
        is-deeply $v2,   (my num $ = 3e0), 'new value (native)';

        my num $v3;
        cmp-ok $v3--, '===', NaN, 'return value (uninit. native)';
        cmp-ok $v3,   '===', NaN, 'new value (uninit. native)';
    }
}

{ # coverage; 2016-10-16
    subtest 'prefix:<->(num)' => {
        plan 8;
        cmp-ok -(my num $), '===', NaN, '- uninitialized';
        cmp-ok −(my num $), '===', NaN, '− uninitialized';
        is-deeply -(my num $ = 0e0  ), (my num $ = 0e0  ), '- zero';
        is-deeply −(my num $ = 0e0  ), (my num $ = 0e0  ), '− zero';
        is-deeply -(my num $ = 42e0 ), (my num $ = -42e0), '- positive';
        is-deeply −(my num $ = 42e0 ), (my num $ = -42e0), '− positive';
        is-deeply -(my num $ = -42e0), (my num $ = 42e0 ), '- negative';
        is-deeply −(my num $ = -42e0), (my num $ = 42e0 ), '− negative';
    }

    subtest 'abs(num)' => {
        plan 4;
        cmp-ok    abs(my num $), '===', NaN, 'uninitialized';
        is-deeply abs(my num $ = 0e0),   (my num $ = 0e0),  'zero';
        is-deeply abs(my num $ = 42e0),  (my num $ = 42e0), 'positive';
        is-deeply abs(my num $ = -42e0), (my num $ = 42e0), 'negative';
    }

    subtest 'infix:<+>(num, num)' => {
        plan 16;
        my num $nu;
        my num $nz = 0e0;
        my num $np = 42e0;
        my num $nn = -42e0;

        cmp-ok $nu + $nz, '===', NaN, 'uninit + zero';
        cmp-ok $nu + $np, '===', NaN, 'uninit + positive';
        cmp-ok $nu + $nn, '===', NaN, 'uninit + negative';
        cmp-ok $nu + $nu, '===', NaN, 'uninit + uninit';
        cmp-ok $nz + $nu, '===', NaN, 'zero + uninit';
        cmp-ok $np + $nu, '===', NaN, 'positive + uninit';
        cmp-ok $nn + $nu, '===', NaN, 'negative + uninit';

        is-deeply $nz + $np, (my num $ = 42e0 ), 'zero + positive';
        is-deeply $nz + $nn, (my num $ = -42e0), 'zero + negative';
        is-deeply $nz + $nz, (my num $ = 0e0  ), 'zero + zero';
        is-deeply $np + $nn, (my num $ = 0e0  ), 'positive + negative';
        is-deeply $np + $nz, (my num $ = 42e0 ), 'positive + zero';
        is-deeply $np + $np, (my num $ = 84e0 ), 'positive + positive';
        is-deeply $nn + $nz, (my num $ = -42e0), 'negative + zero';
        is-deeply $nn + $np, (my num $ = 0e0  ), 'negative + positive';
        is-deeply $nn + $nn, (my num $ = -84e0), 'negative + negative';
    }

    subtest 'infix:<*>(num, num)' => {
        plan 16;
        my num $nu;
        my num $nz = 0e0;
        my num $np = 4e0;
        my num $nn = -4e0;

        cmp-ok $nu * $nz, '===', NaN, 'uninit * zero';
        cmp-ok $nu * $np, '===', NaN, 'uninit * positive';
        cmp-ok $nu * $nn, '===', NaN, 'uninit * negative';
        cmp-ok $nu * $nu, '===', NaN, 'uninit * uninit';
        cmp-ok $nz * $nu, '===', NaN, 'zero * uninit';
        cmp-ok $np * $nu, '===', NaN, 'positive * uninit';
        cmp-ok $nn * $nu, '===', NaN, 'negative * uninit';

        is-deeply $nz * $np, (my num $ = 0e0  ), 'zero * positive';
        is-deeply $nz * $nn, (my num $ = 0e0  ), 'zero * negative';
        is-deeply $nz * $nz, (my num $ = 0e0  ), 'zero * zero';
        is-deeply $np * $nn, (my num $ = -16e0), 'positive * negative';
        is-deeply $np * $nz, (my num $ = 0e0  ), 'positive * zero';
        is-deeply $np * $np, (my num $ = 16e0 ), 'positive * positive';
        is-deeply $nn * $nz, (my num $ = 0e0  ), 'negative * zero';
        is-deeply $nn * $np, (my num $ = -16e0), 'negative * positive';
        is-deeply $nn * $nn, (my num $ = 16e0 ), 'negative * negative';
    }
}

{ # coverage; 2016-10-16
    subtest 'infix:<%>(num, num)' => {
        plan 9;
        my num $nu;
        my num $nz  = 0e0;
        my num $n4  = 4e0;
        my num $n5  = 5e0;
        my num $nn4 = -4e0;

        cmp-ok $nu % $n5, '===', NaN, 'uninit % defined';
        cmp-ok $n5 % $nu, '===', NaN, 'defined % uninit';
        cmp-ok $nu % $nu, '===', NaN, 'uninit % uninit';

        is-deeply $nz  % $n4,  (my num $ =  0e0), '0 % 4';
        is-deeply $n4  % $n5,  (my num $ =  4e0), '4 % 5';
        is-deeply $n5  % $n4,  (my num $ =  1e0), '5 % 4';
        is-deeply $nz  % $nn4, (my num $ =  0e0), '0 % -4';
        is-deeply $nn4 % $n5,  (my num $ =  1e0), '-4 % 5';
        is-deeply $n5  % $nn4, (my num $ = -3e0), '5 % -4';
    }

    subtest 'infix:<**>(num, num)' => {
        plan 22;
        my num $nu;
        my num $nz = 0e0;
        my num $n1 = 1e0;
        my num $np = 2e0;
        my num $nn = -2e0;

        cmp-ok $nu ** $n1, '===', NaN, 'uninit ** 1st power';
        cmp-ok $nu ** $np, '===', NaN, 'uninit ** positive';
        cmp-ok $nu ** $nn, '===', NaN, 'uninit ** negative';
        cmp-ok $nu ** $nu, '===', NaN, 'uninit ** uninit';
        cmp-ok $nz ** $nu, '===', NaN, 'zero ** uninit';
        cmp-ok $np ** $nu, '===', NaN, 'positive ** uninit';
        cmp-ok $nn ** $nu, '===', NaN, 'negative ** uninit';

        #?rakudo.jvm todo 'gives NaN'
        is-deeply $n1 ** $nu, (my num $ = 1e0    ), '1 ** uninit';
        is-deeply $nu ** $nz, (my num $ = 1e0    ), 'uninit ** zero';
        is-deeply $nz ** $np, (my num $ = 0e0    ), 'zero ** positive';
        is-deeply $nz ** $nz, (my num $ = 1e0    ), 'zero ** zero';
        is-deeply $nz ** $n1, (my num $ = 0e0    ), 'zero ** 1st power';
        is-deeply $np ** $nz, (my num $ = 1e0    ), 'positive ** zero';
        is-deeply $np ** $n1, (my num $ = 2e0    ), 'positive ** 1st power';
        is-deeply $np ** $np, (my num $ = 4e0    ), 'positive ** positive';
        is-deeply $nn ** $nz, (my num $ = 1e0    ), 'negative ** zero';
        is-deeply $nn ** $n1, (my num $ = -2e0   ), 'negative ** 1st power';
        is-deeply $nn ** $np, (my num $ = 4e0    ), 'negative ** positive';
        is-approx $np ** $nn, (my num $ = 0.25e0 ), 'positive ** negative';
        is-approx $nn ** $nn, (my num $ = 0.25e0 ), 'negative ** negative';

        # rational powers => like taking roots
        is-approx (my num $ = 125e0) ** (my num $ = (1/3).Num),
            (my num $ = 5e0), '1/3 power (third root)';
        is-approx (my num $ = 125e0) ** (my num $ = (4/6).Num),
            (my num $ = 25e0), '4/6 power (6th root of 4th power)';
    }

    subtest 'log(num)' => sub {
        plan 8;
        cmp-ok    log(my num $        ), '===', NaN, 'uninitialized';
        cmp-ok    log(my num $ = NaN  ), '===', NaN, 'NaN';
        cmp-ok    log(my num $ = -42e0), '===', NaN, 'negative';
        cmp-ok    log(my num $ =    -∞), '===', NaN, '-∞';
        is-deeply log(my num $ =     ∞), my num $ =      ∞, '+∞';
        is-deeply log(my num $ =   0e0), my num $ =     -∞, 'zero';
        is-deeply log(my num $ =   1e0), my num $ =    0e0, 'one';
        is-approx log(my num $ =  42e0), my num $ = 3.74e0, '42',
            :abs-tol(.01);
    }

    subtest 'ceiling(num)' => sub {
        plan 9;
        cmp-ok    ceiling(my num $         ), '===', NaN, 'uninitialized';
        cmp-ok    ceiling(my num $ =    NaN), '===', NaN, 'NaN';
        is-deeply ceiling(my num $ =     -∞), my num $ =   -∞, '-∞';
        is-deeply ceiling(my num $ =      ∞), my num $ =    ∞, '+∞';
        is-deeply ceiling(my num $ =    0e0), my num $ =  0e0, 'zero';
        is-deeply ceiling(my num $ =  4.7e0), my num $ =  5e0, 'positive (1)';
        is-deeply ceiling(my num $ =  4.2e0), my num $ =  5e0, 'positive (2)';
        is-deeply ceiling(my num $ = -4.7e0), my num $ = -4e0, 'negative (1)';
        is-deeply ceiling(my num $ = -4.2e0), my num $ = -4e0, 'negative (2)';
    }
}

{ # coverage; 2016-10-18

    # Special cases, like NaN/Inf returns, are based on 2008 IEEE 754 standard

    sub prefix:<√> { sqrt $^x }

    subtest 'sin(num)' => {
        plan 13;

        cmp-ok sin(my num $      ), '===', NaN, 'uninitialized';
        cmp-ok sin(my num $ = NaN), '===', NaN, 'NaN';
        cmp-ok sin(my num $ =  -∞), '===', NaN, '-∞';
        cmp-ok sin(my num $ =   ∞), '===', NaN, '+∞';

        is-approx sin(my num $ =  0e0), my num $ =   0e0,  '0e0';
        is-approx sin(my num $ =    τ), my num $ =   0e0,  'τ';
        is-approx sin(my num $ =   -τ), my num $ =   0e0,  '-τ';
        is-approx sin(my num $ =    π), my num $ =   0e0,  'π';
        is-approx sin(my num $ =   -π), my num $ =   0e0,  '-π';
        is-approx sin(my num $ =  π/2), my num $ =   1e0,  'π/2';
        is-approx sin(my num $ = -π/2), my num $ =  -1e0,  '-π/2';
        is-approx sin(my num $ =  π/4), my num $ =  .5*√2, 'π/4';
        is-approx sin(my num $ = -π/4), my num $ = -.5*√2, '-π/4';
    }

    subtest 'asin(num)' => {
        plan 11;

        cmp-ok asin(my num $         ), '===', NaN, 'uninitialized';
        cmp-ok asin(my num $ =    NaN), '===', NaN, 'NaN';
        cmp-ok asin(my num $ =     -∞), '===', NaN, '-∞';
        cmp-ok asin(my num $ =      ∞), '===', NaN, '+∞';
        cmp-ok asin(my num $ = -1.1e0), '===', NaN, '-1.1e0';
        cmp-ok asin(my num $ =  1.1e0), '===', NaN, '+1.1e0';

        is-approx asin(my num $ =    0e0), my num $ =  0e0, '0e0';
        is-approx asin(my num $ =    1e0), my num $ =  π/2, '1e0';
        is-approx asin(my num $ =   -1e0), my num $ = -π/2, '-1e0';
        is-approx asin(my num $ =  .5*√2), my num $ =  π/4, '½√2';
        is-approx asin(my num $ = -.5*√2), my num $ = -π/4, '-½√2';
    }

    subtest 'cos(num)' => {
        plan 13;

        cmp-ok cos(my num $      ), '===', NaN, 'uninitialized';
        cmp-ok cos(my num $ = NaN), '===', NaN, 'NaN';
        cmp-ok cos(my num $ =  -∞), '===', NaN, '-∞';
        cmp-ok cos(my num $ =   ∞), '===', NaN, '+∞';

        is-approx cos(my num $ =  0e0), my num $ =  1e0,  '0e0';
        is-approx cos(my num $ =  π/4), my num $ = .5*√2, 'π/4';
        is-approx cos(my num $ = -π/4), my num $ = .5*√2, '-π/4';
        is-approx cos(my num $ =    π), my num $ = -1e0,  'π';
        is-approx cos(my num $ =   -π), my num $ = -1e0,  '-π';
        is-approx cos(my num $ =  π/2), my num $ =  0e0,  'π/2';
        is-approx cos(my num $ = -π/2), my num $ =  0e0,  '-π/2';
        is-approx cos(my num $ =  π/4), my num $ = .5*√2, 'π/4';
        is-approx cos(my num $ = -π/4), my num $ = .5*√2, '-π/4';
    }

    subtest 'acos(num)' => {
        plan 11;

        cmp-ok acos(my num $         ), '===', NaN, 'uninitialized';
        cmp-ok acos(my num $ =    NaN), '===', NaN, 'NaN';
        cmp-ok acos(my num $ =     -∞), '===', NaN, '-∞';
        cmp-ok acos(my num $ =      ∞), '===', NaN, '+∞';
        cmp-ok acos(my num $ = -1.1e0), '===', NaN, '-1.1e0';
        cmp-ok acos(my num $ =  1.1e0), '===', NaN, '+1.1e0';

        is-approx acos(my num $ =    1e0), my num $ =  0e0,  '1e0';
        is-approx acos(my num $ =   -1e0), my num $ =  π,    '-1e0';
        is-approx acos(my num $ =    0e0), my num $ =  π/2,  '0e0';
        is-approx acos(my num $ =  .5*√2), my num $ =  π/4,  '½√2';
        is-approx acos(my num $ = -.5*√2), my num $ = .75*π, '-½√2';
    }

    subtest 'tan(num)' => {
        plan 13;

        cmp-ok tan(my num $      ), '===', NaN, 'uninitialized';
        cmp-ok tan(my num $ = NaN), '===', NaN, 'NaN';
        cmp-ok tan(my num $ =  -∞), '===', NaN, '-∞';
        cmp-ok tan(my num $ =   ∞), '===', NaN, '+∞';

        is-approx tan(my num $ =  0e0), my num $ =  0e0,        '0e0';
        is-approx tan(my num $ =    τ), my num $ =  0e0,        'τ';
        is-approx tan(my num $ =   -τ), my num $ =  0e0,        '-τ';
        is-approx tan(my num $ =    π), my num $ =  0e0,        'π';
        is-approx tan(my num $ =   -π), my num $ =  0e0,        '-π';
        is-approx tan(my num $ =  π/4), my num $ =  1e0,        'π/4';
        is-approx tan(my num $ = -π/4), my num $ = -1e0,        '-π/4';
        is-approx tan(my num $ =  π/2),  (sin(π/2) / cos(π/2)), 'π/2';
        is-approx tan(my num $ = -π/2), -(sin(π/2) / cos(π/2)), '-π/2';
    }

    subtest 'atan(num)' => {
        plan 7;

        cmp-ok atan(my num $      ), '===', NaN, 'uninitialized';
        cmp-ok atan(my num $ = NaN), '===', NaN, 'NaN';

        is-approx atan(my num $ =  0e0), my num $ =  0e0, '0e0';
        is-approx atan(my num $ =  1e0), my num $ =  π/4, '1e0';
        is-approx atan(my num $ = -1e0), my num $ = -π/4, '-1e0';
        is-approx atan(my num $ =    π), my num $ =  1.26262725567891e0, 'π';
        is-approx atan(my num $ =   -π), my num $ = -1.26262725567891e0, '-π';
    }

    subtest 'sec(num)' => {
        plan 13;

        cmp-ok sec(my num $      ), '===', NaN, 'uninitialized';
        cmp-ok sec(my num $ = NaN), '===', NaN, 'NaN';
        cmp-ok sec(my num $ =  -∞), '===', NaN, '-∞';
        cmp-ok sec(my num $ =   ∞), '===', NaN, '+∞';

        is-approx sec(my num $ =  0e0), my num $ =  1e0,  '0e0';
        is-approx sec(my num $ =    τ), my num $ =  1e0,  'τ';
        is-approx sec(my num $ =   -τ), my num $ =  1e0,  '-τ';
        is-approx sec(my num $ =    π), my num $ = -1e0,  'π';
        is-approx sec(my num $ =   -π), my num $ = -1e0,  '-π';
        is-approx sec(my num $ =  π/4), my num $ =  2/√2, 'π/4';
        is-approx sec(my num $ = -π/4), my num $ =  2/√2, '-π/4';

        # Since we don't have perfect π, cheetsy-doodle to get "infinity"
        is-approx sec(my num $ =  π/2), my num $ = tan(π/2), 'π/2';
        is-approx sec(my num $ = -π/2), my num $ = tan(π/2), '-π/2';
    }

    subtest 'asec(num)' => {
        plan 10;

        cmp-ok asec(my num $        ), '===', NaN, 'uninitialized';
        cmp-ok asec(my num $ =   NaN), '===', NaN, 'NaN';
        cmp-ok asec(my num $ =   0e0), '===', NaN, '0e0';
        cmp-ok asec(my num $ =  .9e0), '===', NaN, '.9e0';
        cmp-ok asec(my num $ = -.9e0), '===', NaN, '-.9e0';

        is-approx asec(my num $ =   1e0), my num $ = 0e0,   '1e0';
        is-approx asec(my num $ =     ∞), my num $ = π/2,   '∞';
        is-approx asec(my num $ =    -∞), my num $ = π/2,   '-∞';
        is-approx asec(my num $ =  2/√2), my num $ = π/4,   '2/√2';
        is-approx asec(my num $ = -2/√2), my num $ = 3/4*π, '-2/√2';
    }
}

# vim: ft=perl6
