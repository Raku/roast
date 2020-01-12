use v6;
use Test;
use lib $?FILE.IO.parent(2).add("packages/Test-Helpers");
use Test::Tap;

plan 2;

for ThreadPoolScheduler.new, CurrentThreadScheduler -> $*SCHEDULER {
    diag "**** scheduling with {$*SCHEDULER.WHAT.raku}";

    tap-ok Supply.from-list(<old dog jumpso oover the foxo>).split("o"),
      ['','ldd', 'gjumps', '', '', 'verthef', 'x', ''],
      "handle split a simple list of words";
}

# vim: ft=perl6 expandtab sw=4
