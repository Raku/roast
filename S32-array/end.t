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

#?rakudo skip 'unspecced'
{
  my $a;
  #?pugs todo
  dies_ok { $a.end }, ".end does not work on arbitrary scalars (1)";
}

#?rakudo skip 'unspecced'
{
  my $a = 42;
  #?pugs todo
  dies_ok { $a.end }, ".end does not work on arbitrary scalars (2)";
}

{
  my $a = [];
  is $a.end, -1, ".end works on empty arrayrefs";
}

{
  my $a = [<a b c>];
  is $a.end, 2, ".end works on initialized arrayrefs (1)";
}

#?niecza skip 'Unable to resolve method end in class Parcel'
{
  my $a = <a b c>;
  is $a.end, 2, ".end works on initialized arrayrefs (2)";
}

#?rakudo skip 'unspecced'
{
  dies_ok { end(1,2,3,4) }, "end(1,2,3,4) should not work";
}

#?niecza skip 'Unable to resolve method end in class Parcel'
{
  is (end (1,2,3,4)), 3, "end (1,2,3,4) should work";
}

{
  is (end [1,2,3,4]), 3, "end [1,2,3,4] should work";
}

#?niecza skip 'Unable to resolve method end in class Parcel'
{
  is (end ([1,2,3,4],)), 0, "end ([1,2,3,4],) should return 0";
}

# vim: ft=perl6
