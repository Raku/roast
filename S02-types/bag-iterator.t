use v6;
use Test;

plan 2 * 7;

# Test iterators coming from Bags

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
            my $been = 0;
            $been++ while $i.skip-one;
            is $been, +@expected, "$desc: skip-one until exhausted";
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
    <a b b c c c d d d d>.Bag,       "Bag",
    <a b b c c c d d d d>.BagHash,   "BagHash"

-> $b, $case {
    my @pairs = $b.pairs;
    t( { $b.iterator },           "$case", @pairs );
    t( { $b.kv.iterator },        "$case.kv", @pairs.map: { |(.key,.value) } );
    t( { $b.keys.iterator },      "$case.keys", @pairs.map: { .key } );
    t( { $b.values.iterator },    "$case.values", @pairs.map: { .value } );
    t( { $b.pairs.iterator },     "$case.pairs", @pairs );
    t( { $b.antipairs.iterator }, "$case.antipairs", @pairs.map: { .antipair });
    t( { $b.invert.iterator },    "$case.invert", @pairs.map: { .antipair });
}

#vim: ft=perl6
