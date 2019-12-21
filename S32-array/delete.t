use v6;
use Test;

plan 34;

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
  is ~(@array[2]:delete), "c",
    "deletion of an array element returned the right thing";
  is make-string(@array), "a b Any() d", "deletion of an array element";

  is ~(@array[3]:delete), "d",
    "deletion of array elements returned the right things";
  is make-string(@array), "a b", "deletion of array elements (1)";
  is +@array, 2,     "deletion of array elements (2)";
}

# W/ negative indices:
{
  my @array = <a b c d>;
  is ~(@array[*-2]:delete), "c",
    "deletion of array element accessed by an negative index returned the right thing";
  # @array is now ("a", "b", Any, "d") ==> double spaces
  is make-string(@array), "a b Any() d", "deletion of an array element accessed by an negative index (1)";
  is +@array,        4, "deletion of an array element accessed by an negative index (2)";

  is ~(@array[*-1]:delete), "d",
    "deletion of last array element returned the right thing";
  # @array is now ("a", "b")
  is ~@array, "a b", "deletion of last array element (1)";
  is +@array,     2, "deletion of last array element (2)";
}

# W/ multiple positive and negative indices:
{
  my @array = <a b c d e f>;
  is ~(@array[2, *-3, *-1]:delete), "c d f",
    "deletion of array elements accessed by positive and negative indices returned right things";
  # @array is now ("a", "b", Any, Any, "e") ==> double spaces
  is make-string(@array), "a b Any() Any() e",
    "deletion of array elements accessed by positive and negative indices (1)";
  is +@array, 5,
    "deletion of array elements accessed by positive and negative indices (2)";
}

# Results taken from Perl
{
  my @array = <a b c>;
  is ~(@array[2, *-1]:delete), "c ",
    "deletion of the same array element accessed by different indices returned right things";
  is ~@array, "a b",
    "deletion of the same array element accessed by different indices (1)";
  is +@array, 2,
    "deletion of the same array element accessed by different indices (2)";
}

# L<S32::Containers/"Array"/"Deleted elements at the end of an Array">
{
    my @array;
    @array[8] = 'eight';
    @array[8]:delete;
    is +@array, 0, 'deletion of trailing items purge empty positions';
}

# W/ one range of positive indices
{
  my @array = <a b c d e f>;
  is ~(@array[2..4]:delete), "c d e",
    "deletion of array elements accessed by a range of positives indices returned right things";
  # @array is now ("a", "b", Any, Any, Any, "f") ==> 4 spaces
  is make-string(@array), "a b Any() Any() Any() f",
    "deletion of array elements accessed by a range of positive indices (1)";
  is +@array, 6,
    "deletion of array elements accessed by a range of positive indices (2)";
}

{
  my @array = <a b c d e f>;
  is ~(@array[2^..4]:delete), "d e",
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
    is ~(EVAL @array.perl ), '0 1', '@array.perl works after init';
    is ~( map { 1 }, @array ), '1 1', 'map @array works after init';
    @array[0]:delete;
    lives-ok { @array.perl }, '@array.perl lives after delete';
    lives-ok { map { 1 }, @array }, 'map @array lives after delete';
}

# RT #116695
{
    my @array;
    @array[0,2] = (Any, 'two');
    @array[2]:delete;
    is @array.elems, 1,
        'deletion of trailing item does not purge elements we assigned to (1)';
    @array[1,2] = (Any, 'two');
    @array[2]:delete;
    is @array.elems, 2,
        'deletion of trailing item does not purge elements we assigned to (2)';
}

# RT #125457
{
    my @array = 1, 2, 3;
    @array[2]:delete;
    @array[3] = 4;
    is @array[2], Any, 'deletion of trailing item followed by add item beyond does not resurrect deleted item';
}

# RT #131783
subtest '.Slip and .List on Arrays with holes' => {
    plan 4;

    my @default-default = <a b c>;
    @default-default[1]:delete;
    @default-default[5] = 70;

    my @custom-default is default(42) = <a b c>;
    @custom-default[1]:delete;
    @custom-default[5] = 70;

    subtest '.List with default `is default` converts holes to Nil' => {
        plan 4;
        my @list := @default-default.List;
        is-deeply @list[0,2,5], ('a', 'c', 70), 'actual values are correct';
        ok @list[$_] =:= Nil, "index $_ has a Nil" for 1, 3, 4;
    }

    # The .List keeps the default as Nil, whereas .Slip uses the `is default` value
    subtest '.List with custom `is default` still converts holes to Nil' => {
        plan 4;
        my @list := @custom-default.List;
        is-deeply @list[0,2,5], ('a', 'c', 70), 'actual values are correct';
        ok @list[$_] =:= Nil, "index $_ has a Nil" for 1, 3, 4;
    }

    subtest '.Slip with default `is default` converts holes to Any' => {
        plan 4;
        my @list := @default-default.Slip;
        is-deeply @list[0,2,5], ('a', 'c', 70), 'actual values are correct';
        cmp-ok @list[$_], '===', Any, "index $_ has an Any" for 1, 3, 4;
    }

    # The .List keeps the default as Nil, whereas .Slip uses the `is default` value
    subtest '.Slip with custom `is default` converts holes to default' => {
        plan 4;
        my @list := @custom-default.Slip;
        is-deeply @list[0,2,5], ('a', 'c', 70), 'actual values are correct';
        cmp-ok @list[$_], '==', 42, "index $_ has a default value" for 1, 3, 4;
    }
}

# RT #132261
{
    (my @a = <a b c>)[1]:delete;
    @a[5] = 70;
    my @b is default(42) = @a.List;
    is-deeply @b, ["a", 42, "c", 42, 42, 70], 'Array.List fills holes with Nils';
}

# TODO More exclusive bounds checks

# TODO W/ multiple ranges
# vim: ft=perl6
