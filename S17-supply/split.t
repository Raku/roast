use v6;
use Test;
use lib $?FILE.IO.parent(2).add("packages/Test-Helpers");
use Test::Tap;

plan 2 * 17;

for ThreadPoolScheduler.new, CurrentThreadScheduler -> $*SCHEDULER {
    diag "**** scheduling with {$*SCHEDULER.WHAT.raku}";

    my @list = <old dog jumpso oover the foxo>;
    tap-ok Supply.from-list(@list).split("o"),
      ['','ldd', 'gjumps', '', '', 'verthef', 'x', ''],
      "split a simple list of words";

    for Inf, *, 10, "Inf", "10" -> $limit {
        tap-ok Supply.from-list(@list).split("o", $limit),
          ['','ldd', 'gjumps', '', '', 'verthef', 'x', ''],
          "split a simple list of words with limit $limit.raku()";
    }

    for -Inf, -1, 0, "-Inf", "-1", "0" -> $limit {
        tap-ok Supply.from-list(@list).split("o", $limit),
          [],
          "split a simple list of words with limit $limit.raku()";
    }

    tap-ok Supply.from-list(@list).split("o", 3),
      ['','ldd', 'gjumps'],
      "split a simple list of words for a max of 3";

    tap-ok Supply.from-list(@list).split("o", 3, :!skip-empty),
      ['','ldd', 'gjumps'],
      "split a simple list of words for a max of 3";

    tap-ok Supply.from-list(@list).split("o", 3, :skip-empty),
      ['ldd', 'gjumps','verthef'],
      "split a simple list of words for a max of 3";

    tap-ok Supply.from-list(@list).split("o", :!skip-empty),
      ['','ldd', 'gjumps', '', '', 'verthef', 'x', ''],
      "split a simple list of words not skipping empty";

    tap-ok Supply.from-list(@list).split("o", :skip-empty),
      ['ldd', 'gjumps', 'verthef', 'x'],
      "split a simple list of words while skipping empty";
}

# vim: ft=perl6 expandtab sw=4
