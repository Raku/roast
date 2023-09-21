use v6.c;

use Test;

#L<S02/The C<Num> and C<Rat> Types/Perl 6 intrinsically supports big integers>

plan 66;

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

# vim: ft=perl6
