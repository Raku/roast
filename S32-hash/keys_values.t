use v6;

use Test;

plan 14;

=begin pod

#Basic C<keys> and C<values> tests for hashes and pairs, see S32::Containers.

=end pod

my %hash = (a => 1, b => 2, c => 3, d => 4);

# L<S32::Containers/"Hash"/=item keys>
is(~%hash.keys.sort, "a b c d", '%hash.keys works');
is(~sort(keys(%hash)), "a b c d", 'keys(%hash) on hashes');
is(+%hash.keys, +%hash, 'we have the same number of keys as elements in the hash');

# L<S32::Containers/"Hash"/=item values>
#?pugs todo
is(~%hash.values.sort, "1 2 3 4", '%hash.values works');
#?pugs todo
is(~sort(values(%hash)), "1 2 3 4", 'values(%hash) works');
is(+%hash.values, +%hash, 'we have the same number of keys as elements in the hash');

# keys and values on Pairs
my $pair = (a => 42);
#?niecza todo
is(~$pair.keys,     "a", '$pair.keys works');
#?niecza todo
is(~keys($pair),    "a", 'keys($pair) works');
is($pair.keys.elems, 1, 'we have one key');

#?niecza todo
is(~$pair.values,       42, '$pair.values works');
#?niecza todo
is(~values($pair),      42, 'values($pair) works');
is($pair.values.elems,  1,  'we have one value');

# test that .keys and .values work on Any values as well;

{
    my $x;
    lives_ok { $x.values }, 'Can call Any.values';
    lives_ok { $x.keys },   'Can call Any.keys';

}
#vim: ft=perl6
