use v6;
use Test;

plan 13;

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
