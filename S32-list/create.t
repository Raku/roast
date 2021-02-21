use v6;
use Test;

# L<S32::Containers/"List"/"=item ">

=begin pod

built-in "list" tests

=end pod

plan 11;

my $list_sub = list(1, 2, 3);
isa-ok($list_sub, List, '&list() creates a list assignable to a scalar.');
is($list_sub, (1, 2, 3), 'The &list() function created a list.');
is(+$list_sub, 3, 'Finding the length of the list works as expected.');

{
  my $list_obj = List.new(4, 5, 6);
  isa-ok($list_obj, List, 'Creating a new list object with new works.');
  is($list_obj, list(4, 5, 6), 'The list object contains the right values.');
  is(+$list_obj, 3, 'Finding the length functions properly.');
}
{
  my @list-pos is List = 1, 2, 3;
  isa-ok(@list-pos, List, "List can be created by 'is List'");
  is(@list-pos, (1, 2, 3), 'The list objects contains the right values.');
}
{ # Test for the fix in https://github.com/rakudo/rakudo/pull/4208
  my @list is List = 'foo';
  is(+@list, 1, 'The lenght is one');
  is(@list, ('foo',), 'The list constains the expected value');
}
# vim: ft=perl6


# vim: expandtab shiftwidth=4
