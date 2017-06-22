use v6;

use Test;

plan 13;

# L<S14/Roles>
{
  my $a = {:x};
  is $a, {:x}, "basic sanity";
  lives-ok { $a does role { has $.cool = "yeah" }}, "anonymous role mixin";
  is $a, {:x}, "still basic sanity";
  is $a.cool, "yeah", "anonymous role gave us an attribute";
}

# The same, but we story the anonymous role in a variable
{
  my $a = {:x};
  is $a, {:x}, "basic sanity";
  my $role;
  lives-ok { $role = role { has $.cool = "yeah" } }, "anonymous role definition";
  lives-ok { $a does $role }, "anonymous role variable mixin";
  is $a, {:x}, "still basic sanity";
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
  lives-ok {$a does role_generator("hi")}, "role generating function mixin";
  is $a, {:x}, "still basic sanity";
  is $a.cool, "hi", "role generating function gave us an attribute";
}

# vim: ft=perl6
