use v6;

use Test;

=head1 DESCRIPTION

This test tests the C<WHAT> builtin.

=cut

# L<S12/Introspection/"WHAT">

plan 9;

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

# L<S12/Introspection/"These are all actually macros, not true operators or methods.">

{
    class Foo {
        method WHAT {'Bar'}
    }
    my $o = Foo.new;
    is(Foo."WHAT", 'Bar', '."WHAT" calls the method instead of the macro');
    is(Foo.WHAT,   'Foo', '.WHAT still works as intended');
}
