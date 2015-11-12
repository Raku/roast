use v6;
use Test;

# L<S32::Containers/"List"/"=item grep">

plan 17;

my @list = (1 .. 10);

is grep( { ($_ % 2) }, @list, :v ).grep(Int), [1,3,5,7,9],
  'do we get Ints';

is grep( { ($_ % 2) }, @list, :v ), [1,3,5,7,9],
  'simple direct test of sub';
is @list.grep( { ($_ % 2) }, :v ), [1,3,5,7,9],
  'simple direct test of method';

{
  is    42.grep({ 1 }, :v), [42],
    "method form of grep works on numbers";
  is 'str'.grep({ 1 }, :v), ['str'],
    "method form of grep works on strings";
}

#
# Grep with mutating block
#
# L<S02/Names/"$_, $!, and $/ are context<rw> by default">
{
  my @array = <a b c d>;
  is @array.grep({ $_ ~= "c"; 1 }, :v), [<ac bc cc dc>],
    'mutating $_ in grep works (1)';
  is @array, [<ac bc cc dc>],
    'mutating $_ in grep works (2)';
}

# grep with last, next etc.
{
    is (1..16).grep({last if $_ % 5 == 0; $_ % 2 == 0}, :v),
       [2,4], 'last works in grep';
    is (1..12).grep({next if $_ % 5 == 0; $_ % 2 == 0}, :v),
       [2,4,6,8,12], 'next works in grep';
}

# since the test argument to .grep is a Matcher, we can also
# check type constraints:
{
    is (2, [], 4, [], 5).grep(Int, :v),
       [2,4,5], ".grep with non-Code matcher";

    is grep(Int, 2, [], 4, [], 5, :v),
       [2,4,5], "grep with non-Code matcher";
}

{
    my @a = <a b c>;
    my @b = <b c d>;
    is @a.grep(any(@b), :v), [<b c>], 'Junction matcher';

}

# Bool handling
{
    throws-like { grep $_ == 1, 1,2,3, :v }, X::Match::Bool;
    throws-like { (1,2,3).grep: $_== 1, :v }, X::Match::Bool;
    is grep( Bool,True,False,Int, :v ), [True,False],
      'can we match on Bool as type';
    is (True,False,Int).grep(Bool, :v), [True,False],
      'can we match on Bool as type';
}

# :!v handling
{
    throws-like { (^10).grep(Int, :!v) }, Exception;
}

# vim: ft=perl6
