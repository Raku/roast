use v6;
use Test;
use lib $?FILE.IO.parent(2).add("packages/Test-Helpers");
use Test::Tap;

plan 6;

for ThreadPoolScheduler.new, CurrentThreadScheduler -> $*SCHEDULER {
    diag "**** scheduling with {$*SCHEDULER.WHAT.raku}";

    my @list = <old dog jumpso oover the foxo>;
    tap-ok Supply.from-list(@list).split("o"),
      ['','ldd', 'gjumps', '', '', 'verthef', 'x', ''],
      "split a simple list of words";

    tap-ok Supply.from-list(@list).split("o", :!skip-empty),
      ['','ldd', 'gjumps', '', '', 'verthef', 'x', ''],
      "split a simple list of words not skipping empty";

    tap-ok Supply.from-list(@list).split("o", :skip-empty),
      ['ldd', 'gjumps', 'verthef', 'x'],
      "split a simple list of words while skipping empty";
}

# vim: ft=perl6 expandtab sw=4
