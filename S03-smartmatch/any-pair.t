use v6;
use Test;
plan 10;

#L<S03/Smart matching/Any Pair test object attribute>
{
    # ?."{X.key}" === ?X.value
    # means:
    # call the method with the name of X.key on the object, coerce to
    # Bool, and check if it's the same as boolean value of X.value

    class SmartmatchTest::AttrPair {
        has $.a = 4;
        has $.b = 'foo';
        has $.c = Mu;
    }
    my $o = SmartmatchTest::AttrPair.new();
    ok  ($o ~~ :a(4)),      '$obj ~~ Pair (Int, +)';
    ok  ($o ~~ :a(2)),      '$obj ~~ Pair (Int, +)';
    ok !($o ~~ :b(0)),      '$obj ~~ Pair (different types)';
    ok  ($o ~~ :b<foo>),    '$obj ~~ Pair (Str, +)';
    ok  ($o ~~ :b<ugh>),    '$obj ~~ Pair (Str, -)';
    ok  ($o ~~ :c(Mu)),     '$obj ~~ Pair (Mu, +)';
    ok  ($o ~~ :c(0)),      '$obj ~~ Pair (0, +)';
    ok !($o ~~ :b(Mu)),     '$obj ~~ Pair (Mu, -)';
    # not explicitly specced, but implied by the spec and decreed 
    # by TimToady: non-existing method or attribute dies:
    # http://irclog.perlgeek.de/perl6/2009-07-06#i_1293199
    #?niecza skip 'TODO'
    dies_ok {$o ~~ :e(Mu)},  '$obj ~~ Pair, nonexistent, dies (1)';
    #?niecza skip 'TODO'
    dies_ok {$o ~~ :e(5)},      '$obj ~~ Pair, nonexistent, dies (2)';
}

done;

# vim: ft=perl6
