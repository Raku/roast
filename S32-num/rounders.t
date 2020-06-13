use v6;
use Test;
use lib $?FILE.IO.parent(2).add: 'packages/Test-Helpers';
use Test::Util;

plan 143;

# L<S32::Numeric/Real/"=item round">
# L<S32::Numeric/Real/"=item floor">
# L<S32::Numeric/Real/"=item truncate">
# L<S32::Numeric/Real/"=item ceiling">

=begin pod

Basic tests for the round(), floor(), truncate() and ceiling() built-ins

=end pod

is( floor(NaN), NaN, 'floor(NaN) is NaN');
is( round(NaN), NaN, 'round(NaN) is NaN');
is( ceiling(NaN), NaN,  'ceiling(NaN) is NaN');
is( truncate(NaN), NaN, 'truncate(NaN) is NaN');

is( floor(Inf), Inf, 'floor(Inf) is Inf');
is( round(Inf), Inf, 'round(Inf) is Inf');
is( ceiling(Inf), Inf,  'ceiling(Inf) is Inf');
is( truncate(Inf), Inf, 'truncate(Inf) is Inf');

is( floor(-Inf), -Inf, 'floor(-Inf) is -Inf');
is( round(-Inf), -Inf, 'round(-Inf) is -Inf');
is( ceiling(-Inf), -Inf,  'ceiling(-Inf) is -Inf');
is( truncate(-Inf), -Inf, 'truncate(-Inf) is -Inf');

is( NaN.floor, NaN, 'NaN.floor is NaN');
is( NaN.round, NaN, 'NaN.round is NaN');
is( NaN.ceiling, NaN,  'NaN.ceiling is NaN');
is( NaN.truncate, NaN, 'NaN.truncate is NaN');

is( Inf.floor, Inf, 'Inf.floor is Inf');
is( Inf.round, Inf, 'Inf.round is Inf');
is( Inf.ceiling, Inf,  'Inf.ceiling is Inf');
is( Inf.truncate, Inf, 'Inf.truncate is Inf');

is( (-Inf).floor, -Inf, '(-Inf).floor is -Inf');
is( (-Inf).round, -Inf, '(-Inf).round is -Inf');
is( (-Inf).ceiling, -Inf,  '(-Inf).ceiling is -Inf');
is( (-Inf).truncate, -Inf, '(-Inf).truncate is -Inf');

my %tests =
    ( ceiling => [ [ 1.5, 2 ], [ 2, 2 ], [ 1.4999, 2 ],
         [ -0.1, 0 ], [ -1, -1 ], [ -5.9, -5 ],
         [ -0.5, 0 ], [ -0.499.Num, 0 ], [ -5.499.Num, -5 ],
         [ 2.Num, 2 ] ],
      floor => [ [ 1.5, 1 ], [ 2, 2 ], [ 1.4999, 1 ],
         [ -0.1, -1 ], [ -1, -1 ], [ -5.9, -6 ],
         [ -0.5, -1 ], [ -0.499.Num, -1 ], [ -5.499.Num, -6 ],
         [ 2.Num, 2 ]  ],
      round => [ [ 1.5, 2 ], [ 2, 2 ], [ 1.4999, 1 ],
         [ -0.1, 0 ], [ -1, -1 ], [ -5.9, -6 ],
         [ -0.5, 0 ], [ -0.499.Num, 0 ], [ -5.499.Num, -5 ],
         [ 2.Num, 2 ]  ],
      truncate => [ [ 1.5, 1 ], [ 2, 2 ], [ 1.4999, 1 ],
         [ -0.1, 0 ], [ -1, -1 ], [ -5.9, -5 ],
         [ -0.5, 0 ], [ -0.499.Num, 0 ], [ -5.499.Num, -5 ],
         [ 2.Num, 2 ]  ],
    );

my @testkeys = %tests.keys.sort;

for @testkeys -> $type {
    my @subtests = @(%tests{$type});    # XXX .[] doesn't work yet!
    for @subtests -> $test {
        my $code = "$type\($test[0]\)";
        my &sub-in-question = &::($type);
        my $res = sub-in-question($test[0]);

        ok($res == $test[1], "$code == {$test[1]}");
    }
}

# Tests for 2-argument version of &round
# (https://github.com/rakudo/rakudo/issues/1745).
{
  my @tests = (
    [ 1.23456, 0.00001, 1.23456 ],
    [ 1.23456, 0.0001,  1.2346  ],
    [ 1.23456, 0.001,   1.235   ],
    [ 1.23456, 0.01,    1.23    ],
    [ 1.23456, 0.1,     1.2     ],

    # Make sure first argument is coerced to Numeric.
    [ "123.12", 0.01, 123.12 ],
    [ [<foo bar baz>], 1, 3 ],
    [ { :1foo, :2bar, :3baz }, 1, 3 ],
  );

  for @tests {
    ok(round(.[0], .[1]) == .[2], "round({.[0].raku}, {.[1].raku}) == {.[2].raku}");
  }
}

for @testkeys -> $type {
    my @subtests = @(%tests{$type});    # XXX .[] doesn't work yet!
    for @subtests -> $test {
        my $code = "({$test[0]}).{$type}";
        my $res = $test[0]."$type"();

        ok($res == $test[1], "$code == {$test[1]}");
    }
}

for @testkeys -> $t {
    isa-ok &::($t)(1.1), Int, "rounder $t returns an Int";
}

# MoarVM Issue #157
# separate test since rakudo.jvm rounds this very large number
# more precise than rakudo.moar
{
    my $number   = 5e+33;
    my $result_1 = 4999999999999999727876154935214080;   # result on Moar and Parrot
    my $result_2 = 5000000000000000000000000000000000;   # result on JVM
    my $result_3 = 5000000000000000304336907238637568;   # result seen on Moar/MinGW

    ok round($number) ~~ any($result_1,$result_2,$result_3),
        'large positive numbers rounded do not give negative numbers (1)';
    ok $number.round ~~ any($result_1,$result_2,$result_3),
        'large positive numbers rounded do not give negative numbers (2)';
}

# https://github.com/Raku/old-issue-tracker/issues/2593
{
    my $integer = 987654321;
    is $integer.round(1),   987654321, "round integer with argument";
    is $integer.round(5),   987654320, "($integer).round(5) == 987654320";
    is $integer.round(1e5), 987700000, "($integer).round(1e5) == 987700000";
    is 2.round(3/20),       1.95,      "2.round(3/20) == 1.95";
}

{
    my $num = 123.456789;
    cmp-ok $num.round(1),     '==', 123,       "round with argument";
    cmp-ok $num.round(5),     '==', 125,       "($num).round(5) == 125";
    cmp-ok $num.round(1/100), '==', 123.46,    "($num).round(1/100) == 123.46";
    cmp-ok $num.round(1e-5),  '=~=', 123.45679e0,
        "($num).round(1e-5) =~= 123.45679e0";
}

# https://github.com/Raku/old-issue-tracker/issues/4825
{
    my $complex = 5.123456789+3.987654321i;
    is $complex.round(1),             5+4i,  "complex round with argument";
    is $complex.round(5),             5+5i,  "($complex).round(5) == 5+5i";
    is $complex.round(1/100),   5.12+3.99i,  "($complex).round(1/100) == 5.12+3.99i";
    is $complex.round(1e-3),  5.123+3.988i,  "($complex).round(1e-3) == 5.123+3.988i";
}

{
    my $big-int = 1234567890123456789012345678903;
    is $big-int.floor, $big-int, "floor passes bigints unchanged";
    is $big-int.ceiling, $big-int, "ceiling passes bigints unchanged";
    is $big-int.round, $big-int, "round passes bigints unchanged";
    is $big-int.truncate, $big-int, "truncate passes bigints unchanged";
}

{
    my $big-rat = 1234567890123456789012345678903 / 2;
    my $big-int = 1234567890123456789012345678903 div 2;
    is $big-rat.floor, $big-int, "floor handles Rats properly";
    is $big-rat.ceiling, $big-int + 1, "ceiling handles Rats properly";
    is $big-rat.round, $big-int + 1, "round handles Rats properly";
    is $big-rat.truncate, $big-int, "truncate handles Rats properly";
}

{
    my $big-rat = FatRat.new(1234567890123456789012345678903, 2);
    my $big-int = 1234567890123456789012345678903 div 2;
    is $big-rat.floor, $big-int, "floor handles FatRats properly";
    is $big-rat.ceiling, $big-int + 1, "ceiling handles FatRats properly";
    is $big-rat.round, $big-int + 1, "round handles FatRats properly";
    is $big-rat.truncate, $big-int, "truncate handles FatRats properly";
}

group-of 64 => "type of .round's return value" => {
    is-deeply 42.round(42), 42,
        "Int with Int rounder is Int";
    is-deeply 42.round(IntStr.new(42, "42")), 42,
        "Int with IntStr rounder is Int";
    is-deeply 42.round(42e0), 42e0,
        "Int with Num rounder is Num";
    is-deeply 42.round(NumStr.new(42e0, "42e0")), 42e0,
        "Int with NumStr rounder is Num";
    is-deeply 42.round(42.0), 42.0,
        "Int with Rat rounder is Rat";
    is-deeply 42.round(RatStr.new(42.0, "42.0")), 42.0,
        "Int with RatStr rounder is Rat";
    is-deeply 42.round(<42+0i>), 42e0,
        "Int with Complex rounder is Num";
    is-deeply 42.round(ComplexStr.new(<42+0i>, "42+0i")), 42e0,
        "Int with ComplexStr rounder is Num";
    is-deeply IntStr.new(42, "42").round(42), 42,
        "IntStr with Int rounder is Int";
    is-deeply IntStr.new(42, "42").round(IntStr.new(42, "42")), 42,
        "IntStr with IntStr rounder is Int";
    is-deeply IntStr.new(42, "42").round(42e0), 42e0,
        "IntStr with Num rounder is Num";
    is-deeply IntStr.new(42, "42").round(NumStr.new(42e0, "42e0")), 42e0,
        "IntStr with NumStr rounder is Num";
    is-deeply IntStr.new(42, "42").round(42.0), 42.0,
        "IntStr with Rat rounder is Rat";
    is-deeply IntStr.new(42, "42").round(RatStr.new(42.0, "42.0")), 42.0,
        "IntStr with RatStr rounder is Rat";
    is-deeply IntStr.new(42, "42").round(<42+0i>), 42e0,
        "IntStr with Complex rounder is Num";
    is-deeply IntStr.new(42, "42").round(ComplexStr.new(<42+0i>, "42+0i")), 42e0,
        "IntStr with ComplexStr rounder is Num";
    is-deeply 42e0.round(42), 42,
        "Num with Int rounder is Int";
    is-deeply 42e0.round(IntStr.new(42, "42")), 42,
        "Num with IntStr rounder is Int";
    is-deeply 42e0.round(42e0), 42e0,
        "Num with Num rounder is Num";
    is-deeply 42e0.round(NumStr.new(42e0, "42e0")), 42e0,
        "Num with NumStr rounder is Num";
    is-deeply 42e0.round(42.0), 42.0,
        "Num with Rat rounder is Rat";
    is-deeply 42e0.round(RatStr.new(42.0, "42.0")), 42.0,
        "Num with RatStr rounder is Rat";
    is-deeply 42e0.round(<42+0i>), 42e0,
        "Num with Complex rounder is Num";
    is-deeply 42e0.round(ComplexStr.new(<42+0i>, "42+0i")), 42e0,
        "Num with ComplexStr rounder is Num";
    is-deeply NumStr.new(42e0, "42e0").round(42), 42,
        "NumStr with Int rounder is Int";
    is-deeply NumStr.new(42e0, "42e0").round(IntStr.new(42, "42")), 42,
        "NumStr with IntStr rounder is Int";
    is-deeply NumStr.new(42e0, "42e0").round(42e0), 42e0,
        "NumStr with Num rounder is Num";
    is-deeply NumStr.new(42e0, "42e0").round(NumStr.new(42e0, "42e0")), 42e0,
        "NumStr with NumStr rounder is Num";
    is-deeply NumStr.new(42e0, "42e0").round(42.0), 42.0,
        "NumStr with Rat rounder is Rat";
    is-deeply NumStr.new(42e0, "42e0").round(RatStr.new(42.0, "42.0")), 42.0,
        "NumStr with RatStr rounder is Rat";
    is-deeply NumStr.new(42e0, "42e0").round(<42+0i>), 42e0,
        "NumStr with Complex rounder is Num";
    is-deeply NumStr.new(42e0, "42e0").round(ComplexStr.new(<42+0i>, "42+0i")), 42e0,
        "NumStr with ComplexStr rounder is Num";
    is-deeply 42.0.round(42), 42,
        "Rat with Int rounder is Int";
    is-deeply 42.0.round(IntStr.new(42, "42")), 42,
        "Rat with IntStr rounder is Int";
    is-deeply 42.0.round(42e0), 42e0,
        "Rat with Num rounder is Num";
    is-deeply 42.0.round(NumStr.new(42e0, "42e0")), 42e0,
        "Rat with NumStr rounder is Num";
    is-deeply 42.0.round(42.0), 42.0,
        "Rat with Rat rounder is Rat";
    is-deeply 42.0.round(RatStr.new(42.0, "42.0")), 42.0,
        "Rat with RatStr rounder is Rat";
    is-deeply 42.0.round(<42+0i>), 42e0,
        "Rat with Complex rounder is Num";
    is-deeply 42.0.round(ComplexStr.new(<42+0i>, "42+0i")), 42e0,
        "Rat with ComplexStr rounder is Num";
    is-deeply RatStr.new(42.0, "42.0").round(42), 42,
        "RatStr with Int rounder is Int";
    is-deeply RatStr.new(42.0, "42.0").round(IntStr.new(42, "42")), 42,
        "RatStr with IntStr rounder is Int";
    is-deeply RatStr.new(42.0, "42.0").round(42e0), 42e0,
        "RatStr with Num rounder is Num";
    is-deeply RatStr.new(42.0, "42.0").round(NumStr.new(42e0, "42e0")), 42e0,
        "RatStr with NumStr rounder is Num";
    is-deeply RatStr.new(42.0, "42.0").round(42.0), 42.0,
        "RatStr with Rat rounder is Rat";
    is-deeply RatStr.new(42.0, "42.0").round(RatStr.new(42.0, "42.0")), 42.0,
        "RatStr with RatStr rounder is Rat";
    is-deeply RatStr.new(42.0, "42.0").round(<42+0i>), 42e0,
        "RatStr with Complex rounder is Num";
    is-deeply RatStr.new(42.0, "42.0").round(ComplexStr.new(<42+0i>, "42+0i")), 42e0,
        "RatStr with ComplexStr rounder is Num";
    is-deeply <42+0i>.round(42), <42+0i>,
        "Complex with Int rounder is Complex";
    is-deeply <42+0i>.round(IntStr.new(42, "42")), <42+0i>,
        "Complex with IntStr rounder is Complex";
    is-deeply <42+0i>.round(42e0), <42+0i>,
        "Complex with Num rounder is Complex";
    is-deeply <42+0i>.round(NumStr.new(42e0, "42e0")), <42+0i>,
        "Complex with NumStr rounder is Complex";
    is-deeply <42+0i>.round(42.0), <42+0i>,
        "Complex with Rat rounder is Complex";
    is-deeply <42+0i>.round(RatStr.new(42.0, "42.0")), <42+0i>,
        "Complex with RatStr rounder is Complex";
    is-deeply <42+0i>.round(<42+0i>), <42+0i>,
        "Complex with Complex rounder is Complex";
    is-deeply <42+0i>.round(ComplexStr.new(<42+0i>, "42+0i")), <42+0i>,
        "Complex with ComplexStr rounder is Complex";
    is-deeply ComplexStr.new(<42+0i>, "42+0i").round(42), <42+0i>,
        "ComplexStr with Int rounder is Complex";
    is-deeply ComplexStr.new(<42+0i>, "42+0i").round(IntStr.new(42, "42")), <42+0i>,
        "ComplexStr with IntStr rounder is Complex";
    is-deeply ComplexStr.new(<42+0i>, "42+0i").round(42e0), <42+0i>,
        "ComplexStr with Num rounder is Complex";
    is-deeply ComplexStr.new(<42+0i>, "42+0i").round(NumStr.new(42e0, "42e0")), <42+0i>,
        "ComplexStr with NumStr rounder is Complex";
    is-deeply ComplexStr.new(<42+0i>, "42+0i").round(42.0), <42+0i>,
        "ComplexStr with Rat rounder is Complex";
    is-deeply ComplexStr.new(<42+0i>, "42+0i").round(RatStr.new(42.0, "42.0")), <42+0i>,
        "ComplexStr with RatStr rounder is Complex";
    is-deeply ComplexStr.new(<42+0i>, "42+0i").round(<42+0i>), <42+0i>,
        "ComplexStr with Complex rounder is Complex";
    is-deeply ComplexStr.new(<42+0i>, "42+0i").round(ComplexStr.new(<42+0i>, "42+0i")), <42+0i>,
        "ComplexStr with ComplexStr rounder is Complex";
}


# vim: expandtab shiftwidth=4
