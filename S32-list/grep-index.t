use v6;
use Test;

# L<S32::Containers/"List"/"=item grep-index">

plan 35;

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
#?pugs   skip "adverbial block"
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
#?pugs skip "Can't modify constant item: VStr 'a'"
{
  my @array = <a b c d>;
  #?rakudo 2 skip 'test error -- is $_ rw here?'
  is_deeply @array.grep-index({ $_ ~= "c"; 1 })), [0..3],
    'mutating $_ in grep-index works (1)';
  is_deeply @array, [<ac bc cc dc>],
    'mutating $_ in grep-index works (2)';
}

# grep with last, next etc.
#?pugs skip "last/next in grep"
{
    is_deeply (1..16).grep-index({last if $_ % 5 == 0; $_ % 2 == 0}),
       (1,3).list.item, 'last works in grep-index';
    is_deeply (1..12).grep-index({next if $_ % 5 == 0; $_ % 2 == 0}),
       (1,3,5,7,11).list.item, 'next works in grep-index';
}

# since the test argument to .grep is a Matcher, we can also
# check type constraints:
#?pugs skip "Int"
{
    is_deeply (2, [], 4, [], 5).grep-index(Int),
       (0,2,4).list.item, ".grep-index with non-Code matcher";

    is_deeply grep-index(Int, 2, [], 4, [], 5),
       (0,2,4).list.item, "grep-index with non-Code matcher";
}

#?pugs skip 'Cannot cast from VList to VCode'
{
    my @a = <a b c>;
    my @b = <b c d>;
    is_deeply @a.grep-index(any(@b)), (1,2).list.item, 'Junction matcher';

}

# vim: ft=perl6
