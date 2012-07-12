use v6;

use Test;

plan 8;

=begin description

Basic C<keys> and C<values> tests for arrays, see S32.

=end description

my @array = <a b c d>;

# L<S32::Containers/"Array"/=item keys>
is(~@array.keys, '0 1 2 3', '@arrays.keys works');
is(~keys(@array), '0 1 2 3', 'keys(@array) works');
is(+@array.keys, +@array, 'we have the same number of keys as elements in the array');

# L<S32::Containers/"Array"/=item values>
is(~@array.values, 'a b c d', '@array.values works');
is(~values(@array), 'a b c d', 'values(@array) works');
is(+@array.values, +@array, 'we have the same number of values as elements in the array');

my $v := @array.values;
$v.shift; $v.shift;
is($v.elems, 2, "shifting .values removes an element...");
is(@array.elems, 4, "...while leaving original list alone.");

# vim: ft=perl6
