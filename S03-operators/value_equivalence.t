use v6;

use Test;

=begin pod

L<S03/"Chaining binary precedence" /Value identity>

C<===> and C<eqv> are 2 distinct operators, where C<===> tests value
equivalence for immutable types and reference equivalence for 
mutable types, and C<eqv> tests value equivalence for snapshots of mutable
types.  So C<(1,2) === (1,2)> returns true but C<[1,2] === [1,2]> returns 
false, and C<[1,2] eqv [1,2]> returns true.

=end pod

plan 51;

# === on values
{
  ok  (1 === 1), "=== on values (1)";
  ok  (0 === 0), "=== on values (2)";
  ok !(0 === 1), "=== on values (3)";
  ok  ("abc" === "abc"), "=== on values(abc)";
  ok !("abc" === "ABC"), "=== on values(abc === ABC)";
  ok !(1 === 1.0), "=== on values (1 === 1.0)";
  ok !(1 === "1"), '=== on values (1 === "1")';
}

# Value types
{
  my $a = 1;
  my $b = 1;

  ok $a === $a, "=== on value types (1-1)";
  ok $b === $b, "=== on value types (1-2)";
  ok $a === $b, "=== on value types (1-3)";
}

{
  my $a = 1;
  my $b = 2;

  ok  ($a === $a), "=== on value types (2-1)";
  ok  ($b === $b), "=== on value types (2-2)";
  ok !($a === $b), "=== on value types (2-3)";
}

# Reference types
{
  my @a = (1,2,3);
  my @b = (1,2,3);

  ok  (\@a === \@a), "=== on array references (1)";
  ok  (\@b === \@b), "=== on array references (2)";
  ok !(\@a === \@b), "=== on array references (3)";
}

{
  my $a = \3;
  my $b = \3;

  ok  ($a === $a), "=== on scalar references (1-1)";
  ok  ($b === $b), "=== on scalar references (1-2)";
  #?rakudo todo 'scalar reference equivalence'
  ok !($a === $b), "=== on scalar references (1-3)";
}

{
  my $a = { 3 };
  my $b = { 3 };

  ok  ($a === $a), "=== on sub references (1-1)";
  ok  ($b === $b), "=== on sub references (1-2)";
  ok !($a === $b), "=== on sub references (1-3)";
}

{
  ok  (&say === &say), "=== on sub references (2-1)";
  ok  (&map === &map), "=== on sub references (2-2)";
  ok !(&say === &map), "=== on sub references (2-3)";
}

{
  my $num = 3;
  my $a   = \$num;
  my $b   = \$num;

  ok  ($a === $a), "=== on scalar references (2-1)";
  ok  ($b === $b), "=== on scalar references (2-2)";
  ok  ($a === $b), "=== on scalar references (2-3)";
}

{
  ok !([1,2,3] === [4,5,6]), "=== on anonymous array references (1)";
  ok !([1,2,3] === [1,2,3]), "=== on anonymous array references (2)";
  ok !([]      === []),      "=== on anonymous array references (3)";
}

{
  ok !({a => 1} === {a => 2}), "=== on anonymous hash references (1)";
  ok !({a => 1} === {a => 1}), "=== on anonymous hash references (2)";
}

{
  ok !(\3 === \4),         "=== on anonymous scalar references (1)";
  #?rakudo todo 'scalar reference equivalence'
  ok !(\3 === \3),         "=== on anonymous scalar references (2)";
  ok !(\undef === \undef), "=== on anonymous scalar references (3)";
}

# Chained === (not specced, but obvious)
{
  ok  (3 === 3 === 3), "chained === (1)";
  ok !(3 === 3 === 4), "chained === (2)";
}

# Subparam binding doesn't affect === test
#?rakudo skip 'pointy blocks as expressions'
{
  my $foo;
  my $test = -> $arg { $foo === $arg };

  $foo = 3;
  ok  $test($foo), "subparam binding doesn't affect === (1)";
  ok  $test(3),    "subparam binding doesn't affect === (2)";

  ok !$test(4),    "subparam binding doesn't affect === (3)";
  my $bar = 4;
  ok !$test($bar), "subparam binding doesn't affect === (4)";
}

{
    my $a = 1;
    my $b = 2;
    is($a === $a, Bool::True,  '=== returns Bool::True when true');
    is($a === $b, Bool::False, '=== returns Bool::False when false');
}

# L<S03/"Chaining binary precedence" /Negated relational operators>
{
  ok !(1 !=== 1), "!=== on values (1)";
  ok !(0 !=== 0), "!=== on values (2)";
  ok  (1 !=== 0), "!=== on values (3)";
  ok !("abc" !=== "abc"), "!=== on values(abc)";
  ok  ("abc" !=== "ABC"), "!=== on values(abc !=== ABC)";
  ok  (1 !=== 1.0), "!=== on values (1 !=== 1.0)";
  ok  (1 !=== "1"), '!=== on values (1 !=== "1")';
}
