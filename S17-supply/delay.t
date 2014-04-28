use v6;
use lib 't/spec/packages';

use Test;
use Test::Tap;

plan 22;

for (ThreadPoolScheduler, CurrentThreadScheduler) {
    $*SCHEDULER = .new;
    isa_ok $*SCHEDULER, $_, "***** scheduling with {$_.gist}";

    {
        my $delay = 2;
        my $now   = now;
        my $seen;
        tap_ok $now.Supply.delay($delay).do( { $seen = now } ),
          [$now], ".delay worked";
        ok $seen && $seen >= $now + $delay, "supply sufficiently delayed";
    }

    {
        my $for   = Supply.for(1..10);
        my $delay = $for.delay(0);
        ok $for === $delay, "delaying by 0 is a noop";
        tap_ok $delay, [1..10], "noop delay";
    }
}
