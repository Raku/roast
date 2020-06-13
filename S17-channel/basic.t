use v6;
use Test;

plan 28;

{
    my Channel $c .= new;
    $c.send(1);
    $c.send(2);
    is $c.receive, 1, "Received first value";
    is $c.poll, 2, "Polled for second value";
    ok $c.poll === Nil, "poll returns Nil when no values available";
}

{
    my $c = Channel.new;
    my $closed = $c.closed;
    $c.send(42);
    $c.close();
    nok $closed, "Channel not closed before value consumed";
    is $c.receive, 42, "Received value";
    ok $closed, "Channel closed after all values consumed";
    is $closed.status, Kept, "closed status";
    ok $c.poll === Nil, 'poll returns Nil when channel closed';
    throws-like { $c.receive }, X::Channel::ReceiveOnClosed;
    throws-like { $c.send(18) }, X::Channel::SendOnClosed;
}

{
    my $c = Channel.new;
    my $closed = $c.closed;
    $c.send(1);
    my $error = "oh noes";
    $c.fail($error);
    nok $closed, "Channel not closed before value consumed";
    is $c.poll, 1, "Polled value";
    ok $closed, "Channel closed after all values consumed";
    is $closed.status, Broken, "closed status";
    is $closed.cause.message, $error, "failure reason conveyed";
    ok $c.poll === Nil, 'poll returns Nil when channel failed';
    throws-like { $c.receive }, X::AdHoc, payload => $error,
     "error thrown on receive";
    throws-like { $c.send(18) }, X::Channel::SendOnClosed;
}

{
    my class X::Roast::Channel is Exception { };
    my $c = Channel.new;
    my $closed = $c.closed;
    $c.fail(X::Roast::Channel.new);
    is $closed.status, Broken,
     'Failing an empty channel immediately breaks its .closed promise';
    isa-ok $closed.cause, X::Roast::Channel, "failure reason conveyed";
    throws-like { $c.receive }, X::Roast::Channel;
}

{
    my $p = Supply.from-list(1..5);
    is ~$p.Channel.list, "1 2 3 4 5", "Supply.from-list and .Channel work";
}

{
    my $p = Supply.from-list(1..5);
    is ~@($p.Channel), "1 2 3 4 5", "Supply.from-list and @(.Channel) work";
}

{
    my $c = Channel.new;
    my $closed = $c.closed;
    $c.close;
    is $closed.status, Kept,
     'Closing an empty channel immediately keeps its .closed promise';
}

{
    my $c = Channel.new;
    my $timer = Supply.interval(5).tap: {
        if $_ > 0 {
            flunk("Timeout while receiving from a closed shared channel");
            exit(1);
        }
    };

    my $worker-a = start { for @$c {} };
    my $worker-b = start { for @$c {} };

    $c.close;

    await $worker-a, $worker-b;

    pass("Both workers detected end-of-channel after a shared channel close");
    $timer.close;
}

{
    my $c = Channel.new;
    $c.send(1);
    $c.send(2);

    react whenever $c { done }

    is $c.poll, 2, 'second value should still be in the channel';
}

{ # coverage; 2016-09-26
    throws-like { Channel.elems     }, Exception, 'Channel:U.elems fails';
    throws-like { Channel.new.elems }, Exception, 'Channel:D.elems fails';
}

# vim: expandtab shiftwidth=4
