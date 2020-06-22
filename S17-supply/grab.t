use v6;
use Test;
use lib $?FILE.IO.parent(2).add("packages/Test-Helpers");
use Test::Tap;

plan 5;

dies-ok { Supply.grab }, 'can not be called as a class method';

for ThreadPoolScheduler.new, CurrentThreadScheduler -> $*SCHEDULER {
    diag "**** scheduling with {$*SCHEDULER.WHAT.raku}";

    tap-ok Supply.from-list(1..10).grab( {.reverse} ), [10...1], "we can reverse";
    tap-ok Supply.from-list(1..10).grab( {[min] $_} ), [1], "we can find the min";
}

# vim: expandtab shiftwidth=4
