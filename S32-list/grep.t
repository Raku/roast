use v6;
use Test;

# L<S32::Containers/"List"/"=item grep">

=begin pod

built-in grep tests

=end pod

plan 49;

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
{
    my @result = @list.grep :{ ($_ % 2) };
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
{
  my @array = <a b c d>;
  is ~(@array.grep({ $_ ~= "c"; 1 })), "ac bc cc dc",
    'mutating $_ in grep works (1)';
  is ~@array, "ac bc cc dc",
    'mutating $_ in grep works (2)';
}

# grep with last, next etc.
{
    is (1..16).grep({last if $_ % 5 == 0; $_ % 2 == 0}).join('|'),
       '2|4', 'last works in grep';
    is (1..12).grep({next if $_ % 5 == 0; $_ % 2 == 0}).join('|'),
       '2|4|6|8|12', 'next works in grep';
    # https://github.com/Raku/old-issue-tracker/issues/5329
    is (^Inf).grep({last if $_ > 5; True}).eager.join, '012345',
        'last in grep on infinite list';
    # https://github.com/Raku/old-issue-tracker/issues/5992
    {
        my $retries = 0;
        is (1..5).grep({
            if $_ == 3 {
                $retries++;
                redo unless $retries == 3
            };
            $_
        }).join('|'), '1|2|3|4|5', 'redo works in grep (1)';
        is $retries, 3, 'redo works in grep (2)';
    }
}

# since the test argument to .grep is a Matcher, we can also
# check type constraints:
{
    is (2, [], 4, [], 5).grep(Int).join(','),
       '2,4,5', ".grep with non-Code matcher";

    is grep(Int, 2, [], 4, [], 5).join(','),
       '2,4,5', "grep() with non-Code matcher";
}

# https://github.com/Raku/old-issue-tracker/issues/1456
{
    my @in = ( 1, 1, 2, 3, 4, 4 );

# This test passes, but it's disabled because it doesn't belong here.
# It just kind of clarifies the test that follows.
#    is (map { $^a == $^b }, @in), (?1, ?0, ?1), 'map takes two at a time';

    is (grep { $^a == $^b }, @in), (1, 1, 4, 4), 'grep takes two at a time';
}

{
    my @a = <a b c>;
    my @b = <b c d>;
    is @a.grep(any(@b)).join('|'), 'b|c', 'Junction matcher';

}

# sensible boolification
# https://github.com/Raku/old-issue-tracker/issues/1661
# since rakudo returns an iterator (and not a list) and some internals leaked,
# a zero item list/iterator would return True, which is obviously wrong
{
    ok <0 1 2>.grep(1), 'Non-empty return value from grep is true (1)';
    ok <0 1 2>.grep(0), 'Non-empty return value from grep is true (2)';
    nok <0 1 2>.grep(3), 'Empty return value from grep is false';
}

# chained greps
{
    is ~(1...100).grep(* %% 2).grep(* %% 3), ~(6, 12 ... 96), "chained greps work";
}

# Bool handling
{
    # `temp $_` business is merely to avoid warnings while we use the most
    # likely variable a user might misuse in the erroneous version of `grep`
    throws-like ｢temp $_ = 42; grep $_ == 1, 1,2,3｣,  X::Match::Bool;
    throws-like ｢temp $_ = 42; (1,2,3).grep: $_== 1｣, X::Match::Bool;
    is grep( Bool,True,False,Int ), (True,False), 'can we match on Bool as type';
    is (True,False,Int).grep(Bool), (True,False), 'can we match on Bool as type';
}

# https://github.com/Raku/old-issue-tracker/issues/3180
{
    my @a = 1..10;
    @a.grep(* %% 2).>>++;
    is @a, <1 3 3 5 5 7 7 9 9 11>,
        'grep is rw-like, can chain it to modify elements of grepped list/array';
}

# https://github.com/Raku/old-issue-tracker/issues/5499
{
    is (^∞).grep(*.is-prime).is-lazy, True, '.grep propagates .is-lazy';
    is (grep *.is-prime, ^∞).is-lazy, True, 'grep() propagates .is-lazy';
}

# grep with an unexpected adverb
{
    throws-like(
        { @list.grep(Mu, :asdfblargs) },
        X::Adverb, :unexpected{.contains: 'asdfblargs'},
        'grep on an instance with an unexpected adverb'
    );
    throws-like(
        { List.grep(Mu, :asdfblargs) },
        X::Adverb, :unexpected{.contains: 'asdfblargs'},
        'grep on a type object with an unexpected adverb'
    );
}

# https://irclog.perlgeek.de/perl6/2018-03-04#i_15882545
#?rakudo.jvm skip 'hangs: Exception in thread "Thread-1" UnwindException'
#?DOES 1
{
  subtest '.grep(Regex) on hyper/race Seq do not crash' => {
    plan 4;
    is-deeply "a\nb\nc\nbo\n".lines.race.grep(/b/).List,  <b bo>, 'race basic';
    is-deeply "a\nb\nc\nbo\n".lines.hyper.grep(/b/).List, <b bo>, 'hyper basic';

    my @has    := (^10_000).eager;
    my @wanted := @has.grep(*.contains: '2').List;
    my $w = '2';
    is-deeply @has.race.grep( /$w/).sort.List, @wanted, 'race, with shared var';
    is-deeply @has.hyper.grep(/$w/).List,      @wanted, 'hyper, w/  shared var';
  }
}

# https://github.com/rakudo/rakudo/issues/2614
is-deeply ("foo").grep({ /foo/ }), ("foo",),
    'Block returning a regex to grep will Do The Right Thing, dubious as it is';

# R#2975
{
    is-deeply ((0, 0), (0, 1), (1, 1)).grep(*.any), ((0,1),(1,1)),
      'is any junction handled correctly in grep';
    is-deeply ((0, 0), (0, 1), (1, 1)).grep(*.one), ((0,1),),
      'is one junction handled correctly in grep';
    is-deeply ((0, 0), (0, 1), (1, 1)).grep(*.none), ((0,0),),
      'is none junction handled correctly in grep';
}

# vim: expandtab shiftwidth=4
