use v6;
use Test;

plan 16;

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
    throws_like { $c.receive }, X::Channel::ReceiveOnClosed;
    throws_like { $c.send(18) }, X::Channel::SendOnClosed;
}

{
    my $c = Channel.new;
    $c.send(1);
    $c.fail("oh noes");
    is $c.receive, 1, "received first value";
    dies_ok { $c.receive }, "error thrown on receive";
    throws_like { $c.send(18) }, X::Channel::SendOnClosed;
    is $c.closed.cause.message, "oh noes", "failure reason conveyed";
}

{
    my class X::Roast::Channel is Exception { };
    my $c = Channel.new;
    $c.fail(X::Roast::Channel.new);
    throws_like { $c.receive }, X::Roast::Channel;
}

{
    my $p = Supply.for(1..5);
    is ~$p.Channel.list, "1 2 3 4 5", "Supply.for and .Channel work";
}

{
    my $p = Supply.for(1..5);
    is ~@($p.Channel), "1 2 3 4 5", "Supply.for and @(.Channel) work";
}

{
    my $c = Channel.new;
    $c.close;
    is $c.closed.status, Kept, 'Closing a channel immediately keeps its .closed promise';

}
