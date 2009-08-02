use v6;

use Test;

#L<S06/"Macros">

plan 4;

{
  my $z = 3;
  my $in_macro;
  my $in_macro_clos;
  macro returns_a_closure {
    my $x = 42;
    $in_macro = 1;
    return { $in_macro_clos++; 100 + $x + $z };
  }

  is $in_macro,           1, "macro was executed during compile time";
  ok !$in_macro_clos,        "macro closure was not executed during compile time";
  is returns_a_closure, 145, "closure returning macro";
  is $in_macro_clos,      1, "macro closure was executed during runtime";
}

# vim: ft=perl6
