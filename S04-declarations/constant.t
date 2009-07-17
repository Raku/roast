use v6;

use Test;

plan 33;

# L<S04/The Relationship of Blocks and Declarations/"The new constant declarator">

# Following tests test whether the declaration succeeded.
#?pugs todo 'feature'
{
    my $ok;

    constant foo = 42;
    $ok = foo == 42;

    ok $ok, "declaring a sigilless constant using 'constant' works";
}

{
    my $ok;

    constant $bar = 42;
    $ok = $bar == 42;

    ok $ok, "declaring a constant with a sigil using 'constant' works";
}

{
    {
        constant foo2 = 42;
    }
    eval_dies_ok 'foo2 == 42', 'constants are lexically scoped';
}

{
    constant foo3 = 42;
    lives_ok { my foo3 $x = 42 },        'constant can be used as a type constraint';
    dies_ok { my foo3 $x = 43 },         'constant used as a type constraint enforces';
    dies_ok { my foo3 $x = 42; $x =43 }, 'constant used as a type constraint enforces';
}

{
    my $ok;

    constant $foo = 582;
    constant $bar = $foo;
    $ok = $bar == 582;

    ok $ok, "declaring a constant in terms of another constant works";
}

#?rakudo skip 'package-scoped constant'
{
    package ConstantTest {
        constant yak = 'shaving';
    }
    is ConstantTest::yak, 'shaving', 'constant is "our"-scoped';
}

#?rakudo skip 'COMPILING'
{
    my $ok;

    constant $foo = 8224;
    constant $bar = COMPILING::<$foo>;
    $ok = $bar == 8224;

    ok $ok, "declaring a constant in terms of COMPILING constant works";
}

{
    my $ok;

    constant %foo = { :a(582) };
    constant $bar = %foo<a>;
    $ok = $bar == 582;

    ok $ok, "declaring a constant in terms of hash constant works";
}

#?rakudo skip 'COMPILING'
{
    my $ok;

    constant %foo = { :b(8224) };
    constant $bar = COMPILING::<%foo><b>;
    $ok = $bar == 8224;

    ok $ok, "declaring a constant in terms of COMPILING hash constant works";
}

{
    my $ok;

    constant @foo = 0, 582;
    constant $bar = @foo[1];
    $ok = $bar == 582;

    ok $ok, "declaring a constant in terms of array constant works";
}

#?rakudo skip 'COMPILING'
{
    my $ok;

    constant @foo = [ 1, 2, 8224 ];
    constant $bar = COMPILING::<@foo>[2];
    $ok = $bar == 8224;

    ok $ok, "declaring a constant in terms of COMPILING hash constant works";
}

{
    my $ok;

    constant Num baz = 42;
    $ok = baz == 42;

    ok $ok, "declaring a sigilless constant with a type specification using 'constant' works";
}

#?rakudo skip 'unicode constant name'
{
    my $ok;

    constant λ = 42;
    $ok = λ == 42;

    ok $ok, "declaring an Unicode constant using 'constant' works";
}

# Following tests test whether the constants are actually constant.
#?pugs todo 'feature'
{
    my $ok;

    constant grtz = 42;
    $ok++ if grtz == 42;

    try { grtz = 23 };
    $ok++ if $!;
    $ok++ if grtz == 42;

    is $ok, 3, "a constant declared using 'constant' is actually constant (1)";
}

#?rakudo skip 'binding'
#?pugs todo 'feature'
{
    my $ok;

    constant baka = 42;
    $ok++ if baka == 42;

    try { baka := 23 };
    $ok++ if $!;
    $ok++ if baka == 42;

    is $ok, 3, "a constant declared using 'constant' is actually constant (2)";
}

#?pugs todo 'feature'
{
    my $ok;

    constant wobble = 42;
    $ok++ if wobble == 42;

    try { wobble++ };
    $ok++ if $!;
    $ok++ if wobble == 42;

    is $ok, 3, "a constant declared using 'constant' is actually constant (3)";
}

#?rakudo skip 'binding'
#?pugs todo 'feature'
{
    my $ok;

    constant wibble = 42;
    $ok++ if wibble == 42;

    try { wibble := { 23 } };
    $ok++ if $!;
    $ok++ if wibble == 42;

    is $ok, 3, "a constant declared using 'constant' is actually constant (4)";
}

# L<S04/The Relationship of Blocks and Declarations/The initializing
# expression is evaluated at BEGIN time.>
#?rakudo skip 'BEGIN and outer lexicals'
{
    my $ok;

    my $foo = 42;
    BEGIN { $foo = 23 }
    constant timecheck = $foo;
    $ok++ if timecheck == 23;

    #?pugs todo 'feature'
    ok $ok, "the initializing values for constants are evaluated at compile-time";
}

# RT #64522
{
    constant $x = 64522;
    dies_ok { $x += 2 }, 'dies: constant += n';
    is $x, 64522, 'constant after += has not changed';

    sub con { 64522 }
    dies_ok { ++con }, "constant-returning sub won't increment";
    is con, 64522, 'constant-returning sub after ++ has not changed';
}

# XXX identities (spec?)
{
    constant $change = 'alteration';

    lives_ok { $change ~= '' }, 'can append nothing to a constant';
    lives_ok { $change = 'alteration' }, 'can assign constant its own value';
    my $t = $change;
    lives_ok { $change = $t }, 'can assign constant its own value from var';
    lives_ok { $change = 'alter' ~ 'ation' },
             'can assign constant its own value from expression';

    constant $five = 5;

    lives_ok { $five += 0 }, 'can add zero to constant number';
    lives_ok { $five *= 1 }, 'can multiply constant number by 1';
    lives_ok { $five = 5 }, 'can assign constant its own value';
    my $faux_five = $five;
    lives_ok { $five = $faux_five },
             'can assign constant its own value from variable';
    lives_ok { $five = 2 + 3 },
             'can assign constant its own value from expression';
}

# vim: ft=perl6
