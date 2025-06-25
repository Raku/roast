use v6.e.PREVIEW;
use Test;
use lib $*PROGRAM.parent(2).add("packages/Test-Helpers");
use Test::Tap;

plan 7;

dies-ok { Supply.snip(1000) }, 'can not be called as a class method';

for ThreadPoolScheduler.new, CurrentThreadScheduler -> $*SCHEDULER {
    diag "**** scheduling with {$*SCHEDULER.WHAT.raku}";

    tap-ok Supply.from-list(1..14).snip(*>9),
      [(1,2,3,4,5,6,7,8,9),(10,11,12,13,14)],
      "we can snip with a single test";

    tap-ok Supply.from-list(1..14).snip(*>9, *>11),
      [(1,2,3,4,5,6,7,8,9),(10,11),(12,13,14)],
      "we can snip with two tests";

    tap-ok Supply.from-list("a","b","c",1,2,3).snip(Int),
      [("a","b","c"),(1,2,3)],
      "we can snip with a type object";
}

# vim: expandtab shiftwidth=4
