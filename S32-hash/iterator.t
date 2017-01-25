use v6;
use Test;

plan 4 * 7;

# Test iterators coming from Hashes

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
            my $seen = 0;
            $seen++ while $i.skip-one;
            is $seen, +@expected, "$desc: skip-one until exhausted";
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
    (my % = "a" .. "z" Z=> 1..26),          "hash",
    (my %{Any} = "a" .. "z" Z=> 1..26),     "hash\{Any}",
    (my Int % = "a" .. "z" Z=> 1..26),      "Int Hash",
    (my Int %{Any} = "a" .. "z" Z=> 1..26), "Int Hash\{Any}"

-> %h, $case {
    my @pairs = %h.pairs;
    t( { %h.iterator },           "$case", @pairs );
    t( { %h.kv.iterator },        "$case.kv", @pairs.map: { |(.key,.value) } );
    t( { %h.keys.iterator },      "$case.keys", @pairs.map: { .key } );
    t( { %h.values.iterator },    "$case.values", @pairs.map: { .value } );
    t( { %h.pairs.iterator },     "$case.pairs", @pairs );
    t( { %h.antipairs.iterator }, "$case.antipairs", @pairs.map: { .antipair });
    t( { %h.invert.iterator },    "$case.invert", @pairs.map: { .antipair });
}

#vim: ft=perl6
