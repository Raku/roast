use v6;

use Test;

plan 45;

# C<=:=> is only for containers, not values

#L<S03/Item assignment precedence/"There is also an identity test">

{
  my $foo = 1;
  my $bar = 1;
  ok  ($foo =:= $foo), '$foo =:= $foo is true';
  ok  ($bar =:= $bar), '$bar =:= $bar is true';
  ok !($foo =:= $bar), '$foo =:= $bar is false';
  ok ($foo =:= $foo) ~~ Bool, 'success returns a Bool';
  ok ($foo =:= $bar) ~~ Bool, 'failure returns a Bool';
}

{
  my $f = sub {};
  ok $f =:= $f,        '$subref =:= $subref is true';
  ok &say =:= &say,    '&sub =:= &sub is true';
  ok !($f =:= &say),   '$subref1 =:= $subref2 is false';
}

{
  my ($a, $b, $c, $d);

  ok !($a =:= $b),     "basic sanity";

  $b := $a;
  ok  ($a =:= $b),     "=:= is true after rebinding (1-1)";
  ok  ($a =:= $a),     "=:= is true after rebinding (1-2)";
  ok  ($b =:= $b),     "=:= is true after rebinding (1-3)";

  $c := $b;
  ok  ($c =:= $a),     "=:= is true after rebinding (2-1)";
  ok  ($c =:= $b),     "=:= is true after rebinding (2-2)";
  ok  ($c =:= $c),     "=:= is true after rebinding (2-3)";

  $c := $d;
  ok !($c =:= $a),     "=:= is true after rebinding (3-1)";
  ok !($c =:= $b),     "=:= is true after rebinding (3-2)";
  ok  ($c =:= $c),     "=:= is true after rebinding (3-3)";
  ok  ($a =:= $b),     "=:= is true after rebinding (3-4)";
  ok  ($a =:= $a),     "=:= is true after rebinding (3-5)";
  ok  ($b =:= $b),     "=:= is true after rebinding (3-6)";
}

# Rebinding of array elements - unspecced!
{
  my @a = (1,2,3);
  my @b = (1,2,3);

  ok !(@b[1] =:= @a[1]), "rebinding of array elements (1)";

  try { @b[1] := @a[1] };
  ok  (@b[1] =:= @a[1]), "rebinding of array elements (2)";

  @b = (1,2,3);
  ok !(@b[1] =:= @a[1]), "assignment destroyed the bindings (1)";
  @a[1] = 100;
  is @a[1], 100,         "assignment destroyed the bindings (2)";
  is @b[1], 2,           "assignment destroyed the bindings (3)";
}

# Subparam binding
{
  my ($foo, $bar);
  my $test = -> $arg is rw { $foo =:= $arg };

  ok  $test($foo), "binding of scalar subparam retains =:= (1)";
  ok !$test($bar), "binding of scalar subparam retains =:= (2)";
  $bar := $foo;
  ok  $test($bar), "binding of scalar subparam retains =:= (3)";
}

{
  my ($foo, $bar);
  my $test = -> $arg is rw { $foo =:= $arg };

  ok  $test($foo), "binding of scalar subparam marked is rw retains =:= (1)";
  ok !$test($bar), "binding of scalar subparam marked is rw retains =:= (2)";
  $bar := $foo;
  ok  $test($bar), "binding of scalar subparam marked is rw retains =:= (3)";
}

# Again, unspecced that @args[0] can participate in =:=
{
  my ($foo, $bar);
  my $test = -> *@args { $foo =:= @args[0] };

  #?pugs todo 'unspecced'
  #?rakudo todo 'unspecced'
  ok  $test($foo), "binding of slurpy array subparam retains =:= (1)";
  ok !$test($bar), "binding of slurpy array subparam retains =:= (2)";
  $bar := $foo;
  #?pugs todo 'unspecced'
  #?rakudo todo 'unspecced'
  ok  $test($bar), "binding of slurpy array subparam retains =:= (3)";
}

# Again, unspecced that @args[0] can participate in =:=
{
  my ($foo, $bar);
  my $test = sub { $foo =:= @_[0] };

  #?pugs todo 'unspecced'
  #?rakudo todo 'unspecced'
  ok  $test($foo), "binding of implicit @_ subparam retains =:= (1)";
  ok !$test($bar), "binding of implicit @_ subparam retains =:= (2)";
  $bar := $foo;
  #?pugs todo 'unspecced'
  #?rakudo todo 'unspecced'
  ok  $test($bar), "binding of implicit @_ subparam retains =:= (3)";
}

class TestObj { has $!a }


{
  my $foo = ::TestObj.new(:a<3>);
  my $bar = ::TestObj.new(:a<3>);
  my $baz = $foo;
  my $frop := $foo;

  ok(!($foo =:= $bar), "two identical objects are not the same object");
  ok(!($foo =:= $baz), "two references to one object are still not the same object");
  ok(($foo =:= $frop), "binding makes two objects the same object");
}

#?rakudo todo 'misuse of =:='
#?niecza skip 'Failure NYI'
#?pugs   skip 'Failure NYI'
{
    ok (Mu =:= Mu) ~~ Failure, 'misuse of =:= is failure (Mu)';
    ok (1 =:= '1') ~~ Failure, 'misuse of =:= is failure (literals)';
    ok (1 =:= 2) ~~ Failure, 'misuse of =:= is failure (!=)';
    ok (1 =:= 1) ~~ Failure, 'misuse of =:= is failure (even when ==)';
}

# vim: ft=perl6
