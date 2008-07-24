use v6;

use Test;

=begin pod

=head1 DESCRIPTION

This test tests the C<WHAT> builtin.

=end pod

# L<S12/Introspection/"WHAT">

plan 10;

# Basic subroutine/method form tests for C<WHAT>.
{
  my $a = 3;
  ok((WHAT $a) === Int, "subroutine form of WHAT");
  ok(($a.WHAT) === Int, "method form of WHAT");
}

# Now testing basic correct inheritance.
{
  my $a = 3;
  ok($a.WHAT ~~ Num,    "an Int isa Num");
  ok($a.WHAT ~~ Object, "an Int isa Object");
}

# And a quick test for Code:
{
  my $a = sub ($x) { 100 + $x };
  ok($a.WHAT === Sub,    "a sub's type is Sub");
  ok($a.WHAT ~~ Routine, "a sub isa Routine");
  ok($a.WHAT ~~ Code,    "a sub isa Code");
}

# L<S12/Introspection/"which also bypasses the macros.">

{
    class Foo {
        method WHAT {'Bar'}
    }
    my $o = Foo.new;
    is($o."WHAT", 'Bar', '."WHAT" calls the method instead of the macro');
    is($o.WHAT,   'Foo', '.WHAT still works as intended');
    my $meth = "WHAT";
    is($o.$meth,  'Bar', '.$meth calls the method instead of the macro');
}
