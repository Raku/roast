use v6;

use Test;

# L<S06/Macros>

plan 8;

{
  my $was_in_macro;
  macro dollar_foo { $was_in_macro = 1; '$COMPILING::foo' }
  is $was_in_macro, 1, "string returning macro was called at compile time";
  my $foo = 42;
  #?pugs todo
  is dollar_foo, $foo, "simple string returning macro (1)";
  dollar_foo() = 23;
  #?pugs todo
  is $foo, 23, "simple string returning macro (2)";
}

{
  my $ret = EVAL '
    macro plus_3 { "+ 3" }
    42 plus_3;
  ';
  #?pugs todo 'feature'
  is $ret, 45, "simple string returning macro (3)";
};

{
  macro four { '4' }
  my $foo = 100 + four;
  is $foo, 104, "simple string returning macro (4)";
}

{
  macro prefix_1000 (Int $x) { "1000$x" }
  is prefix_1000(42), 100042, "simple string returning macro (5)";
}

{
  my $was_in_macro;
  macro prefix_2000 (Int $x) { $was_in_macro = 1; "2000$x" }
  is $was_in_macro, 1,
    "simple string returning macro without argparens is parsed correctly (1)";
  is (prefix_2000 42), 200042,
    "simple string returning macro without argparens is parsed correctly (2)";
}

# vim: ft=perl6
