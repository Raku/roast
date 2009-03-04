use v6;

use Test;

plan 8;

=begin description

Basic C<keys> and C<values> tests for arrays, see S32.

=end description

my @array = <a b c d>;

# L<S32/Containers/"Array"/=item keys>
is(~@array.keys, '0 1 2 3', '@arrays.keys works');
is(~keys(@array), '0 1 2 3', 'keys(@array) works');
#?rakudo skip 'cannot parse named arguments'
is(~keys(:array(@array)), '0 1 2 3', 'keys(:array(@array)) works');
is(+@array.keys, +@array, 'we have the same number of keys as elements in the array');

# L<S32/Containers/"Array"/=item values>
is(~@array.values, 'a b c d', '@array.values works');
is(~values(@array), 'a b c d', 'values(@array) works');
#?rakudo skip 'cannot parse named arguments'
is(~values(:array(@array)), 'a b c d', 'values(:array(@array)) works');
is(+@array.values, +@array, 'we have the same number of values as elements in the array');

# vim: ft=perl6
