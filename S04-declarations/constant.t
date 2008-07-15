use v6;

use Test;

plan 19;

# Following tests test whether the declaration succeeded.
{
    my $ok;

    eval '
        constant foo = 42;
        $ok = foo == 42;
    ';

    ok $ok, "declaring a sigilless constant using 'constant' works", :todo<feature>;
}

{
    my $ok;

    eval '
        constant $bar = 42;
        $ok = $bar == 42;
    ';

    ok $ok, "declaring a constant with a sigil using 'constant' works";
}

{
    my $ok;

    eval '
        constant $foo = 582;
        constant $bar = $foo;
        $ok = $bar == 582;
    ';

    ok $ok, "declaring a constant in terms of another constant works";
}

{
    my $ok;

    eval '
        constant $foo = 8224;
        constant $bar = COMPILING::<$foo>;
        $ok = $bar == 8224;
    ';

    ok $ok, "declaring a constant in terms of COMPILING constant works";
}

{
    my $ok;

    eval '
        constant %foo = { :a(582) };
        constant $bar = %foo<a>;
        $ok = $bar == 582;
    ';

    ok $ok, "declaring a constant in terms of hash constant works";
}

{
    my $ok;

    eval '
        constant %foo = { :b(8224) };
        constant $bar = COMPILING::<%foo><b>;
        $ok = $bar == 8224;
    ';

    ok $ok, "declaring a constant in terms of COMPILING hash constant works";
}

{
    my $ok;

    eval '
        constant @foo = [ 0, 582 ];
        constant $bar = @foo[1];
        $ok = $bar == 582;
    ';

    ok $ok, "declaring a constant in terms of hash constant works";
}

{
    my $ok;

    eval '
        constant @foo = [ 1, 2, 8224 ];
        constant $bar = COMPILING::<@foo>[2];
        $ok = $bar == 8224;
    ';

    ok $ok, "declaring a constant in terms of COMPILING hash constant works";
}

{
    my $ok;

    eval '
        constant Num baz = 42;
        $ok = baz == 42;
    ';

    ok $ok, "declaring a sigilless constant with a type specification using 'constant' works", :todo<feature>;
}

{
    my $ok;

    eval '
        constant λ = 42;
        $ok = λ == 42;
    ';

    ok $ok, "declaring an Unicode constant using 'constant' works", :todo<feature>;
}

# Following tests test whether the constants are actually constant.
{
    my $ok;

    eval '
        constant grtz = 42;
        $ok++ if grtz == 42;

        try { grtz = 23 };
        $ok++ if $!;
        $ok++ if grtz == 42;
    ';

    is $ok, 3, "a constant declared using 'constant' is actually constant (1)", :todo<feature>;
}

{
    my $ok;

    eval '
        constant baka = 42;
        $ok++ if baka == 42;

        try { baka := 23 };
        $ok++ if $!;
        $ok++ if baka == 42;
    ';

    is $ok, 3, "a constant declared using 'constant' is actually constant (2)", :todo<feature>;
}

{
    my $ok;

    eval '
        constant wobble = 42;
        $ok++ if wobble == 42;

        try { &wobble = { 23 } };
        $ok++ if $!;
        $ok++ if wobble == 42;
    ';

    is $ok, 3, "a constant declared using 'constant' is actually constant (3)", :todo<feature>;
}

{
    my $ok;

    eval '
        constant wibble = 42;
        $ok++ if wibble == 42;

        try { &wibble := { 23 } };
        $ok++ if $!;
        $ok++ if wibble == 42;
    ';

    is $ok, 3, "a constant declared using 'constant' is actually constant (4)", :todo<feature>;
}

# See thread "our constant pi, my constant pi" on p6l started by Ingo
# Blechschmidt L<http://www.nntp.perl.org/group/perl.perl6.language/23000>,
# especially Luke's reply
# L<http://www.nntp.perl.org/group/perl.perl6.language/23000>.

{
    my $ok;

    eval '
        {
            my constant wack = 42;
            $ok++ if wack == 42;
        }

        $ok++ unless eval "wack; 1";
    ';

    is $ok, 2, "declaring constants using 'my constant' works", :todo<feature>;
}

{
    my $ok;

    eval '
        my constant wack = 42;
        $ok++ if wack == 42;

        {
            my constant wack = 23;
            $ok++ if wack == 23;
        }

        $ok++ if wack == 23;
    ';

    is $ok, 3, "constants declared by 'my constant' shadow correctly", :todo<feature>;
}

{
    my $ok;

    eval '
        {
            our constant globconst1 = 42;
            $ok++ if globconst1 == 42;
        }

        $ok++ if globconst1 == 42;
    ';

    is $ok, 2, "declaring constants using 'our constant' works", :todo<feature>;
}

{
    my $ok;

    eval '
        {
            constant globconst2 = 42;
            $ok++ if globconst2 == 42;
        }

        $ok++ if globconst2 == 42;
    ';

    is $ok, 2, "declaring constants using 'constant' creates package-scoped vars", :todo<feature>;
}

# L<S04/The Relationship of Blocks and Declarations/The initializing
# expression is evaluated at BEGIN time.>
{
    my $ok;

    eval '
        my $foo = 42;
        BEGIN { $foo = 23 }
        my constant timecheck = $foo;
        $ok++ if timecheck == 23;
    ';

    ok $ok, "the initializing values for constants are evaluated at compile-time", :todo<feature>;
}
