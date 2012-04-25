use v6;
use Test;

plan 52;

# L<S03/Comparison semantics/Binary eqv tests equality much like === does>
# L<S32::Basics/Any/"=item eqv">

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

#?rakudo skip 'binding NYI'
#?niecza skip 'Cannot use value like Capture as a number'
{
  my @a = (1,2,3);
  my @b = (1,2,3);

  ok  (\@a eqv \@a), "eqv on array references (1)";
  ok  (\@b eqv \@b), "eqv on array references (2)";
  #?pugs todo
  ok !(\@a eqv \@b), "eqv on array references (3)";
  @a := @b;
  ok \@a eqv \@b, '\@array of two bound arrays are eqv';
}

#?niecza skip 'Cannot use value like Capture as a number'
{
  my $a = \3;
  my $b = \3;

  ok ($a eqv $a), "eqv on scalar references (1-1)";
  ok ($b eqv $b), "eqv on scalar references (1-2)";
  ok ($a eqv $b), "eqv on scalar references (1-3)";
  #?rakudo skip 'infix:<!eqv>'
  #?pugs todo
  ok (\$a !eqv \$b), "eqv on scalar references (1-4)";
}

#?niecza skip 'Cannot use value like Block as a number'
{
  my $a = { 3 };
  my $b = { 3 };

  ok ($a eqv $a), "eqv on sub references (1-1)";
  ok ($b eqv $b), "eqv on sub references (1-2)";
  # it's impossible to compare blocks for equivalence in general,
  # and they have associations to different source locations
  # (line number, column)
  nok ($a eqv $b), "eqv on sub references (1-3)";
  nok ($a eqv { 5 }), 'eqv on sub references (1-4)';
}

#?niecza skip 'Cannot use value like Sub as a number'
{
  ok  (&say eqv &say), "eqv on sub references (2-1)";
  ok  (&map eqv &map), "eqv on sub references (2-2)";
  ok !(&say eqv &map), "eqv on sub references (2-3)";
}

#?niecza skip 'Cannot use value like Capture as a number'
{
  my $num = 3; my $a   = \$num;
  my $b   = \$num;

  ok  ($a eqv $a), "eqv on scalar references (2-1)";
  ok  ($b eqv $b), "eqv on scalar references (2-2)";
  ok  ($a eqv $b), "eqv on scalar references (2-3)";
}

{
  #?niecza todo
  nok ([1,2,3] eqv [4,5,6]), "eqv on anonymous array references (1)";
  ok ([1,2,3] eqv [1,2,3]), "eqv on anonymous array references (2)";
  ok ([]      eqv []),      "eqv on anonymous array references (3)";
}

{
  #?niecza todo
  ok !({a => 1} eqv {a => 2}), "eqv on anonymous hash references (-)";
  #?pugs todo
  ok  ({a => 1} eqv {a => 1}), "eqv on anonymous hash references (+)";
  #?pugs todo
  ok ({a => 2, b => 1} eqv { b => 1, a => 2}), 'order really does not matter'; 
  ok !({a => 1} eqv {a => 1, b => 2}), 'hashes: different number of pairs';
}

#?rakudo skip 'captures'
#?niecza skip 'Cannot use value like Capture as a number'
{
  ok !(\3 eqv \4),         "eqv on anonymous scalar references (1)";
  # XXX the following seems bogus nowadays
  #?pugs 2 todo
  ok !(\3 eqv \3),         "eqv on anonymous scalar references (2)";
  ok !(\Mu eqv \Mu), "eqv on anonymous scalar references (3)";
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

{
    is Any eqv Any, Bool::True, 'Any eqv Any';
}

#?pugs skip "autothreaded?"
{
    ok 'a' eqv any <a b c>, "eqv autothreads correctly";
}

# RT #75322 - Rakudo used to be confused when lists began with ()
{
    #?niecza todo
    nok ((), "x") eqv ((), 9), 'list starting with () - 1';
    nok ((), (), 1) eqv ((), 9), 'list starting with () - 1';
    nok ((), (), (), 1) eqv ((), (), ""), 'list starting with () - 1';
    nok ((), (), (), 1) eqv ((), 4), 'list starting with () - 1';
    ok ((), ()) eqv ((), ()), '((), ())';
}

# vim: ft=perl6
