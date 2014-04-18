use v6;
use Test;

plan 44;

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

        my @a1;
        my $done1 = False;
        my $tap1 = $s.tap( -> $val { @a1.push($val) },
          done => { @a1.push("end"); $done1 = True });
        for ^50 { sleep .1; last if $done1 }
        ok $done1, "supply 1 was really done";
        is ~@a1, "1 2 3 4 5 6 7 8 9 10 end", "Synchronous publish worked";

        my @a2;
        my $done2 = False;
        my $tap2 = $s.tap( -> $val { @a2.push($val) },
          done => { @a2.push("end"); $done2 = True });
        for ^50 { sleep .1; last if $done2 }
        ok $done2, "supply 2 was really done";
        is ~@a2, "1 2 3 4 5 6 7 8 9 10 end", "Second tap also gets all values";
    }

#?rakudo.jvm skip "hangs"
{
        my $s = Supply.for(2..6);
        my @a;
        for $s.list {
            @a.push($_);
        }
        is ~@a, "2 3 4 5 6", "Supply.for and .list work";
}

    {
        my $s = Supply.for(1..10);
        my @res;
        my $done;
        $s.map(* * 5).tap({ @res.push($_) }, :done( {$done = True} ));

        for ^50 { sleep .1; last if $done }
        ok $done, "the mapped supply was really done";
        is ~@res, '5 10 15 20 25 30 35 40 45 50', "mapping taps works";
    }

    {
        my $s = Supply.for(1..10);
        my @res;
        my $done;
        $s.grep(* > 5).tap({ @res.push($_) }, :done( {$done = True} ));

        for ^50 { sleep .1; last if $done }
        ok $done, "the grepped supply was really done";
        is ~@res, '6 7 8 9 10', "grepping taps works";
    }

    {
        my $s1 = Supply.new;
        my $s2 = Supply.new;

        my @res;
        my $tap = $s1.zip($s2, &infix:<~>).tap({ @res.push($_) });

        $s1.more(1);
        $s1.more(2);
        $s2.more('a');
        $s2.more('b');
        $s2.more('c');
        $s1.done();
        $s2.done();

        is @res.join(','), '1a,2b', 'zipping taps works';
    }

#?rakudo skip "Cannot call method 'more' on a null object"
{
        my $done = False;
        my $s1 = Supply.new;
        my $s2 = Supply.new;

        my @res;
        my $tap = $s1.merge($s2).tap({ @res.push: $_ }, :done({$done = True}));

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
