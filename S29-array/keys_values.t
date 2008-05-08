use v6;

use Test;

plan 6;

=begin description

Basic C<keys> and C<values> tests for arrays, see S29.

=end description

my @array = <a b c d>;

# L<S29/"Array"/=item keys>
is(~@array.keys, '0 1 2 3', '@arrays.keys works');
is(~keys(@array), '0 1 2 3', 'keys(@array) works');
is(+@array.keys, +@array, 'we have the same number of keys as elements in the array');

# L<S29/"Array"/=item values>
is(~@array.values, 'a b c d', '@array.values works');
is(~values(@array), 'a b c d', 'values(@array) works');
is(+@array.values, +@array, 'we have the same number of values as elements in the array');

