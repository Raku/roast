use v6;
use Test;

plan 2 * 7;

# Test iterators coming from Mixes

sub t(&iterator, $desc, *@expected) {
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

for 
    (a => 1.1, b => 2.2, c => 3.3, d => 4.4).Mix,       "Mix",
    (a => 1.1, b => 2.2, c => 3.3, d => 4.4).MixHash,   "MixHash"

-> $m, $case {
    my @pairs = $m.pairs;
    t( { $m.iterator },           "$case", @pairs );
    t( { $m.kv.iterator },        "$case.kv", @pairs.map: { |(.key,.value) } );
    t( { $m.keys.iterator },      "$case.keys", @pairs.map: { .key } );
    t( { $m.values.iterator },    "$case.values", @pairs.map: { .value } );
    t( { $m.pairs.iterator },     "$case.pairs", @pairs );
    t( { $m.antipairs.iterator }, "$case.antipairs", @pairs.map: { .antipair });
    t( { $m.invert.iterator },    "$case.invert", @pairs.map: { .antipair });
}

#vim: ft=perl6
