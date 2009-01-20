use v6;

use Test;

# L<"http://use.perl.org/~autrijus/journal/25351">
# Roles are also classes! They can be instantiated just fine if they are
# concrete enough. Basically they mean composable classes or mixin-able
# classes. Hence, RoleName.new() instantiates an object that will probably fail
# on all stubs.

plan 13;

role SampleRole {
  method sample_method () { 42 }
}

{
  my $obj = SampleRole.new;
  ok $obj.defined, "roles can be instantiated";

  ok $obj ~~ SampleRole, "our instantiated role object smartmatches against our role";

  is $obj.sample_method, 42, "calling a method on our instantiated role object worked";

  my $obj2 = SampleRole.new;
  ok $obj.WHAT === $obj2.WHAT, "Punned role classes have the same .WHAT";
}

role WithAttr {
    has $.x;
    has $.y;
}
{
    my $obj = WithAttr.new(x => 'abc', y => 123);
    ok $obj ~~ WithAttr, "our instantiated role object smartmatches against our role";
    is $obj.x, 'abc', "role attributes initialized in constructor";
    is $obj.y, 123, "role attributes initialized in constructor";
}

role ParaRole[$x] {
    method get_x { $x }
}

{
    my $obj = ParaRole[42].new;
    my $obj2 = ParaRole[100].new;

    ok $obj ~~ ParaRole, "instantiated object smartmatches against parameterized role";
    ok $obj ~~ ParaRole[42], "instantiated object smartmatches against parameterized role (with param)";
    ok $obj2 ~~ ParaRole, "instantiated object smartmatches against parameterized role";
    ok $obj2 ~~ ParaRole[100], "instantiated object smartmatches against parameterized role (with param)";

    is $obj.get_x, 42, "instantiated object has method with correct associated role parameter";
    is $obj2.get_x, 100, "instantiated object has method with correct associated role parameter";
}
