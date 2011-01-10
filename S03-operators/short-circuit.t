use v6;

use Test;

=begin description

Tests that || and && and // really short circuit, and do not call their
rhs when the lhs is enough to deduce the result.

Also, test new ^^ operator here: even though it does not short circuit,
it is closely related to || and && and //.

=end description

# test cases by Andrew Savige

plan 54;

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
    my $x;      # should be Mu
    my $y = 2;
    $x // ($y = 42);

    is($y, 42, "// operator working");
}

#?rakudo skip 'no inifx:<orelse> yet'
{
    my $x;      # should be Mu
    my $y = 2;
    $x orelse $y = 42;

    is($y, 42, "'orelse' operator working");
}

{
    my $x;      # should be Mu
    my $y = 2;
    $x ^^ ($y = 42);

    is($y, 42, "^^ operator not short circuiting");

    $x = 0;
    1 ^^ 2 ^^ ($x = 5);
    is($x, 0, "^^ operator short circuiting");
}

{
    my $x;      # should be Mu
    my $y = 2;
    $x xor $y = 42;

    is($y, 42, "xor operator not short circuiting");
}

{
    is(1 && 42,        42, "&&   operator working");
    is((1 and 42),     42, "and  operator working");

    is(0 || 42,        42, "||   operator working");
    is((0 or 42),      42, "or   operator working");

    is((Mu // 42),  42, "//   operator working"); #"
    #?rakudo skip 'no inifx:<orelse> yet'
    is((Mu orelse 42), 42, "orelse  operator working");

    is(0 ^^ 42,        42, "^^  operator working (one true)");
    is(42 ^^ 0,        42, "^^  operator working (one true)");
    #?rakudo skip '1 ^^ 42 should return False (or maybe Nil)'
    ok((1 ^^ 42) === (?0), "^^  operator working (both true)");
    #?rakudo skip '0 ^^ 0 should return False (or maybe Nil)'
    ok((0 ^^ 0)  === (?0), "^^  operator working (both false)");
    is((0 xor 42),     42, "xor operator working (one true)");
    is((42 xor 0),     42, "xor operator working (one true)");
    is((0 xor 42),     42, "xor operator working (one true)");
    is((42 xor 0),     42, "xor operator working (one true)");
    #?rakudo skip '1 ^^ 42 yields Mu?'
    ok(!(1 xor 42),        "xor operator working (both true)");
    ok(!(0 xor 0),         "xor operator working (both false)");
}


# RT #73820 infix ^^ return wrong types
# RT #72826 infix ^^ return wrong types
#?rakudo 14 skip 'test return type of infix ^^'
{
    is ( 7 ^^ 7 ).WHAT, 'Bool()', 'Bool()';
    is ( 7 ^^ Mu ).WHAT, 'Int()', 'Int()';
    is ( 0 ^^ ^7 ).WHAT, 'Range()', 'Range()';
    is ( ^7 ^^ 0 ).WHAT, 'Range()', 'Range()';
    is ( 7.5i ^^ Mu ).WHAT, 'Complex()', 'Complex()';
    is ( Inf ^^ Mu ).WHAT, 'Num()', 'Num()';
    is ( 'Inf' ^^ Mu ).WHAT, 'Str()', 'Str()';

    my @a = (1,2,3);
    my @b = (4,5,6);
    my (@c, @d);

    is (@a ^^ @c), '1 2 3', 'Array ^^ true returns true array';
    is (@c ^^ @a), '1 2 3', 'Array ^^ true returns true array';
    ok (@a ^^ @b) == (), 'Array ^^ true returns empty list';
    ok (@c ^^ @d) == (), 'Array ^^ true returns empty list';
    is (@a ^^ ()), '1 2 3', 'True array ^^ empty list returns array';
    is (() ^^ @a), '1 2 3', 'Empty list ^^ true array returns array';
    ok (() ^^ @c) == (), 'Empty list ^^ empty array returns ()';
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

# a pugs regression 

{
    my $a = sub { 1 };
    my $b;
    sub c($code) { if $code and $code() { return 1 }; return 2 }

    is c($a), 1, 'shortcircuit idiom given coderef works';

    # This one will just kill pugs with the cast failure, so force fail
    #?pugs eval 'short circuiting'
    is c($b), 2, 'shortcircuit idiom given Mu works';
}

# a rakudo regression
ok (0 || 0 || 1), '0 || 0 || 1 is true';

# RT #77864
{
    my $x;
    $x &&= 5;
    is $x, 5, '&&= on a fresh variable works';
    my $y ||= 'moin';
    is $y, 'moin', '||= on a fresh variable works';

}

done;

# vim: ft=perl6
