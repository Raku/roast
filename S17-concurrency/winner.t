use v6;
use Test;

plan 4;

#?rakudo skip 'syntax not valid yet'
{
    my $p1 = Promise.in(1);
    my $p2 = Promise.in(2);
    my @seen;
    is( do winner * {
        done $p1 { @seen.push: 'a'; 'first' }
        done $p2 { @seen.push: 'b'; 'second' }
    }, 'first', 'did we get the first promise' );
    is( do winner * {
        done $p2 { @seen.push: 'b'; 'second' }
    }, 'second', 'did we get the second promise' );
    is ~@seen, 'a b', 'did promises fire in right order';
}

#?rakudo skip 'syntax not valid yet'
{
    my $p = Publish.for(1..5);
    my $c = $p.Channel;
    my @a;
    loop {
        winner $c {
            more * => { say "pushing"; @a.push($^val) },
            done * => { say "done"; @a.push("done"); last }
        );
    }
    is ~@a, "1 2 3 4 5 done", "Publish.for and .Channel work";
}
