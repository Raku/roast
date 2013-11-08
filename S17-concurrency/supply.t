use v6;
use Test;

plan 17;

{
    my $p = Publisher.new;
    
    my @vals;
    my $saw_last;
    my $s = $p.subscribe(
        -> $val { @vals.push($val) },
        { $saw_last = True });

    $p.next(1);
    is @vals.join, "1", "Subscriber got initial value";
    nok $saw_last, "No last yet";
    
    $p.next(2);
    $p.next(3);
    $p.last();
    is @vals.join, "123", "Subscriber saw all values";
    ok $saw_last, "Saw last";
}

{
    my $p = Publisher.new;
    
    my @s1_vals;
    my @s2_vals;
    my $s1 = $p.subscribe(-> $val { @s1_vals.push($val) });
    
    $p.next(1);
    is @s1_vals.join, "1", "First subscriber got initial value";
    
    my $s2 = $p.subscribe(-> $val { @s2_vals.push($val) });
    $p.next(2);
    is @s1_vals.join, "12", "First subscriber has both values";
    is @s2_vals.join, "2", "Second subscriber missed first value";
    
    $s1.unsubscribe();
    $p.next(3);
    is @s1_vals.join, "12", "First subscriber unsubscribed, missed third value";
    is @s2_vals.join, "23", "Second subscriber gets third value";
}


{
    my $p = Publish.for(1..10, :scheduler(CurrentThreadScheduler));
    
    my @a1;
    my $s1 = $p.subscribe(
        -> $val { @a1.push($val) },
        { @a1.push("end") });
    is @a1.join, "12345678910end", "Synchronous publish worked";
    
    my @a2;
    my $s2 = $p.subscribe(
        -> $val { @a2.push($val) },
        { @a2.push("end") });
    is @a2.join, "12345678910end", "Second subscribe also gets all values";
}

{
    my $p = Publish.for(1..5);
    my $c = $p.Channel;
    my @a;
    loop {
        select(
            $c       => { @a.push($^val) },
            $c.closed => { @a.push("done"); last }
        );
    }
    is @a.join, "12345done", "Publish.for and .Channel work";
}

{
    my $p = Publish.for(2..6);
    my @a;
    for $p.list {
        @a.push($_);
    }
    is @a.join, "23456", "Publish.for and .list work";
}

{
    my $p1 = Publisher.new;
    my $p2 = Publisher.new;

    my @res;
    my $s = $p1.zip($p2, &infix:<~>).subscribe({ @res.push($_) });

    $p1.next(1);
    $p1.next(2);
    $p2.next('a');
    $p2.next('b');
    $p2.next('c');
    $p1.last();
    $p2.last();
    
    is @res.join(','), '1a,2b', 'zipping subscribables works';
}

{
    my $p1 = Publisher.new;
    my $p2 = Publisher.new;

    my @res;
    my $s = $p1.merge($p2).subscribe({ @res.push($_) });

    $p1.next(1);
    $p1.next(2);
    $p2.next('a');
    $p1.next(3);
    $p1.last();
    $p2.next('b');
    
    is @res.join(','), '1,2,a,3,b', "merging subscribables works";
}

{
    my $p1 = Publish.for(1..10, :scheduler(CurrentThreadScheduler));
    my @res;
    $p1.grep(* > 5).subscribe({ @res.push($_) });
    is @res.join(','), '6,7,8,9,10', "grepping subscribables works";
}

{
    my $p1 = Publish.for(1..5, :scheduler(CurrentThreadScheduler));
    my @res;
    $p1.map(2 * *).subscribe({ @res.push($_) });
    is @res.join(','), '2,4,6,8,10', "mapping subscribables works";
}
