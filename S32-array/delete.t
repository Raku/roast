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

  is ~@array.delete(3), "d",
    "deletion of array elements returned the right things";
  #?pugs todo
  is make-string(@array), "a b", "deletion of array elements (1)";
  #?pugs todo
  is +@array, 2,     "deletion of array elements (2)";
}

# W/ negative indices:
#?rakudo skip ":delete NYI, but will be shortly"
{
  my @array = <a b c d>;
  #?pugs todo
  is ~@array[*-2]:delete, "c",
    "deletion of array element accessed by an negative index returned the right thing";
  # @array is now ("a", "b", Any, "d") ==> double spaces
  #?pugs todo
  is make-string(@array), "a b Any() d", "deletion of an array element accessed by an negative index (1)";
  is +@array,        4, "deletion of an array element accessed by an negative index (2)";

  #?pugs todo
  is ~@array[*-1]:delete, "d",
    "deletion of last array element returned the right thing";
  # @array is now ("a", "b")
  #?pugs todo
  is ~@array, "a b", "deletion of last array element (1)";
  #?pugs todo
  is +@array,     2, "deletion of last array element (2)";
}

# W/ multiple positive and negative indices:
#?pugs todo
#?rakudo skip ":delete NYI, but will be shortly"
{
  my @array = <a b c d e f>;
  is ~@array[2, *-3, *-1]:delete, "c d f",
    "deletion of array elements accessed by positive and negative indices returned right things";
  # @array is now ("a", "b", Any, Any, "e") ==> double spaces
  is make-string(@array), "a b Any() Any() e",
    "deletion of array elements accessed by positive and negative indices (1)";
  is +@array, 5,
    "deletion of array elements accessed by positive and negative indices (2)";
}

# Results taken from Perl 5
#?niecza todo "Not sure if this test is correct or not"
#?pugs   todo "Not sure if this test is correct or not"
#?rakudo skip ":delete NYI, but will be shortly"
{
  my @array = <a b c>;
  is ~@array[2, *-1]:delete, "c b",
    "deletion of the same array element accessed by different indices returned right things";
  is ~@array, "a",
    "deletion of the same array element accessed by different indices (1)";
  is +@array, 1,
    "deletion of the same array element accessed by different indices (2)";
}

# L<S32::Containers/"Array"/"Deleted elements at the end of an Array">
#?pugs todo
{
    my @array;
    @array[8] = 'eight';
    @array.delete(8);
    is +@array, 0, 'deletion of trailing items purge empty positions';

}

# W/ one range of positive indices
#?rakudo skip ":delete NYI, but will be shortly"
{
  my @array = <a b c d e f>;
  is ~@array[2..4]:delete, "c d e",
    "deletion of array elements accessed by a range of positives indices returned right things";
  # @array is now ("a", "b", Any, Any, Any, "f") ==> 4 spaces
  is make-string(@array), "a b Any() Any() Any() f",
    "deletion of array elements accessed by a range of positive indices (1)";
  is +@array, 6,
    "deletion of array elements accessed by a range of positive indices (2)";
}

#?rakudo skip ":delete NYI, but will be shortly"
{
  my @array = <a b c d e f>;
  is ~@array[2^..4]:delete, "d e",
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
    #?pugs todo
    is ~(eval @array.perl ), '0 1', '@array.perl works after init';
    is ~( map { 1 }, @array ), '1 1', 'map @array works after init';
    @array.delete(0);
    lives_ok { @array.perl }, '@array.perl lives after delete';
    lives_ok { map { 1 }, @array }, 'map @array lives after delete';
}

# TODO More exclusive bounds checks

# TODO W/ multiple ranges
# vim: ft=perl6
