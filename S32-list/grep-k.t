use v6;
use Test;

# L<S32::Containers/"List"/"=item grep">

plan 40;

my @list = (1 .. 10);

is grep( { ($_ % 2) }, @list, :k ).grep(Int), (0,2,4,6,8).list.item, 'do we get Ints';
is grep( { ($_ % 2) }, @list, :k ), (0,2,4,6,8).list.item,
  'simple direct test of sub';
is @list.grep( { ($_ % 2) }, :k ), (0,2,4,6,8).list.item,
  'simple direct test of method';

{
    my @result = grep { ($_ % 2) }, @list, :k;
    is(+@result, 5, 'we got a list back');
    is(@result[0], 0, 'got the value we expected');
    is(@result[1], 2, 'got the value we expected');
    is(@result[2], 4, 'got the value we expected');
    is(@result[3], 6, 'got the value we expected');
    is(@result[4], 8, 'got the value we expected');
}

#?rakudo skip "adverbial block RT #124759"
{
    my @result = @list.grep():{ ($_ % 2) }, :k;
    is(+@result, 5, 'we got a list back');
    is(@result[0], 0, 'got the value we expected');
    is(@result[1], 2, 'got the value we expected');
    is(@result[2], 4, 'got the value we expected');
    is(@result[3], 6, 'got the value we expected');
    is(@result[4], 8, 'got the value we expected');
}

#?rakudo skip "adverbial block RT #124760"
{
    my @result = @list.grep :{ ($_ % 2) }, :k;
    is(+@result, 5, 'we got a list back');
    is(@result[0], 0, 'got the value we expected');
    is(@result[1], 2, 'got the value we expected');
    is(@result[2], 4, 'got the value we expected');
    is(@result[3], 6, 'got the value we expected');
    is(@result[4], 8, 'got the value we expected');
}

#?rakudo todo "closure as non-final argument RT #124761"
{
    my @result = grep { ($_ % 2) }: @list, :k;
    is(+@result, 5, 'we got a list back');
    is(@result[0], 0, 'got the value we expected');
    is(@result[1], 2, 'got the value we expected');
    is(@result[2], 4, 'got the value we expected');
    is(@result[3], 6, 'got the value we expected');
    is(@result[4], 8, 'got the value we expected');
}

{
  is(   42.grep({ 1 }, :k), 0, "method form of grep works on numbers");
  is('str'.grep({ 1 }, :k), 0, "method form of grep works on strings");
}

#
# Grep with mutating block
#
# L<S02/Names/"$_, $!, and $/ are context<rw> by default">
{
  my @array = <a b c d>;
  is @array.grep({ $_ ~= "c"; 1 }, :k), [0..3],
    'mutating $_ in grep works (1)';
  is @array, [<ac bc cc dc>],
    'mutating $_ in grep works (2)';
}

# grep with last, next etc.
{
    is (1..16).grep({last if $_ % 5 == 0; $_ % 2 == 0}, :k),
       (1,3).list.item, 'last works in grep';
    is (1..12).grep({next if $_ % 5 == 0; $_ % 2 == 0}, :k),
       (1,3,5,7,11).list.item, 'next works in grep';
}

# since the test argument to .grep is a Matcher, we can also
# check type constraints:
{
    is (2, [], 4, [], 5).grep(Int, :k),
       (0,2,4).list.item, ".grep with non-Code matcher";

    is grep(Int, 2, [], 4, [], 5, :k),
       (0,2,4).list.item, "grep with non-Code matcher";
}

{
    my @a = <a b c>;
    my @b = <b c d>;
    is @a.grep(any(@b), :k), (1,2).list.item, 'Junction matcher';

}

# Bool handling
{
    throws-like { grep $_ == 1, 1,2,3, :k }, X::Match::Bool;
    throws-like { (1,2,3).grep: $_== 1, :k }, X::Match::Bool;
    is grep( Bool,True,False,Int, :k ), (0,1), 'can we match on Bool as type';
    is (True,False,Int).grep(Bool, :k), (0,1), 'can we match on Bool as type';
}

# vim: ft=perl6
