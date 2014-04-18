use v6;
use Test;

plan 44;

for (ThreadPoolScheduler, CurrentThreadScheduler) {
    $*SCHEDULER = .new;
    isa_ok $*SCHEDULER, $_, "***** scheduling with {$_.gist}";

    {
        my $p = Supply.new;
    
        my @vals;
        my $saw_done;
        my $tap = $p.tap( -> $val { @vals.push($val) },
          done => { $saw_done = True });

        $p.more(1);
        is ~@vals, "1", "Tap got initial value";
        nok $saw_done, "No done yet";

        $p.more(2);
        $p.more(3);
        $p.done;
        is ~@vals, "1 2 3", "Tap saw all values";
        ok $saw_done, "Saw done";
    }

    {
        my $p = Supply.new;

        my @tap1_vals;
        my @tap2_vals;
        my $tap1 = $p.tap(-> $val { @tap1_vals.push($val) });

        $p.more(1);
        is ~@tap1_vals, "1", "First tap got initial value";

        my $tap2 = $p.tap(-> $val { @tap2_vals.push($val) });
        $p.more(2);
        is ~@tap1_vals, "1 2", "First tap has both values";
        is ~@tap2_vals, "2", "Second tap missed first value";

        $tap1.close;
        $p.more(3);
        is ~@tap1_vals, "1 2", "First tap closed, missed third value";
        is ~@tap2_vals, "2 3", "Second tap gets third value";
    }

    {
        my $p = Supply.for(1..10);

        my @a1;
        my $done1 = False;
        my $tap1 = $p.tap( -> $val { @a1.push($val) },
          done => { @a1.push("end"); $done1 = True });
        for ^50 { sleep .1; last if $done1 }
        ok $done1, "supply 1 was really done";
        is ~@a1, "1 2 3 4 5 6 7 8 9 10 end", "Synchronous publish worked";

        my @a2;
        my $done2 = False;
        my $tap2 = $p.tap( -> $val { @a2.push($val) },
          done => { @a2.push("end"); $done2 = True });
        for ^50 { sleep .1; last if $done2 }
        ok $done2, "supply 2 was really done";
        is ~@a2, "1 2 3 4 5 6 7 8 9 10 end", "Second tap also gets all values";
    }

#?rakudo.jvm skip "hangs"
{
        my $p = Supply.for(2..6);
        my @a;
        for $p.list {
            @a.push($_);
        }
        is ~@a, "2 3 4 5 6", "Supply.for and .list work";
}

    {
        my $p1 = Supply.for(1..10);
        my @res;
        my $done;
        $p1.map(* * 5).tap({ @res.push($_) }, :done( {$done = True} ));

        for ^50 { sleep .1; last if $done }
        ok $done, "the mapped supply was really done";
        is ~@res, '5 10 15 20 25 30 35 40 45 50', "mapping taps works";
    }

    {
        my $p1 = Supply.for(1..10);
        my @res;
        my $done;
        $p1.grep(* > 5).tap({ @res.push($_) }, :done( {$done = True} ));

        for ^50 { sleep .1; last if $done }
        ok $done, "the grepped supply was really done";
        is ~@res, '6 7 8 9 10', "grepping taps works";
    }

    {
        my $p1 = Supply.new;
        my $p2 = Supply.new;

        my @res;
        my $tap = $p1.zip($p2, &infix:<~>).tap({ @res.push($_) });

        $p1.more(1);
        $p1.more(2);
        $p2.more('a');
        $p2.more('b');
        $p2.more('c');
        $p1.done();
        $p2.done();

        is @res.join(','), '1a,2b', 'zipping taps works';
    }

#?rakudo skip "Cannot call method 'more' on a null object"
{
        my $done = False;
        my $p1 = Supply.new;
        my $p2 = Supply.new;

        my @res;
        my $tap = $p1.merge($p2).tap({ @res.push: $_ }, :done({$done = True}));

        $p1.more(1);
        $p1.more(2);
        $p2.more('a');
        $p1.more(3);
        $p1.done();
        $p2.more('b');
        $p2.done();
    
        for ^50 { sleep .1; last if $done }
        ok $done, "the merged supply was really done";
        is @res.join(','), '1,2,a,3,b', "merging taps works";
}
}
