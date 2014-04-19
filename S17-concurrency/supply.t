use v6;
use Test;

plan 140;

sub tap_ok ( $s, $expected, $text ) {
    ok $s ~~ Supply, "{$s.^name} appears to be doing Supply";

    my @res;
    my $done;
    $s.tap({ @res.push($_) }, :done( {$done = True} ));

    for ^50 { sleep .1; last if $done }
    ok $done, "$text was really done";
    is_deeply @res, $expected, $text;
}

for (ThreadPoolScheduler, CurrentThreadScheduler) {
    $*SCHEDULER = .new;
    isa_ok $*SCHEDULER, $_, "***** scheduling with {$_.gist}";

    {
        my $s = Supply.new;
    
        my @vals;
        my $saw_done;
        my $tap = $s.tap( -> $val { @vals.push($val) },
          done => { $saw_done = True });

        $s.more(1);
        is ~@vals, "1", "Tap got initial value";
        nok $saw_done, "No done yet";

        $s.more(2);
        $s.more(3);
        $s.done;
        is ~@vals, "1 2 3", "Tap saw all values";
        ok $saw_done, "Saw done";
    }

    {
        my $s = Supply.new;

        my @tap1_vals;
        my @tap2_vals;
        my $tap1 = $s.tap(-> $val { @tap1_vals.push($val) });

        $s.more(1);
        is ~@tap1_vals, "1", "First tap got initial value";

        my $tap2 = $s.tap(-> $val { @tap2_vals.push($val) });
        $s.more(2);
        is ~@tap1_vals, "1 2", "First tap has both values";
        is ~@tap2_vals, "2", "Second tap missed first value";

        $tap1.close;
        $s.more(3);
        is ~@tap1_vals, "1 2", "First tap closed, missed third value";
        is ~@tap2_vals, "2 3", "Second tap gets third value";
    }

    {
        my $s = Supply.for(1..10);
        tap_ok $s, [1..10], "On demand publish worked";
        tap_ok $s, [1..10], "Second tap gets all the values";
    }

    {
        my $seen;
        tap_ok Supply.for(1..10).do( {$seen++} ),
          [1..10], ".do worked";
        is $seen, 10, "did the side effect work";
    }

    tap_ok Supply.for( [1,2],[3,4,5] ).flat,
      [1..5], "On demand publish with flat";

    tap_ok Supply.for( (1..5).map( {[$_]} ) ),
      [[1],[2],[3],[4],[5]], "On demand publish with arrays";

    tap_ok Supply.for( [1,2],[3,4,5] ).map( {.flat} ),
      [1..5], "On demand publish with flattened arrays";

#?rakudo.jvm skip "hangs"
{
        my $s = Supply.for(2..6);
        my @a;
        for $s.list {
            @a.push($_);
        }
        is ~@a, "2 3 4 5 6", "Supply.for and .list work";
}

    tap_ok Supply.for(1..10).map( * * 5 ),
      [5,10,15,20,25,30,35,40,45,50],
      "mapping tap with single values works";

    tap_ok Supply.for(1..10).map( { $_ xx 2 } ),
      [1,1,2,2,3,3,4,4,5,5,6,6,7,7,8,8,9,9,10,10],
      "mapping tap with multiple values works";

    tap_ok Supply.for(1..10).grep( * > 5 ),
      [6,7,8,9,10],
      "grepping taps works";

    tap_ok Supply.for(1..10,1..10).uniq,
      [1,2,3,4,5,6,7,8,9,10],
      "uniq tap works";

    tap_ok Supply.for(1..10).uniq(:as(* div 2)),
      [1,2,4,6,8,10],
      "uniq with as tap works";

    tap_ok Supply.for(<a A B b c C>).uniq( :with( {$^a.lc eq $^b.lc} ) ),
      [<a B c>],
      "uniq with with tap works";

    tap_ok Supply.for(<a AA B bb cc C>).uniq(
        :as( *.substr(0,1) ), :with( {$^a.lc eq $^b.lc} )
      ),
      [<a B cc>],
      "uniq with as and with tap works";

    tap_ok Supply.for(1..10,1..10).squish,
      [1,2,3,4,5,6,7,8,9,10,1,2,3,4,5,6,7,8,9,10],
      "squish tap with 2 ranges works";

    tap_ok Supply.for(1,2,2,3,3,4,4,5,5,6,6,7,7,8,8,9,9,10).squish,
      [1,2,3,4,5,6,7,8,9,10],
      "squish tap with doubling range works";

    tap_ok Supply.for(1..10).squish(:as(* div 2)),
      [1,2,4,6,8,10],
      "squish with as tap works";

    tap_ok Supply.for(<a A B b c C A>).squish( :with( {$^a.lc eq $^b.lc} ) ),
      [<a B c A>],
      "squish with with tap works";

    tap_ok Supply.for(<a AA B bb cc C AA>).squish(
        :as( *.substr(0,1) ), :with( {$^a.lc eq $^b.lc} )
      ),
      [<a B cc AA>],
      "squish with as and with tap works";

    {
        my $s1 = Supply.new;
        my $s2 = Supply.new;

        my @res;
        my $tap = $s1.zip($s2, :with( &infix:<~> )).tap({ @res.push($_) });

        $s1.more(1);
        $s1.more(2);
        $s2.more('a');
        $s2.more('b');
        $s2.more('c');
        $s1.done();
        $s2.done();

        is_deeply @res, [<1a 2b>], 'zipping taps works';
    }

#?rakudo skip "Cannot call method 'more' on a null object"
{
        my $done = False;
        my $s1 = Supply.new;
        my $s2 = Supply.new;

        my @res;
        my $ms = $s1.merge($s2);
        ok $ms ~~ Supply, "{$ms.^name} appears to be doing Supply";
        my $tap = $ms.tap({ @res.push: $_ }, :done({$done = True}));

        $s1.more(1);
        $s1.more(2);
        $s2.more('a');
        $s1.more(3);
        $s1.done();
        $s2.more('b');
        $s2.done();
    
        for ^50 { sleep .1; last if $done }
        ok $done, "the merged supply was really done";
        is @res.join(','), '1,2,a,3,b', "merging taps works";
}
}
