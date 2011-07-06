use v6;
use Test;

plan 53;

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
{
  my @a = (1,2,3);
  my @b = (1,2,3);

  ok  (\@a eqv \@a), "eqv on array references (1)";
  ok  (\@b eqv \@b), "eqv on array references (2)";
  ok !(\@a eqv \@b), "eqv on array references (3)";
  @a := @b;
  ok \@a eqv \@b, '\@array of two bound arrays are eqv';
}

#?rakudo skip 'backslashes'
{
  my $a = \3;
  my $b = \3;

  ok ($a eqv $a), "eqv on scalar references (1-1)";
  ok ($b eqv $b), "eqv on scalar references (1-2)";
  ok ($a eqv $b), "eqv on scalar references (1-3)";
  #?rakudo skip 'infix:<!eqv>'
  ok (\$a !eqv \$b), "eqv on scalar references (1-4)";
}

#?
{
  my $a = { 3 };
  my $b = { 3 };

  ok ($a eqv $a), "eqv on sub references (1-1)";
  ok ($b eqv $b), "eqv on sub references (1-2)";
  #?rakudo todo 'eqv on sub-refs'
  ok ($a eqv $b), "eqv on sub references (1-3)";
  ok !($a eqv { 5 }), 'eqv on sub references (1-4)';
}

{
  ok  (&say eqv &say), "eqv on sub references (2-1)";
  ok  (&map eqv &map), "eqv on sub references (2-2)";
  ok !(&say eqv &map), "eqv on sub references (2-3)";
}

{
  my $num = 3; my $a   = \$num;
  my $b   = \$num;

  ok  ($a eqv $a), "eqv on scalar references (2-1)";
  ok  ($b eqv $b), "eqv on scalar references (2-2)";
  ok  ($a eqv $b), "eqv on scalar references (2-3)";
}

{
  ok !([1,2,3] eqv [4,5,6]), "eqv on anonymous array references (1)";
  ok ([1,2,3] eqv [1,2,3]), "eqv on anonymous array references (2)";
  ok ([]      eqv []),      "eqv on anonymous array references (3)";
}

{
  ok !({a => 1} eqv {a => 2}), "eqv on anonymous hash references (-)";
  ok  ({a => 1} eqv {a => 1}), "eqv on anonymous hash references (+)";
  ok ({a => 2, b => 1} eqv { b => 1, a => 2}), 'order really does not matter'; 
  ok !({a => 1} eqv {a => 1, b => 2}), 'hashes: different number of pairs';
}

#?rakudo skip 'captures'
{
  ok !(\3 eqv \4),         "eqv on anonymous scalar references (1)";
  # XXX the following seems bogus nowadays
  #?pugs 2 todo 'bug'
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
    is Mu eqv Mu, Bool::True, 'Mu eqv Mu';
    is Any eqv Any, Bool::True, 'Any eqv Any';
    is Any eqv Mu, Bool::False, 'Any !eqv Mu';
}

# RT #75322 - Rakudo used to be confused when lists began with ()
{
    nok ((), "x") eqv ((), 9), 'list starting with () - 1';
    nok ((), (), 1) eqv ((), 9), 'list starting with () - 1';
    nok ((), (), (), 1) eqv ((), (), ""), 'list starting with () - 1';
    nok ((), (), (), 1) eqv ((), 4), 'list starting with () - 1';
    ok ((), ()) eqv ((), ()), '((), ())';
}

# vim: ft=perl6
