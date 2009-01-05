use v6;

use Test;

# L<"http://use.perl.org/~autrijus/journal/25351">
# Roles are also classes! They can be instantiated just fine if they are
# concrete enough. Basically they mean composable classes or mixin-able
# classes. Hence, RoleName.new() instantiates an object that will probably fail
# on all stubs.

# XXX
# on the other hand # L<S12/Roles/> says
#   In either case, a class is necessary for instantiation--a role may 
#   not be directly instantiated.
# 
# so we need some kind of decision on this.

plan 3;

role SampleRole {
  method sample_method () { 42 }
}

{
  my $obj = SampleRole.new;
  ok $obj.defined, "roles can be instantiated";

  ok $obj ~~ SampleRole, "our instantiated role object smartmatches against our role";

  is $obj.sample_method, 42, "calling a method on our instantiated role object worked";
}
