use v6;

use Test;

plan 13;

#?pugs 99 todo 'anonymous roles'

# L<S14/Roles>
{
  my $a = {:x};
  is $a, {:x}, "basic sanity";
  lives_ok { $a does role { has $.cool = "yeah" }}, "anonymous role mixin";
  is $a, {:x}, "still basic sanity";
  is $a.cool, "yeah", "anonymous role gave us an attribute";
}

# The same, but we story the anonymous role in a variable
{
  my $a = {:x};
  is $a, {:x}, "basic sanity";
  my $role;
  lives_ok { $role = role { has $.cool = "yeah" } }, "anonymous role definition";
  #?rakudo.jvm todo "RT 121626"
  #?rakudo.moar todo "RT 121626"
  lives_ok { $a does $role }, "anonymous role variable mixin";
  is $a, {:x}, "still basic sanity";
  #?rakudo.jvm todo "RT 121626"
  #?rakudo.moar todo "RT 121626"
  is $a.cool, "yeah", "anonymous role variable gave us an attribute";
}

# Guarantee roles are really first-class-entities:
{
    sub role_generator(Str $val) {
      return role {
        has $.cool = $val;
      }
    }

  my $a = {:x};
  is $a, {:x}, "basic sanity";
  #?niecza todo 'This is being misinterpreted as an initial value'
  lives_ok {$a does role_generator("hi")}, "role generating function mixin";
  is $a, {:x}, "still basic sanity";
  #?niecza skip 'roles are run once and only capture the protopad'
  #?rakudo skip 'anonymous roles only created once'
  is $a.cool, "hi", "role generating function gave us an attribute";
}

# vim: ft=perl6
