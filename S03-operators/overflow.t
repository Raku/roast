use v6;

use Test;

plan 17;

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
#?rakudo todo 'detect integer overflow/underflow'
is($a, 2147483648, "var incremented after post-autoincrement");
is($c, 2147483647, "during post-autoincrement return value is not yet incremented");

$a = 2147483647;
$c=++$a;
#?rakudo 2 todo 'detect integer overflow/underflow'
is($a, 2147483648, "var incremented  after pre-autoincrement");
is($c, 2147483648, "during pre-autoincrement return value is incremented");

$a = 2147483647;
$a=$a+1;
is($a, 2147483648, 'simple assignment: $a = $a+1');

$a = -2147483648;
$c=$a--;
#?rakudo todo 'detect integer overflow/underflow'
is($a, -2147483649, "var decremented after post-autodecrement");
is($c, -2147483648, "during post-autodecrement return value is not yet decremented");

$a = -2147483648;
$c=--$a;
#?rakudo 2 todo 'detect integer overflow/underflow'
is($a, -2147483649, "var decremented  after pre-autodecrement");
is($c, -2147483649, "during pre-autodecrement return value is decremented");

$a = -2147483648;
$a=$a-1;
is($a, -2147483649, 'simple assignment: $a = $a-1');

$a = 2147483648;
$a = -$a;
$c=$a--;
#?rakudo todo 'detect integer overflow/underflow'
is($a, -2147483649, "post-decrement negative value");

$a = 2147483648;
$a = -$a;
$c=--$a;
#?rakudo todo 'detect integer overflow/underflow'
is($a, -2147483649, "pre-decrement negative value");

$a = 2147483648;
$a = -$a;
$a=$a-1;
is($a, -2147483649, 'assign $a = -$a; $a = $a-1');

$a = 2147483648;
my $b = -$a;
$c=$b--;

#?rakudo todo 'detect integer overflow/underflow'
is($b, ((-$a)-1), "compare -- to -1 op with same origin var");
is($a, 2147483648, "make sure origin var remains unchanged");

$a = 2147483648;
$b = -$a;
$c=--$b;
#?rakudo todo 'detect integer overflow/underflow'
is($b, ((-$a)-1), "same thing with predecremenet");

$a = 2147483648;
$b = -$a;
$b= $b - 1;
is($b, -(++$a), 'est oder of predecrement in -(++$a)');

