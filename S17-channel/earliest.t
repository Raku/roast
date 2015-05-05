use v6;
use Test;

plan 7;

{
    my $c = Supply.from-list(1..5).Channel;
    my @a;
    loop {
        earliest $c {
            more * -> $val { @a.push($val) }
            done * -> { @a.push("done"); last }
        }
    }
    is ~@a, "1 2 3 4 5 done", "Supply.from-list.Channel, earliest channel work";
}

{
    my $c = Supply.from-list(1..5).Channel;
    my @a;
    loop {
        earliest * {
            more $c -> $val { @a.push($val) }
            done $c -> { @a.push("done"); last }
        }
    }
    is ~@a, "1 2 3 4 5 done", "Supply.from-list.Channel and earliest * work";
}

{
    my @c = Supply.from-list(11..15).Channel, Supply.from-list(16..20).Channel;
    my %done; # cannot use a simple counter  :-(
    my @a;
    loop {
        earliest * {
            more @c { @a.push: $:v }
# When using multiple channels, and they don't close simultaneously, there is
# a chance that the "done" section of a closed channel is executed more than
# once.  Hence the the use of a hash, rather than just a simple counter.
            done @c { %done{$:k}++; last if +%done == 2 }
        }
    }
    is ~@a.sort, "11 12 13 14 15 16 17 18 19 20",
      "Supply.from-list.Channel and earliest * work";
}

{
    my $c_a = Supply.from-list(1..5).Channel;
    my $c_b = Supply.from-list(6..10).Channel;

    my @c = $c_a, $c_b;

    my @a;
    my @b;

    # without some specific logic it will call a matching done block
    # until the loop is exited.
    my $done_a = False;
    my $done_b = False;

    my $last = @c.elems;
    loop {
        earliest @c {
            more $c_a -> $val { @a.push($val) }
            more $c_b -> $val { @b.push($val) }
            done $c_a -> { if !$done_a { @a.push("done_a"); $done_a = True } }
            done $c_b -> { if !$done_b { @b.push("done_b"); $done_b = True } }
        }
        last if $done_a && $done_b;
    }
    is ~@a, "1 2 3 4 5 done_a", "Supply.from-list.Channel and earliest <list> work with channel specific more and done";
    is ~@b, "6 7 8 9 10 done_b", "Supply.from-list.Channel and earliest <list> work with channel specific more and done";
}

{
    my $c_a = Supply.from-list(1..5).Channel;
    my $c_b = Supply.from-list(6..10).Channel;

    my @c = $c_a, $c_b;

    my @a;
    my @b;

    # without some specific logic it will call a matching done block
    # until the loop is exited.
    my $done_a = False;
    my $done_b = False;

    my $last = @c.elems;
    # need to limit the number of times we loop as it won't finish if
    # this doesn't work
    for ^16 {
        earliest @c {
            more $c_a -> $val { @a.push($val) }
            more * -> $val { @b.push($val) }
            done $c_a -> { if !$done_a { @a.push("done_a"); $done_a = True } }
            done * -> { if !$done_b { @b.push("done_b"); $done_b = True } }
        }
        last if $done_a && $done_b;
    }
    is ~@a, "1 2 3 4 5 done_a", "Supply.from-list.Channel and earliest <list> work with channel specific and wild card more and done";
    is ~@b, "6 7 8 9 10 done_b", "Supply.from-list.Channel and earliest <list> work with channel specific and wild card more and done";
}
