use v6;

use Test;
use lib $?FILE.IO.parent(2).add("packages");
plan 72;

# L<S04/The Relationship of Blocks and Declarations/"The new constant declarator">

# Following tests test whether the declaration succeeded.
{
    constant foo = 42;

    ok foo == 42, "declaring a sigilless constant using 'constant' works";
    dies-ok { foo = 3 }, "can't reassign to a sigil-less constant";
}

{
    # RT #69522
    sub foo0 { "OH NOES" };
    constant foo0 = 5;
    is foo0,   5,         'bare constant wins against sub of the same name';
    is foo0(), 'OH NOES', '... but parens always indicate a sub call';
}

{
    my $ok;

    constant $bar0 = 42;
    ok $bar0 == 42, "declaring a constant with a sigil using 'constant' works";
    dies-ok { $bar0 = 2 }, "Can't reassign to a sigiled constant";
}

# RT #69740
{
    throws-like 'constant ($a, $b) = (3, 4)', X::Syntax::Missing, 'constant no longer takes list';
}

{
    throws-like 'constant %hash = "nothash"', X::TypeCheck, 'constant hash requires Associative';
}

{
    {
        constant foo2 = 42;
    }
    eval-lives-ok 'foo2 == 42', 'constants are our scoped';
}

{
    constant foo3 = 42;
    #?rakudo todo 'constants as type constraints'
    lives-ok { my foo3 $x = 42 },        'constant can be used as a type constraint';
    dies-ok { my foo3 $x = 43 },         'constant used as a type constraint enforces';
    dies-ok { my foo3 $x = 42; $x =43 }, 'constant used as a type constraint enforces';
}

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

{
    package ConstantTest3 {
        my constant yak = 'shaving';
    }
    dies-ok { ConstantTest3::yak }, 'constant can be explicitly "my"-scoped';
}

#?rakudo todo 'COMPILING RT #125054'
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

#?rakudo todo 'COMPILING RT #125054'
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

#?rakudo todo 'COMPILING RT #125054'
{
    my $ok;

    constant @foo = [ 1, 2, 8224 ];
    constant $bar = COMPILING::<@foo>[2];
    $ok = $bar == 8224;

    ok $ok, "declaring a constant in terms of COMPILING hash constant works";
}

{
    my $ok;

    my Num constant baz = 42;
    $ok = baz == 42;

    ok $ok, "declaring a sigilless constant with a type specification using 'constant' works";
}

{
    my $ok;

    constant λ = 42;
    $ok = λ == 42;

    ok $ok, "declaring an Unicode constant using 'constant' works";
}

# Following tests test whether the constants are actually constant.
{
    my $ok = 0;

    constant grtz = 42;
    $ok++ if grtz == 42;

    try { grtz = 23 };
    $ok++ if $!;
    $ok++ if grtz == 42;

    is $ok, 3, "a constant declared using 'constant' is actually constant (1)";
}

{
    my $ok;

    constant baka = 42;
    $ok++ if baka == 42;

    try { EVAL 'baka := 23' };
    $ok++ if $!;
    $ok++ if baka == 42;

    is $ok, 3, "a constant declared using 'constant' is actually constant (2)";
}

{
    my $ok = 0;

    constant wobble = 42;
    $ok++ if wobble == 42;

    try { wobble++ };
    $ok++ if $!;
    $ok++ if wobble == 42;

    is $ok, 3, "a constant declared using 'constant' is actually constant (3)";
}

{
    my $ok;

    constant wibble = 42;
    $ok++ if wibble == 42;

    try { EVAL 'wibble := { 23 }' };
    $ok++ if $!;
    $ok++ if wibble == 42;

    is $ok, 3, "a constant declared using 'constant' is actually constant (4)";
}

# L<S04/The Relationship of Blocks and Declarations/The initializing
# expression is evaluated at BEGIN time.>
{
    my $ok;

    my $foo = 42;
    BEGIN { $foo = 23 }
    constant timecheck = $foo;
    $ok++ if timecheck == 23;

    ok $ok, "the initializing values for constants are evaluated at compile-time";
}

# RT #64522
{
    constant $x = 64522;
    dies-ok { $x += 2 }, 'dies: constant += n';
    is $x, 64522, 'constant after += has not changed';

    sub con { 64522 }
    dies-ok { ++con }, "constant-returning sub won't increment";
    is con, 64522, 'constant-returning sub after ++ has not changed';
}

# identities -- can't assign to constant even if it doesn't change it.
{
    constant $change = 'alteration';

    dies-ok { $change ~= '' }, 'append nothing to a constant';
    dies-ok { $change = 'alteration' }, 'assign constant its own value';
    my $t = $change;
    dies-ok { $change = $t }, 'assign constant its own value from var';
    dies-ok { $change = 'alter' ~ 'ation' },
             'assign constant its own value from expression';

    constant $five = 5;

    dies-ok { $five += 0 }, 'add zero to constant number';
    dies-ok { $five *= 1 }, 'multiply constant number by 1';
    dies-ok { $five = 5 }, 'assign constant its own value';
    my $faux_five = $five;
    dies-ok { $five = $faux_five },
             'assign constant its own value from variable';
    dies-ok { $five = 2 + 3 },
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

{
    enum F::B <c d e>;
    my constant G = F::B;
    # RT #66650
    ok F::B::c == G::c, 'can use "constant" to alias an enum';
    my constant Yak = F::B::c;
    # RT #66636
    ok Yak === F::B::c, 'can use "constant" to alias an enum value';
}

{
    constant fib := 0, 1, *+* ... *;
    is fib[100], 354224848179261915075, 'can have a constant using a sequence and index it';
}

# RT #115132
{
    lives-ok {constant x1 = "foo" ~~ /bar/},
        'can assign result of smart matching to constant';
    constant x2 = "foo" ~~ "foo";
    is x2, True, 'can assign True to constant';
    constant x3 = "foo" ~~ "bar";
    is x3, False, 'can assign False to constant';
}

# RT #112116
{
    constant %escapes = (^128).map({; chr($_) => sprintf '%%%02X', $_ }).hash;
    is %escapes<e>, '%65', 'constant hashes constructed by map';
}

# RT #119751
{
    class B { constant \a = 3; };
    is B::a, 3, 'escaped constant declaration in class';
}

# RT #122604
{
    constant lots = 0..*;
    lives-ok {lots[100_000]}, "can index an infinite constant list at 100K";
}

# RT #111734
{
    constant True = 42;
    is True, 42, 'can locally redefine True';
}

# RT #114506
{
    class RT114506 {
        has $.val;
    }
    my RT114506 constant Ticket .= new(:val("dot-equals assignment"));
    is Ticket.WHAT, RT114506, "Constant is of the right type";
    is Ticket.val, "dot-equals assignment", ".= new initialization on constants works";
}

throws-like q[constant Mouse = Rat; constant Mouse = Rat], X::Redeclaration,
    symbol  => 'Mouse';

# RT #122895
{
     # constants and non constants are consistently non flattening.
     is (my @ = 'a', <b c>)[1], <b c>, "non constant doesn't flatten"; 
     is (constant @ = 'a', <b c>)[1], <b c>, "constant doesn't flatten"; 
}

# test that constant @x caches Seq
{
    constant @x = (^5).grep(* > 2);
    ok @x ~~ Positional, "constant @x does Positional";
    my @a = @x>>.Str;
    my @b = @x>>.Str;
    is-deeply @a, @b, 'constant @ sequence can be evaluated more than once';
    is @x[0], 3, "can subscript into constant @ (1)";
    is @x[1], 4, "can subscript into constant @ (2)";
}

# test use of 'constant' to make synonym to operator
{
    constant &infix:<`> = &infix:<+>;

    is 1 ` 5, 6, "can add operator synonym via 'constant'";
    is 1 ` 2 * 3, 7, "new synonym has same precedence as what it's aliasing";
}

{
    constant &postfix:<`> = &prefix:<?>;

    is 1`, True, "can create synonym of operator in different grammatical category";
}

{
    multi sub infix:<☃>(Int $a, Int $b) { $a * $b }

    constant &infix:<☄> := &infix:<☃>;

    is 7 ☃ 6, 42, "Operator multi defined on snowman works using snowman";
    is 6 ☄ 6, 36, "Operator multi defined on snowman works using comet";

    multi sub infix:<☄>(Str $a, Int $b) { $a x $b }

    is "A" ☄ 5, "AAAAA", "Operator multi defined on comet works using comet";
    is "B" ☃ 4, "BBBB", "Operator multi defined on comet works using snowman";
}

{
    use ExportConstant;
    is &constant-sub(), 'win', 'Can call an exported constant sub';
    ok "foo" ~~ $constant-regex, 'Can match a exported constant regex';
}

# vim: ft=perl6
