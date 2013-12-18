use v6;
use Test;

plan 4;

#?rakudo.parrot skip 'no implementation of promise/winner'
{
    my $p1 = Promise.in(1);
    my $p2 = Promise.in(2);
    my @seen;
    is( winner * {
        done $p1 { @seen.push: 'a'; 'first' }
        done $p2 { @seen.push: 'b'; 'second' }
    }, 'first', 'did we get the first promise' );
    is(winner * {
        done $p2 { @seen.push: 'b'; 'second' }
    }, 'second', 'did we get the second promise' );
    is ~@seen, 'a b', 'did promises fire in right order';
}

#?rakudo.parrot skip 'no implementation of supply/winner'
{
    my $p = Supply.for(1..5);
    my $c = $p.Channel;
    my @a;
    loop {
        winner $c {
            more * -> $val { @a.push($val) }
            done * -> { @a.push("done"); last }
        }
    }
    is ~@a, "1 2 3 4 5 done", "Publish.for and .Channel work";
}
