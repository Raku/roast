use v6-alpha;
use Test;
plan 7;

# L<S29/"List"/"=item map">

# Test was primarily aimed at PIL2JS, which did not pass this test (fixed now).
{
  my @array  = <a b c d>;
  my @result = map { (), }, @array;

  is +@result, 0, "map works with the map body returning an empty list";
}

{
  my @array  = <a b c d>;
  my @empty  = ();
  my @result = map { @empty }, @array;

  is +@result, 0, "map works with the map body returning an empty array";
}

{
  my @array  = <a b c d>;
  my @result = map { [] }, @array;

  is +@result, 4, "map works with the map body returning an empty arrayref";
}

{
  my @array  = <a b c d>;
  my $empty  = [];
  my @result = map { $empty }, @array;

  is +@result, 4, "map works with the map body returning an empty arrayref variable", :todo<bug>;
}

{
  my @array  = <a b c d>;
  my @result = map { undef }, @array;

  is +@result, 4, "map works with the map body returning undef";
}

{
  my @array  = <a b c d>;
  my $undef  = undef;
  my @result = map { $undef }, @array;

  is +@result, 4, "map works with the map body returning an undefined variable";
}

{
  my @array  = <a b c d>;
  my @result = map { () }, @array;

  is +@result, 0, "map works with the map body returning ()";
}
