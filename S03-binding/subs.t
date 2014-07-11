use v6;

use Test;

plan 12;

# L<S03/Item assignment precedence>

# Tests for rebinding subroutines themselves

{
  my sub foo { 42 }
  my sub bar { 41 }

  is(foo(), 42, 'before sub redefinition');

  &foo := &bar;
  is(foo(), 41, 'after sub redefinition');
}

# Since regexes are methods, token redefinition should work the same way

package TokenTest {
  token foo { <[ab]> }
  token bar { <[ef]> }

  my $target = 'cat';
  my Bool $bool;

  ok($bool = ($target ~~ m/<foo>/), 'before token redefinition');

  &foo := &bar;
  ok(not($bool = ($target ~~ m/<foo>/)), 'after token redefinition');
}

# Tests for binding the return value of subroutines (both as RHS and LHS).

{
    my sub foo { 42 }

    my $var := foo();
    is $var, 42,
        "binding a var to the return value of a sub (a constant) works (1)";

    dies_ok { $var = 23 },
        "binding a var to the return value of a sub (a constant) works (2)";
}

=begin unspecced

{
    my sub foo { 42 }

    dies_ok { foo() := 23 },
        "using the constant return value of a sub as the LHS in a binding operation dies";
}

There're two ways one can argue:
* 42 is constant, and rebinding constants doesn't work, so foo() := 23 should
  die.
* 42 is constant, but the implicit return() packs the constant 42 into a
  readonly 42, and readonly may be rebound.
  To clear the terminology,
    42                  # 42 is a constant
    sub foo ($a) {...}  # $a is a readonly

=end unspecced

{
    my sub foo { my $var = 42; $var }

    my $var := foo();
    is $var, 42,
        "binding a var to the return value of a sub (a variable) works (1)";

    dies_ok { $var = 23 },
        "binding a var to the return value of a sub (a variable) works (2)";
}

{
    my sub foo is parcel { my $var = 42; $var }

    my $var := foo();
    is $var, 42,
        "binding a var to the return value of an 'is parcel' sub (a variable) works (1)";

    lives_ok { $var = 23 },
        "binding a var to the return value of an 'is parcel' sub (a variable) works (2)";
    is $var, 23,
        "binding a var to the return value of an 'is parcel' sub (a variable) works (3)";
}

{
    my sub foo is parcel { my $var = 42; $var }

    lives_ok { foo() := 23 },
        "using the variable return value of an 'is parcel' sub as the LHS in a binding operation works";
}

=begin discussion

Should the constant return value be autopromoted to a var? Or should it stay a
constant?

{
    my sub foo is parcel { 42 }

    dies_ok/lives_ok { foo() := 23 },
        "using the constant return value of an 'is parcel' sub as the LHS in a binding operation behaves correctly";
}

=end discussion

# vim: ft=perl6
