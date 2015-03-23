use v6;
use lib 't/spec/packages';

use Test;
use Test::Tap;

plan 3;

dies_ok { Supply.reverse }, 'can not be called as a class method';

for ThreadPoolScheduler.new, CurrentThreadScheduler -> $*SCHEDULER {
    diag "**** scheduling with {$*SCHEDULER.WHAT.perl}";

    tap_ok Supply.from-list(1..10).reverse, [10...1], "we can reverse";
}
