use v6;
use lib 't/spec/packages';

use Test;
use Test::Tap;

plan 8;

for (ThreadPoolScheduler, CurrentThreadScheduler) {
    $*SCHEDULER = .new;
    isa_ok $*SCHEDULER, $_, "***** scheduling with {$_.gist}";

    tap_ok Supply.for(1..10).grep( * > 5 ),
      [6,7,8,9,10],
      "grepping taps works";
}
