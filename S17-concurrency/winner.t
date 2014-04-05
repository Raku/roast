use v6;
use Test;

plan 9;

#?rakudo.parrot skip 'no implementation of promise/winner'
#?rakudo.moar skip ':in NYI'
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
    is ~@seen, 'a b', 'did p1,p2 fire in right order';
}

#?rakudo.parrot skip 'no implementation of promise/winner'
{
    my @p = start( { sleep 1; 'a' } ), start( { sleep 2; 'b' } );
    my @seen;
    is( winner * {
        done @p { @seen.push: $:v; $:k }
    }, 0, 'did we get the first promise' );
    sleep 1;
    is(winner * {
        done @p { @seen.push: $:v; $:k }
    }, (0|1), 'did we get the first or second promise' );
    is ~@seen, ('a b'|'a a'), 'did @p fire in right order';
}

#?rakudo.parrot skip 'no implementation of channel/winner'
{
    my $c = Supply.for(1..5).Channel;
    my @a;
    loop {
        winner $c {
            more * -> $val { @a.push($val) }
            done * -> { @a.push("done"); last }
        }
    }
    is ~@a, "1 2 3 4 5 done", "Supply.for.Channel and winner channel work";
}

#?rakudo.parrot skip 'no implementation of channel/winner'
{
    my $c = Supply.for(1..5).Channel;
    my @a;
    loop {
        winner * {
            more $c -> $val { @a.push($val) }
            done $c -> { @a.push("done"); last }
        }
    }
    is ~@a, "1 2 3 4 5 done", "Supply.for.Channel and winner * work";
}

#?rakudo.parrot skip 'no implementation of channel/winner'
{
    my @c = Supply.for(11..15).Channel, Supply.for(16..20).Channel;
    my %done;
    my @a;
    loop {
        winner * {
            more @c { @a.push: $:v }
            done @c { %done{$:k}++; last if +%done == 2 }
        }
    }
    is ~@a.sort, "11 12 13 14 15 16 17 18 19 20", "Supply.for.Channel and winner * work";
}
