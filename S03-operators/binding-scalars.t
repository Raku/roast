use v6;

use Test;

=begin head1
Binding tests

These tests are derived from the "Item assignment precedence" section of Synopsis 3

# L<S03/Item assignment precedence/replaces the container itself  For instance>

=end head1

plan 29;

# Basic scalar binding tests
{
  my $x = 'Just Another';
  is($x, 'Just Another', 'normal assignment works');

  my $y := $x;
  is($y, 'Just Another', 'y is now bound to x');

  ok($y =:= $x, 'y is bound to x (we checked with the =:= identity op)');

  my $z = $x;
  is($z, 'Just Another', 'z is not bound to x');

  ok(!($z =:= $x), 'z is not bound to x (we checked with the =:= identity op)');

  $y = 'Perl Hacker';
  is($y, 'Perl Hacker', 'y has been changed to "Perl Hacker"');
  is($x, 'Perl Hacker', 'x has also been changed to "Perl Hacker"');

  is($z, 'Just Another', 'z is still "Just Another" because it was not bound to x');
}


# Binding and $CALLER::
#XXX This can pass bogusly (was doing for Rakudo for a while).
#?niecza skip 'CALLER::'
{
  sub bar {
    return $CALLER::a eq $CALLER::b;
  }

  sub foo {
    my $a is context = "foo";
    my $b is context := $a;    #OK not used
    return bar(); # && bar2();
  }

  ok(foo(), "CALLER resolves bindings in caller's dynamic scope");
}

# Binding to swap
#?rakudo skip 'list binding'
#?niecza skip 'list binding'
{
  my $a = "a";
  my $b = "b";

  ($a, $b) := ($b, $a);
  is($a, 'b', '$a has been changed to "b"');
  is($b, 'a', '$b has been changed to "a"');

  $a = "c";
  is($a, 'c', 'binding to swap didn\'t make the vars readonly');
}

# More tests for binding a list
#?rakudo skip 'list binding'
#?niecza skip 'list binding'
{
  my $a = "a";
  my $b = "b";
  my $c = "c";

  ($a, $b) := ($c, $c);
  is($a, 'c', 'binding a list literal worked (1)');
  is($b, 'c', 'binding a list literal worked (2)');

  $c = "d";
  is($a, 'd', 'binding a list literal really worked (1)');
  is($b, 'd', 'binding a list literal really worked (2)');
}


# Binding subroutine parameters
# XXX! When executed in interactive Pugs, the following test works!
{
  my $a;
  my $b = sub ($arg) { $a := $arg };
  my $val = 42;

  $b($val);
  is $a, 42, "bound readonly sub param was bound correctly (1)";
  $val++;
  #?niecza skip "difference of interpretation on ro binding"
  #?rakudo todo 'nom regression'
  is $a, 43, "bound readonly sub param was bound correctly (2)";

  dies_ok { $a = 23 },
    "bound readonly sub param remains readonly (1)";
  #?niecza skip "difference of interpretation on ro binding"
  #?rakudo todo 'nom regression'
  is $a, 43,
    "bound readonly sub param remains readonly (2)";
  is $val, 43,
    "bound readonly sub param remains readonly (3)";
}

{
  my $a;
  my $b = sub ($arg is rw) { $a := $arg };
  my $val = 42;

  $b($val);
  is $a, 42, "bound rw sub param was bound correctly (1)";
  $val++;
  is $a, 43, "bound rw sub param was bound correctly (2)";

  lives_ok { $a = 23 }, "bound rw sub param remains rw (1)";
  is $a, 23,            "bound rw sub param remains rw (2)";
  is $val, 23,          "bound rw sub param remains rw (3)";
}

# := actually takes subroutine parameter list
#?rakudo todo 'List binding'
#?niecza skip 'list binding'
{
  my $a;
  eval '(:$a) := (:a<foo>)';
  #?pugs todo
  is($a, "foo", "bound keyword");
  my @tail;
  eval '($a, *@tail) := (1, 2, 3)';
  #?pugs todo
  ok($a == 1 && ~@tail eq '2 3', 'bound slurpy');
}

# RT #77462
# binding how has the same precedence as list assignment
{
    my $x := 1, 2;
    is $x.join, '12', 'binding has same precdence as list assignment'
}

# vim: ft=perl6
