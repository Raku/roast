use v6;
use Test;

plan 1;

# This test covers a hang due to the `.list` call below hanging when there was
# a `whenever` subscribed to the Channel and we closed it. The bug vanished if
# wrapping it into a `start` or similar to do a timeout, so seems sensitive to
# the thread pool contents, so was placed into its own test file.
react {
    my $c = Channel.new;
    whenever $c { };
    $c.close;
    for $c.list { }
}
pass "No hang when we close/drain a Channel that is subscribed to in the same react";

# vim: expandtab shiftwidth=4
