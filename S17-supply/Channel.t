use v6;
use lib 't/spec/packages';

use Test;

plan 12;

for (ThreadPoolScheduler, CurrentThreadScheduler) {
    $*SCHEDULER = .new;
    isa_ok $*SCHEDULER, $_, "***** scheduling with {$_.gist}";

    {
        my $s = Supply.new;
        my $c = $s.Channel;
        isa_ok $c, Channel, 'we got a Channel';
        $s.more(42);
        is $c.receive, 42, 'got first mored value';
        $s.more(43);
        $s.more(44);
        is $c.receive, 43, 'got second mored value';
        is $c.receive, 44, 'got third mored value';
        $s.done;
        ok $c.closed, 'doneing closes the Channel';
    }
}
