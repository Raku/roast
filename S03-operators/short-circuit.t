use v6;

use Test;

=begin description

Tests that || and && and // really short circuit, and do not call their
rhs when the lhs is enough to deduce the result.

Also, test new ^^ operator here: even though it does not short circuit,
it is closely related to || and && and //.

=end description

plan 83;

my $accum = '';
sub f1($s)   { $accum ~= $s; 1 }
sub f0($s)   { $accum ~= $s; 0 }
sub fAny($s) { $accum ~= $s; Any }

#?DOES 1
sub accumtest($expect, $op) {
    is $accum, $expect, "$op operator short circuiting exactly when needed";
    $accum = '';
}

{
    my $x = 1;
    my $y = 2;
    $x == 1 || ($y = 42);

    is($y, 2, "|| operator short circuiting");

    f0('a') || f0('b') || f1('c') || f0('d') || f1('e');
    accumtest 'abc', '||';
}

{
    my $x = 1;
    my $y = 2;
    $x == 1 or $y = 42;

    is($y, 2, "'or' operator short circuiting");

    f0('a') or f0('b') or f1('c') or f0('d') or f1('e');
    accumtest 'abc', "'or'";
}

{
    my $x = 1;
    my $y = 2;
    $x != 1 && ($y = 42);

    is($y, 2, "&& operator short circuiting");

    f1('a') && f1('b') && f1('c') && f0('d') && f1('e');
    accumtest 'abcd', '&&';
}

{
    my $x = 1;
    my $y = 2;
    $x != 1 and $y = 42;

    is($y, 2, "'and' operator short circuiting");

    f1('a') and f1('b') and f1('c') and f0('d') and f1('e');
    accumtest 'abcd', "'and'";
}

{
    my $x = 1;
    my $y = 2;
    $x // ($y = 42);

    is($y, 2, "// operator short circuiting");

    fAny('a') // fAny('b') // f0('c') // f1('d') // fAny('e');
    accumtest 'abc', '//';

    fAny('a') // f1('b') // f0('c');
    accumtest 'ab', '//';
}

{
    my $x = 1;
    my $y = 2;
    $x orelse $y = 42;

    is($y, 2, "'orelse' operator short circuiting");

    fAny('a') orelse fAny('b') orelse f0('c') orelse f1('d') orelse fAny('e');
    accumtest 'abc', "'orelse'";

    fAny('a') orelse f1('b') orelse f0('c');
    accumtest 'ab', "'orelse'";
}

{
    my $x;      # should be Mu
    my $y = 2;
    $x // ($y = 42);

    is($y, 42, "// operator working");
}

{
    my $x;      # should be Mu
    my $y = 2;
    $x orelse $y = 42;

    is($y, 42, "'orelse' operator working");
}

#?niecza skip "^^ NYI"
{
    my $x;      # should be Mu
    my $y = 2;
    $x ^^ ($y = 42);

    is($y, 42, "^^ operator not short circuiting");

    $x = 0;
    1 ^^ 2 ^^ ($x = 5);
    is($x, 0, "^^ operator short circuiting");

    f0('a') ^^ f0('b') ^^ f1('c') ^^ f0('d') ^^
        f0('e') ^^ f1('f') ^^ f0('g') ^^ f0('h');
    accumtest 'abcdef', '^^';
}

#?niecza skip "xor NYI"
{
    my $x;      # should be Mu
    my $y = 2;
    $x xor $y = 42;

    is($y, 42, "xor operator not short circuiting");

    $x = 0;
    1 xor 2 xor ($x = 5);
    is($x, 0, "xor operator short circuiting");

    f0('a') xor f0('b') xor f1('c') xor f0('d') xor
        f0('e') xor f1('f') xor f0('g') xor f0('h');
    accumtest 'abcdef', 'xor';
}

{
    is(1 && 42,        42, "&&   operator working");
    is((1 and 42),     42, "and  operator working");

    is(0 || 42,        42, "||   operator working");
    is((0 or 42),      42, "or   operator working");

    is((Mu // 42),  42, "//   operator working"); #"
    is((Mu orelse 42), 42, "orelse  operator working");

    #?niecza 10 skip "^^ xor NYI"
    is(0 ^^ 42,        42, "^^  operator working (one true)");
    is(42 ^^ 0,        42, "^^  operator working (one true)");
    #?rakudo todo 'wrong return type'
    is(1 ^^ 42,     False, "^^  operator working (both true)");
    is(0 ^^ 0,          0, "^^  operator working (both false)");
    is((0 xor 42),     42, "xor operator working (one true)");
    is((42 xor 0),     42, "xor operator working (one true)");
    is((0 xor 42),     42, "xor operator working (one true)");
    is((42 xor 0),     42, "xor operator working (one true)");
    ok(!(1 xor 42),        "xor operator working (both true)");
    ok(!(0 xor 0),         "xor operator working (both false)");
}

# L<S03/Tight or precedence/'if all arguments are false'>
# RT #72826 infix ^^ return wrong types
#?niecza skip "^^ NYI"
{
    is 0 ^^ False ^^ '', '', '^^ given all false values returns last (1)';
    is False ^^ '' ^^ 0, 0, '^^ given all false values returns last (2)';
    is False ^^ 42 ^^ '', 42, '^^ given one true value returns it (1)';
    is 0 ^^ Int ^^ 'plugh', 'plugh', '^^ given one true value returns it (2)';
    #?rakudo todo 'wrong return type'
    is 15 ^^ 0 ^^ 'quux', False, '^^ given two true values returns False (1)';
    #?rakudo todo 'wrong return type'
    is 'a' ^^ 'b' ^^ 0, False, '^^ given two true values returns False (2)';

    is (0 xor False xor ''), '', 'xor given all false values returns last (1)';
    is (False xor '' xor 0), 0, 'xor given all false values returns last (2)';
    is (False xor 42 xor ''), 42, 'xor given one true value returns it (1)';
    is (0 xor Int xor 'plugh'), 'plugh', 'xor given one true value returns it (2)';
    #?rakudo todo 'wrong return type'
    is (15 xor 0 xor 'quux'), False, 'xor given two true values returns False (1)';
    #?rakudo todo 'wrong return type'
    is ('a' xor 'b' xor 0), False, 'xor given two true values returns False (2)';

    #?rakudo todo 'wrong return type'
    isa_ok 7 ^^ 7, Bool, '^^ can return a Bool';
    isa_ok 7 ^^ Mu, Int, '^^ can return an Int';
    isa_ok 0 ^^ ^7, Range, '^^ can return a Range';
    isa_ok ^7 ^^ 0, Range, '^^ can return a Range';
    isa_ok 7.5i ^^ Mu, Complex, '^^ can return a Complex';
    isa_ok Inf ^^ Mu, Num, '^^ can return a Num';
    isa_ok 'Inf' ^^ Mu, Str, '^^ can return a Str';

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
    #?niecza todo
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

{
    my $a = sub { 1 };
    my $b;
    sub c($code) { if $code and $code() { return 1 }; return 2 }

    is c($a), 1, 'shortcircuit idiom given coderef works';

    is c($b), 2, 'shortcircuit idiom given Mu works';
}

# a rakudo regression
ok (0 || 0 || 1), '0 || 0 || 1 is true';

# RT #77864
{
    my $x;
    $x &&= 5;
    ok !defined($x), '&&= on a fresh variable works';
    my $y ||= 'moin';
    is $y, 'moin', '||= on a fresh variable works';

}

{
    my $a = 0;
    my $b = 0;
    $a //= ($b = 1);
    is $a, 0, 'basic //=';
    is $b, 0, '//= short-circuits';

    $a = 1;
    $b = 0;
    $a ||= ($b = 2);
    is $a, 1, 'basic ||=';
    is $b, 0, '||= short-circuits';

}

# RT #90158
{
    my @a = 1;
    @a ||= ();
    is ~@a, '1', '||= works with array on the LHS';
}

# RT #116230
{
    my role SomeRole { };
    my $x = SomeRole;
    $x //= SomeRole.new;
    ok $x.defined, '//= can cope with role type objects';
}

done;

# vim: ft=perl6
