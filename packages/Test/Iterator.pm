use v6;
unit module Test::Iterator;

use Test;

# Test whether all iterator functions work as expected on an
# iterator.
# First parameter is Callable that generates a fresh iterator.
# Second parameter is a description for this group of tests.
# Rest is a slurpy with the expected result of pulling all
# values from the iterator.
sub iterator-ok(&iterator, $desc, *@expected) is export {
    subtest {
        plan 17;
        {
            my @a;
            my $i = iterator();
            until (my $pulled := $i.pull-one) =:= IterationEnd {
                @a.push($pulled)
            }
            is @a, @expected, "$desc: pull-one until exhausted";
        }

        {
            my $i = iterator();
            Nil until $i.push-exactly(my @a,3) =:= IterationEnd;
            is @a, @expected, "$desc: push-exactly until exhausted";
        }

        {
            my $i = iterator();
            Nil until $i.push-at-least(my @a,3) =:= IterationEnd;
            is @a, @expected, "$desc: push-at-least until exhausted";
        }

        {
            is iterator().push-all(my @a), IterationEnd,
              "$desc: does push-all return IterationEnd";
            is @a, @expected, "$desc: push-all";
        }

        {
            is iterator().push-until-lazy(my @a), IterationEnd,
              "$desc: does push-until-lazy return IterationEnd";
            is @a, @expected, "$desc: push-until-lazy";
        }

        {
            is iterator().sink-all, IterationEnd,
              "$desc: does sink-all return IterationEnd";
        }

        {
            my $i = iterator();
            my $meen = 0;
            $meen++ while $i.skip-one;
            is $meen, +@expected, "$desc: skip-one until exhausted";
            is $i.pull-one, IterationEnd, "$desc: did skip-one exhaust?";
        }

        {
            my $i = iterator();
            ok $i.skip-at-least(@expected - 1),
              "$desc: skip-at-least except last";
            is $i.pull-one, @expected[* - 1],
              "$desc: skip-at-least check last value";
            is $i.pull-one, IterationEnd,
              "$desc: did skip-at-least after pull-one exhaust?";
        }

        {
            is iterator().skip-at-least-pull-one(@expected-1), @expected[*-1],
              "$desc: skip-at-least-pull-one last";
        }

        {
            my $iterator = iterator();
            $iterator.can('count-only')
              ?? is( $iterator.count-only, +@expected, "$desc: count-only" )
              !! pass( "$desc: doesn't support count-only" );
            $iterator.can('bool-only')
              ?? ok( $iterator.bool-only, "$desc: bool-only" )
              !! pass( "$desc: doesn't support bool-only" );
            $iterator.push-all(my @a);
            is @a, @expected, "$desc: count/bool-only didn't pull";
        }
    }, "tests for $desc";
}

#vim: ft=perl6
