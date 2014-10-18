use v6;
use Test;

plan 3;

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

{
    my @c = Supply.for(11..15).Channel, Supply.for(16..20).Channel;
    my %done; # cannot use a simple counter  :-(
    my @a;
    loop {
        winner * {
            more @c { @a.push: $:v }
# When using multiple channels, and they don't close simultaneously, there is
# a chance that the "done" section of a closed channel is executed more than
# once.  Hence the the use of a hash, rather than just a simple counter.
            done @c { %done{$:k}++; last if +%done == 2 }
        }
    }
    is ~@a.sort, "11 12 13 14 15 16 17 18 19 20", "Supply.for.Channel and winner * work";
}
