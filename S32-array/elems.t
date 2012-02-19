use v6;

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

#?rakudo skip 'unspecced'
#?niecza todo
#?pugs todo
{
  my $a;
  dies_ok { $a.elems }, ".elems does not work on arbitrary scalars (1)";
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

#?rakudo skip 'unspecced'
{
  dies_ok { elems(1,2,3,4) }, "elems(1,2,3,4) should not work";
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
