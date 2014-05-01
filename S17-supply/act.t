use v6;
use lib 't/spec/packages';

use Test;

plan 6;

for (ThreadPoolScheduler, CurrentThreadScheduler) {
    $*SCHEDULER = .new;
    isa_ok $*SCHEDULER, $_, "***** scheduling with {$_.gist}";

    {
        my @seen;
        my $tap = Supply.for(1..10).act( { @seen.push($_) } );
        isa_ok $tap, Tap, 'we got a Tap';
        sleep .1 until @seen == 10;
        is_deeply @seen, [1..10], 'we got all of the values';
    }
}
