use v6;
use lib 't/spec/packages';

use Test;
use Test::Tap;

plan 12;

for (ThreadPoolScheduler, CurrentThreadScheduler) {
    $*SCHEDULER = .new;
    isa_ok $*SCHEDULER, $_, "***** scheduling with {$_.gist}";

    {
        my $seen;
        tap_ok Supply.for(1..10).do( {$seen++} ),
          [1..10], ".do worked";
        is $seen, 10, "did the side effect work";
    }
}
