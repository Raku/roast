use v6;
use lib $?FILE.IO.parent(2).add("packages");

use Test;
use Test::Tap;

plan 7;

dies-ok { Supply.new.skip("foo") }, 'cannot have "foo" skip';

for ThreadPoolScheduler.new, CurrentThreadScheduler -> $*SCHEDULER {
    diag "**** scheduling with {$*SCHEDULER.WHAT.perl}";

    tap-ok Supply.from-list(1..4).skip, [2,3,4], "skip without argument works";
    tap-ok Supply.from-list(1..10).skip(5), [6,7,8,9,10], "skip five works";
    tap-ok Supply.from-list(1..10).skip(15), [], "skip 15 works";
}

# vim: ft=perl6 expandtab sw=4
