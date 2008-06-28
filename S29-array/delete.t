use v6;
use Test;

plan 22;

=begin description

Basic C<delete> tests, see S29.

=end description

# L<S29/"Array"/=item delete>

# W/ positive indices:
{
  my @array = <a b c d>;
  is ~@array, "a b c d", "basic sanity (1)";
  is ~@array.delete(2), "c",
    "deletion of an array element returned the right thing";
  # Note: The double space here is correct (it's the stringification of undef).
  is ~@array, "a b  d", "deletion of an array element";

  is ~@array.delete(0, 3), "a d",
    "deletion of array elements returned the right things";
  is ~@array, " b", "deletion of array elements (1)";
  is +@array, 2,     "deletion of array elements (2)";
}

# W/ negative indices:
{
  my @array = <a b c d>;
  is ~@array.delete(-2), "c",
    "deletion of array element accessed by an negative index returned the right thing";
  # @array is now ("a", "b", undef, "d") ==> double spaces
  is ~@array, "a b  d", "deletion of an array element accessed by an negative index (1)";
  is +@array,        4, "deletion of an array element accessed by an negative index (2)";

  is ~@array.delete(-1), "d",
    "deletion of last array element returned the right thing";
  # @array is now ("a", "b", undef)
  is ~@array, "a b", "deletion of last array element (1)";
  is +@array,     2, "deletion of last array element (2)";
}

# W/ multiple positive and negative indices:
{
  my @array = <a b c d e f>;
  is ~@array.delete(2, -3, -1), "c d f",
    "deletion of array elements accessed by positive and negative indices returned right things";
  # @array is now ("a", "b", undef, undef, "e") ==> double spaces
  is ~@array, "a b   e",
    "deletion of array elements accessed by positive and negative indices (1)";
  is +@array, 5,
    "deletion of array elements accessed by positive and negative indices (2)";
}

# Results taken from Perl 5
{
  my @array = <a b c>;
  is ~@array.delete(2, -1), "c b",
    "deletion of the same array element accessed by different indices returned right things";
  is ~@array, "a",
    "deletion of the same array element accessed by different indices (1)";
  is +@array, 1,
    "deletion of the same array element accessed by different indices (2)";
}

# L<S29/Array/"Deleted elements at the end of an Array">
{
    my @array;
    @array[8] = 'eight';
    @array.delete(8);
    is +@array, 0, 'deletion of trailing items purge empty positions'; 

}

# W/ one range of positive indices
#?rakudo 3 skip 'Rakudo: delete does not flatten Range'
{
  my @array = <a b c d e f>;
  is ~@array.delete(2..4), "c d e",
    "deletion of array elements accessed by a range of positives indices returned right things";
  # @array is now ("a", "b", undef, undef, undef, "f") ==> 4 spaces
  is ~@array, "a b    f",
    "deletion of array elements accessed by a range of positive indices (1)";
  is +@array, 6,
    "deletion of array elements accessed by a range of positive indices (2)";
}

#?rakudo 3 skip 'Rakudo: delete does not flatten Range'
{
  my @array = <a b c d e f>;
  is ~@array.delete(^2..4), "d e",
    "deletion of array elements accessed by a range of positives indices returned right things (2)";
  # @array is now ("a", "b", "c", undef, undef, "f") ==> 4 spaces
  is ~@array, "a b   e f",
    "deletion of array elements accessed by a range of positive indices (3)";
  is +@array, 6,
    "deletion of array elements accessed by a range of positive indices (4)";
}

# TODO More exclusive bounds checks

# TODO W/ multiple ranges

