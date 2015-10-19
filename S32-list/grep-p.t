use v6;
use Test;

# L<S32::Containers/"List"/"=item grep">

plan 17;

my @list = (1 .. 10);

is grep( { ($_ % 2) }, @list, :p ).grep(Pair), [0=>1,2=>3,4=>5,6=>7,8=>9],
  'do we get Pairs';

is grep( { ($_ % 2) }, @list, :p ), [0=>1,2=>3,4=>5,6=>7,8=>9],
  'simple direct test of sub';
is @list.grep( { ($_ % 2) }, :p ), [0=>1,2=>3,4=>5,6=>7,8=>9],
  'simple direct test of method';

{
  is    42.grep({ 1 }, :p), [0=>42],
    "method form of grep works on numbers";
  is 'str'.grep({ 1 }, :p), [0=>'str'],
    "method form of grep works on strings";
}

#
# Grep with mutating block
#
# L<S02/Names/"$_, $!, and $/ are context<rw> by default">
{
  my @array = <a b c d>;
  is @array.grep({ $_ ~= "c"; 1 }, :p), [0=>'ac',1=>'bc',2=>'cc',3=>'dc'],
    'mutating $_ in grep works (1)';
  is @array, [<ac bc cc dc>],
    'mutating $_ in grep works (2)';
}

# grep with last, next etc.
{
    is (1..16).grep({last if $_ % 5 == 0; $_ % 2 == 0}, :p),
       [1=>2,3=>4], 'last works in grep';
    is (1..12).grep({next if $_ % 5 == 0; $_ % 2 == 0}, :p),
       [1=>2,3=>4,5=>6,7=>8,11=>12], 'next works in grep';
}

# since the test argument to .grep is a Matcher, we can also
# check type constraints:
{
    is (2, [], 4, [], 5).grep(Int, :p),
       [0=>2,2=>4,4=>5], ".grep with non-Code matcher";

    is grep(Int, 2, [], 4, [], 5, :p),
       [0=>2,2=>4,4=>5], "grep with non-Code matcher";
}

{
    my @a = <a b c>;
    my @b = <b c d>;
    is @a.grep(any(@b), :p), [1=>'b',2=>'c'], 'Junction matcher';

}

# Bool handling
{
    throws-like { grep $_ == 1, 1,2,3, :p }, X::Match::Bool;
    throws-like { (1,2,3).grep: $_== 1, :p }, X::Match::Bool;
    is grep( Bool,True,False,Int, :p ), [0=>True,1=>False],
      'can we match on Bool as type';
    is (True,False,Int).grep(Bool, :p), [0=>True,1=>False],
      'can we match on Bool as type';
}

# :!p handling
{
    is (^10).grep(Int, :!p), [^10], 'is :!p the same as no attribute';
}

# vim: ft=perl6
