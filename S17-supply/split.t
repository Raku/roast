use v6;
use Test;
use lib $?FILE.IO.parent(2).add("packages/Test-Helpers");
use Test::Tap;

my @source = <old dog jumpso oover the foxo>;
my @schedulers = ThreadPoolScheduler.new, CurrentThreadScheduler;
my @needles = "o", /o/;

plan @schedulers * @needles * 17;

for @schedulers -> $*SCHEDULER {
    diag "**** scheduling with {$*SCHEDULER.WHAT.raku}";

    for "o", /o/ -> \needle {
        tap-ok Supply.from-list(@source).split(needle),
          ['','ldd', 'gjumps', '', '', 'verthef', 'x', ''],
          "split a simple list of words";

        for Inf, *, 10, "Inf", "10" -> $limit {
            tap-ok Supply.from-list(@source).split(needle, $limit),
              ['','ldd', 'gjumps', '', '', 'verthef', 'x', ''],
              "split a simple list of words with limit $limit.raku()";
        }

        for -Inf, -1, 0, "-Inf", "-1", "0" -> $limit {
            tap-ok Supply.from-list(@source).split(needle, $limit),
              [],
              "split a simple list of words with limit $limit.raku()";
        }

        tap-ok Supply.from-list(@source).split(needle, 3),
          ['','ldd', 'gjumps'],
          "split a simple list of words for a max of 3";

        tap-ok Supply.from-list(@source).split(needle, 3, :!skip-empty),
          ['','ldd', 'gjumps'],
          "split a simple list of words for a max of 3";

        tap-ok Supply.from-list(@source).split(needle, 3, :skip-empty),
          ['ldd', 'gjumps','verthef'],
          "split a simple list of words for a max of 3";

        tap-ok Supply.from-list(@source).split(needle, :!skip-empty),
          ['','ldd', 'gjumps', '', '', 'verthef', 'x', ''],
          "split a simple list of words not skipping empty";

        tap-ok Supply.from-list(@source).split(needle, :skip-empty),
          ['ldd', 'gjumps', 'verthef', 'x'],
          "split a simple list of words while skipping empty";
    }
}

# vim: ft=perl6 expandtab sw=4
