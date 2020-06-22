use v6;
use Test;
use lib $?FILE.IO.parent(2).add("packages/Test-Helpers");
use Test::Tap;

plan 11;

dies-ok { Supply.rotate }, 'can not be called as a class method';

for ThreadPoolScheduler.new, CurrentThreadScheduler -> $*SCHEDULER {
    diag "**** scheduling with {$*SCHEDULER.WHAT.raku}";

    tap-ok Supply.from-list(1..5).rotate, [2,3,4,5,1], "we can rotate";
    tap-ok Supply.from-list(1..5).rotate(3), [4,5,1,2,3], "we can rotate(3)";
    tap-ok Supply.from-list(1..5).rotate(8), [4,5,1,2,3], "we can rotate(8)";
    tap-ok Supply.from-list(1..5).rotate(-3), [3,4,5,1,2], "we can rotate(-3)";
    tap-ok Supply.from-list(1..5).rotate(0), [1,2,3,4,5], "we can rotate(0)";
}

# vim: expandtab shiftwidth=4
