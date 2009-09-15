use v6;

use Test;

plan 25;

#L<S03/Autoincrement precedence>

=begin description

Mostly copied from Perl 5.8.4 s t/op/inc.t

Verify that addition/subtraction properly handle "overflow"
conditions on common architectures.  The current tests are
significant on machines with 32-bit longs, but should not
fail anywhere.

=end description

my $a = 2147483647;
my $c=$a++;
is($a, 2147483648, "var incremented after post-autoincrement");
is($c, 2147483647, "during post-autoincrement return value is not yet incremented");

$a = 2147483647;
$c=++$a;
is($a, 2147483648, "var incremented  after pre-autoincrement");
is($c, 2147483648, "during pre-autoincrement return value is incremented");

$a = 2147483647;
$a=$a+1;
is($a, 2147483648, 'simple assignment: $a = $a+1');

$a = -2147483648;
$c=$a--;
is($a, -2147483649, "var decremented after post-autodecrement");
is($c, -2147483648, "during post-autodecrement return value is not yet decremented");

$a = -2147483648;
$c=--$a;
is($a, -2147483649, "var decremented  after pre-autodecrement");
is($c, -2147483649, "during pre-autodecrement return value is decremented");

$a = -2147483648;
$a=$a-1;
is($a, -2147483649, 'simple assignment: $a = $a-1');

$a = 2147483648;
$a = -$a;
$c=$a--;
is($a, -2147483649, "post-decrement negative value");

$a = 2147483648;
$a = -$a;
$c=--$a;
is($a, -2147483649, "pre-decrement negative value");

$a = 2147483648;
$a = -$a;
$a=$a-1;
is($a, -2147483649, 'assign $a = -$a; $a = $a-1');

$a = 2147483648;
my $b = -$a;
$c=$b--;

is($b, ((-$a)-1), "compare -- to -1 op with same origin var");
is($a, 2147483648, "make sure origin var remains unchanged");

$a = 2147483648;
$b = -$a;
$c=--$b;
is($b, ((-$a)-1), "same thing with predecremenet");

$a = 2147483648;
$b = -$a;
$b= $b - 1;
is($b, -(++$a), 'est oder of predecrement in -(++$a)');

#?rakudo skip "Big number issues with div"
{
    is(0x80000000 div 1, 0x80000000, "0x80000000 div 1 == 0x80000000");
    is(0x80000000 div -1, -0x80000000, "0x80000000 div -1 == -0x80000000");
    is(-0x80000000 div 1, -0x80000000, "-0x80000000 div 1 == -0x80000000");
    is(-0x80000000 div -1, 0x80000000, "-0x80000000 div -1 == 0x80000000");
    is 18446744073709551616 div 1, 18446744073709551616;
    is 18446744073709551616 div 2, 9223372036854775808, "Bignums are not working yet";
    is 18446744073709551616 div 4294967296, 4294967296, "Bignums are not working yet";
    ok 18446744073709551616 div 9223372036854775808 == 2, '$bignum1 div $bignum2';
}


# vim: ft=perl6
