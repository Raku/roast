use v6;

use Test;

plan 26;

=begin pod

Basic submethod tests. See L<S12/"Submethods">

=end pod
# L<S12/Submethods>
{
  my $was_in_foo_build = 0;
  my $was_in_bar_build = 0;

  lives_ok {
    class Foo        { submethod BUILD() { $was_in_foo_build++ } }
    class Bar is Foo { submethod BUILD() { $was_in_bar_build++ } }
  }, "class definitions were parsed/run/compiled";

  my $a;
  lives_ok {$a = Foo.new()},    "Foo.new() worked (1)";
  is $was_in_foo_build, 1,      "Foo's BUILD was called";
  # is instead of todo_is to avoid unexpected succeedings
  is $was_in_bar_build, 0,      "Bar's BUILD was not called";

  my $b;
  lives_ok {$b = Bar.new()},    "Bar.new() worked";
  is $was_in_foo_build, 2,      "Foo's BUILD was called again";
  is $was_in_bar_build, 1,      "Bar's BUILD was called, too";

  # The next three tests are basically exactly the same as the first three tests
  # (not counting the initial class definition). This is to verify our call to
  # Bar.new didn't removed/changed some internal structures which'd prevent
  # Foo.BUILD of getting called.
  my $c;
  lives_ok {my $c = Foo.new()}, "Foo.new() worked (2)";
  is $was_in_foo_build, 3,      "Foo's BUILD was called again";
  is $was_in_bar_build, 1,      "Bar's BUILD was not called again";
}

# See thread "BUILD and other submethods" on p6l
# L<"http://groups-beta.google.com/group/perl.perl6.language/msg/e9174e5538ded4a3">
{
  my $was_in_baz_submethod  = 0;
  my $was_in_grtz_submethod = 0;

  class Baz         { submethod blarb() { $was_in_baz_submethod++ } }
  class Grtz is Baz { submethod blarb() { $was_in_grtz_submethod++ } }

  my ($baz, $grtz);
  lives_ok {$baz  = Baz.new},  "Baz.new() worked";
  lives_ok {$grtz = Grtz.new}, "Grtz.new() worked";

  try { $baz.blarb };
  is $was_in_baz_submethod,  1, "Baz's submethod blarb was called";
  # No :todo to avoid unexpected suceedings
  is $was_in_grtz_submethod, 0, "Grtz's submethod blarb was not called";

  try { $grtz.blarb };
  is $was_in_baz_submethod,  1, "Baz's submethod blarb was not called again";
  is $was_in_grtz_submethod, 1, "Grtz's submethod blarb was called now";

  try { $grtz.Baz::blarb };
  is $was_in_baz_submethod,  2, "Baz's submethod blarb was called again now";
  is $was_in_grtz_submethod, 1, "Grtz's submethod blarb was not called again";
}

# Roles with BUILD
# See thread "Roles and BUILD" on p6l
# L<"http://www.nntp.perl.org/group/perl.perl6.language/21277">
#?rakudo skip 'roles and submethods'
{
  my $was_in_a1_build = 0;
  my $was_in_a2_build = 0;
  role RoleA1  { multi submethod BUILD() { $was_in_a1_build++ } }
  role RoleA2  { multi submethod BUILD() { $was_in_a2_build++ } }
  class ClassA does RoleA1 does RoleA2 {}

  ClassA.new;

  is $was_in_a1_build, 1, "roles' BUILD submethods were called when mixed in a class (1)";
  is $was_in_a2_build, 1, "roles' BUILD submethods were called when mixed in a class (2)";
}

#?rakudo skip 'roles and submethods'
{
  my $was_in_b1_build = 0;
  my $was_in_b2_build = 0;
  role RoleB1  { multi submethod BUILD() { $was_in_b1_build++ } }
  role RoleB2  { multi submethod BUILD() { $was_in_b2_build++ } }
  class ClassB {}

  my $B = ClassB.new;
  is $was_in_b1_build, 0, "roles' BUILD submethods were not yet called (1)";
  is $was_in_b2_build, 0, "roles' BUILD submethods were not yet called (2)";

  $B does (RoleB1, RoleB2);
  is $was_in_b1_build, 1, "roles' BUILD submethods were called now (1)", :todo<feature>;
  is $was_in_b2_build, 1, "roles' BUILD submethods were called now (2)", :todo<feature>;
};

# BUILD with signatures that don't map directly to attributes
#?rakudo skip 'BUILD'
{
  class ClassC
  {
    has $.double_value;

    submethod BUILD ( $value = 1 )
    {
      $.double_value = $value * 2;
    }
  }

  my $C = ClassC.new();
  is( $C.double_value, 2,
    'BUILD() should allow default values of optional params in signature' );

  my $C2 = ClassC.new( :value(100) );
  is( $C2.double_value, 200, '... or value passed in' );
}

# vim: ft=perl6
