use v6;

use Test;

plan 7;

dies_ok { Supply.act({...}) }, 'can not be called as a class method';

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
