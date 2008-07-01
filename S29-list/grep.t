use v6;
use Test;

# L<S29/"List"/"=item grep">

=begin pod

built-in grep tests

=end pod

plan 29;

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

#?rakudo skip "adverbial closure"
{
    my @result = @list.grep():{ ($_ % 2) };
    is(+@result, 5, 'we got a list back');
    is(@result[0], 1, 'got the value we expected');
    is(@result[1], 3, 'got the value we expected');
    is(@result[2], 5, 'got the value we expected');
    is(@result[3], 7, 'got the value we expected');
    is(@result[4], 9, 'got the value we expected');
}

#?rakudo skip "adverbial closure"
{
    my @result = @list.grep :{ ($_ % 2) };
    is(+@result, 5, 'we got a list back');
    is(@result[0], 1, 'got the value we expected');
    is(@result[1], 3, 'got the value we expected');
    is(@result[2], 5, 'got the value we expected');
    is(@result[3], 7, 'got the value we expected');
    is(@result[4], 9, 'got the value we expected');
}

#?rakudo skip "adverbial closure"
{
    my @result = grep { ($_ % 2) }: @list;
    is(+@result, 5, 'we got a list back'); 
    is(@result[0], 1, 'got the value we expected'); 
    is(@result[1], 3, 'got the value we expected'); 
    is(@result[2], 5, 'got the value we expected'); 
    is(@result[3], 7, 'got the value we expected'); 
    is(@result[4], 9, 'got the value we expected'); 
}

# .grep shouldn't work on non-arrays
{
  #?pugs 2 todo 'bug'
  dies_ok { 42.grep: { $_ } },    "method form of grep should not work on numbers";
  dies_ok { "str".grep: { $_ } }, "method form of grep should not work on strings";
  #?rakudo skip "Arity problem"
  is ~(42,).grep: { 1 }, "42",    "method form of grep should work on arrays";
}

#
# Grep with mutating block
#
# L<S02/Names/"$_, $!, and $/ are context<rw> by default">

{
  my @array = <a b c d>;
  is ~(try { @array.grep: { $_ ~= "c"; 1 } }), "ac bc cc dc",
    'mutating $_ in grep works (1)';
  is ~@array, "ac bc cc dc",
    'mutating $_ in grep works (2)';
}

