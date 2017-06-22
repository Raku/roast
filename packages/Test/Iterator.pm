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
        plan 24;
        {
            my @a;
            my $iterator = iterator();
            until (my $pulled := $iterator.pull-one) =:= IterationEnd {
                @a.push($pulled)
            }
            is @a, @expected, "$desc: pull-one until exhausted";
        }

        {
            my $iterator = iterator();
            Nil until $iterator.push-exactly(my @a,3) =:= IterationEnd;
            is @a, @expected, "$desc: push-exactly until exhausted";
            is $iterator.pull-one, IterationEnd,
              "$desc: is iterator exhausted after a loop with push-exactly";
        }

        {
            my $iterator = iterator();
            Nil until $iterator.push-at-least(my @a,3) =:= IterationEnd;
            is @a, @expected, "$desc: push-at-least until exhausted";
            is $iterator.pull-one, IterationEnd,
              "$desc: is iterator exhausted after a loop with push-at-least";
        }

        {
            my $iterator = iterator();
            is $iterator.push-all(my @a), IterationEnd,
              "$desc: does push-all return IterationEnd";
            is @a, @expected, "$desc: push-all";
            is $iterator.pull-one, IterationEnd,
              "$desc: is iterator exhausted after a push-all";
        }

        {
            my $iterator = iterator();
            is $iterator.push-until-lazy(my @a), IterationEnd,
              "$desc: does push-until-lazy return IterationEnd";
            is @a, @expected, "$desc: push-until-lazy";
            is $iterator.pull-one, IterationEnd,
              "$desc: is iterator exhausted after a push-until-lazy";
        }

        {
            my $iterator = iterator();
            is $iterator.sink-all, IterationEnd,
              "$desc: does sink-all return IterationEnd";
            is $iterator.pull-one, IterationEnd,
              "$desc: is iterator exhausted after a sink-all";
        }

        {
            my $iterator = iterator();
            my $meen = 0;
            $meen++ while $iterator.skip-one;
            is $meen, +@expected, "$desc: skip-one until exhausted";
            is $iterator.pull-one, IterationEnd, "$desc: did skip-one exhaust?";
            is $iterator.pull-one, IterationEnd,
              "$desc: is iterator exhausted after a loop with skip-one";
        }

        {
            my $iterator = iterator();
            ok $iterator.skip-at-least(@expected - 1),
              "$desc: skip-at-least except last";
            is $iterator.pull-one, @expected[* - 1],
              "$desc: skip-at-least check last value";
            is $iterator.pull-one, IterationEnd,
              "$desc: did skip-at-least after pull-one exhaust?";
        }

        {
            my $iterator = iterator();
            is $iterator.skip-at-least-pull-one(@expected-1), @expected[*-1],
              "$desc: skip-at-least-pull-one last";
            is $iterator.pull-one, IterationEnd,
              "$desc: is iterator exhausted after skip-at-least-pull-one?";
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
