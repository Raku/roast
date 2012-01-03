use v6;
use Test;

plan 29;

=begin description

Basic C<delete> tests, see S32.

=end description

# L<S32::Containers/"Array"/=item delete>

sub make-string(@a) {
    ~@a.map({ $_ // "Any()" });
}

# W/ positive indices:
{
  my @array = <a b c d>;
  is ~@array, "a b c d", "basic sanity (1)";
  is ~@array.delete(2), "c",
    "deletion of an array element returned the right thing";
  is make-string(@array), "a b Any() d", "deletion of an array element";

  is ~@array.delete(0, 3), "a d",
    "deletion of array elements returned the right things";
  is make-string(@array), "Any() b", "deletion of array elements (1)";
  is +@array, 2,     "deletion of array elements (2)";
}

# W/ negative indices:
{
  my @array = <a b c d>;
  is ~@array.delete(*-2), "c",
    "deletion of array element accessed by an negative index returned the right thing";
  # @array is now ("a", "b", Any, "d") ==> double spaces
  is make-string(@array), "a b Any() d", "deletion of an array element accessed by an negative index (1)";
  is +@array,        4, "deletion of an array element accessed by an negative index (2)";

  is ~@array.delete(*-1), "d",
    "deletion of last array element returned the right thing";
  # @array is now ("a", "b")
  is ~@array, "a b", "deletion of last array element (1)";
  is +@array,     2, "deletion of last array element (2)";
}

# W/ multiple positive and negative indices:
{
  my @array = <a b c d e f>;
  is ~@array.delete(2, *-3, *-1), "c d f",
    "deletion of array elements accessed by positive and negative indices returned right things";
  # @array is now ("a", "b", Any, Any, "e") ==> double spaces
  is make-string(@array), "a b Any() Any() e",
    "deletion of array elements accessed by positive and negative indices (1)";
  is +@array, 5,
    "deletion of array elements accessed by positive and negative indices (2)";
}

# Results taken from Perl 5
#?niecza todo "Not sure if this test is correct or not"
{
  my @array = <a b c>;
  is ~@array.delete(2, *-1), "c b",
    "deletion of the same array element accessed by different indices returned right things";
  is ~@array, "a",
    "deletion of the same array element accessed by different indices (1)";
  is +@array, 1,
    "deletion of the same array element accessed by different indices (2)";
}

# L<S32::Containers/"Array"/"Deleted elements at the end of an Array">
{
    my @array;
    @array[8] = 'eight';
    @array.delete(8);
    is +@array, 0, 'deletion of trailing items purge empty positions';

}

# W/ one range of positive indices
{
  my @array = <a b c d e f>;
  is ~@array.delete(2..4), "c d e",
    "deletion of array elements accessed by a range of positives indices returned right things";
  # @array is now ("a", "b", Any, Any, Any, "f") ==> 4 spaces
  is make-string(@array), "a b Any() Any() Any() f",
    "deletion of array elements accessed by a range of positive indices (1)";
  is +@array, 6,
    "deletion of array elements accessed by a range of positive indices (2)";
}

{
  my @array = <a b c d e f>;
  is ~@array.delete(2^..4), "d e",
    "deletion of array elements accessed by a range of positives indices returned right things (2)";
  # @array is now ("a", "b", "c", Any, Any, "f") ==> 4 spaces
  is make-string(@array), "a b c Any() Any() f",
    "deletion of array elements accessed by a range of positive indices (3)";
  is +@array, 6,
    "deletion of array elements accessed by a range of positive indices (4)";
}

# RT #67446
{
    my @array = 0..1;
    is ~(eval @array.perl ), '0 1', '@array.perl works after init';
    is ~( map { 1 }, @array ), '1 1', 'map @array works after init';
    @array.delete(0);
    lives_ok { @array.perl }, '@array.perl lives after delete';
    lives_ok { map { 1 }, @array }, 'map @array lives after delete';
}

# TODO More exclusive bounds checks

# TODO W/ multiple ranges
# vim: ft=perl6
