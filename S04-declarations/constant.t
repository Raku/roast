use v6;

use Test;


# L<S04/The Relationship of Blocks and Declarations/"The new constant declarator">

# Following tests test whether the declaration succeeded.
#?pugs todo 'feature'
{
    constant foo = 42;

    ok foo == 42, "declaring a sigilless constant using 'constant' works";
    dies_ok { foo = 3 }, "can't reassign to a sigil-less constant";
}

{
    # RT #69522
    sub foo { "OH NOES" };
    constant foo = 5;
    is foo,   5,         'bare constant wins against sub of the same name';
    is foo(), 'OH NOES', '... but parens always indicate a sub call';
}

{
    my $ok;

    constant $bar = 42;
    ok $bar == 42, "declaring a constant with a sigil using 'constant' works";
    dies_ok { $bar = 2 }, "Can't reassign to a sigiled constant";
}

# RT #69740
{
    eval_dies_ok 'constant ($a, $b) = (3, 4)', 'constant no longer takes list';
}


{
    {
        constant foo2 = 42;
    }
    eval_dies_ok 'foo2 == 42', 'constants are lexically scoped';
}

#?rakudo skip 'constants as type constraints'
{
    constant foo3 = 42;
    lives_ok { my foo3 $x = 42 },        'constant can be used as a type constraint';
    dies_ok { my foo3 $x = 43 },         'constant used as a type constraint enforces';
    dies_ok { my foo3 $x = 42; $x =43 }, 'constant used as a type constraint enforces';
}

#?rakudo skip 'non-literal constants'
{
    my $ok;

    constant $foo = 582;
    constant $bar = $foo;
    $ok = $bar == 582;

    ok $ok, "declaring a constant in terms of another constant works";
}

{
    package ConstantTest {
        constant yak = 'shaving';
    }
    is ConstantTest::yak, 'shaving', 'constant is "our"-scoped';
}

{
    package ConstantTest2 {
        our constant yak = 'shaving';
    }
    is ConstantTest2::yak, 'shaving', 'constant can be explicitly "our"-scoped';
}

#?rakudo skip "probably can't parse yet"
{
    package ConstantTest3 {
        my constant yak = 'shaving';
    }
    ok !ConstantTest3::yak.defined, 'constant can be explicitly "my"-scoped';
}

#?rakudo skip 'COMPILING'
{
    my $ok;

    constant $foo = 8224;
    constant $bar = COMPILING::<$foo>;
    $ok = $bar == 8224;

    ok $ok, "declaring a constant in terms of COMPILING constant works";
}

#?rakudo skip 'constant hashes'
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

#?rakudo skip 'array constants'
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

#?rakudo skip 'typed constants'
{
    my $ok;

    my Num constant baz = 42;
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
    my $ok = 0;

    constant grtz = 42;
    $ok++ if grtz == 42;

    try { grtz = 23 };
    $ok++ if $!;
    $ok++ if grtz == 42;

    #?rakudo todo 'unknown'
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
    my $ok = 0;

    constant wobble = 42;
    $ok++ if wobble == 42;

    try { wobble++ };
    $ok++ if $!;
    $ok++ if wobble == 42;

    #?rakudo todo 'unknown'
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

# identities -- can't assign to constant even if it doesn't change it.
{
    constant $change = 'alteration';

    dies_ok { $change ~= '' }, 'append nothing to a constant';
    dies_ok { $change = 'alteration' }, 'assign constant its own value';
    my $t = $change;
    dies_ok { $change = $t }, 'assign constant its own value from var';
    dies_ok { $change = 'alter' ~ 'ation' },
             'assign constant its own value from expression';

    constant $five = 5;

    dies_ok { $five += 0 }, 'add zero to constant number';
    dies_ok { $five *= 1 }, 'multiply constant number by 1';
    dies_ok { $five = 5 }, 'assign constant its own value';
    my $faux_five = $five;
    dies_ok { $five = $faux_five },
             'assign constant its own value from variable';
    dies_ok { $five = 2 + 3 },
             'assign constant its own value from expression';
}

{
    constant C = 6;
    class A {
        constant B = 5;
        has $.x = B;
        has $.y = A::B;
        has $.z = C;
    }

    is A.new.x, 5, 'Can declare and use a constant in a class';
    is A.new.y, 5, 'Can declare and use a constant with FQN in a class';
    is A.new.z, 6, 'Can use outer constants in a class';
}

done;

# vim: ft=perl6
