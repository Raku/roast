use v6;

use Test;

plan 15;

{
  my $a is dynamic = 9;
  my $sub = sub { $CALLER::a };

  {
    my $a is dynamic = 3;
    is $sub(), 3, 'basic $CALLER:: works';
  }
} #1

{
  my $a is dynamic = 9;
  my $sub2 = sub { $CALLER::a };
  my $sub1 = sub {
    my $a is dynamic = 10;
    $sub2();
  };

  {
    my $a is dynamic = 11;
    is $sub1(), 10, '$CALLER:: with nested subs works';
  }
} #1

{
  my $get_caller = sub { return sub { $CALLER::CALLER::a } };
  my $sub1 = sub {
    my $a is dynamic = 3;
    $get_caller();
  };
  my $sub2 = sub {
    my $a is dynamic = 5;
    $get_caller();
  };

  my $result_of_sub1 = $sub1();
  my $result_of_sub2 = $sub2();

  # We can't use the more elegant dies_ok here as it would influence $CALLER::
  # calculation.
  ok !(try { $result_of_sub1() }), '$CALLER::CALLER:: is recalculated on each access (1)';
  ok !(try { $result_of_sub2() }), '$CALLER::CALLER:: is recalculated on each access (2)';
} #2

# L<S02/Names/The CALLER package refers to the lexical scope>
{
  # $_ is always implicitly declared "is dynamic".
  my sub foo () { $CALLER::_ }
  my sub bar () {
    $_ = 42;
    foo();
  }

  $_ = 23;
  is bar(), 42, '$_ is implicitly declared "is dynamic" (1)';
} #1

{
  # $_ is always implicitly declared "is dynamic".
  # (And, BTW, $_ is lexical.)
  my sub foo () { $_ = 17; $CALLER::_ }
  my sub bar () {
    $_ = 42;
    foo();
  }

  $_ = 23;
  is bar(), 42, '$_ is implicitly declared "is dynamic" (2)';
} #1

#?pugs skip 'Cannot cast from VStr "success" to VCode (VCode)'
{
  # ...but other vars are not
  my sub foo { my $abc = 17; $CALLER::abc }	#OK not used
  my sub bar {
    my $abc = 42;	#OK not used
    foo();
    'success'
  }

  my $abs = 23;
  #?niecza todo 'strictness'
  nok (try bar()) eq 'success',
    'vars not declared "is dynamic" are not accessible via $CALLER::';
} #1

# Vars declared with "is dynamic" default to being rw in the creating scope and
# readonly when accessed with $CALLER::.
{
  my $foo is dynamic = 42;
  $foo++;
  is $foo, 43, '"is dynamic" vars are rw in the creating scope (1)';
} #1

{
  my $foo is dynamic = 42;
  { $foo++ }
  is $foo, 43, '"is dynamic" vars are rw in the creating scope (2)';
} #1

#?pugs skip "Can't modify constant item: VInt 42"
{
  my sub modify { $CALLER::foo++; 'success' }
  my $foo is dynamic ::= 42;
  nok (try modify()) eq 'success', '"::=" vars are ro when accessed with $CALLER::';
} #1

{
  my sub modify { $CALLER::_++ }
  $_ = 42;
  modify();
  is $_, 43,             '$_ is implicitly rw (2)';
} #1

{
  my sub modify { $CALLER::foo++ }
  my $foo is dynamic = 42;
  modify();
  is $foo, 43,
      '"is dynamic" vars declared "is rw" are rw when accessed with $CALLER:: (2)';
} #1

{
  my sub get_foo { try { $DYNAMIC::foo } }
  my $foo is dynamic = 42;

  #?pugs todo
  is get_foo(), 42, '$DYNAMIC:: searches call stack';
} #1

# Rebinding caller's variables -- legal?
{
  my $other_var = 23;
  my sub rebind_foo { $CALLER::foo := $other_var }
  my $foo is dynamic = 42;

  rebind_foo();
  is $foo, 23,               'rebinding $CALLER:: variables works (2)';
  $other_var++;
  is $foo, 24,               'rebinding $CALLER:: variables works (3)';
} #2

# vim: ft=perl6
