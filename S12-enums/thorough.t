use v6;

use Test;

plan 67;

=begin description

Enum tests from L<S12/Enums>

=end description

#?pugs 999 skip
# L<S12/Enums/values are specified as a list>
enum day <Sun Mon Tue Wed Thu Fri Sat>;

ok day.WHAT, 'enum.WHAT returned a value';
ok day.perl, 'enum.perl returned a value';

#?DOES 14
sub test_stuff($x) {
  ok not $x does Wed, "basic enum mixing worked ($x-2)";
  is $x.day, 3,       "automatically created accessor worked ($x)";
  is day::Tue, 3,     "enum provided a correct mapping ($x)";
  ok $x ~~ day,       "smartmatch worked correctly ($x-1)";
  ok $x ~~ Tue,       "smartmatch worked correctly ($x-2)";
  ok $x ~~ day::Tue,  "smartmatch worked correctly ($x-3)";
  ok $x !~~  Wed,     "smartmatch worked correctly ($x-4)";
  ok $x.does(Tue),    ".does worked correctly ($x-1)";
  ok $x.does(day),    ".does worked correctly ($x-2)";
  is $x.day, 3,       ".day worked correctly ($x)";
  ok Tue $x,          "Tue() worked correctly ($x)";
  ok $x.Tue,          ".Tue() worked correctly ($x)";
  ok $x.Tue.WHAT,     '$obj.Tue.WHAT returns a true valuee';
  ok $x.Tue.perl,     '$obj.Tue.perl returns a true valuee';
}

{
  my $x = 1;
  is $x, 1, "basic sanity (1)";
  # L<S12/Enums/has the right semantics mixed in:>
  ok $x does Tue, "basic enum mixing worked (1-1)";
  $x does Tue;
  test_stuff($x);
}

{
  my $x = 2;
  is $x, 2, "basic sanity (2)";
  # L<S12/Enums/or pseudo-hash form:>
  ok $x does day<Tue>, "basic enum mixing worked (2-1)";
  test_stuff($x);
}

{
  my $x = 3;
  is $x, 3, "basic sanity (3)";
  # L<S12/Enums/is the same as>
  ok $x does day::Tue, "basic enum mixing worked (3-1)";
  test_stuff($x);
}

{
  my $x = 4;
  is $x, 4, "basic sanity (4)";
  # L<S12/Enums/which is short for something like:>
  ok $x does day,            "basic enum mixing worked (4-0)";
  ok $x.day = &day::("Tue"), "basic enum mixing worked (4-1)";
  test_stuff($x);
}
