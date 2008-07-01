use v6;

use Test;

=begin description

Tests that || and && and // really short circuit, and do not call their
rhs when the lhs is enough to deduce the result.

Also, test new ^^ operator here: even though it does not short circuit,
it is closely related to || and && and //.

=end description

# test cases by Andrew Savige

plan 34;

{
    my $x = 1;
    my $y = 2;
    $x == 1 || ($y = 42);

    is($y, 2, "|| operator short circuiting");
}

{
    my $x = 1;
    my $y = 2;
    $x == 1 or $y = 42;

    is($y, 2, "'or' operator short circuiting");
}

{
    my $x = 1;
    my $y = 2;
    $x != 1 && ($y = 42);

    is($y, 2, "&& operator short circuiting");
}

{
    my $x = 1;
    my $y = 2;
    $x != 1 and $y = 42;

    is($y, 2, "'and' operator short circuiting");
}

{
    my $x = 1;
    my $y = 2;
    $x // ($y = 42);

    is($y, 2, "// operator short circuiting");
}

#?rakudo skip 'no inifx:<orelse> yet'
{
    my $x = 1;
    my $y = 2;
    $x orelse $y = 42;

    is($y, 2, "'orelse' operator short circuiting");
}

{
    my $x;      # should be undef
    my $y = 2;
    $x // ($y = 42);

    is($y, 42, "// operator working");
}

#?rakudo skip 'no inifx:<orelse> yet'
{
    my $x;      # should be undef
    my $y = 2;
    $x orelse $y = 42;

    is($y, 42, "'orelse' operator working");
}

{
    my $x;      # should be undef
    my $y = 2;
    $x ^^ ($y = 42);

    is($y, 42, "^^ operator not short circuiting");
}

{
    my $x;      # should be undef
    my $y = 2;
    $x xor $y = 42;

    is($y, 42, "xor operator not short circuiting");
}

{
    is(1 && 42,        42, "&&   operator working");
    is((1 and 42),     42, "and  operator working");

    is(0 || 42,        42, "||   operator working");
    is((0 or 42),      42, "or   operator working");

    #?rakudo 2 skip 'no inifx:<orelse> yet'
    is((undef // 42),  42, "//   operator working"); #"
    is((undef orelse 42), 42, "orelse  operator working");

    is(0 ^^ 42,        42, "^^  operator working (one true)");
    is(42 ^^ 0,        42, "^^  operator working (one true)");
    ok(!(1 ^^ 42),         "^^  operator working (both true)");
    ok(!(0 ^^ 0),          "^^  operator working (both false)");
    is((0 xor 42),     42, "xor operator working (one true)");
    is((42 xor 0),     42, "xor operator working (one true)");
    is((0 xor 42),     42, "xor operator working (one true)");
    is((42 xor 0),     42, "xor operator working (one true)");
    ok(!(1 xor 42),        "xor operator working (both true)");
    ok(!(0 xor 0),         "xor operator working (both false)");
}

{
    my $x0 = 0;
    my @a0 = () and $x0 = 1;
    is($x0, 0,    "'and' operator short circuiting");
    ok(+@a0 == 0, "'and' operator working with list assignment");
}

{
    my $x0 = 0;
    my @a0 = () or $x0 = 1;
    is($x0,  1, "'or' operator short circuiting");
    is(+@a0, 0, "'or' operator working with list assignment");
}

# L<S03/Chained comparisons/Each argument chain will evaluate at most once>
{
    my $x = 0;
    my $y = 0;
    #?rakudo todo 'chained comparison order of evaluations'
    ok(($x++ < ++$y < ++$y), "chained comparison (truth - 1)");
    # expect x=1, y=2
    is($y, 2, "chained comparison short-circuit: not re-evaluating middle");
}

# L<S03/Chained comparisons/A chain of comparisons short-circuits>
{
    my $x = 0;
    my $y = 0;
    ok(not(++$x < $y++ < $y++), "chained comparison (truth - 2)");
    # expect x=1, y=1
    is($y, 1, "chained comparison short-circuit: stopping soon enough");
}

