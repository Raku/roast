use v6;

use Test;

# L<A02/"RFC 212: Make C<length(@array)> Work">
# L<S29/"Array"/"elems">
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
  dies_ok { $a.elems }, ".elems does not work on arbitrary scalars (1)";
}

{
# (ryporter 2007-09-22): This test fails because a VInt is
# being converted into an array in the final defintion of doArray
# in AST/Internals.hs ("doArray val f").  When I tried replacing
# "val" with "(VList x)", to accept fewer inputs, this test passed, 
# but many others failed.
#
# Also relevant is the "(rw!Array)" declaration for List::elems
# in Prim.hs.  Changing it to "(Array)", combined with the above
# change, caused both this and the preceding test to succeed.
#
  my $a = 42;
  dies_ok { $a.elems }, ".elems does not work on arbitrary scalars (2)";
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
