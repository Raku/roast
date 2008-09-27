use v6;

use Test;

plan 39;

#L<S03/Autoincrement precedence>

=begin description

Mostly copied from Perl 5.8.4 s t/op/inc.t

Verify that addition/subtraction properly upgrade to doubles.
These tests are only significant on machines with 32 bit longs,
and two s complement negation, but should not fail anywhere.

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
is($b, ((-$a)-1), "commpare -- to -1 op with same origin var");
is($a, 2147483648, "make sure origin var remains unchanged");

$a = 2147483648;
$b = -$a;
$c=--$b;
is($b, ((-$a)-1), "same thing with predecremenet");

$a = 2147483648;
$b = -$a;
$b= $b - 1;
is($b, -(++$a), 'est oder of predecrement in -(++$a)');

#?rakudo skip 'unimpl undef++'
$a = undef;
is($a++, 0, 'undef++ == 0');

#?rakudo skip 'unimpl undef--'
$a = undef;
ok($a-- ~~ undef, 'undef-- is undefined');

$a = 'x';
is($a++, 'x', 'magical ++ should not be numified');
isa_ok($a, "Str", "it isa Str");

my %a = ('a' => 1);
%a{"a"}++;
is(%a{'a'}, 2, "hash key"); 


my %b = ('b' => 1);
my $var = 'b';
%b{$var}++;
is(%b{$var}, 2, "hash key via var");

my @a = (1);
@a[0]++;
is(@a[0], 2, "array elem"); 

my @b = (1);
my $moo = 0;
@b[$moo]++;
is(@b[$moo], 2, "array elem via var"); 
is($moo, 0, "var was not touched");

# Test that the expression to increment will only be evaluated once.
#?rakudo skip "unimpl Lexically scoped subs"
{
  my $was_in_foo;
  my sub foo () { $was_in_foo++; 0 };

  my @array = (42);

  is(++@array[+foo()], 43, "++ evaluates the expression to increment only once (1)");
  is($was_in_foo,       1, "++ evaluates the expression to increment only once (2)");
}

# Test case courtesy of Limbic_Region
{
    my $curr  = 4;
    my @array = 1..5;
    is @array[$curr], 5, "postincrements in array subscripts work";
    @array[ --$curr ]++;

    is $curr, 3, "postincrements in array subscripts work";
    is @array[$curr], 5, "postincrements in array subscripts work";
}

# test incrementing literals
# all of those can be detected at compile time, so use eval_dies_ok here
{
    eval_dies_ok ' 4++ ', "can't postincrement a literal number";
    eval_dies_ok ' ++4 ', "can't preincrement a literal number";
    eval_dies_ok ' 4-- ', "can't postdecrement a literal number";
    eval_dies_ok ' --4 ', "can't predecrement a literal number";
    eval_dies_ok ' "x"++ ', "can't postincrement a literal string";
    eval_dies_ok ' ++"x" ', "can't preincrement a literal string";
    eval_dies_ok ' "x"-- ', "can't postdecrement a literal string";
    eval_dies_ok ' --"x" ', "can't predecrement a literal string";
}
