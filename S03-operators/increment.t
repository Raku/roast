use Test;

plan 41;

#L<S03/Autoincrement precedence>

=begin description

Verify that autoincrement/autodecrement work properly.
(Overflow cases are handled in S03-operators/overflow.t)

=end description

{
    my $a = Mu;
    is($a++, 0, 'Mu++ == 0');

    $a = Mu;
    is $a--, 0 , 'postincrement (& decrement) returns 0 the first time';

    $a = 'z';
    is($a++, 'z', 'magical ++ should not be numified');
    isa-ok($a, "Str", "it isa Str");
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
# all of those can be detected at compile time
{
    throws-like ' 4++ ', X::Multi::NoMatch, "can't postincrement a literal number";
    throws-like ' ++4 ', X::Multi::NoMatch, "can't preincrement a literal number";
    throws-like ' 4-- ', X::Multi::NoMatch, "can't postdecrement a literal number";
    throws-like ' --4 ', X::Multi::NoMatch, "can't predecrement a literal number";
    throws-like ' "x"++ ', X::Multi::NoMatch, "can't postincrement a literal string";
    throws-like ' ++"x" ', X::Multi::NoMatch, "can't preincrement a literal string";
    throws-like ' "x"-- ', X::Multi::NoMatch, "can't postdecrement a literal string";
    throws-like ' --"x" ', X::Multi::NoMatch, "can't predecrement a literal string";
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
    is $x.succ, Bool::True, '.succ on False works';

    $x = Bool::True;
    is --$x, Bool::False, '-- on True works';
    $x = Bool::True;
    is $x.pred, Bool::False, '.succ on False works';
}

# https://github.com/Raku/old-issue-tracker/issues/1747
throws-like 'my $x = 0; ++++$x', X::Multi::NoMatch,
    'can not double-increment, because the return value is not a container';

{
    is state $i++, 0, '++ is allowed on declarator';
    is $i, 1, '...and actually increments variable';
    is my $j.++, 0, '.++ is allowed on declarator';
    is $j, 1, '...and actually increments variable';
    is my $k.defined, False, 'method is allowed on declarator';
}

{ # coverage; 2016-09-19
    my $i;
    is --$i, -1, 'prefix:<--> on Any:U returns -1';
    is   $i, -1, 'prefix:<--> on Any:U makes it -1';
}

# https://github.com/rakudo/rakudo/issues/3379
{
    my $a = "⁰";
    is (^101).map({$a++}),
      '⁰ ¹ ² ³ ⁴ ⁵ ⁶ ⁷ ⁸ ⁹ ¹⁰ ¹¹ ¹² ¹³ ¹⁴ ¹⁵ ¹⁶ ¹⁷ ¹⁸ ¹⁹ ²⁰ ²¹ ²² ²³ ²⁴ ²⁵ ²⁶ ²⁷ ²⁸ ²⁹ ³⁰ ³¹ ³² ³³ ³⁴ ³⁵ ³⁶ ³⁷ ³⁸ ³⁹ ⁴⁰ ⁴¹ ⁴² ⁴³ ⁴⁴ ⁴⁵ ⁴⁶ ⁴⁷ ⁴⁸ ⁴⁹ ⁵⁰ ⁵¹ ⁵² ⁵³ ⁵⁴ ⁵⁵ ⁵⁶ ⁵⁷ ⁵⁸ ⁵⁹ ⁶⁰ ⁶¹ ⁶² ⁶³ ⁶⁴ ⁶⁵ ⁶⁶ ⁶⁷ ⁶⁸ ⁶⁹ ⁷⁰ ⁷¹ ⁷² ⁷³ ⁷⁴ ⁷⁵ ⁷⁶ ⁷⁷ ⁷⁸ ⁷⁹ ⁸⁰ ⁸¹ ⁸² ⁸³ ⁸⁴ ⁸⁵ ⁸⁶ ⁸⁷ ⁸⁸ ⁸⁹ ⁹⁰ ⁹¹ ⁹² ⁹³ ⁹⁴ ⁹⁵ ⁹⁶ ⁹⁷ ⁹⁸ ⁹⁹ ¹⁰⁰',
      'did we get correct increments on ⁰';

    is (^101).map({--$a}),
      '¹⁰⁰ ⁰⁹⁹ ⁰⁹⁸ ⁰⁹⁷ ⁰⁹⁶ ⁰⁹⁵ ⁰⁹⁴ ⁰⁹³ ⁰⁹² ⁰⁹¹ ⁰⁹⁰ ⁰⁸⁹ ⁰⁸⁸ ⁰⁸⁷ ⁰⁸⁶ ⁰⁸⁵ ⁰⁸⁴ ⁰⁸³ ⁰⁸² ⁰⁸¹ ⁰⁸⁰ ⁰⁷⁹ ⁰⁷⁸ ⁰⁷⁷ ⁰⁷⁶ ⁰⁷⁵ ⁰⁷⁴ ⁰⁷³ ⁰⁷² ⁰⁷¹ ⁰⁷⁰ ⁰⁶⁹ ⁰⁶⁸ ⁰⁶⁷ ⁰⁶⁶ ⁰⁶⁵ ⁰⁶⁴ ⁰⁶³ ⁰⁶² ⁰⁶¹ ⁰⁶⁰ ⁰⁵⁹ ⁰⁵⁸ ⁰⁵⁷ ⁰⁵⁶ ⁰⁵⁵ ⁰⁵⁴ ⁰⁵³ ⁰⁵² ⁰⁵¹ ⁰⁵⁰ ⁰⁴⁹ ⁰⁴⁸ ⁰⁴⁷ ⁰⁴⁶ ⁰⁴⁵ ⁰⁴⁴ ⁰⁴³ ⁰⁴² ⁰⁴¹ ⁰⁴⁰ ⁰³⁹ ⁰³⁸ ⁰³⁷ ⁰³⁶ ⁰³⁵ ⁰³⁴ ⁰³³ ⁰³² ⁰³¹ ⁰³⁰ ⁰²⁹ ⁰²⁸ ⁰²⁷ ⁰²⁶ ⁰²⁵ ⁰²⁴ ⁰²³ ⁰²² ⁰²¹ ⁰²⁰ ⁰¹⁹ ⁰¹⁸ ⁰¹⁷ ⁰¹⁶ ⁰¹⁵ ⁰¹⁴ ⁰¹³ ⁰¹² ⁰¹¹ ⁰¹⁰ ⁰⁰⁹ ⁰⁰⁸ ⁰⁰⁷ ⁰⁰⁶ ⁰⁰⁵ ⁰⁰⁴ ⁰⁰³ ⁰⁰² ⁰⁰¹ ⁰⁰⁰',
      'did we get correct decrements on ¹⁰⁰';
}

# vim: expandtab shiftwidth=4
