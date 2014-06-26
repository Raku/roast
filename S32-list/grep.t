use v6;
use Test;

# L<S32::Containers/"List"/"=item grep">

=begin pod

built-in grep tests

=end pod

plan 38;

my @list = (1 .. 10);

{
    my @result = grep { ($_ % 2) }, @list;
    is(+@result, 5, 'we got a list back');
    is(@result[0], 1, 'got the value we expected');
    is(@result[1], 3, 'got the value we expected');
    is(@result[2], 5, 'got the value we expected');
    is(@result[3], 7, 'got the value we expected');
    is(@result[4], 9, 'got the value we expected');
}

#?rakudo skip "adverbial block"
#?niecza skip 'No value for parameter Mu $sm in Any.grep'
{
    my @result = @list.grep():{ ($_ % 2) };
    is(+@result, 5, 'we got a list back');
    is(@result[0], 1, 'got the value we expected');
    is(@result[1], 3, 'got the value we expected');
    is(@result[2], 5, 'got the value we expected');
    is(@result[3], 7, 'got the value we expected');
    is(@result[4], 9, 'got the value we expected');
}

#?rakudo skip "adverbial block"
#?pugs   skip "adverbial block"
#?niecza skip 'No value for parameter Mu $sm in Any.grep'
{
    my @result = @list.grep :{ ($_ % 2) };
    is(+@result, 5, 'we got a list back');
    is(@result[0], 1, 'got the value we expected');
    is(@result[1], 3, 'got the value we expected');
    is(@result[2], 5, 'got the value we expected');
    is(@result[3], 7, 'got the value we expected');
    is(@result[4], 9, 'got the value we expected');
}

#?rakudo skip "closure as non-final argument"
#?niecza skip 'Invocant handling is NYI'
{
    my @result = grep { ($_ % 2) }: @list;
    is(+@result, 5, 'we got a list back');
    is(@result[0], 1, 'got the value we expected');
    is(@result[1], 3, 'got the value we expected');
    is(@result[2], 5, 'got the value we expected');
    is(@result[3], 7, 'got the value we expected');
    is(@result[4], 9, 'got the value we expected');
}

{
  is(42.grep({ 1 }), "42",     "method form of grep works on numbers");
  is('str'.grep({ 1 }), 'str', "method form of grep works on strings");
}

#
# Grep with mutating block
#
# L<S02/Names/"$_, $!, and $/ are context<rw> by default">
#?pugs skip "Can't modify constant item: VStr 'a'"
{
  my @array = <a b c d>;
  is ~(@array.grep({ $_ ~= "c"; 1 })), "ac bc cc dc",
    'mutating $_ in grep works (1)';
  is ~@array, "ac bc cc dc",
    'mutating $_ in grep works (2)';
}

# grep with last, next etc.
#?pugs skip "last/next in grep"
{
    is (1..16).grep({last if $_ % 5 == 0; $_ % 2 == 0}).join('|'),
       '2|4', 'last works in grep';
    is (1..12).grep({next if $_ % 5 == 0; $_ % 2 == 0}).join('|'),
       '2|4|6|8|12', 'next works in grep';
}

# since the test argument to .grep is a Matcher, we can also
# check type constraints:
#?pugs skip "Int"
{
    is (2, [], 4, [], 5).grep(Int).join(','),
       '2,4,5', ".grep with non-Code matcher";

    is grep(Int, 2, [], 4, [], 5).join(','),
       '2,4,5', "grep() with non-Code matcher";
}

# RT 71544
#?niecza skip 'No value for parameter $b in ANON'
{
    my @in = ( 1, 1, 2, 3, 4, 4 );

# This test passes, but it's disabled because it doesn't belong here.
# It just kind of clarifies the test that follows.
#    is (map { $^a == $^b }, @in), (?1, ?0, ?1), 'map takes two at a time';

    #?rakudo skip 'RT 71544: grep arity sensitivity different from map'
    #?pugs todo
    is (grep { $^a == $^b }, @in), (1, 1, 4, 4), 'grep takes two at a time';
}

#?pugs skip 'Cannot cast from VList to VCode'
{
    my @a = <a b c>;
    my @b = <b c d>;
    is @a.grep(any(@b)).join('|'), 'b|c', 'Junction matcher';

}

# sensible boolification
# RT #74056
# since rakudo returns an iterator (and not a list) and some internals leaked,
# a zero item list/iterator would return True, which is obviously wrong
#?pugs skip 'Cannot cast from VList to VCode'
{
    ok <0 1 2>.grep(1), 'Non-empty return value from grep is true (1)';
    ok <0 1 2>.grep(0), 'Non-empty return value from grep is true (2)';
    nok <0 1 2>.grep(3), 'Empty return value from grep is false';
}

# chained greps
#?pugs skip "..."
{
    is ~(1...100).grep(* %% 2).grep(* %% 3), ~(6, 12 ... 96), "chained greps work";
}

done;

# vim: ft=perl6
