use v6;

use Test;

=begin kwid

Tests for Synopsis 3
=end kwid

plan 33;

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

# L<S03/Traversing arrays in parallel/"but a short list may always be extended arbitrarily">
#?rakudo todo "nom regression"
#?niecza skip 'TODO'
{
    is (1, 2, * Z <a b c d>).join('|'),
       '1|a|2|b|2|c|2|d',
       'A * as the last value extends lists for infix:<Z> (zip)';
}

# L<S03/List infix precedence/"the zip operator">
#for RT #73836
my @z=2,3;
is (2 Z 3), @z, 'joining of single items';

# vim: ft=perl6
