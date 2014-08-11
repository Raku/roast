use v6;
use Test;

# L<S32::Containers/"List"/"=item grep-index">

plan 39;

my @list = (1 .. 10);

is_deeply grep-index( { ($_ % 2) }, @list ), (0,2,4,6,8).list.item,
  'simple direct test of sub';
is_deeply @list.grep-index( { ($_ % 2) } ), (0,2,4,6,8).list.item,
  'simple direct test of method';

{
    my @result = grep-index { ($_ % 2) }, @list;
    is(+@result, 5, 'we got a list back');
    is(@result[0], 0, 'got the value we expected');
    is(@result[1], 2, 'got the value we expected');
    is(@result[2], 4, 'got the value we expected');
    is(@result[3], 6, 'got the value we expected');
    is(@result[4], 8, 'got the value we expected');
}

#?rakudo skip "adverbial block"
#?niecza skip 'NYI'
{
    my @result = @list.grep-index():{ ($_ % 2) };
    is(+@result, 5, 'we got a list back');
    is(@result[0], 0, 'got the value we expected');
    is(@result[1], 2, 'got the value we expected');
    is(@result[2], 4, 'got the value we expected');
    is(@result[3], 6, 'got the value we expected');
    is(@result[4], 8, 'got the value we expected');
}

#?rakudo skip "adverbial block"
#?niecza skip 'NYI'
{
    my @result = @list.grep-index :{ ($_ % 2) };
    is(+@result, 5, 'we got a list back');
    is(@result[0], 0, 'got the value we expected');
    is(@result[1], 2, 'got the value we expected');
    is(@result[2], 4, 'got the value we expected');
    is(@result[3], 6, 'got the value we expected');
    is(@result[4], 8, 'got the value we expected');
}

#?rakudo skip "closure as non-final argument"
#?niecza skip 'Invocant handling is NYI'
{
    my @result = grep-index { ($_ % 2) }: @list;
    is(+@result, 5, 'we got a list back');
    is(@result[0], 0, 'got the value we expected');
    is(@result[1], 2, 'got the value we expected');
    is(@result[2], 4, 'got the value we expected');
    is(@result[3], 6, 'got the value we expected');
    is(@result[4], 8, 'got the value we expected');
}

{
  is(   42.grep-index({ 1 }), 0, "method form of grep works on numbers");
  is('str'.grep-index({ 1 }), 0, "method form of grep works on strings");
}

#
# Grep with mutating block
#
# L<S02/Names/"$_, $!, and $/ are context<rw> by default">
{
  my @array = <a b c d>;
  #?rakudo 2 skip 'test error -- is $_ rw here?'
  is_deeply @array.grep-index({ $_ ~= "c"; 1 })), [0..3],
    'mutating $_ in grep-index works (1)';
  is_deeply @array, [<ac bc cc dc>],
    'mutating $_ in grep-index works (2)';
}

# grep-index with last, next etc.
{
    is_deeply (1..16).grep-index({last if $_ % 5 == 0; $_ % 2 == 0}),
       (1,3).list.item, 'last works in grep-index';
    is_deeply (1..12).grep-index({next if $_ % 5 == 0; $_ % 2 == 0}),
       (1,3,5,7,11).list.item, 'next works in grep-index';
}

# since the test argument to .grep-index is a Matcher, we can also
# check type constraints:
{
    is_deeply (2, [], 4, [], 5).grep-index(Int),
       (0,2,4).list.item, ".grep-index with non-Code matcher";

    is_deeply grep-index(Int, 2, [], 4, [], 5),
       (0,2,4).list.item, "grep-index with non-Code matcher";
}

{
    my @a = <a b c>;
    my @b = <b c d>;
    is_deeply @a.grep-index(any(@b)), (1,2).list.item, 'Junction matcher';

}

# Bool handling
{
    throws_like { grep-index $_ == 1, 1,2,3 }, X::Match::Bool;
    throws_like { (1,2,3).grep-index: $_== 1 }, X::Match::Bool;
    is grep-index( Bool,True,False,Int ), (0,1), 'can we match on Bool as type';
    is (True,False,Int).grep-index(Bool), (0,1), 'can we match on Bool as type';
}

# vim: ft=perl6
