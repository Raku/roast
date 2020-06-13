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

    for @needles -> \needle {
        tap-ok Supply.from-list(@source).split(needle),
          ['','ldd', 'gjumps', '', '', 'verthef', 'x', ''],
          "split a simple list of words";

        for Inf, *, "Inf" -> $limit {
            tap-ok Supply.from-list(@source).split(needle, $limit),
              ['','ldd', 'gjumps', '', '', 'verthef', 'x', ''],
              "split a simple list of words with limit $limit.raku()";
        }

        for 10, "10" -> $limit {
            #?rakudo.jvm todo 'GH #3456 problem with .split(needle, limit)'
            tap-ok Supply.from-list(@source).split(needle, $limit),
              ['','ldd', 'gjumps', '', '', 'verthef', 'x', ''],
              "split a simple list of words with limit $limit.raku()";
        }

        for -Inf, -1, 0, "-Inf", "-1", "0" -> $limit {
            tap-ok Supply.from-list(@source).split(needle, $limit),
              [],
              "split a simple list of words with limit $limit.raku()";
        }

        #?rakudo.jvm todo 'unknown problem with .split(needle, limit)'
        tap-ok Supply.from-list(@source).split(needle, 3),
          ['','ldd', 'gjumps'],
          "split a simple list of words for a max of 3";

        #?rakudo.jvm todo 'unknown problem with .split(needle, limit)'
        tap-ok Supply.from-list(@source).split(needle, 3, :!skip-empty),
          ['','ldd', 'gjumps'],
          "split a simple list of words for a max of 3";

        #?rakudo.jvm todo 'unknown problem with .split(needle, limit)'
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

# vim: expandtab shiftwidth=4
