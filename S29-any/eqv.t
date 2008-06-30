use v6;
use Test;

plan 40;

# L<S03/Comparison semantics/Binary eqv tests equality much like === does>
# L<S29/Any/"=item eqv">

# eqv on values
{
  ok  (1 eqv 1), "eqv on values (1)";
  ok  (0 eqv 0), "eqv on values (2)";
  ok !(0 eqv 1), "eqv on values (3)";
}

# Value types
{
  my $a = 1;
  my $b = 1;

  ok $a eqv $a, "eqv on value types (1-1)";
  ok $b eqv $b, "eqv on value types (1-2)";
  ok $a eqv $b, "eqv on value types (1-3)";
}


{
  my $a = 1;
  my $b = 2;

  ok  ($a eqv $a), "eqv on value types (2-1)";
  ok  ($b eqv $b), "eqv on value types (2-2)";
  ok !($a eqv $b), "eqv on value types (2-3)";
}

# Reference types
{
  my @a = (1,2,3);
  my @b = (1,2,3);

  ok  (\@a eqv \@a), "eqv on array references (1)";
  ok  (\@b eqv \@b), "eqv on array references (2)";
  #?pugs todo 'bug'
  ok !(\@a eqv \@b), "eqv on array references (3)";
}

{
  my $a = \3;
  my $b = \3;

  ok  ($a eqv $a), "eqv on scalar references (1-1)";
  ok  ($b eqv $b), "eqv on scalar references (1-2)";
  #?pugs todo 'bug'
  ok !($a eqv $b), "eqv on scalar references (1-3)";
}

{
  my $a = { 3 };
  my $b = { 3 };

  ok  ($a eqv $a), "eqv on sub references (1-1)";
  ok  ($b eqv $b), "eqv on sub references (1-2)";
  ok !($a eqv $b), "eqv on sub references (1-3)";
}

{
  ok  (&say eqv &say), "eqv on sub references (2-1)";
  ok  (&map eqv &map), "eqv on sub references (2-2)";
  ok !(&say eqv &map), "eqv on sub references (2-3)";
}

{
  my $num = 3;
  my $a   = \$num;
  my $b   = \$num;

  ok  ($a eqv $a), "eqv on scalar references (2-1)";
  ok  ($b eqv $b), "eqv on scalar references (2-2)";
  ok  ($a eqv $b), "eqv on scalar references (2-3)";
}

{
  ok !([1,2,3] eqv [4,5,6]), "eqv on anonymous array references (1)";
  #?pugs 2 todo 'bug'
  ok !([1,2,3] eqv [1,2,3]), "eqv on anonymous array references (2)";
  ok !([]      eqv []),      "eqv on anonymous array references (3)";
}

{
  ok !({a => 1} eqv {a => 2}), "eqv on anonymous hash references (1)";
  ok !({a => 1} eqv {a => 1}), "eqv on anonymous hash references (2)";
}

{
  ok !(\3 eqv \4),         "eqv on anonymous scalar references (1)";
  #?pugs 2 todo 'bug'
  ok !(\3 eqv \3),         "eqv on anonymous scalar references (2)";
  ok !(\undef eqv \undef), "eqv on anonymous scalar references (3)";
}

# Chained eqv (not specced, but obvious)
{
  ok  (3 eqv 3 eqv 3), "chained eqv (1)";
  ok !(3 eqv 3 eqv 4), "chained eqv (2)";
}

# Subparam binding doesn't affect eqv test
{
  my $foo;
  my $test = -> $arg { $foo eqv $arg };

  $foo = 3;
  ok  $test($foo), "subparam binding doesn't affect eqv (1)";
  ok  $test(3),    "subparam binding doesn't affect eqv (2)";

  ok !$test(4),    "subparam binding doesn't affect eqv (3)";
  my $bar = 4;
  ok !$test($bar), "subparam binding doesn't affect eqv (4)";
}

{
    is(1 eqv 1, Bool::True,  'eqv returns Bool::True when true');
    is(0 eqv 1, Bool::False, 'eqv returns Bool::False when false');
}
