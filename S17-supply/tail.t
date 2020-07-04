use v6;
use Test;
use lib $?FILE.IO.parent(2).add("packages/Test-Helpers");
use Test::Tap;

plan 15;

dies-ok { Supply.new.tail("foo") }, 'cannot have "foo" tail';

for ThreadPoolScheduler.new, CurrentThreadScheduler -> $*SCHEDULER {
    diag "**** scheduling with {$*SCHEDULER.WHAT.raku}";

    tap-ok Supply.from-list(1..10).tail, [10], "tail without argument works";
    tap-ok Supply.from-list(1..10).tail(5), [6..10], "tail five works";
    tap-ok Supply.from-list(1..10).tail(15), [1..10], "tail 15 works";
    tap-ok Supply.from-list(1..10).tail(*), [1..10], "tail * works";
    tap-ok Supply.from-list(1..10).tail(Inf), [1..10], "tail Inf works";
    tap-ok Supply.from-list(1..10).tail(*-3), [4..10], "tail *-3 works";
    tap-ok Supply.from-list(1..10).tail(*-13), [], "tail *-13 works";
}

# vim: expandtab shiftwidth=4
