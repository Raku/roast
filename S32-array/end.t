use v6;

use Test;

# L<S32::Containers/"Array"/"end">
plan 12;

{
  my @a;
  is @a.end, -1, ".end works on uninitialized arrays";
}

{
  my @a = ();
  is @a.end, -1, ".end works on empty arrays";
}

{
  my @a = <a b c>;
  is @a.end, 2, ".end works on initialized arrays";
}

{
  my $a;
  is $a.end, 0, ".end works on arbitrary scalars (1)";
}

{
  my $a = 42;
  is $a.end, 0, ".end works on arbitrary scalars (2)";
}

{
  my $a = [];
  is $a.end, -1, ".end works on empty arrayitems";
}

{
  my $a = [<a b c>];
  is $a.end, 2, ".end works on initialized arrayitems (1)";
}

{
  my $a = <a b c>;
  is $a.end, 2, ".end works on initialized arrayitems (2)";
}

{
  throws-like 'end(1,2,3,4)', X::TypeCheck::Argument,
    "end(1,2,3,4) should not work";
}

{
  is (end (1,2,3,4)), 3, "end (1,2,3,4) should work";
}

{
  is (end [1,2,3,4]), 3, "end [1,2,3,4] should work";
}

{
  is (end ([1,2,3,4],)), 0, "end ([1,2,3,4],) should return 0";
}

# vim: expandtab shiftwidth=4
