use v6;
use Test;

# L<S32::Containers/"List"/"=item ">

=begin pod

built-in "list" tests

=end pod

plan 6;

my $list_sub = list(1, 2, 3);
isa_ok($list_sub, List, '&list() creates a list assignable to a scalar.');
is($list_sub, (1, 2, 3), 'The &list() function created a list.');
is(+$list_sub, 3, 'Finding the length of the list works as expected.');

#?niecza skip 'Excess arguments to List.new, used 1 of 4 positionals'
#?pugs skip 'Must only use named arguments to new() constructor'
{
my $list_obj = List.new(4, 5, 6);
isa_ok($list_obj, List, 'Creating a new list object with new works.');
is($list_obj, list(4, 5, 6), 'The list object contains the right values.');
is(+$list_obj, 3, 'Finding the length functions properly.');
}

# vim: ft=perl6

