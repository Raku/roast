use v6.d;
use Test;

plan 19;

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
    $c.send(42);
    $c.close();
    nok $c.closed, "Channel not closed before value received";
    is $c.receive, 42, "Received value";
    ok $c.closed, "Channel closed after all values received";
    throws-like { $c.receive }, X::Channel::ReceiveOnClosed;
    throws-like { $c.send(18) }, X::Channel::SendOnClosed;
}

{
    my $c = Channel.new;
    $c.send(1);
    $c.fail("oh noes");
    is $c.receive, 1, "received first value";
    dies-ok { $c.receive }, "error thrown on receive";
    throws-like { $c.send(18) }, X::Channel::SendOnClosed;
    is $c.closed.cause.message, "oh noes", "failure reason conveyed";
}

{
    my class X::Roast::Channel is Exception { };
    my $c = Channel.new;
    $c.fail(X::Roast::Channel.new);
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
    $c.close;
    is $c.closed.status, Kept, 'Closing a channel immediately keeps its .closed promise';

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

{ # coverage; 2016-09-26
    is Channel.elems, 1, 'Channel:U.elems returns 1';
    throws-like { Channel.new.elems }, Exception, 'Channel:D.elems fails';
}
