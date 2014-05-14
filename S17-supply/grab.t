use v6;
use lib 't/spec/packages';

use Test;
use Test::Tap;

plan 7;

dies_ok { Supply.grab }, 'can not be called as a class method';

for (ThreadPoolScheduler, CurrentThreadScheduler) {
    $*SCHEDULER = .new;
    isa_ok $*SCHEDULER, $_, "***** scheduling with {$_.gist}";

    tap_ok Supply.for(1..10).grab( {.reverse} ), [10...1], "we can reverse";
    tap_ok Supply.for(1..10).grab( {[min] $_} ), [1], "we can find the min";
}
