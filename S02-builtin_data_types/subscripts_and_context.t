use v6;

use Test;

plan 8;

# "The context inside of hash and array scripts seems to be/is wrong"

# L<S02/Names and Variables/"The context in which a subscript is evaluated is no longer controlled by the sigil either.">
{
  sub return_01 { my @sub_array = ("0", "1"); return @sub_array }

  my @array  = <a b c d>;
  my @sliced = @array[return_01()];
  # @sliced *should* be <a b>, but it is <c>.
  # This is because return_012() is called in numeric context, and so return_012
  # returns the *number* of elems in @sub_array instead of the array @sub_array.
  is ~@sliced, "a b", "context inside of array subscripts for slices";
}

# Same for hashes.
{
  sub return_ab { my @sub_array = <a b>; return @sub_array }

  my %hash   = (a => 1, b => 2, c => 3);
  my @sliced = %hash{return_ab()};
  # @sliced *should* be ("1, "2").
  # The above for bug explanation.
  is ~@sliced, "1 2", "context inside of hash subscripts for slices";
}

# This time we return a single value.
{
  sub return_3 { 3   }
  sub return_c { "c" }

  my @array = <a b c d e>;
  my %hash  = (c => 12);

  is ~@array[return_3()], "d",
    "context inside of array subscripts in normal rvalue context";
  is ~%hash{return_c()},   12,
    "context inside of hash subscripts in normal rvalue context";

  @array[return_3()] = "Z";
  %hash{return_c()}  = 23;

  is @array[3], "Z", "context inside of array subscripts in lvalue context";
  is %hash<c>,   23, "context inside of hash subscripts in lvalue context";

  @array[3] = 15;
  @array[return_3()]++;
  %hash{return_c()}++;

  is @array[3],  16, 'context inside of array subscripts when used with &postfix:<++>';
  is %hash<c>,   24, 'context inside of hash subscripts when used with &postfix:<++>';
}

# vim: ft=perl6
