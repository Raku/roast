use v6;
use Test;
use lib $?FILE.IO.parent(2).add("packages/Test-Helpers");
use Test::Tap;

my @schedulers = ThreadPoolScheduler.new, CurrentThreadScheduler;

plan @schedulers * 3;

for @schedulers -> $*SCHEDULER {
    diag "**** scheduling with {$*SCHEDULER.WHAT.raku}";

    for \(* < 4), \(* < 4, :!end) -> \c {
        tap-ok Supply.from-list(1,2,3,4,5).first(|c), [1,],
          "first with {c.raku.substr(1)}";
    }

    with \(* < 4, :end) -> \c {
        tap-ok Supply.from-list(1,2,3,4,5).first(|c), [3,],
          "first with {c.raku.substr(1)}";
    }
}

# vim: ft=perl6 expandtab sw=4
