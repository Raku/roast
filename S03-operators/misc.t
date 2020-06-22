use v6;

use Test;

=begin kwid

Tests for Synopsis 3
=end kwid

plan 78;

my $str1 = "foo";
my $str2 = "bar";
my $str3 = "foobar";
my $str4 = $str1~$str2;

# L<S03/Concatenation>
is($str3, $str4, "~");

# L<S03/Conditional operator precedence/Also known as the ternary or trinary operator>
my $bar = "";
($str3 eq $str4) ?? ($bar = 1) !! ($bar = 0);

ok($bar, "?? !!");

# L<S03/Chaining binary precedence/==>
my $five = 5;
my $four = 4;
my $wibble = 4;

ok(!($five == $four), "== (false)");
ok($wibble == $four, "== (true)");
ok(!($wibble != $four), "== (false)");
ok($five != $four, "!= (true)");

ok($five == 5, "== (const on rhs)");
ok(!($five != 5), "!= (const on rhs)");

ok(5 == $five, "== (const on lhs)");
ok(!(5 != $five), "!= (const on lhs)");

ok($five == (2 + 3), "== (sum on rhs)");
ok(!($five != (2 + 3)), "== (sum on rhs)");

is(2 + 3, $five, "== (sum on lhs)");
ok((2 + 3) == 5, "== (sum on lhs)");
ok(!((2 + 3) != $five), "== (sum on lhs)");

# L<S03/Concatenation>
is("text " ~ "stitching", "text stitching", 'concatenation with ~ operator');

# Bit Stitching

# L<S03/Tight or precedence/short-circuit inclusive-or>
is(2 || 3, 2, "|| returns first true value");
ok(!(defined( 0 || Mu)), "|| returns last false value of list?");

{
    (my @s)[0] //= 5;
    is @s[0], 5, '(my @s)[0] //= something works';
    (state @t)[0] //= 5;
    is @t[0], 5, '(state @t)[0] //= something works';
}

is(2 ?| 3, True, "boolean or (?|) returns True or False");
is(0 ?| Any, False, "boolean or (?|) returns True or False");

# L<S03/Junctive operators/They thread through operations>
ok(?((all((4|5|6) + 3) == one(7|8|9))), "all elements in junction are incremented");
ok(?((any(1..6) == one(1|2|3|4|5|6))), "any elements will match via junction");

{
    ok( ?(7 > any(4..12)), "any test against scalar" );

    my @oldval  = (5, 8, 12);

    my @newval1 = (17, 15, 14); # all greater
    my @newval2 = (15, 7,  20); # some less some greater
    my @newval3 = (3, 1, 4);    # all less
    my @newval4 = (1,2,40);

    ok( ?(any(@newval4) > any(@oldval)), "any test array against any array" );
    ok( ?(any(@newval4) > all(@oldval)), "any test array against all array" );
    ok( ?(all(@newval2) > any(@oldval)), "all test array against any array" );
    ok( ?(all(@newval1) > all(@oldval)), "all test array against all array" );

    ok(?(42 > 12 & 20 & 32), "test the all infix operator");
}

# L<S03/Hyper operators/hyper operator distributes over them as lists>
{
    my @rv;
    @rv = (1,2,3,4) >>+<< (1,2,3,4);
    is(~@rv, "2 4 6 8", 'hyper-add');
}

# L<S03/List infix precedence/"the zip operator">
# https://github.com/Raku/old-issue-tracker/issues/1633
my @z=2,3;
is (2 Z 3), @z, 'joining of single items';

# https://github.com/Raku/old-issue-tracker/issues/3065
{
    throws-like { EVAL q[.say for (1 , 2, 3)«~» "!"] },
        X::Syntax::Confused,
        'Guillemet form of subscript does not parse as infix hyperop',
        message => { m/"Two terms in a row"/ };
}

# https://github.com/Raku/old-issue-tracker/issues/3496
{
    multi infix:«≃» { $^l lt $^r };
    multi infix:«!≃» { not($^l ≃ $^r) };
    ok "foo" !≃ "bar",
        'operator can start with a bang (!) and have Unicode character in it';
}

# Duplicate prefixes
{
    # https://github.com/Raku/old-issue-tracker/issues/1562
    throws-like "1%^^1", X::Syntax::DuplicatedPrefix, prefixes => "^^",
        "%^^ fails to parse (RT #73198)";
    # https://github.com/Raku/old-issue-tracker/issues/1921
    throws-like "555 ~~!~~ 666", X::Syntax::DuplicatedPrefix, prefixes => "~~",
        "~~!~~ fails to parse (RT #76436)";
}

# https://github.com/Raku/old-issue-tracker/issues/2445
# comparison complains if either of its arguments is undefined
{
    throws-like {Int < 0}, Exception;
    # https://github.com/Raku/old-issue-tracker/issues/2445
    #?rakudo todo ""
    throws-like {"cat" gt Str}, Exception;
}

# unicode operators are there
{
    is −1, -1, "unary MINUS SIGN";

    is 42−1, 42-1, "infix MINUS SIGN";
    my \a = 42; my \b = 1;
    is a−b, a - b, "infix MINUS SIGN is not considered a hyphen";
    is −a−b, -a - b, "prefix MINUS SIGN works with infix";

    is 2 × 3, 6, "we have infix MULTIPLICATION SIGN";

    #?rakudo.jvm todo 'expected: 0, got: 0.666667'
    is 2 ÷ 3, ⅔, "we have infix DIVISION SIGN";

    ok   4 ≤ 23, 'we have infix LESS-THAN OR EQUAL TO';
    ok  16 ≥  8, 'we have infix GREATER-THAN OR EQUAL TO';
    ok  15 ≠ 42, 'we have infix NOT EQUAL TO';

    nok  4 ≥ 23, 'we have infix LESS-THAN OR EQUAL TO (not always True)';
    nok 16 ≤  8, 'we have infix GREATER-THAN OR EQUAL TO (not always True)';
    nok 42 ≠ 42, 'we have infix NOT EQUAL TO (not always True)';

    ok -5 ≤ -4 ≤ -3, 'unicode op chaining';
    ok  5 ≥  4 ≥  3, 'unicode op chaining';
    ok -3 ≠ -4 ≠  1, 'unicode op chaining';

    ok  4 < 8 ≤ 15 <= 16 != 23 ≠ 42 == 42 ≠ 23 != 16 >= 15 ≥ 8 > 4,
        'unicode ops chain with ASCII ones';
    nok 4 < 8 ≤ 15 <= 16 != 23 ≠ 42 == 42 ≠ 23 != 16 >= 15 ≥ ∞ > 4,
        'unicode ops chain with ASCII ones (not always True)';


    my $DateT := Date.today;
    is-deeply  $DateT.later(:day)   ≥ $DateT.earlier(:day), True,
        'Date ≥ Date (true)';
    is-deeply $DateT.earlier(:day) ≥ $DateT  .later(:day),  False,
        'Date ≥ Date (false)';
    is-deeply  $DateT.earlier(:day) ≤ $DateT  .later(:day), True,
        'Date ≤ Date (true)';
    is-deeply $DateT  .later(:day) ≤ $DateT.earlier(:day),  False,
        'Date ≤ Date (false)';
    is-deeply $DateT.earlier(:day) ≠ $DateT  .later(:day),  True,
        'Date ≠ Date (true)';
    is-deeply Date.new('2015-12-25') ≠ Date.new('2015-12-25'), False,
        'Date ≠ Date (false)';

    my $DateTimeN := DateTime.now;
    is-deeply $DateTimeN  .later(:day) ≥ $DateTimeN.earlier(:day), True,
        'DateTime ≥ DateTime (true)';
    is-deeply $DateTimeN.earlier(:day) ≥ $DateTimeN  .later(:day), False,
        'DateTime ≥ DateTime (false)';
    is-deeply $DateTimeN.earlier(:day) ≤ $DateTimeN  .later(:day), True,
        'DateTime ≤ DateTime (true)';
    is-deeply $DateTimeN  .later(:day) ≤ $DateTimeN.earlier(:day), False,
        'DateTime ≤ DateTime (false)';
    is-deeply $DateTimeN.earlier(:day) ≠ $DateTimeN  .later(:day), True,
        'DateTime ≠ DateTime (true)';
    is-deeply DateTime.new(:2017year)  ≠ DateTime.new(:2017year),  False,
        'DateTime ≠ DateTime (false)';

    is-deeply v42 ≥ v10, True,  'Version ≥ Version (true)';
    is-deeply v10 ≥ v42, False, 'Version ≥ Version (false)';
    is-deeply v10 ≤ v42, True,  'Version ≤ Version (true)';
    is-deeply v42 ≤ v10, False, 'Version ≤ Version (false)';
    is-deeply v42 ≠ v10, True,  'Version ≠ Version (true)';
    is-deeply v42 ≠ v42, False, 'Version ≠ Version (false)';
}

# https://github.com/Raku/old-issue-tracker/issues/6629
is-deeply (0 ≠ 0 | 1 or 42), 42, 'Junctions with ≠ works like for negated ops';

subtest 'does works with non-roles' => {
    plan 3;

    my $o = my class Foo { method Str { 'original' } }.new;
    is $o.Str, 'original', 'original value';

    $o does 'modded';
    is $o.Str, 'modded', '`does` with Str overrode Str method';

    my $mod = my class Bars {}.new;
    $o does $mod;
    is-deeply $o.Bars, $mod, '`does` a custom class adds method from .^name';
}

# https://github.com/rakudo/rakudo/issues/2568
{
    is-deeply 3 ~ ( 5 | "18" ), any("35","318"),
      "does a junction survive ~ Junction";
    is-deeply ( 5 | "18" ) ~ 3, any("53","183"),
      "does a junction survive Junction ~";
    is-deeply ( 5 | "18" ) ~ ( 3 | 6), any("53","56","183",186),
      "does a junction survive Junction ~ Junction";
}

# vim: expandtab shiftwidth=4
