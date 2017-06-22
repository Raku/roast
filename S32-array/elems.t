use v6;

use Test;

# L<S32::Containers/"Array"/=item "elems">
plan 12;

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

{
  my $a;
  is $a.elems, 1, ".elems works on arbitrary scalars";
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

# RT#125576
eval-dies-ok 'my Int @a = 1..Inf; @a[*-1]',
     'Attempting to view last element of Int Array with Inf in it dies';

# vim: ft=perl6
