use v6;
use Test;

plan 3;

# RT #123520
# This test comes first in the file so it's the first to start any threads;
# this means we can test the actual bug in the ticket.
{
    my @order;
    my $p1 = start { sleep 3; @order.push(3) },
    my $p2 = Promise.at(now + 1).then({ @order.push(1) });
    await Promise.anyof($p1, $p2);
    sleep 1;
    @order.push(2);
    await $p1, $p2;
    is @order, (1, 2, 3), 'Scheduler did not cause things to run in wrong order';
}

{
    my $start = now;
    my $p = Promise.at(now + 11);
    is $p.result, True, "Promise.at result is True";
    ok now - $start >= 1, "Promise.at took long enough";
}
