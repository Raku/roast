use v6.c;

use Test;

# L<S32::Containers/"Array"/=item "elems">
plan 11;

{
  my @a;
  is @a.elems, 0, ".elems works on uninitialized arrays";
}

{
  my @a = ();
  is @a.elems, 0, ".elems works on empty arrays";
}

{
  my @a = <a b c>;
  is @a.elems, 3, ".elems works on initialized arrays";
}

#?niecza todo
{
  my $a;
  is $a.elems, 1, ".elems does works on arbitrary scalars";
}

{
  my $a = [];
  is $a.elems, 0, ".elems works on empty arrayrefs";
}

{
  my $a = [<a b c>];
  is $a.elems, 3, ".elems works on initialized arrayrefs (1)";
}

{
  my $a = <a b c>;
  is $a.elems, 3, ".elems works on initialized arrayrefs (2)";
}

{
  throws-like 'elems(1,2,3,4)', X::TypeCheck::Argument,
    "elems(1,2,3,4) should not work";
}

{
  is (elems (1,2,3,4)), 4, "elems (1,2,3,4) should work";
}

{
  is (elems [1,2,3,4]), 4, "elems [1,2,3,4] should work";
}

{
  is (elems ([1,2,3,4],)), 1, "elems ([1,2,3,4],) should return 1";
}

# vim: ft=perl6
