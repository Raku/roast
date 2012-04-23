use v6;

use Test;

plan 17;

# L<S02/Names/"Which class am I in?">

class Foo {
  method get_self_normal()    { self }
  method get_class_normal()   { $?CLASS }
  method get_package_normal() { $?PACKAGE }

  method get_class_pvar()   { ::?CLASS }
  method get_package_pvar() { ::?PACKAGE }

  method dummy()     { 42 }
}

role Bar {
  method get_self_normal()    { self }
  method get_class_normal()   { $?CLASS }
  method get_role_normal()    { $?ROLE }
  method get_package_normal() { $?PACKAGE }

  method get_class_pvar()   { ::?CLASS }
  method get_role_pvar()    { ::?ROLE }
  method get_package_pvar() { ::?PACKAGE }

  method dummy()     { 42 }
}

class SimpleClass does Bar {}

{
  my $foo_obj = Foo.new;
  my $class   = $foo_obj.get_class_normal;
  my $package = $foo_obj.get_package_normal;
  is( $package.gist, Foo.gist, '$?PACKAGE should be the package name' );

  ok( $class ~~ Foo, 'the thing returned by $?CLASS in our class smartmatches against our class' );
  my $forty_two;
  lives_ok { my $obj = $class.new; $forty_two = $obj.dummy },
    'the class returned by $?CLASS in our class was really our class (1)';
  is $forty_two, 42, 'the class returned by $?CLASS in our class way really our class (2)';
}

{
  my $foo1 = Foo.new;
  my $foo2 = $foo1.get_self_normal;

  ok $foo1 === $foo2, 'self in classes works';
}

{
  my $bar   = SimpleClass.new;
  my $class = $bar.get_class_normal;
  my $package = $bar.get_package_normal;

  is( $package.gist, Bar.gist, '$?PACKAGE should be the role package name - it is not generic like $?CLASS');

  #?pugs todo 'bug'
  ok $class ~~ ::SimpleClass, 'the thing returned by $?CLASS in our role smartmatches against our class';
  my $forty_two;
  lives_ok { my $obj = $class.new; $forty_two = $obj.dummy },
    'the class returned by $?CLASS in our role way really our class (1)';
  is $forty_two, 42, 'the class returned by $?CLASS in our role way really our class (2)';
}

{
  my $bar1 = SimpleClass.new;
  my $bar2 = $bar1.get_self_normal;

  ok $bar1 === $bar2, 'self in roles works';
}

{
  my $bar  = SimpleClass.new;
  my $role = $bar.get_role_normal;

  ok $role ~~ Bar, 'the returned by $?ROLE smartmatches against our role';
}

# Now the same with type vars
#?pugs todo 'oo'
{
  ok Foo.new.get_class_pvar === ::Foo,
    "::?CLASS in classes works";
  ok SimpleClass.new.get_class_pvar === ::SimpleClass,
    "::?CLASS in roles works";
  ok SimpleClass.new.get_role_pvar === ::Bar,
    "::?ROLE in roles works";
}

# Per L<"http://www.nntp.perl.org/group/perl.perl6.language/23541">:
#     On Sat, Oct 15, 2005 at 07:39:36PM +0300, wolverian wrote:
#     : On Sat, Oct 15, 2005 at 08:25:15AM -0700, Larry Wall wrote:
#     : > [snip]
#     : >
#     : > Of course, there's never been any controversy here about what to call
#     : > "self", oh no... :-)
#     : 
#     : IMHO just call it "self" (by default) and be done with it. :) 
#
#     Let it be so.
#
#     Larry
{
  class Grtz {
    method get_self1 { self }
    method get_self2 ($self:) { $self }
    method foo       { 42 }
    method run_foo   { self.foo }
  }
  my $grtz = Grtz.new;

  ok $grtz.get_self1 === $grtz.get_self2,
    'self is an alias for $self (1)';
  is $grtz.run_foo, 42,
    'self is an alias for $self (2)';
}

{
  eval_dies_ok 'self' , "there is no self outside of a method";
}

# vim: ft=perl6
