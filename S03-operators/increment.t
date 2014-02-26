use v6;

use Test;

plan 32;

#L<S03/Autoincrement precedence>

=begin description

Verify that autoincrement/autodecrement work properly.
(Overflow cases are handled in S03-operators/overflow.t)

=end description

{
    my $a = Mu;
    is($a++, 0, 'Mu++ == 0');

    #?niecza todo '#88'
    $a = Mu;
    is $a--, 0 , 'postincrement (& decrement) returns 0 the first time';

    $a = 'z';
    is($a++, 'z', 'magical ++ should not be numified');
    isa_ok($a, "Str", "it isa Str");
    is $a, 'aa', 'magical ++ is carrying properly';
}

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

# this used to be a rakudo regression
{
    my $x = 2.0;
    $x += 1;
    ok $x == 3.0, 'can add Int to Rat with +=';

    my Rat $y = 2.0;
    $y += 1;
    ok $y == 3.0, 'can add Int to Rat with += and type constraint';
}

{
    my $x = 2.0.Num;
    $x += 1;
    ok $x == 3.0, 'can add Int to Num with +=';

    my Num $y = 2.0.Num;
    $y += 1;
    ok $y == 3.0, 'can add Int to Num with += and type constraint';
}

# also a Rakudo regression
{
    my $x = Bool::False;
    is ++$x, Bool::True, '++ on False works';
    $x = Bool::False;
    #?pugs skip '.succ'
    is $x.succ, Bool::True, '.succ on False works';

    $x = Bool::True;
    #?pugs todo
    is --$x, Bool::False, '-- on True works';
    $x = Bool::True;
    #?pugs skip '.pred'
    is $x.pred, Bool::False, '.succ on False works';
}

# RT #74912
#?niecza todo 'Works fine in niecza...'
eval_dies_ok 'my $x = 0; ++++$x',
    'can not double-increment, because the return value is not a container';

# vim: ft=perl6
