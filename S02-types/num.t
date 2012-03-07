use v6;

use Test;

#L<S02/The C<Num> and C<Rat> Types/Perl 6 intrinsically supports big integers>

plan 64;

isa_ok( eval(1.Num.perl), Num, 'eval 1.Num.perl is Num' );
is_approx( eval(1.Num.perl), 1, 'eval 1.Num.perl is 1' );
isa_ok( eval(0.Num.perl), Num, 'eval 0.Num.perl is Num' );
is_approx( eval(0.Num.perl), 0, 'eval 0.Num.perl is 0' );
isa_ok( eval((-1).Num.perl), Num, 'eval -1.Num.perl is Num' );
is_approx( eval((-1).Num.perl), -1, 'eval -1.Num.perl is -1' );
isa_ok( eval(1.1.Num.perl), Num, 'eval 1.1.Num.perl is Num' );
is_approx( eval(1.1.perl), 1.1, 'eval 1.1.Num.perl is 1.1' );
isa_ok( eval((-1.1).Num.perl), Num, 'eval -1.1.Num.perl is Num' );
is_approx( eval((-1.1).perl), -1.1, 'eval -1.1.Num.perl is -1.1' );
isa_ok( eval(1e100.Num.perl), Num, 'eval 1e100.Num.perl is Num' );
is_approx( eval(1e100.Num.perl), 1e100, 'eval 1e100.Num.perl is 1' );

{
    my $a = 1; "$a";
    isa_ok($a, Int);
    is($a, "1", '1 stringification works');
}

{
    my $a = -1; "$a";
    isa_ok($a, Int);
    is($a, "-1", '-1 stringification works');
}

#L<S02/The C<Num> and C<Rat> Types/Rat supports extended precision rational arithmetic>
{
    my $a = 1 / 1;
    isa_ok($a, Rat);
    is(~$a, "1", '1/1 stringification works');
}

{
    my $a = -1.0;
    isa_ok($a, Rat);
    is($a, "-1", '-1 stringification works');
}

{
    my $a = 0.1;
    isa_ok($a, Rat);
    is($a, "0.1", '0.1 stringification works');
}

{
    my $a = -0.1; "$a";
    isa_ok($a, Rat);
    is($a, "-0.1", '-0.1 stringification works');
}

{
    my $a = 10.01; "$a";
    isa_ok($a, Rat);
    is($a, "10.01", '10.01 stringification works');
}

{
    my $a = -1.0e0;
    isa_ok($a, Num);
    is($a, "-1", '-1 stringification works');
}

{
    my $a = 0.1e0;
    isa_ok($a, Num);
    is($a, "0.1", '0.1 stringification works');
}

{
    my $a = -0.1e0; "$a";
    isa_ok($a, Num);
    is($a, "-0.1", '-0.1 stringification works');
}

{
    my $a = 10.01e0; "$a";
    isa_ok($a, Num);
    is($a, "10.01", '10.01 stringification works');
}

{
    my $a = 1e3; "$a";
    ok $a ~~ Num, '1e3 conforms to Num';
    is($a, "1000", '1e3 stringification works');
}

{
    my $a = 10.01e3; "$a";
    isa_ok($a, Num);
    is($a, "10010", '10.01e3 stringification works');
}

#L<S02/The C<Num> and C<Rat> Types/Perl 6 intrinsically supports big integers>

{
    my $a = 0b100; "$a";
    isa_ok($a, Int);
    is($a, "4", '0b100 (binary) stringification works');
}

{
    my $a = 0x100; "$a";
    isa_ok($a, Int);
    is($a, "256", '0x100 (hex) stringification works');
}

{
    my $a = 0o100; "$a";
    isa_ok($a, Int);
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

isa_ok(1 / 1, Rat);

{
    my $a = 80000.0000000000000000000000000;
    isa_ok($a, Rat);
    ok($a == 80000.0, 'trailing zeros compare correctly');
}

{
    my $a = 1.0000000000000000000000000000000000000000000000000000000000000000000e1;
    isa_ok($a, Num);
    ok($a == 10.0, 'trailing zeros compare correctly');
}

#L<S02/The C<Num> and C<Rat> Types/Perl 6 intrinsically supports big integers>
{
    my $a = "1.01";
    isa_ok($a.Int, Int);
    is($a.Int, 1, "1.01 intifies to 1");
}

#L<S02/The C<Num> and C<Rat> Types/may be bound to an arbitrary>
{
    my $a = "0d0101";
    #?pugs todo
    isa_ok(+$a, Int);
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

# vim: ft=perl6
